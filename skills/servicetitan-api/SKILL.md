---
name: servicetitan-api
description: Access ServiceTitan data for Golden Rule PHC via MCP connector. Covers multi-tenant queries, job data, lead attribution, business units, technician performance, and revenue tracking.
---

# ServiceTitan API Access (Golden Rule)

## Status: ✅ Working (via MCP)

## Access Method

ServiceTitan data is accessed through the **Golden Rule MCP connector**, not direct API calls.

- **MCP Skill**: See `golden-rule-mcp/SKILL.md` for connection details
- **Endpoint**: `https://gr-connectors-web.vercel.app/api/mcp`
- **Auth**: Bearer token via `op read "op://Machine One/GR MCP Bearer Token/credential"`

## Multi-Tenant Structure

Golden Rule has **4 ServiceTitan tenants**:

| Tenant | Tool Prefix | Market | Services |
|--------|-------------|--------|----------|
| `utah` | `gr_servicetitan_utah_*` | Salt Lake City, UT | Plumbing, HVAC |
| `grimes` | `gr_servicetitan_grimes_*` | Des Moines/Grimes, IA | Plumbing, HVAC, Electrical, Sewer |
| `rivercity` | `gr_servicetitan_rivercity_*` | Des Moines, IA | HVAC |
| `rivercity2` | `gr_servicetitan_rivercity2_*` | Des Moines, IA | HVAC |

## Available Tools (per tenant)

| Tool Suffix | Purpose | Required Args |
|-------------|---------|---------------|
| `_get_jobs` | Jobs by date range, status, revenue | `start_date`, `end_date` |
| `_get_leads` | Inbound leads, source attribution | `start_date`, `end_date` |
| `_get_business_units` | Business unit list (services offered) | none |
| `_get_technician_performance` | Revenue per tech, job counts | `start_date`, `end_date` |
| `_get_revenue` | Revenue breakdown by period | `start_date`, `end_date` |
| `_get_customers` | Customer records | `start_date`, `end_date` |

## Common Queries

### Check what services Utah actually offers
```bash
TOKEN=$(op read "op://Machine One/GR MCP Bearer Token/credential")
curl -s --max-time 25 -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"gr_servicetitan_utah_get_business_units","arguments":{}}}' \
  https://gr-connectors-web.vercel.app/api/mcp
```

### Utah jobs this week
```bash
curl ... "gr_servicetitan_utah_get_jobs" {"start_date":"2026-04-07","end_date":"2026-04-09"}
```

## Utah Verified Services (from ServiceTitan job data)

### ✅ Plumbing Services
Leak repair, water heater (tank + tankless), water softener, drain cleaning, toilet, faucet, shower/bath fixtures, garbage disposal, sump pump, gas lines, repiping

### ✅ HVAC Services
Heating repair, cooling repair, AC replacement, furnace replacement

### ⛔ NOT Offered in Utah
Sewer lines, sewer repair, sewer replacement — **zero** sewer jobs in ServiceTitan Utah tenant. Do NOT create sewer-related ads or landing pages for Utah.

## Attribution Integration

### Current State (April 2026)
- **Online bookings** → ScheduleEngine → ServiceTitan directly (✅ full attribution)
- **Phone calls** → CSR manually creates in ServiceTitan (❌ no GCLID passthrough)
- **Revenue tracking** → ServiceTitan jobs show revenue per job (✅ available via MCP)

### Known Issues
| Issue | Linear | Impact |
|-------|--------|--------|
| No DNI (Dynamic Number Insertion) | GFV-304 | Can't match phone calls to ad clicks |
| $0 revenue in some UT jobs | GFV-109 | Cross-campaign revenue zero-outs |
| 47 unattributed Utah calls | GFV-187 | Unknown campaign source |

## Key Contacts

| Person | Role | Context |
|--------|------|---------|
| Greg Romans | GM, Utah | Ask about financing, services, team |
| Derrick | Tech lead | GA4/GTM access elevation |
| Arvin | MCP connector dev | ServiceTitan tool additions |


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
