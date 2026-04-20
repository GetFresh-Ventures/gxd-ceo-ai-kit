---
name: ads-optimization-audit
description: End-to-end repeatable methodology for diagnosing, auditing, researching, and remediating Google Ads + Organic SEO performance. Covers competitive intelligence, keyword gaps, backlink analysis, content refresh, and ad deployment — all via SEMrush MCP and Google Ads.
---


> [!IMPORTANT]
> **GFV-Adapted Skill** — This skill runs within the GetFresh Ventures infrastructure. Follow these conventions.

### GFV Infrastructure Integration

**Credentials** — Never use `.env` files. All secrets live in macOS Keychain:
```bash
security find-generic-password -s "<service>" -a "<account>" -w
```
Check `~/Documents/Code/gfv-brain/scripts/pil_config.py` for service mappings.

**Data Sources** — Before querying external APIs, check PIL first:
- `search_pil` / `smart_search` / `vector_search` MCP tools (491K+ embeddings, 81K entities)
- Supabase tables: `entity_embeddings`, `ont_entities`, `ont_facts`
- Local SQLite: WhatsApp (59K msgs), Slack (2.5K msgs), `gfv_memory.db`

**Output** — Save results to `~/Documents/Code/gfv-brain/` or PIL via Supabase. Never send external messages (email, Slack, WhatsApp) without Diraj's explicit "send it" approval.

**Active Clients**:
- **Golden Rule PHC** — HVAC/plumbing/roofing: goldenrulephc.com, rivercityac.com, cornerstoneroofingexteriors.com
- **Aprio Board Portal** — SaaS governance: aprioboardportal.com
- **GetFresh Ventures** — Venture studio: getfreshventures.com

---

**SEO Tools Available**: SEMrush MCP, Google Search Console MCP, GA4 MCP, Lighthouse (via Chrome DevTools MCP). Use `golden-rule-semrush`, `golden-rule-gsc`, `golden-rule-ga4` skills for client-specific queries.

**Ads Infrastructure**: Google Ads MCP (3 accounts: DSM-PPC, LSA-Utah, LSA-DSM). Use `golden-rule-google-ads` and `golden-rule-google-ads-ops` skills for campaign management.


# Ads Optimization Audit — Full Cycle Skill

**Use this skill when:** Running a performance audit on Google Ads campaigns, diagnosing gaps, executing competitive research, or remediating keyword/bidding/targeting issues for any home services market.

**This skill was battle-tested on:** Golden Rule Utah market (April 2026) — HVAC, Plumbing, Water Heater, Electrical campaigns.

**Prerequisites:**
- [Golden Rule Google Ads Skill](../golden-rule-google-ads/SKILL.md) — MCP query syntax
- [Golden Rule SEMrush Skill](../golden-rule-semrush/SKILL.md) — all 36 tools + playbooks
- [PPC Keyword Strategy](../ppc-keyword-strategy/SKILL.md) — intent hierarchy & keyword design

---

## Phase 1: DIAGNOSE — Campaign Health Audit

### 1.1 Pull Account Overview
```python
# Via Google Ads MCP
gr_google_ads_campaigns(account="DSM-PPC")  # or target account

# Via SEMrush — see what SEMrush thinks our paid profile looks like
gr_semrush_domain_overview(domain="goldenrulephc.com", database="us")
```

### 1.2 Campaign-Level Audit Checklist
For each campaign, verify:

| Check | How | Red Flag |
|---|---|---|
| **Match Types** | Review keyword list | >50% Broad match = waste |
| **Budget Allocation** | Campaign settings | Budget spread across low-intent keywords |
| **Geo-Targeting** | Locations tab | Missing zip codes or too-wide radius |
| **Ad Schedule** | Ad schedule tab | Showing ads 24/7 with no bid adjustments |
| **Negative Keywords** | Neg KW list | Missing DIY, research, competitor terms |
| **Conversion Tracking** | Goals tab | Missing GCLID/GA4 attribution |
| **Search Terms** | Search terms report | >20% irrelevant queries = match type problem |

### 1.3 Key Metrics to Flag
```
CTR < 3% → ad copy needs work
CPC > $50 → keyword selection issue
Conversion Rate < 5% → landing page mismatch
Quality Score < 6 → relevance problem
```

---

## Phase 2: AUDIT — Competitive Intelligence via SEMrush

### 2.1 Identify Competitors

```python
# Step 1: Organic competitors
gr_semrush_domain_organic_competitors(domain="goldenrulephc.com", database="us")

# Step 2: Paid competitors
gr_semrush_domain_paid_competitors(domain="goldenrulephc.com", database="us")
```

