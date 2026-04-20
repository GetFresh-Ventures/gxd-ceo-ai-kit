---
name: golden-rule-semrush
description: Query SEMrush data for Golden Rule properties (goldenrulephc.com, rivercityac.com, cornerstoneroofingexteriors.com) via MCP. Covers domain analysis, keyword research, backlinks, site audit, position tracking, and competitive intelligence.
---

# Golden Rule SEMrush MCP Skill

**Use this skill when:** Analyzing organic/paid search performance, identifying keyword opportunities, monitoring competitors, auditing site health, or building content strategy for any Golden Rule property.

## Connection Details

- **MCP Endpoint:** `https://gr-connectors-web.vercel.app/api/mcp`
- **Auth:** Bearer token from `golden-rule-dashboard/.env.local` → `SUPABASE_MCP_TOKEN`
- **Format:** JSON-RPC 2.0 with SSE response parsing

## Available Tools (36 total)

### Domain Analysis (7 tools)

| Tool | Purpose | Key Args |
|---|---|---|
| `gr_semrush_domain_overview` | Traffic, keywords, authority score | `domain`, `database` |
| `gr_semrush_domain_organic` | Organic keyword rankings | `domain`, `database`, `display_limit`, `display_sort` |
| `gr_semrush_domain_paid` | Paid keyword positions | `domain`, `database`, `display_limit` |
| `gr_semrush_domain_organic_competitors` | Who ranks for same keywords | `domain`, `database` |
| `gr_semrush_domain_paid_competitors` | Who bids on same keywords | `domain`, `database` |
| `gr_semrush_domain_organic_subdomains` | Subdomain traffic split | `domain`, `database` |
| `gr_semrush_domain_organic_urls` | Top pages by organic traffic | `domain`, `database`, `display_sort` |

### Keyword Research (6 tools)

| Tool | Purpose | Key Args |
|---|---|---|
| `gr_semrush_keyword_overview` | Volume, CPC, competition for a keyword | `phrase`, `database` |
| `gr_semrush_keyword_organic_results` | Who ranks organically for keyword | `phrase`, `database` |
| `gr_semrush_keyword_paid_results` | Who's bidding on keyword | `phrase`, `database` |
| `gr_semrush_keyword_related` | Related keywords by volume | `phrase`, `database`, `display_sort` (nq_desc = by volume) |
| `gr_semrush_keyword_broad_match` | Broad match variations | `phrase`, `database` |
| `gr_semrush_keyword_questions` | Question-format queries | `phrase`, `database`, `display_sort` |

### Backlinks (8 tools)

| Tool | Purpose |
|---|---|
| `gr_semrush_backlinks_overview` | Total backlinks, domains, authority |
| `gr_semrush_backlinks_list` | Individual backlink URLs |
| `gr_semrush_backlinks_referring_domains` | Linking domains |
| `gr_semrush_backlinks_anchors` | Anchor text distribution |
| `gr_semrush_backlinks_pages` | Most linked-to pages |
| `gr_semrush_backlinks_tld` | TLD distribution |
| `gr_semrush_backlinks_historical` | Historical trend |
| `gr_semrush_backlinks_categories` | Category breakdown |

### Site Audit (4 tools)

| Tool | Purpose |
|---|---|
| `gr_semrush_siteaudit_info` | Audit status and health score |
| `gr_semrush_siteaudit_snapshots` | List of audit snapshots |
| `gr_semrush_siteaudit_snapshot_details` | Detailed snapshot metrics |
| `gr_semrush_siteaudit_issues` | Current issues found |

### Position Tracking (4 tools)

| Tool | Purpose |
|---|---|
| `gr_semrush_tracking_campaigns` | List tracking campaigns |
| `gr_semrush_tracking_positions` | Current keyword positions |
| `gr_semrush_tracking_overview` | Position distribution summary |
| `gr_semrush_tracking_history` | Position changes over time |

### URL-Level Analysis (2 tools)

| Tool | Purpose |
|---|---|
| `gr_semrush_url_organic_keywords` | Keywords a specific URL ranks for |
| `gr_semrush_url_paid_keywords` | Keywords a specific URL bids on |

### Project Management (2 tools)

| Tool | Purpose |
|---|---|
| `gr_semrush_projects_list` | List all SEMrush projects |
| `gr_semrush_projects_get` | Get project details |

---

## Common Workflows

### 1. Weekly Competitor Gap Analysis

