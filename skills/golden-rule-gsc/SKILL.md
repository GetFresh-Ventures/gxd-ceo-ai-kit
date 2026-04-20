---
name: golden-rule-gsc
description: Query Google Search Console performance data for all Golden Rule properties (goldenrulephc.com, rivercityac.com, cornerstoneroofingexteriors.com) via MCP. Covers search queries, clicks, impressions, CTR, and position.
---

# Golden Rule — Google Search Console MCP Skill

**Prerequisite:** Read [golden-rule-mcp](../golden-rule-mcp/SKILL.md) for connection details, curl template, and response parsing.
**Cross-reference:** [Google Ads Skill](../golden-rule-google-ads/SKILL.md) | [GA4 Skill](../golden-rule-ga4/SKILL.md)

---

## Properties & Tool Prefixes

| Property | Website | Tool Name |
|----------|---------|-----------|
| Golden Rule PHC | goldenrulephc.com | `gr_gsc_grphc_get_search_performance` |
| River City AC | rivercityac.com | `gr_gsc_rivercity_get_search_performance` |
| Cornerstone Roofing | cornerstoneroofingexteriors.com | `gr_gsc_cornerstone_get_search_performance` |

Each property has exactly **1 tool** — `_get_search_performance`.

---

## Parameters

```json
{
  "start_date": "2026-03-30",
  "end_date": "2026-04-06"
}
```

Both `start_date` and `end_date` are required. ISO date format (YYYY-MM-DD).

> **GSC data lag:** GSC data is typically 2-3 days behind. If querying up to today, the most recent 2-3 days may have partial or no data.

---

## Response Schema

Keys: [date, query, page] | Metrics: clicks, impressions, ctr, position

```json
{
  "keys": [
    "2026-04-02",                           // date
    "golden rule plumbing heating cooling & electrical",  // query
    "https://goldenrulephc.com/"            // page URL
  ],
  "clicks": 9,
  "impressions": 43,
  "ctr": 0.20930232558139536,
  "position": 1.1627906976744187
}
```

**Parsing notes:**
- `keys` is always [date, query, url] — array of 3 strings
- `clicks`, `impressions` are integers (not strings like Google Ads)
- `ctr` is a decimal (0.209 = 20.9%) — multiply by 100 for percentage
- `position` is a float — 1.0 = top of page 1; round for display
- Results are per-day per-query per-page

---

## Common Workflows

### 1. Weekly Search Performance
```bash
curl ... "gr_gsc_grphc_get_search_performance" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

### 2. Cross-Brand Search Comparison
```bash
for brand in grphc rivercity cornerstone; do
  curl ... "gr_gsc_${brand}_get_search_performance" {"start_date":"...","end_date":"..."} &
done
wait
```

### 3. Identify Non-Brand Query Opportunities
Parse results and filter out queries NOT containing "golden rule", "river city", or "cornerstone" to find organic keyword gaps.

### 4. Landing Page Audit
Group results by `keys[2]` (page URL) to see which pages attract the most organic clicks.

---

## Search Performance Benchmarks (April 2026)

### Golden Rule PHC — Top Queries

| Query | Daily Clicks | Impressions | CTR | Position |
|-------|-------------|-------------|-----|----------|
| golden rule plumbing heating cooling & electrical | 4-9 | 20-43 | 16-23% | 1.0-1.2 |
| golden rule plumbing | 4-6 | 30-40 | 13-18% | 2.0-3.8 |
| golden rule | 3-4 | 20-25 | 15-17% | 2.5-2.7 |

**Key observations:**
- Brand queries dominate — position 1-3 for all branded terms
- Non-brand queries (service-specific like "plumbing repair near me") are lower volume
- Schema deployment (213+ pages) should improve rich result appearance over time

---

## Cross-Reference with Other Properties

### GSC → Google Ads
- Compare organic queries (GSC) with paid search terms (Google Ads `_get_search_terms`) to identify:
  - Cannibalization: are you paying for queries you rank #1 organically?
  - Gaps: queries with high impressions but low CTR → consider paid coverage

### GSC → GA4
- Compare GSC landing page clicks with GA4 landing page sessions to validate traffic alignment
- If GSC shows clicks but GA4 shows 0 sessions → tracking/redirect issue

---

## Known Issues

1. **2-3 day data lag** — GSC data is not real-time. Most recent 2-3 days will be incomplete.
2. **213+ pages with schema** — Deployed site-wide. Monitor `position` changes over 4-8 weeks for impact.
3. **No Utah-specific GSC filtering** — GSC shows all goldenrulephc.com queries (Iowa + Utah). Filter by page URL containing "/utah" or Utah-specific query terms for market-level analysis.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