Pick top 2-3 competitors by overlapping keyword count.

### 2.2 Keyword Gap Analysis

```python
# Our organic keywords (top 100 by traffic)
our = gr_semrush_domain_organic(domain="goldenrulephc.com", database="us",
                                 display_limit=100, display_sort="tr_desc")

# Competitor keywords
comp = gr_semrush_domain_organic(domain="competitor.com", database="us",
                                  display_limit=100, display_sort="tr_desc")
```

**Analysis:** Cross-reference keyword sets:
- **Missing keywords:** They rank, we don't → ADD to campaigns or content plan
- **Weak keywords:** We rank worse → OPTIMIZE existing pages
- **Filter criteria:** Volume > 100, KD < 40, CPC < $30

### 2.3 Paid Keyword Reverse-Engineering

```python
# What keywords are competitors bidding on?
gr_semrush_domain_paid(domain="competitor.com", database="us", display_limit=50)

# Who else bids on our target keywords?
gr_semrush_keyword_paid_results(phrase="plumber salt lake city", database="us")
```

### 2.4 Backlink Gap Analysis

```python
# IMPORTANT: Always include target_type="root_domain"
gr_semrush_backlinks_overview(target="goldenrulephc.com", target_type="root_domain")
gr_semrush_backlinks_refdomains(target="goldenrulephc.com", target_type="root_domain",
                                 display_limit=50)

# Compare with competitors
gr_semrush_backlinks_overview(target="competitor.com", target_type="root_domain")
gr_semrush_backlinks_refdomains(target="competitor.com", target_type="root_domain",
                                 display_limit=50)
```

**Analysis:** Find domains linking to competitors but NOT us. Sort by Authority Score. Output 20+ outreach targets.

### 2.5 Anchor Text Audit

```python
gr_semrush_backlinks_anchors(target="goldenrulephc.com", target_type="root_domain",
                              display_limit=25)
```

**Healthy distribution:**
- Branded: 30-40%
- Naked URL: 20-30%
- Generic ("visit", "click here"): 15-20%
- Keyword-rich: <15% (over-optimization if higher)
- **Flag spam anchors** like telegram/SEO service links → add to GSC disavow

### 2.6 Content Refresh Priority List

```python
# Top pages by organic traffic
gr_semrush_domain_organic_urls(domain="goldenrulephc.com", database="us",
                                display_limit=30, display_sort="traffic_desc")

# Keyword profile for top blog posts
gr_semrush_url_organic_keywords(url="https://goldenrulephc.com/blog/slug/", database="us")
```

**Prioritize by:** High keyword count + low traffic = underperforming pages that need refresh.

---

## Phase 3: RESEARCH — Keyword Opportunities

### 3.1 Related Keywords by Service

```python
# For each service line, pull related keywords sorted by volume
for phrase in ["water heater repair utah", "emergency plumber salt lake city",
               "ac repair utah", "furnace repair salt lake city"]:
    gr_semrush_keyword_related(phrase=phrase, database="us",
                                display_limit=20, display_sort="nq_desc")
```

### 3.2 Question Keywords (for ad copy + content)

```python
for phrase in ["water heater repair", "plumber near me", "ac not working"]:
    gr_semrush_keyword_questions(phrase=phrase, database="us", display_limit=15)
```

### 3.3 NAP Consistency Check

```python
# Check our SERP presence for brand queries
for query in ["golden rule plumbing heating cooling", "golden rule plumbing utah"]:
    gr_semrush_keyword_organic_results(phrase=query, database="us", display_limit=20)
```

**Verify NAP on:** Google Business, Yelp, Angi, BBB, Thumbtack, Facebook, Yellow Pages, Apple Maps, Bing Places, DexKnows, Local Chamber of Commerce.

---

## Phase 4: REMEDIATE — Deploy Changes

### 4.1 Add Keywords to Google Ads (Browser)

Navigate to Google Ads → Campaign → Keywords → "+" button → Ad Group → Enter keywords.

**Match type rules:**
- **Phrase match** (wrap in quotes): Default for all new keywords
- **Exact match** (wrap in brackets): Use for high-CPC keywords > $40
- **Broad match** (no wrapping): AVOID — only use with Smart Bidding and conversion data

**Template:**
```
Campaign: Utah-Plumbing-Search → Ad Group: Utah-Plumbing
"plumber salt lake city"
"plumbers davis county utah"
"drain service near me"

Campaign: Utah-HVAC-Search → Ad Group: Utah-Heating
"furnace installation near me"
"furnace tune up near me"
"hvac salt lake city"
```

