---
name: fathom-api
description: Access Fathom meeting transcripts, summaries, and action items via REST API. Covers listing meetings, searching by keyword, extracting transcript content, filtering by date/attendees, and pagination. Use when you need to pull meeting data for reconciliation, intelligence extraction, or cross-referencing call notes.
---

# Fathom API Skill

## Overview

Fathom is an AI meeting assistant that records, transcribes, and summarizes video calls. GFV uses Fathom across all internal and client meetings. The Fathom REST API provides programmatic access to meeting data including full transcripts, action items, and attendee lists.

## Authentication

- **Method:** `X-Api-Key` header
- **Key location:** macOS Keychain under `FATHOM_API_KEY`
- **Generate key:** https://fathom.video/customize#api-access-header
- **Store key:** `security add-generic-password -a $USER -s FATHOM_API_KEY -w <key>`
- **Rate limit:** 60 requests per 60 seconds (1 req/sec safe cadence)

## Client Location

The production Fathom client is at:

```
~/Documents/Code/gfv_gtm/scripts/api/fathom_client.py
```

### Import Pattern

```python
import sys
sys.path.insert(0, os.path.expanduser("~/Documents/Code/gfv_gtm/scripts"))
from api.fathom_client import FathomClient

client = FathomClient()
```

## API Reference

### Base URL
```
https://api.fathom.ai/external/v1
```

### Endpoints

#### `GET /meetings` — List Meetings

Returns a paginated list of meetings the API key owner has access to (own recordings + team-shared).

**Query Parameters:**

| Parameter | Type | Description |
|-----------|------|-------------|
| `created_after` | ISO 8601 timestamp | Only meetings created after this time |
| `created_before` | ISO 8601 timestamp | Only meetings created before this time |
| `include_summary` | boolean | Include AI summary in response (default: false) |
| `include_transcript` | boolean | Include full transcript text (default: false) |
| `include_action_items` | boolean | Include action items list (default: false) |
| `limit` | integer | Max meetings per page (default: 20, max: 50) |
| `cursor` | string | Pagination cursor from previous response |
| `recorded_by[]` | string | Filter by recorder's email |
| `teams[]` | string | Filter by team name |

**Response:**
```json
{
  "items": [...],
  "next_cursor": "eyJob3N0X2..."  // null if no more pages
}
```

**Each meeting item contains:**
```json
{
  "recording_id": "abc123",
  "title": "GetFresh Ventures <> Acme Corp",
  "created_at": "2026-04-09T18:09:37Z",
  "url": "https://fathom.video/share/...",
  "calendar_invitees": [
  ],
  "transcript": "Speaker 1: ...\nSpeaker 2: ...",
  "summary": "...",
  "action_items": [...]
}
```

> **IMPORTANT:** `include_transcript`, `include_summary`, and `include_action_items` default to `false`. You MUST set these to `true` to get content. Without them, you only get metadata (title, date, attendees).

### No Single-Meeting Endpoint

The Fathom API v1 does **not** have a `GET /meetings/:id` endpoint. To get a specific meeting, you must:
1. List meetings with `include_transcript=true` and paginate to find it, OR
2. Use the client's `get_meeting(id)` method which handles this

### No Search Endpoint

The API does **not** have a search endpoint. Client-side search is implemented in `FathomClient.search_meetings()` which paginates and filters by title match.

## Usage Patterns

### 1. List Today's Meetings
```python
from datetime import datetime, timezone
from api.fathom_client import FathomClient

client = FathomClient()
today = datetime.now(timezone.utc).strftime("%Y-%m-%dT00:00:00Z")
result = client.list_meetings(
    created_after=today,
    include_transcript=True,
    include_action_items=True,
    limit=50
)
for m in result["items"]:
    print(f"[{m['date'][:16]}] {m['title']}")
    print(f"  Transcript: {len(m['transcript'])} chars")
    print(f"  Action items: {len(m['action_items'])}")
```

### 2. Search for Client Meetings
```python
meetings = client.search_meetings("Acme Corp", limit=10)
for m in meetings:
    print(f"[{m['date'][:10]}] {m['title']} ({len(m['attendees'])} attendees)")
```

### 3. Full Pagination (All Meetings)
```python
import time

all_meetings = []
cursor = None
while True:
    result = client.list_meetings(
        include_transcript=True,
        include_summary=True,
        include_action_items=True,
        limit=50,
        cursor=cursor
    )
    items = result["items"]
    if not items:
        break
    all_meetings.extend(items)
    cursor = result.get("next_cursor")
    if not cursor:
        break
    time.sleep(1.1)  # Rate limit: 60 req/min
```

