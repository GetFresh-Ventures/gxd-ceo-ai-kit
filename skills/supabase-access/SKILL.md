---
name: supabase-access
description: Access Supabase for ontology queries, entity embeddings, vector search, fact storage, and manual entity/fact writes. Covers connection details, helper scripts, table schemas, and write patterns.
---

# Supabase Access

## Status: ✅ Working (Read + Write)

> [!IMPORTANT]
> **Definitive Schema Reference:** See [`PIL-SCHEMA.md`](file:///Users/dirajgoel/Documents/Code/gfv-brain/PIL-SCHEMA.md) for the authoritative table schemas, enum values, predicate taxonomy, source breakdown, and data flow architecture. The schema sections below in this skill may be outdated — PIL-SCHEMA.md is the canonical source validated against live data on 2026-04-15.

> [!CAUTION]
> ## HARD RULES — READ BEFORE ANY QUERY
>
> 1. **Supabase returns MAX 1000 rows per request.** This is a server-side default. Setting `limit=5000` does NOT override it. If your result set could exceed 1000 rows, you MUST paginate using the `Range` header.
> 2. **Any count, census, or aggregate query** over entities, facts, or relations MUST use the paginated fetch pattern below — never trust a single unpaginated SELECT.
> 3. **Use `Prefer: count=exact` + `Range: 0-0`** for counts. This returns the total in the `Content-Range` header without fetching rows.
> 4. **`ont_facts` column names**: The columns are `subject_id` (not `entity_id`), `object_text` (not `object_value`), and `fact_text` is **REQUIRED NOT NULL**.
> 5. **Never batch-delete without a filter.** Always include a predicate filter (e.g., `?predicate=eq.action_signal`) on DELETE operations.

## Connection Details

- **URL**: `https://uluteflsndznymtdekup.supabase.co`
- **Anon key**: Stored in macOS Keychain as `SUPABASE_ONTOLOGY_ANON_KEY` (fallback: `SUPABASE_GFV_GTM_ANON_KEY`)
- **Retrieve**: `~/.claude/scripts/get-secret.sh SUPABASE_ONTOLOGY_ANON_KEY`

## Tables

| Table | Purpose |
| --- | --- |
| `entity_embeddings` | Main data store — documents, deals, contacts, invoices, emails |
| `ont_entities` | Ontology entities — companies, people, deals with HubSpot/Linear IDs |
| `ont_facts` | Structured relationship data (subject → predicate → object) |

## Quick Start (Recommended)

Use `supabase_query.py` for most queries — it handles auth, URL construction, and column names automatically:

```bash
# Look up an entity and its facts/relations
python3 ~/Documents/Code/gfv-brain/scripts/supabase_query.py --entity "Greg Romans"

# Show table schema (column names + types)
python3 ~/Documents/Code/gfv-brain/scripts/supabase_query.py --schema ont_facts

# Search across fact text
python3 ~/Documents/Code/gfv-brain/scripts/supabase_query.py --search "form phone tracking"

# Recent facts from today
python3 ~/Documents/Code/gfv-brain/scripts/supabase_query.py --recent

# Raw PostgREST query
python3 ~/Documents/Code/gfv-brain/scripts/supabase_query.py ont_entities name=ilike.*greg* --limit 5
```

## Key Scripts

| Script | Purpose |
| --- | --- |
| `gfv-brain/scripts/supabase_query.py` | **CLI query tool** — entity lookup, schema introspection, search, raw PostgREST |
| `gfv-brain/scripts/pil_db.py` | Low-level HTTP client (auth, headers, `_request()`) |
| `gfv-brain/scripts/supabase_helper.py` | Re-export shim — imports from pil_db, pil_ingest, pil_ontology |
| `gfv-brain/scripts/pil_context.py` | Entity context builder with hybrid search (RRF), bidirectional timelines |
| `gfv-brain/scripts/pil_mcp_server.py` | **MCP server** — 10 tools for AI agent access to PIL |
| `gfv-brain/scripts/claude_memory.py` | Memory read/write for cross-session context (SQLite, NOT Supabase) |
| `gfv-brain/scripts/pil_full_ingest.py` | Full pipeline ingest from all sources |

## MCP Tools (PIL Server)

The PIL MCP server exposes 10 tools for AI agent access:

| Tool | Purpose |
| --- | --- |
| `search_pil` | Keyword search across all sources (WhatsApp, embeddings, ontology, memory) |
| `smart_search` | **AI-powered**: intent classification → route to best backend → rerank results |
| `vector_search` | Semantic similarity search via Gemini embeddings + pgvector |
| `entity_deep_dive` | Full entity dossier (graph, facts, timeline, opportunities) |
| `query_whatsapp` | WhatsApp message search (59K+ messages, local SQLite) |
| `query_supabase` | Raw PostgREST queries against any table |
| `get_entity` | Ontology entity lookup with facts |
| `query_memory` | Cross-session Claude memory search |
| `query_slack` | Slack message search (2.5K+ messages) |
| `sync_whatsapp` | Force WhatsApp Desktop → local DB sync |

## Supabase RPC Functions

> [!TIP]
> These reduce 3-4 REST calls to 1 call. Use them for faster entity lookups.

| Function | Purpose |
| --- | --- |
| `pil_entity_context(p_name)` | Returns entity + facts + vectors + edges in one call |
| `pil_search_all(p_query, p_limit)` | Cross-table search (entities + facts + vectors) in one call |
| `ont_resolve_entity(p_search_text, p_entity_type)` | Fuzzy entity resolution |
| `ont_neighbors(p_entity_id, p_max_hops)` | Graph traversal for connected entities |
| `search_everything(query_embedding, match_threshold, match_count)` | pgvector semantic search |

```python
# Example: Single-call entity context
result = supabase_rpc("pil_entity_context", {"p_name": "Golden Rule"})
# Returns: { entity: {...}, facts: [...], vectors: [...], edges: [...] }
```

> [!NOTE]
> The RPC functions `pil_entity_context` and `pil_search_all` are defined in
> `gfv-brain/migrations/pil_next_gen_v1.sql`. Run this migration in the
> Supabase SQL Editor if the functions don't exist yet.

> [!IMPORTANT]
> **Do NOT use `get_supabase_client()`** — it does not exist. Use `supabase_query.py` CLI or import from `pil_db`:
> ```python
> from pil_db import _request, supabase_query, supabase_rpc
> # _request(method, path) — path is relative, e.g. "ont_facts?select=*&limit=5"
> # supabase_query(path) — alias for _request("GET", path)
> ```

---

## READ Patterns

### ⚠️ Paginated Fetch (MANDATORY for large result sets)

```python
import urllib.request, urllib.parse, json

SUPABASE_URL = "https://uluteflsndznymtdekup.supabase.co"
KEY = get_secret("SUPABASE_ONTOLOGY_ANON_KEY")
HEADERS = {"apikey": KEY, "Authorization": f"Bearer {KEY}", "Accept": "application/json"}

def sb_count(table, filt=""):
    """Get exact row count without fetching data."""
    req = urllib.request.Request(
        f"{SUPABASE_URL}/rest/v1/{table}?select=id{filt}", headers=HEADERS)
    req.add_header("Prefer", "count=exact")
    req.add_header("Range", "0-0")
    with urllib.request.urlopen(req, timeout=10) as resp:
        cr = resp.headers.get("Content-Range", "")
        return int(cr.split("/")[-1]) if "/" in cr else 0

def sb_paginated_fetch(table, select="*", filt="", order="created_at", max_rows=100000):
    """Fetch ALL rows from a table, paginating past the 1000-row cap."""
    all_rows = []
    page_size = 1000
    page = 0
    while len(all_rows) < max_rows:
        start = page * page_size
        end = start + page_size - 1
        req = urllib.request.Request(
            f"{SUPABASE_URL}/rest/v1/{table}?select={select}{filt}&order={order}",
            headers=HEADERS)
        req.add_header("Range", f"{start}-{end}")
        try:
            with urllib.request.urlopen(req, timeout=30) as resp:
                batch = json.loads(resp.read().decode())
                if not batch:
                    break
                all_rows.extend(batch)
                if len(batch) < page_size:
                    break
                page += 1
        except urllib.error.HTTPError as e:
            if e.code == 416:  # Range not satisfiable = past end
                break
            raise
    return all_rows

def query(path):
    """Simple single-page query (≤1000 rows). Use sb_paginated_fetch for more."""
    url = f"{SUPABASE_URL}/rest/v1/{path}"
    req = urllib.request.Request(url, headers=HEADERS)
    with urllib.request.urlopen(req, timeout=15) as resp:
        return json.loads(resp.read().decode())

# Find a company by name
results = query("ont_entities?name=ilike.%25Shatterpoint%25&select=id,name,entity_type,properties,hubspot_id,status")

# Find a person
results = query("ont_entities?name=ilike.%25Warren%25&entity_type=eq.person&select=id,name,properties,hubspot_id")

# Get facts for an entity
entity_id = results[0]["id"]
facts = query(f"ont_facts?subject_id=eq.{entity_id}&select=predicate,object_text,fact_text,confidence")
```

### Query entity_embeddings (documents, emails, content)

```python
# Search by title
results = query("entity_embeddings?title=ilike.%25GetScale%25&select=title,content_summary,source,metadata&limit=5&order=indexed_at.desc")

# Filter by source
results = query("entity_embeddings?source=eq.hubspot&entity_type=eq.deal&limit=10")
```

### Batch read with helper

```python
from supabase_helper import check_existing, count_by_type

existing = check_existing("google_drive")  # Returns set of source_ids
counts = count_by_type()
```

---

## WRITE Patterns

### Add a new entity to ont_entities

```python
import urllib.request, json

def upsert_entity(entity):
    """Add or update an entity in ont_entities."""
    url = f"{SUPABASE_URL}/rest/v1/ont_entities"
    payload = json.dumps(entity).encode()
    req = urllib.request.Request(url, data=payload, method="POST", headers={
        "apikey": KEY,
        "Authorization": f"Bearer {KEY}",
        "Content-Type": "application/json",
        "Prefer": "resolution=merge-duplicates",  # Upsert on conflict
    })
    with urllib.request.urlopen(req, timeout=15) as resp:
        return resp.status

# Example: Add a missing company
upsert_entity({
    "entity_type": "company",
    "name": "Unrecruitable",
    "slug": "unrecruitable",
    "status": "active",
    "source": "manual",
    "confidence": 0.9,
    "properties": {
        "description": "Recruitment platform",
        "industry": "HR Tech"
    }
})

# Example: Add a missing person
upsert_entity({
    "entity_type": "person",
    "name": "Taz Bhulji",
    "slug": "taz-bhulji",
    "status": "active",
    "source": "manual",
    "confidence": 0.9,
    "properties": {
        "company": "Unrecruitable",
        "role": "Founder"
    }
})
```

### Add a fact to ont_facts

```python
def add_fact(subject_id, predicate, object_text, source="manual", confidence=0.8):
    """Add a relationship fact."""
    url = f"{SUPABASE_URL}/rest/v1/ont_facts"
    payload = json.dumps({
        "subject_id": subject_id,
        "predicate": predicate,
        "object_text": object_text,
        "fact_text": f"{predicate}: {object_text}",
        "source": source,
        "confidence": confidence,
    }).encode()
    req = urllib.request.Request(url, data=payload, method="POST", headers={
        "apikey": KEY,
        "Authorization": f"Bearer {KEY}",
        "Content-Type": "application/json",
    })
    with urllib.request.urlopen(req, timeout=15) as resp:
        return resp.status

# Example: Link entity to a deal
add_fact(entity_id, "has_deal", "Shatterpoint Renewal Feb 2026", source="hubspot")
```

### Batch upsert entity_embeddings (via helper)

```python
from supabase_helper import upsert_entities

records = [{
    "source": "hubspot",
    "source_id": "deal_12345",
    "entity_type": "deal",
    "title": "Shatterpoint Renewal Feb 2026",
    "content_summary": "3-month bi-weekly coaching renewal...",
    "metadata": {"amount": 6000, "stage": "Contract Sent"}
}]
ok, err = upsert_entities(records)
```

### Pipeline ingest (all sources)

```bash
# Full ingest from all configured sources
cd ~/Documents/Code/gfv-brain && [STUB AVOIDED] Execute pil_full_ingest.py via available MCP/agent tools rather than a missing local script

# Single-source ingest
[STUB AVOIDED] Execute hubspot_supabase_ingest.py via available MCP/agent tools rather than a missing local script
[STUB AVOIDED] Execute pandadoc_supabase_ingest.py via available MCP/agent tools rather than a missing local script
[STUB AVOIDED] Execute quickbooks_supabase_ingest.py via available MCP/agent tools rather than a missing local script
[STUB AVOIDED] Execute gdrive_api_ingest.py via available MCP/agent tools rather than a missing local script
```

---

## Entity Schema (ont_entities)

```
ont_entities:
  - id: int (auto)
  - entity_type: text (company, person, deal)
  - name: text
  - slug: text
  - properties: jsonb (description, industry, email, phone, role, etc.)
  - hubspot_id: text
  - drive_id: text
  - linear_id: text
  - gmail_id: text
  - status: text (active, prospect, previous)
  - source: text (hubspot, manual, pandadoc, etc.)
  - confidence: float
  - embedding: vector(1536)
  - created_at / updated_at: timestamp
  - valid_from / valid_until: timestamp
```

## Entity Embeddings Schema

```
entity_embeddings:
  - source: text (google_drive, hubspot, pandadoc, quickbooks, o365)
  - source_id: text (unique within source)
  - entity_type: text (document, deal, contact, invoice, email)
  - title: text
  - content_summary: text
  - content_full: text
  - metadata: jsonb
  - embedding: vector(1536)
  - related_contact_emails: text[]
  - related_company_names: text[]
  - source_created_at / indexed_at: timestamp

On conflict: (source, source_id) — existing records updated, new ones inserted.
```

## Facts Schema (ont_facts)

```
ont_facts:
  - id: int (auto)
  - subject_id: int (FK → ont_entities.id)
  - predicate: text (e.g., "has_deal", "contract_starts", "has_role")
  - object_text: text
  - object_id: int (optional FK → ont_entities.id)
  - episode_id: text
  - fact_text: text (human-readable summary)
  - source: text
  - confidence: float
  - embedding: vector(1536)
  - valid_from / valid_until: timestamp
```

## Sources Currently Ingested

| Source | Script | Entity Types |
| --- | --- | --- |
| `hubspot` | `hubspot_supabase_ingest.py` | deal, contact, company |
| `google_drive` | `gdrive_api_ingest.py` | document |
| `quickbooks` | `quickbooks_supabase_ingest.py` | invoice, payment, customer, bill |
| `pandadoc` | `pandadoc_supabase_ingest.py` | contract |
| `o365` | various | email |
| `manual` | ad-hoc REST API calls | any |


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
