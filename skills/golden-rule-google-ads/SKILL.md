---
name: golden-rule-google-ads
description: Query Google Ads campaigns, keywords, search terms, geo performance, and LSA leads across all Golden Rule accounts via MCP. Covers PPC (DSM-PPC), LSA Utah, and LSA Des Moines.
---

# Golden Rule — Google Ads MCP Skill

**Prerequisite:** Read [golden-rule-mcp](../golden-rule-mcp/SKILL.md) for connection details, curl template, and response parsing.
**Cross-reference:** [GA4 Skill](../golden-rule-ga4/SKILL.md) | [GSC Skill](../golden-rule-gsc/SKILL.md)

---

## Accounts & Tool Prefixes

| Account Name | Customer ID | Tool Prefix | Market | Type |
|-------------|-------------|-------------|--------|------|
| DSM-PPC | 448-550-2333 | `gr_google_ads_ppc_*` | Iowa + Utah | Search + PMAX |
| LSA Utah | 189-035-6117 | `gr_google_ads_lsautah_*` | Utah | Local Services |
| LSA Des Moines | 274-787-7158 | `gr_google_ads_lsadsm_*` | Iowa | Local Services |

> **Note:** Utah Search campaigns (HVAC, Water Heater, Plumbing) live in the **DSM-PPC** account, not a separate Utah account.

---

## Available Tools (6 per account = 18 total)

| Tool Suffix | Purpose | Required Args |
|-------------|---------|---------------|
| `_get_campaign_stats` | Campaign-level metrics (clicks, impressions, cost, conversions) | `start_date`, `end_date` |
| `_get_keyword_performance` | Keyword-level metrics with ad group + campaign context | `start_date`, `end_date` |
| `_get_search_terms` | Actual search queries that triggered ads | `start_date`, `end_date` |
| `_get_geographic_performance` | Performance by geographic location | `start_date`, `end_date` |
| `_get_lsa_leads` | List of LSA leads (calls, messages) | `start_date`, `end_date` |
| `_get_lsa_lead_detail` | Individual lead detail | `lead_id` |

### Parameter Format
```json
{
  "start_date": "2026-03-30",
  "end_date": "2026-04-06"
}
```
- ❌ `"date_range": "LAST_7_DAYS"` — NOT supported
- ❌ `"action": "campaigns"` — NOT supported
- ✅ ISO date strings only

---

## Campaign Structure (DSM-PPC Account, as of April 2026)

### Iowa Campaigns
| Campaign ID | Name | Type | Status |
|-------------|------|------|--------|
| 21057619182 | DSM-Plumbing-Search | SEARCH | ✅ Active |
| 21057659454 | DSM-HVAC-Service | SEARCH | ✅ Active |
| 21247624524 | DSM-Plumbing-Pmax | PMAX | ✅ Active |
| 21257970934 | DSM-Electrical-PMAX | PMAX | ✅ Active |
| 21633422052 | DSM-HVAC-PMax | PMAX | ✅ Active |

### Utah Campaigns
| Campaign ID | Name | Type | Strategy | Status |
|-------------|------|------|----------|--------|
| 22100120349 | Utah-HVAC-Search | SEARCH | Manual CPC, canary ad groups | ✅ Active |
| — | Utah-Plumbing-Search | SEARCH | Manual CPC, symptom-based keywords | ✅ Active |
| — | Utah-WH-Search | SEARCH | Manual CPC, water heater intent | ✅ Active |
| — | Utah-PMAX-HVAC | PMAX | — | ⏸ Paused |
| — | Utah-PMAX-Plumbing | PMAX | — | ⏸ Paused |

> Utah campaigns use **Manual CPC** (not Smart Bidding) until 15+ conversions are recorded. Canary ad groups run at $2-10/day budgets.

---

## Response Schema — Campaign Stats

