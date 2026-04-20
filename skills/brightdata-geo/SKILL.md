---
name: brightdata-geo
description: "CrewAI-based GEO (Generative Engine Optimization) agent from Bright Data. Uses 6 AI agents to audit webpage content, generate search queries via Gemini+Google Search, fetch Google AI Overviews via Bright Data SERP API, compare results, and output actionable optimization suggestions. Requires: Python 3.10+, uv, SERP API key from Bright Data."
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

**SEO Tools Available**: SEMrush MCP, Google Search Console MCP, GA4 MCP, Lighthouse (via Chrome DevTools MCP). Use `golden-rule-semrush`, `golden-rule-gsc`, `golden-rule-ga4` skills for client-specific queries.


# Bright Data GEO Agent — AI Content Optimization

## Overview
6-agent CrewAI pipeline that audits any webpage against Google AI Overview results to generate content optimization recommendations. The methodology is the real value — can be replicated without the Bright Data dependency.

## 6-Agent Architecture

### Agent 1: Title Scraper
- **Role**: Extract H1/title from target URL
- **How**: Scrapes page content, finds `<h1>` or infers title
- **Output**: Plain text title string

### Agent 2: Query Fan-Out Researcher
- **Role**: Generate comprehensive search query expansion from the title
- **How**: Uses Gemini + Google Search grounding to perform live web search
- **Output**: Full query fan-out in Markdown (related queries, People Also Ask, sub-topics)

### Agent 3: Main Query Extractor
- **Role**: Distill the fan-out into the single most important Google-style search query
- **How**: Parses query fan-out, identifies the core keyphrase
- **Output**: Short, clear Google-style search query

### Agent 4: AI Overview Retriever
- **Role**: Fetch Google's AI Overview for the extracted query
- **How**: SERP search with `brd_ai_overview=2` flag to get AI Overview content
- **Output**: AI Overview section in Markdown
- **Fallback**: If no AI Overview exists, generates one from SERP results

### Agent 5: Query Fan-Out Summarizer
- **Role**: Summarize the full query fan-out into structured themes
- **How**: Condenses fan-out into clear, actionable summary
- **Output**: Markdown summary of main themes/sub-topics

### Agent 6: AI Content Optimizer
- **Role**: Compare your content summary against Google AI Overview
- **How**: Pattern matching, similarity analysis, gap identification
- **Output**: Comparison report with action items

## GFV-Adapted Methodology (No Bright Data Required)

Replicate this pipeline using existing tools:

### Step 1: Extract Title → `chrome-devtools-mcp → take_snapshot`
### Step 2: Query Fan-Out → `search_web` with H1 as query
### Step 3: Main Query → Distill to core keyphrase
### Step 4: Get AI Overview → Search in Google browser, capture AIO content
### Step 5: Content Gap → Compare page vs AI Overview
### Step 6: Action Items → Specific optimization recommendations

## Key Pattern: Gemini + Google Search Grounding

```python
# Use camelCase "googleSearch" not "google_search" for LiteLLM
tools.insert(0, {"googleSearch": {}})
```

## Output Format

| Aspect | Your Content | AI Overview | Similarities | Differences |
|--------|-------------|-------------|--------------|-------------|
| Topic A | Coverage | AI coverage | Common themes | Missing elements |

## When to Use
- Optimizing blog posts for AI Overview citation
- Auditing competitor content against AI Overview
- Identifying content gaps for GEO optimization
- Building content briefs based on what AI engines surface


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