### 4. Search Transcript Content for Keywords
```python
def search_transcripts(keyword, days_back=7):
    """Search transcript text for a keyword across recent meetings."""
    from datetime import datetime, timezone, timedelta
    
    client = FathomClient()
    after = (datetime.now(timezone.utc) - timedelta(days=days_back)).isoformat()
    
    results = []
    cursor = None
    while True:
        batch = client.list_meetings(
            created_after=after,
            include_transcript=True,
            limit=50,
            cursor=cursor
        )
        for m in batch["items"]:
            if keyword.lower() in m.get("transcript", "").lower():
                # Extract context around the keyword
                transcript = m["transcript"]
                idx = transcript.lower().find(keyword.lower())
                context = transcript[max(0, idx-200):idx+200]
                results.append({
                    "title": m["title"],
                    "date": m["date"],
                    "context": context,
                    "mentions": transcript.lower().count(keyword.lower())
                })
        cursor = batch.get("next_cursor")
        if not cursor:
            break
        time.sleep(1.1)
    
    return sorted(results, key=lambda x: -x["mentions"])
```

### 5. Extract Acme Corp Meetings
```python
def get_golden_rule_meetings(days_back=30):
    """Get all Acme Corp related meetings from Fathom."""
    client = FathomClient()
    from datetime import datetime, timezone, timedelta
    
    after = (datetime.now(timezone.utc) - timedelta(days=days_back)).isoformat()
    gr_meetings = []
    cursor = None
    
    gr_keywords = ["Acme Corp", "Bob Roberts", "Chris Evans", "derrick", "Acme Corp"]
    
    while True:
        batch = client.list_meetings(
            created_after=after,
            include_transcript=True,
            include_action_items=True,
            limit=50,
            cursor=cursor
        )
        for m in batch["items"]:
            title_lower = m.get("title", "").lower()
            attendee_emails = [
                a.get("email", "").lower() if isinstance(a, dict) else ""
                for a in m.get("attendees", [])
            ]
            
            if (any(k in title_lower for k in gr_keywords) or
                any(e in attendee_emails for e in gr_emails)):
                gr_meetings.append(m)
        
        cursor = batch.get("next_cursor")
        if not cursor:
            break
        time.sleep(1.1)
    
    return gr_meetings
```

## Normalized Meeting Schema

The `FathomClient._normalize_meeting()` method standardizes the raw API response into:

```python
{
    "id": str,              # recording_id
    "title": str,           # meeting title
    "date": str,            # ISO 8601 created_at
    "url": str,             # Fathom share URL
    "attendees": list[str], # attendee names
    "has_transcript": bool,
    "transcript": str,      # full transcript text (speaker-labeled lines)
    "summary": str,         # AI summary
    "action_items": list,   # action item dicts/strings
    "recording_url": str,   # Fathom recording URL
}
```

## Related Infrastructure

### Supabase Ingest
- **Script:** `~/Documents/Code/gfv-brain/scripts/fathom_supabase_ingest.py`
- **Entity type:** `transcript` with `source=fathom`
- **Runs:** As part of `unified_sync_orchestrator.py` or standalone
- **Usage:** `[STUB AVOIDED] Execute fathom_supabase_ingest.py via available MCP/agent tools rather than a missing local script --incremental`

### Fireflies Transcripts (Legacy)
- **Location:** `~/Documents/Code/gfv-brain/data/fireflies_transcripts/*.json`
- **Status:** Older meetings (pre-Fathom). Different format, different API.
- **Note:** Fireflies data is static (JSON dumps), not live API.

### MCP Tools (Claude Sessions Only)
Fathom/Krisp MCP tools are available in Claude Desktop sessions:
- `search_meetings` — Full-text search across all meetings
- `list_action_items` — Get action items from recent meetings
- These are NOT callable from Python scripts

## Common Pitfalls

1. **"No meetings found" with API** — You probably forgot `include_transcript=True`. Without it, the response includes items but transcript is empty.

2. **Rate limiting** — Max 60 req/min. Always add `time.sleep(1.1)` between paginated calls.

3. **Large transcripts** — A 1-hour meeting transcript can be 80K-140K chars. When embedding or passing to LLMs, truncate appropriately.

4. **Duplicate meetings** — The API sometimes returns duplicate entries for the same meeting (different recording IDs). Deduplicate by title + date.

5. **No summary field** — Current API returns empty `summary` for most meetings. Use transcripts + action items instead.

6. **Pagination cursor format** — Cursors are opaque base64 strings. Never construct them; only use values from `next_cursor`.

## Quick Reference

| What | Value |
|------|-------|
| API Base | `https://api.fathom.ai/external/v1` |
| Auth Header | `X-Api-Key: <FATHOM_API_KEY>` |
| Keychain Key | `FATHOM_API_KEY` |
| Client File | `~/Documents/Code/gfv_gtm/scripts/api/fathom_client.py` |
| Ingest Script | `~/Documents/Code/gfv-brain/scripts/fathom_supabase_ingest.py` |
| Rate Limit | 60 req/min |
| Max Page Size | 50 |
| Key Gen URL | https://fathom.video/customize#api-access-header |


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