### 4.2 Add Negative Keywords

Apply negatives at account level or campaign level:

```
DIY negatives: how to, DIY, parts, manual, diagram, troubleshoot
Research negatives: salary, jobs, training, school, certification
Competitor negatives: [competitor brand names]
Irrelevant: free, cheap, used, rental
```

### 4.3 Geo-Targeting Verification

Verify zip codes in Locations tab cover the full service area. Use radius + zip code targeting together.

### 4.4 Update Linear Issues

After every remediation step:
1. Move Linear issue to "Done"
2. Add comment with specific changes made
3. Post project status update

---

## Phase 5: MONITOR — Ongoing Health

### 5.1 Weekly Search Term Review

Follow: `/search-term-review` workflow (every Monday)

### 5.2 Weekly SEMrush Intel Script

Run: `scripts/weekly_semrush_intel.py`

Tracks:
- Authority Score trend
- Organic keyword count
- Competitor position changes
- New backlinks

### 5.3 Monthly Full Audit

Repeat Phases 1-4 monthly:
1. Re-pull keyword gaps (competitors shift)
2. Check for new negative keyword needs from search terms
3. Verify geo-targeting is current
4. Refresh content priority list
5. Update Linear milestones

---

## MCP Tool Quick Reference

### SEMrush Tools (sorted by audit phase)

| Phase | Tool | Purpose |
|---|---|---|
| Diagnose | `gr_semrush_domain_overview` | Traffic, authority, keyword count |
| Audit | `gr_semrush_domain_organic` | Our organic keyword rankings |
| Audit | `gr_semrush_domain_organic_competitors` | Who ranks for same keywords |
| Audit | `gr_semrush_domain_paid_competitors` | Who bids on same keywords |
| Audit | `gr_semrush_domain_paid` | Competitor paid keywords |
| Audit | `gr_semrush_keyword_paid_results` | Who's bidding on a keyword |
| Audit | `gr_semrush_backlinks_overview` | Total backlinks, domains (use target_type!) |
| Audit | `gr_semrush_backlinks_refdomains` | Referring domains list |
| Audit | `gr_semrush_backlinks_anchors` | Anchor text distribution |
| Research | `gr_semrush_keyword_related` | Related keywords by volume |
| Research | `gr_semrush_keyword_questions` | Question-format queries |
| Research | `gr_semrush_keyword_broad_match` | Broad match variations |
| Content | `gr_semrush_domain_organic_urls` | Top pages by traffic |
| Content | `gr_semrush_url_organic_keywords` | Keywords for a specific URL |
| Track | `gr_semrush_tracking_positions` | Position tracking |

### Critical MCP Notes

- **Always set `database: "us"`** — all properties US-based
- **Backlink tools REQUIRE `target_type: "root_domain"`** — omitting this causes 400 errors
- **Accept header required:** `"Accept": "application/json, text/event-stream"` for Python scripts
- **Token env var:** `MCP_API_BEARER_TOKEN` in `.env.local`
- **SSE parsing:** Response is `data: {json}` format — parse last `data:` line
- **Rate limits:** SEMrush has daily API limits — batch queries, save to disk, don't repeat

---

## Output Artifacts

Every audit run should produce:

| File | Purpose |
|---|---|
| `data/semrush_intel/our_organic_keywords.json` | Our keyword rankings |
| `data/semrush_intel/competitor_*_keywords.json` | Competitor keywords |
| `data/semrush_intel/our_backlinks_overview.json` | Our backlink profile |
| `data/semrush_intel/anchor_text_distribution.json` | Anchor text health |
| `data/semrush_intel/top_organic_urls.json` | Content refresh priority |
| `data/semrush_intel/service_keyword_opportunities.json` | Keyword expansion |
| `data/semrush_intel/directory_presence_check.json` | NAP/directory audit |

---

## Applying to New Markets

To run this audit for a new market (e.g., new city, new service area):

1. **Update competitors:** Change the COMPETITORS list to local players
2. **Update geo keywords:** Replace "salt lake city" / "utah" with target market
3. **Update campaigns:** Target the correct Google Ads campaign IDs
4. **Update service lines:** Adjust keyword phrases for the specific services offered
5. **Run Phases 1-4 in sequence** — the SEMrush tools work for any domain

The framework is market-agnostic. The keyword design principles (Tier 1 symptom → Tier 5 research) apply universally to all home services markets.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
