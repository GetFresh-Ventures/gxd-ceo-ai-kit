---
name: firecrawl-web-search
description: Perform advanced Web Search and Deep URL Scraping using Firecrawl. Use this whenever standard HTTP requests fail due to JavaScript rendering rendering walls, Cloudflare blocks, or when competitive data requires high-fidelity markdown extraction.
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


# Firecrawl Web Search & Scraping

## Context
Standard `curl` or basic MCP HTTP requests often fail on modern B2B websites (e.g., ServiceTitan competitors, HVAC pricing pages) because the sites rely heavily on JavaScript to render content, or they deploy aggressive anti-bot filtering.

This skill leverages **Firecrawl**, a tool adapted from the `openclaude` architecture, to perform full-browser JS-rendered scraping and return the content as clean, agent-readable markdown.

## Setup Requirements
Ensure the `FIRECRAWL_API_KEY` is exported in the environment.

## Usage Commands

### 1. Scrape a specific URL
When you have a specific URL (like a competitor's plumbing landing page) and you need to extract the pricing copy, use `scrape` mode.

```bash
[STUB AVOIDED] Execute firecrawl_search.py via available MCP/agent tools rather than a missing local script scrape "https://competitor.com/pricing"
```
*Note: This will return the highly-structured markdown representation of the page, ignoring the DOM noise.*

### 2. Search the Web
When you need to find fresh information (like "Who are the top HVAC private equity buyers in Utah?"), use `search` mode.

```bash
[STUB AVOIDED] Execute firecrawl_search.py via available MCP/agent tools rather than a missing local script search "Top HVAC Private Equity buyers Utah 2026"
```
*Note: This will return the Top 5 results with a snippet, Title, URL, and aggressively fetched Markdown content for the specific search.* 

## Workflow Integration
- Whenever you are doing the **Explore** phase of a complex analysis, prefer `firecrawl_search.py search` to quickly snapshot market conditions before moving to the Planning Phase.
- Store output in `~/brain/competitors/` to maintain durable context for the overarching CEO.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
