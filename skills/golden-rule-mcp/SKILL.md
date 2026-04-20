---
name: golden-rule-mcp
description: How to connect to and query all Golden Rule MCP connectors (Google Ads, GA4, GSC, ServiceTitan, etc.) for live data, real-time monitoring, and campaign changes.
---

# Golden Rule MCP — Connection & Tool Index

This is the **master reference** for connecting to the Golden Rule MCP server. For property-specific workflows and response schemas, see the dedicated skills:

- **[Google Ads](../golden-rule-google-ads/SKILL.md)** — Campaign stats, keywords, search terms, geo performance, LSA leads
- **[GA4](../golden-rule-ga4/SKILL.md)** — Site traffic, conversions, device breakdown, landing pages, realtime
- **[GSC](../golden-rule-gsc/SKILL.md)** — Search performance, queries, clicks, CTR, position

---

## Connection Details

| Field | Value |
|-------|-------|
| Endpoint | `https://gr-connectors-web.vercel.app/api/mcp` |
| Transport | Streamable HTTP (JSON-RPC 2.0 + SSE) |
| Auth | Bearer token in `Authorization` header |
| Token Retrieval | `op read "op://Machine One/Golden Rule Supabase MCP Bearer Token/credential"` |

### Required Headers
```
Content-Type: application/json
Accept: application/json, text/event-stream
Authorization: Bearer <token>
```

---

## curl Template

Every MCP call follows this pattern:

```bash
curl -s --max-time 25 \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer <TOKEN>" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"<TOOL_NAME>","arguments":{<ARGS>}}}' \
  https://gr-connectors-web.vercel.app/api/mcp
```

### Parsing SSE Responses

The server returns Server-Sent Events. Extract the JSON:
```bash
... | python3 -c "
import sys,json
d=sys.stdin.read()
p=d.split('data: ')[-1] if 'data:' in d else d
j=json.loads(p)
c=j.get('result',{}).get('content',[])
t=c[0]['text'] if c else str(j)
print(t[:3000])
"
```

---

## Tool Discovery

```bash
curl -s --max-time 20 -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer <TOKEN>" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  https://gr-connectors-web.vercel.app/api/mcp
```

### Tool Naming Convention

Pattern: `gr_{platform}_{brand}_{action}`

Examples:
- `gr_google_ads_ppc_get_campaign_stats`
- `gr_ga4_grphc_get_site_traffic`
- `gr_gsc_rivercity_get_search_performance`

---

## Response Envelope (all tools)

```json
{
  "connector": "google-ads-lsa" | "ga4" | "search-console" | "servicetitan",
  "tool": "gr_...",
  "freshness": {
    "source": "google-ads",
    "data_mode": "live" | "realtime" | "cached",
    "last_updated": "2026-04-06T18:01:45.961Z",
    "staleness_hours": 0
  },
  "request": { ... },
  "result": { "records": [...] }
}
```

**Key checks:**
- `freshness.staleness_hours` — should be 0 for live data
- `freshness.data_mode` — "live" = fresh pull, "cached" = stale
- `result.records` — empty array = no data (not an error)
- `result.content[].isError: true` = tool error

### Error Patterns
```json
{"text": "Unknown tool: ..."} — wrong tool name
{"text": "Tool \"...\" failed: Missing required argument: start_date"} — missing args
```

---

## Cross-Property Health Check

Run all 9 Google properties in one parallel batch:
```bash
TOKEN="<token>"
START=$(date -v-7d +%Y-%m-%d)
END=$(date +%Y-%m-%d)

# Google Ads (3 accounts)
for acct in ppc lsautah lsadsm; do
  curl -s --max-time 20 -X POST -H "Content-Type: application/json" \
    -H "Accept: application/json, text/event-stream" \
    -H "Authorization: Bearer $TOKEN" \
    -d "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"tools/call\",\"params\":{\"name\":\"gr_google_ads_${acct}_get_campaign_stats\",\"arguments\":{\"start_date\":\"$START\",\"end_date\":\"$END\"}}}" \
    https://gr-connectors-web.vercel.app/api/mcp &
done

# GA4 + GSC (3 brands × 2 = 6 calls)
for brand in grphc rivercity cornerstone; do
  curl -s --max-time 20 ... "gr_ga4_${brand}_get_site_traffic" ... &
  curl -s --max-time 20 ... "gr_gsc_${brand}_get_search_performance" ... &
done
wait
```