```python
# Step 1: See who we compete with organically
gr_semrush_domain_organic_competitors(domain="goldenrulephc.com", database="us")

# Step 2: Check their keyword counts vs ours
gr_semrush_domain_overview(domain="truepros.com", database="us")  # top competitor

# Step 3: Find keywords they rank for that we don't
# Compare organic keywords between domains:
gr_semrush_domain_organic(domain="truepros.com", database="us", display_limit=50, display_sort="tr_desc")
gr_semrush_domain_organic(domain="goldenrulephc.com", database="us", display_limit=50, display_sort="tr_desc")
```

### 2. Keyword Opportunity Identification

```python
# Find high-volume, low-competition keywords
gr_semrush_keyword_related(phrase="water heater repair", database="us", display_limit=20, display_sort="nq_desc")
gr_semrush_keyword_broad_match(phrase="emergency plumber", database="us", display_limit=20)

# Find question keywords for content/FAQ pages
gr_semrush_keyword_questions(phrase="furnace repair", database="us", display_limit=15)
```

### 3. Ad Copy Competitive Intelligence

```python
# See who's bidding on your target keywords
gr_semrush_keyword_paid_results(phrase="plumber salt lake city", database="us", display_limit=10)

# See what keywords competitors bid on
gr_semrush_domain_paid(domain="valleyplumbing.com", database="us", display_limit=20)
```

### 4. Landing Page Optimization

```python
# Find which pages drive the most organic traffic
gr_semrush_domain_organic_urls(domain="goldenrulephc.com", database="us", display_limit=15, display_sort="traffic_desc")

# See what keywords a specific landing page ranks for
gr_semrush_url_organic_keywords(url="https://goldenrulephc.com/service/plumbing/", database="us")
```

### 5. Backlink Monitoring

```python
# Check authority and link profile
gr_semrush_backlinks_overview(target="goldenrulephc.com")

# Find most linked-to pages (content that attracts links)
gr_semrush_backlinks_pages(target="goldenrulephc.com", display_limit=10)

# Check anchor text distribution (should be diverse, not spammy)
gr_semrush_backlinks_anchors(target="goldenrulephc.com", display_limit=15)
```

### 6. Position Tracking Review

```python
# List active tracking campaigns
gr_semrush_tracking_campaigns()

# Check current positions for tracked keywords
gr_semrush_tracking_positions(campaign_id="<id>")

# Check position history for trends
gr_semrush_tracking_history(campaign_id="<id>")
```

---

## Current Data Snapshot (Apr 7, 2026)

### goldenrulephc.com
- **Rank:** 324,591 | **Authority Score:** 27
- **Organic Keywords:** 9,889 | **Organic Traffic:** 4,923/mo
- **Paid Keywords:** Active (SEMrush sees our Google Ads)
- **Backlinks:** 5,163 from 1,081 domains
- **Top Organic Competitor:** truepros.com (360 common keywords)

### Top Organic Pages (by traffic share)
1. Homepage — 49.8%
2. `/blog/outside-breaker-box-purpose-location-homeowners/` — 13.1%
3. `/blog/cant-i-just-purchase-a-drain-snake/` — 4.0%
4. `/blog/what-does-it-mean-that-march-comes-in-like-a-lion/` — 2.5%
5. `/blog/how-to-safely-relight-the-pilot-light/` — 1.6%

### Site Health
- 701 healthy pages | 1 broken | 141 blocked | 128 redirected

### Position Tracking
- 17 keywords tracked in Des Moines
- Tracking engines: Google, Google AI, SearchGPT
- Current status: Most broad service terms showing "not ranking" — need content/SEO work

---

## Properties

| Property | Domain | Notes |
|---|---|---|
| Golden Rule (Iowa + Utah) | goldenrulephc.com | Primary — HVAC, Plumbing, Electrical, WH |
| River City AC | rivercityac.com | Iowa subsidiary |
| Cornerstone Roofing | cornerstoneroofingexteriors.com | Roofing + Exteriors |

---

## Tips

- **Always set `database: "us"`** — all properties are US-based
- **`display_sort: "nq_desc"`** sorts by search volume (highest first)
- **`display_sort: "tr_desc"`** sorts by traffic (most traffic first)
- **`display_limit`** defaults vary — always set explicitly (10-50 for most queries)
- **SSE parsing:** API returns `data: {json}` format — split on `"data: "` and parse the last chunk
- **Rate limits:** SEMrush API has daily limits — batch queries, don't repeat unnecessarily


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
