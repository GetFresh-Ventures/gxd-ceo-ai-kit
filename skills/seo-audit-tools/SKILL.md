---
name: squirrelscan
description: "CLI-based SEO site auditor with 230+ rules across 21 categories. Supports incremental crawling, E-E-A-T auditing, and LLM-optimized output. Use when the user asks for 'site audit', 'crawl my site', 'squirrel scan', or comprehensive multi-page SEO analysis."
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


# SquirrelScan — 230+ Rule Site Auditor

## Overview
CLI-based website auditing tool with 230+ rules across 21 categories. Designed for AI agent workflows with LLM-optimized output formats.

## Installation
```bash
# macOS (recommended)
curl -fsSL https://squirrelscan.com/install | bash

# Or via npm
npm install -g squirrelscan

# Or npx (no install)
npx squirrelscan audit https://example.com
```

## Usage

### Basic Audit
```bash
squirrel audit https://getfreshventures.com
```

### With Output Format
```bash
# JSON for programmatic processing
squirrel audit https://getfreshventures.com -f json -o audit.json

# Markdown for documentation
squirrel audit https://getfreshventures.com -f markdown -o audit.md

# LLM-optimized for AI analysis
squirrel audit https://getfreshventures.com --format llm

# HTML report
squirrel audit https://getfreshventures.com -f html -o report.html
```

### Limit Pages
```bash
squirrel audit https://getfreshventures.com -m 10
```

## Rule Categories (230+ Rules)

| Category | Rules | Focus |
|----------|-------|-------|
| **Accessibility** | 56 | ARIA, button/input names, landmarks, lists, tables, focus |
| **Performance** | 24 | Core Web Vitals, compression, caching, JS optimization |
| **Crawlability** | 15 | Robots.txt, sitemaps, indexability |
| **Security** | 15 | HTTPS, CSP, cookies, leaked secrets (96 patterns) |
| **Links** | 15 | Broken links, redirects, anchor text |
| **Images** | 15 | Alt text, formats, lazy loading, optimization |
| **Content** | 15 | Readability, freshness, word count |
| **E-E-A-T** | 14 | Authority, trust, expertise signals |
| **Core** | 13 | Meta tags, canonical, doctype, charset |
| **Structured Data** | 11 | JSON-LD, schema validation |
| **URL Structure** | 8 | Length, format, parameters |
| **Mobile** | 6 | Viewport, tap targets, responsive |
| **Social Media** | 4 | Open Graph, Twitter Cards |
| **SEO** | 4 | Meta robots, indexability |
| **Video** | 3 | Schema, captions, thumbnails |
| **Local SEO** | 3 | NAP, geo tags, service areas |
| **Legal** | 3 | Privacy policy, cookie consent |
| **Internationalization** | 2 | Hreflang, lang attribute |
| **Analytics** | 2 | GTM, consent mode |
| **AI Detection** | 2 | AI content signals |
| **Adblock Detection** | 2 | Blocked elements, tracking |

## GFV Audit Checklist (Derived from SquirrelScan Rules)

When auditing getfreshventures.com, focus on these high-impact categories:

### P0 — Critical
- [ ] **E-E-A-T (14 rules)**: Author bios, expertise signals, trust indicators
- [ ] **Core (13 rules)**: Meta tags, canonical URLs, charset
- [ ] **Structured Data (11 rules)**: JSON-LD Organization, Article schema
- [ ] **Crawlability (15 rules)**: Sitemap, robots.txt, indexability

### P1 — Important
- [ ] **Content (15 rules)**: Readability scores, freshness signals, word count
- [ ] **Links (15 rules)**: Broken links, redirect chains, anchor text quality
- [ ] **Security (15 rules)**: HTTPS, CSP headers, leaked secrets scan
- [ ] **Performance (24 rules)**: CWV, compression, caching headers

### P2 — Enhancement
- [ ] **Social Media (4 rules)**: OG tags, Twitter Cards
- [ ] **Mobile (6 rules)**: Viewport, tap targets
- [ ] **Images (15 rules)**: Alt text, WebP/AVIF, lazy loading
- [ ] **Accessibility (56 rules)**: ARIA, landmarks, focus management

## Key Features for GFV
- **Incremental Crawling**: ETag, Last-Modified, content hashing — resume from checkpoints
- **Crawl History**: Track site evolution, compare crawls, spot regressions
- **LLM Output**: `--format llm` gives structured output optimized for AI analysis
- **E-E-A-T Dedicated Rules**: 14 rules specifically testing Experience, Expertise, Authority, Trust
- **Secret Leak Detection**: 96 patterns for detecting leaked API keys, tokens, credentials


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
