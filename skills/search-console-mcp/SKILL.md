---
name: search-console-mcp
description: "Expert skill for installing, configuring, and troubleshooting the Search Console MCP server."
version: "1.0.0"
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


# Search Console MCP Server (saurabhsharma2u/search-console-mcp)

## Overview
Full MCP server providing 40+ tools for Google Search Console, Bing Webmaster Tools, and GA4. TypeScript/Node.js. Requires OAuth setup.

## Installation

```bash
# Clone
git clone https://github.com/saurabhsharma2u/search-console-mcp.git
cd search-console-mcp

# Install
npm install

# Setup (interactive OAuth flow)
npx search-console-mcp setup
```

## MCP Configuration

Add to your MCP config:
```json
{
  "mcpServers": {
    "search-console-mcp": {
      "command": "npx",
      "args": ["-y", "search-console-mcp"]
    }
  }
}
```

## Available Tools (40+)

### 📈 Analytics & Performance
| Tool | Description |
|---|---|
| `analytics_query` | Master query tool — full control over dimensions, filters, aggregation |
| `analytics_performance_summary` | Aggregate metrics (clicks, impressions, CTR, position) |
| `analytics_compare_periods` | Week-over-Week/Month-over-Month comparison |
| `analytics_top_queries` | Top search queries by clicks/impressions |
| `analytics_top_pages` | Top performing pages |
| `analytics_by_country` | Performance breakdown by country |
| `analytics_trends` | Rising/falling traffic trend detection |
| `analytics_anomalies` | Unusual daily spikes or drops |
| `analytics_drop_attribution` | Correlate drops with mobile/desktop or algorithm updates |
| `analytics_time_series` | Rolling averages, seasonality, trend forecasting |

### 🎯 SEO Opportunities
| Tool | Description |
|---|---|
| `seo_low_hanging_fruit` | Keywords at positions 5-20 with high impressions |
| `seo_striking_distance` | Keywords at 8-15 — easiest ROI wins |
| `seo_low_ctr_opportunities` | Top 10 ranking but poor CTR (<60% benchmark) |
| `seo_lost_queries` | Queries that lost >80% traffic or went to zero |
| `seo_cannibalization` | Multiple pages competing for same keywords (Conflict Score) |
| `seo_brand_vs_nonbrand` | Segment traffic by brand/non-brand regex |
| `seo_quick_wins` | Pages with many Page 2 keywords pushable to Page 1 |
| `seo_recommendations` | Prioritized general SEO recommendations |

### ⚛️ SEO Primitives
| Tool | Description |
|---|---|
| `seo_primitive_ranking_bucket` | Categorize position ("Top 3", "Page 1") |
| `seo_primitive_traffic_delta` | Calculate change between metrics |
| `seo_primitive_is_brand` | Regex-based brand query check |
| `seo_primitive_is_cannibalized` | Check URL overlap |

### 🔍 Inspection & Validation
| Tool | Description |
|---|---|
| `inspect_url` | Live URL inspection (indexing, coverage, mobile) |
| `inspect_index_status` | Quick index status check |

### 🗺️ Sitemaps
| Tool | Description |
|---|---|
| `sitemaps_list` | List all submitted sitemaps |
| `sitemaps_submit` | Submit a new sitemap |
| `sitemaps_delete` | Remove a sitemap |

### 🏥 Site Health
| Tool | Description |
|---|---|
| `sites_list` | List all verified properties |
| `sites_health` | Overall site health metrics |

### 🔗 Bing Webmaster Tools
| Tool | Description |
|---|---|
| `bing_analytics` | Bing search analytics |
| `bing_crawl_stats` | Crawl statistics |
| `bing_index_now` | Submit URLs for instant indexing |
| `bing_links` | Inbound link analysis |
| `bing_keywords` | Keyword intelligence |

### 📊 GA4 Integration
| Tool | Description |
|---|---|
| `ga4_analytics` | Core GA4 reporting |
| `ga4_behavior` | User behavior analysis |
| `ga4_pagespeed` | PageSpeed Insights via GA4 |
| `ga4_realtime` | Real-time analytics |
| `ga4_properties` | Property management |

## GFV Properties to Configure
- `https://www.getfreshventures.com` (GSC)
- `https://goldenrulephc.com` (GSC)
- `https://rivercityac.com` (GSC)
- `https://cornerstoneroofingexteriors.com` (GSC)
- `https://aprioboardportal.com` (GSC)

## Setup Checklist
- [ ] Clone repo and `npm install`
- [ ] Run `npx search-console-mcp setup` for OAuth
- [ ] Add to MCP config (Gemini or Claude)
- [ ] Verify access to all GFV properties
- [ ] Test with `analytics_top_queries` on getfreshventures.com


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