---

## Claude Code Setup (for team members)

```bash
claude mcp add golden-rule --transport http \
  https://gr-connectors-web.vercel.app/api/mcp \
  --header "Authorization: Bearer <TOKEN>"
```

- Transport MUST be `http` (not `sse`, not `stdio`)
- Restart Claude Code after adding
- If 401 → token is wrong or header syntax is incorrect

---

## Global Gotchas

1. **Cost is in micros** — `costMicros: "412230977"` = $412.23 (÷ 1,000,000)
2. **Conversions can be fractional** — Google Ads attribution modeling (e.g., 14.998)
3. **SSE prefix** — Always strip `event: message\ndata: ` from response
4. **Rate limiting** — Batch parallel calls to 6-8 max to avoid 429s
5. **`get_realtime` takes NO args** — Do not pass start_date/end_date

---

## ServiceTitan Tools

ServiceTitan has 4 tenants with 6 tools each = 24 tools total.

| Tenant | Prefix | Market |
|--------|--------|--------|
| Utah | `gr_servicetitan_utah_*` | Salt Lake City |
| Grimes | `gr_servicetitan_grimes_*` | Des Moines/Grimes |
| River City | `gr_servicetitan_rivercity_*` | Des Moines |
| River City 2 | `gr_servicetitan_rivercity2_*` | Des Moines |

Tools per tenant: `_get_jobs`, `_get_leads`, `_get_business_units`, `_get_technician_performance`, `_get_revenue`, `_get_customers`

See `servicetitan-api` skill for full documentation.

---

## Attribution Pipeline (April 2026)

### Current Flow
```
Google Ads → Landing Page (?gclid=xxx&loc=UT)
    │
    ├── GTM Conversion Linker → captures GCLID → _gcl_aw cookie
    ├── GA4 events: phone_call_click, form_submission
    ├── Phone call → (801) 901-8553 → ServiceTitan (no GCLID)
    └── ScheduleEngine booking → ServiceTitan (full attribution)
```

### Planned: Offline Conversion Import
1. Capture GCLID from landing page clicks → store in Supabase `gclid_leads` table
2. Match completed ServiceTitan jobs → revenue data
3. Upload to Google Ads via Offline Conversion API
4. Requires Google Ads API developer token (application in progress)

### Avoca AI Integration
- **What:** AI phone answering system used by Golden Rule Utah
- **Contact:** Bharat Kilaru (Avoca co-founder)
- **Purpose:** Avoca handles overflow calls and provides call transcripts
- **Attribution value:** Avoca call data can be cross-referenced with ServiceTitan to close the phone attribution gap

---

## Key Team & Contacts

| Person | Role | Relevant For |
|--------|------|-------------|
| Greg Romans | GM, Utah | Service scope, financing, team ops |
| Derrick | Tech lead | GA4/GTM access elevation, tag management |
| Arvin | MCP connector dev | Adding new tools, fixing connectors |
| Bharat Kilaru | Avoca co-founder | AI phone system, call attribution |

---

## Connector Summary

| Connector | Tools | Status |
|-----------|-------|--------|
| Google Ads PPC | 6 | ✅ Live |
| Google Ads LSA Utah | 6 | ✅ Live |
| Google Ads LSA Des Moines | 6 | ✅ Live |
| GA4 (3 brands) | 18 | ✅ Live |
| GSC (3 brands) | 9 | ✅ Live |
| ServiceTitan (4 tenants) | 24 | ✅ Live |
| **Total** | **69 tools** | |


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
