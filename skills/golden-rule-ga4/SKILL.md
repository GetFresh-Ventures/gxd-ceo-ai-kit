---
name: golden-rule-ga4
description: Query GA4 analytics for all Golden Rule properties (goldenrulephc.com, rivercityac.com, cornerstoneroofingexteriors.com) via MCP. Covers site traffic, conversions, device breakdown, landing pages, and realtime data.
---

# Golden Rule — GA4 MCP Skill

**Prerequisite:** Read [golden-rule-mcp](../golden-rule-mcp/SKILL.md) for connection details, curl template, and response parsing.
**Cross-reference:** [Google Ads Skill](../golden-rule-google-ads/SKILL.md) | [GSC Skill](../golden-rule-gsc/SKILL.md)

---

## Properties & Tool Prefixes

| Property | Website | Tool Prefix | GA4 Property ID |
|----------|---------|-------------|-----------------|
| Golden Rule PHC | goldenrulephc.com | `gr_ga4_grphc_*` | 319584840 |
| River City AC | rivercityac.com | `gr_ga4_rivercity_*` | — |
| Cornerstone Roofing | cornerstoneroofingexteriors.com | `gr_ga4_cornerstone_*` | — |

---

## Available Tools (5 per property = 15 total)

| Tool Suffix | Purpose | Required Args |
|-------------|---------|---------------|
| `_get_site_traffic` | Users, sessions by source/medium/date | `start_date`, `end_date` |
| `_get_conversions` | Conversion events by date | `start_date`, `end_date` |
| `_get_device_breakdown` | Desktop vs mobile vs tablet | `start_date`, `end_date` |
| `_get_landing_pages` | Top landing pages by traffic | `start_date`, `end_date` |
| `_get_realtime` | Live active users right now | **NONE** |

### Parameter Format
```json
{
  "start_date": "2026-03-30",
  "end_date": "2026-04-06"
}
```

> ⚠️ **`_get_realtime` takes NO arguments.** Pass empty: `"arguments": {}`

---

## Response Schema — Site Traffic

Dimensions: [date, source, medium] | Metrics: [activeUsers, newUsers, sessions]

```json
{
  "dimensionValues": [
    {"value": "20260402"},     // date (YYYYMMDD)
    {"value": "google"},       // source
    {"value": "organic"}       // medium
  ],
  "metricValues": [
    {"value": "144"},          // activeUsers
    {"value": "136"},          // newUsers
    {"value": "231"}           // sessions
  ]
}
```

**Parsing notes:**
- Date format is `YYYYMMDD` (no dashes)
- All metric values are strings → parse to int
- Results are per-day per-source — aggregate yourself
- `(direct) / (none)` = direct traffic
- `google / organic` = SEO
- `google / cpc` = paid Google Ads

---

## Response Schema — Conversions

Dimensions: [date, source, medium] | Metrics: [eventCount, eventRevenue, sessions]

```json
{
  "dimensionValues": [
    {"value": "20260402"},
    {"value": "(not set)"},
    {"value": "(not set)"}
  ],
  "metricValues": [
    {"value": "46"},           // eventCount
    {"value": "2"},            // eventRevenue ($)
    {"value": "47"}            // sessions
  ]
}
```

> ⚠️ **Revenue is near-zero** ($0-$2/day). This is because GA4 property 319584840 has Viewer-only permissions, blocking Google Ads revenue import. Greg must call RM for Editor access (Linear: GFV-249).

---

## Response Schema — Realtime

Dimensions: [pageTitle] | Metrics: [activeUsers, screenPageViews, conversions]

```json
{
  "dimensionValues": [
    {"value": "Contact | Golden Rule | Grimes, IA"}
  ],
  "metricValues": [
    {"value": "1"},            // activeUsers
    {"value": "1"},            // screenPageViews
    {"value": "0"}             // conversions
  ]
}
```

---

## Common Workflows

### 1. Traffic Overview (7 days)
```bash
curl ... "gr_ga4_grphc_get_site_traffic" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

### 2. Conversion Audit
```bash
# Are phone_call_click and form_submission events firing?
curl ... "gr_ga4_grphc_get_conversions" {"start_date":"2026-04-01","end_date":"2026-04-06"}
```

### 3. Device Split (mobile vs desktop)
```bash
curl ... "gr_ga4_grphc_get_device_breakdown" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

### 4. Landing Page Performance
```bash
# Which pages drive the most traffic?
curl ... "gr_ga4_grphc_get_landing_pages" {"start_date":"2026-03-30","end_date":"2026-04-06"}
```

### 5. Live Users Right Now
```bash
# No date args!
curl ... "gr_ga4_grphc_get_realtime" {}
```

### 6. Cross-Brand Comparison
```bash
# Run all 3 in parallel
for brand in grphc rivercity cornerstone; do
  curl ... "gr_ga4_${brand}_get_site_traffic" {"start_date":"...","end_date":"..."} &
done
wait
```

---

## Traffic Benchmarks (April 2026)

### Golden Rule PHC (goldenrulephc.com)
| Source | Daily Users | Daily Sessions |
|--------|------------|----------------|
| Google Organic | 100-144 | 150-230 |
| Direct | 30-50 | 40-70 |
| Google CPC | 5-15 | 10-25 |
| Realtime Users | 3-8 | — |

### River City AC (rivercityac.com)
- Primary traffic from email campaigns ("Free Inspection CRE")
- Direct traffic: ~20 users/day

### Cornerstone Roofing
- Email campaigns are top traffic source
- Lower overall volume

---

## Known Issues

1. **GA4 Viewer-only permissions** — Property 319584840 blocks revenue import from Google Ads. Conversion revenue shows $0-$2/day instead of actual values.
2. **`(not set)` source/medium** — Majority of conversions have `(not set)` attribution = unattributed. This improves once GA4 ↔ Google Ads link has Editor access.
3. **52% unattributed Utah calls** — Need Greg's 15-number call tracking mapping list (GFV-187).
4. **GTM v92 is LIVE** — 55 tags, 27 triggers, 39 variables deployed. `phone_call_click` and `form_submission` events are configured but need verification via Tag Assistant.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