```json
{
  "campaign": {
    "resourceName": "customers/4485502333/campaigns/21057619182",
    "advertisingChannelType": "SEARCH",
    "name": "DSM-Plumbing-Search",
    "id": "21057619182"
  },
  "metrics": {
    "clicks": "37",
    "conversions": 14.998113,
    "costMicros": "412230977",
    "impressions": "355"
  },
  "segments": {
    "date": "2026-04-06"
  }
}
```

**Parsing notes:**
- `clicks` and `impressions` are strings → parse to int
- `conversions` is a float (attribution modeling)
- `costMicros` is a string → parse to int, divide by 1,000,000 for dollars
- Results are **per-day per-campaign** — aggregate across dates yourself

---

## Response Schema — Keyword Performance

```json
{
  "campaign": { "name": "DSM-Plumbing-Search", "id": "21057619182" },
  "adGroup": { "id": "160322042580", "name": "Emergency Plumbing" },
  "metrics": { "clicks": "3", "impressions": "48", "costMicros": "26551344", "conversions": 0 },
  "adGroupCriterion": { "keyword": { "text": "plumbing service" } },
  "segments": { "date": "2026-04-06" }
}
```

---

## Common Workflows

### 1. Weekly Campaign Performance Review
```bash
# All campaigns across DSM-PPC (Iowa + Utah)
curl ... "gr_google_ads_ppc_get_campaign_stats" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

### 2. Keyword Audit — Check what's firing
```bash
# See which keywords are getting impressions/clicks
curl ... "gr_google_ads_ppc_get_keyword_performance" {"start_date":"2026-04-05","end_date":"2026-04-06"}
```

### 3. Search Term Report — What users actually searched
```bash
# Find wasteful queries or new keyword opportunities
curl ... "gr_google_ads_ppc_get_search_terms" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

### 4. Verify Geo-Targeting (50 zip codes)
```bash
curl ... "gr_google_ads_ppc_get_geographic_performance" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

### 5. LSA Lead Review
```bash
# Utah LSA leads
curl ... "gr_google_ads_lsautah_get_lsa_leads" {"start_date":"2026-03-30","end_date":"2026-04-06"}

# Iowa LSA leads (highest-volume)
curl ... "gr_google_ads_lsadsm_get_lsa_leads" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

---

## Performance Benchmarks (April 2026)

| Metric | Iowa DSM Search | Iowa LSA | Utah LSA | Utah Search |
|--------|----------------|----------|----------|-------------|
| Daily Clicks | 30-40 | 50-100 | 2-6 | 5-15 |
| CPC | $8-11 | $6-12 | $13-26/lead | $5-9 |
| Conv Rate | ~40% | ~12% | ~15% | TBD (need 2+ weeks) |
| Daily Spend | $400-500 | $200-1,300 | $0-78 | $35-75 |

---

## Known Issues

| Issue | Status | Linear | Notes |
|-------|--------|--------|-------|
| GA4 Viewer-only permissions | ❌ Active | GFV-249 | Blocks Key Events + revenue import. Need Derrick to elevate. |
| No phone→GCLID attribution | ❌ Active | GFV-304 | No DNI on Utah LPs. Planned: offline conversion import. |
| Enhanced conversions setup | 🔄 In progress | — | Enabled in DSM-PPC, awaiting Google verification (1-3 days). |
| 47 unattributed Utah calls | ❌ Active | GFV-187 | Need Greg's call mapping from ServiceTitan. |
| PMAX still active in Iowa | ⚠️ Monitoring | — | Plan to pause if Search outperforms. |
| Google Ads API token | 🔄 In progress | — | Applied via API Center for offline conversion import pipeline. |

---

## Attribution Pipeline

See `golden-rule-mcp` skill for the full attribution flow diagram. Key gaps:

1. **GCLID capture** — GTM Conversion Linker handles this ✅
2. **Phone calls** — No DNI, so phone calls can't match to ad clicks ❌
3. **Online bookings** — ScheduleEngine → ServiceTitan ✅ (full attribution)
4. **Form submissions** — Gravity Forms → GTM → GA4 ✅
5. **Offline import** — Planned: Supabase `gclid_leads` → ServiceTitan jobs → Google Ads upload


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
