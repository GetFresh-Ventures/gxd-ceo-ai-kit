---
name: blog-post-writer
description: "Python-based blog post generator using DuckDuckGo Search + LLM. Fetches web references for a keyword, extracts content, and generates SEO-optimized blog posts. Use when asked to 'write a blog post', 'generate content for [topic]', or 'create an article about [keyword]'."
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

**Content Pipeline**: WordPress REST API for Golden Rule (goldenrulephc.com) and Aprio (aprioboardportal.com). Use `wordpress-page-creation` or `aprio-site-deployment` skills for publishing.


# Blog Post Writer — RAG-Based Content Generation

## Overview
Python agent that generates SEO blog posts using a Retrieval-Augmented Generation (RAG) architecture: DuckDuckGo Search → Web scrape → FAISS vector store → LLM generation. The patterns are valuable for GFV content generation.

## Architecture Pattern (Stolen)

### RAG Pipeline for Blog Content
```
1. Keyword Input
   ↓
2. DuckDuckGo Search (top N results for keyword)
   ↓
3. Web Scrape (BeautifulSoup, extract p/h1-h6 elements only)
   ↓
4. Chunk (RecursiveCharacterTextSplitter: 2000 chars, 400 overlap)
   ↓
5. Embed & Index (FAISS vector store)
   ↓
6. Retrieve (similarity search, k=10 chunks)
   ↓
7. Generate (LLM with keyword + retrieved context)
   ↓
8. Output (formatted Markdown blog post)
```

### Key Parameters
- **chunk_size**: 2000 characters
- **chunk_overlap**: 400 characters (20%)
- **retrieval_k**: 10 most similar chunks
- **max_web_references**: 10
- **soup_strainer**: Only `p`, `h1`-`h6` tags (skip nav, footer, ads)

## Blog Post Prompt Template (Stolen & Improved)

The original prompt enforces:
```
1. SEO-optimized title (concise, no "Exploring" or "Discover" prefixes)
2. Minimum 5 sections with 3 sub-sections each
3. Minimum 3 paragraphs per sub-section
4. Proper markdown formatting
5. Real-world examples
6. Forward-looking conclusion
7. Human, engaging tone
```

### GFV-Adapted Blog Post Prompt

When generating blog posts for getfreshventures.com, use this enhanced template:

```
Given the following research context, generate a blog post targeting: {keyword}

Requirements:
- Title: SEO-optimized, concise, no filler words ("Exploring", "Discover", "Ultimate Guide")
- Tone: Authoritative but accessible, VC-insider perspective
- Structure: 5+ sections, 3 sub-sections each, 3+ paragraphs per sub-section
- Include: Real startup examples, data points with citations, founder quotes
- E-E-A-T signals: Reference GFV portfolio companies, Diraj's experience, industry data
- GEO optimization: Include quotable one-liners, structured data points, comparison tables
- CTA: Natural integration of GFV Fellowship program where relevant
- Format: Proper markdown with h2/h3 hierarchy

Context: {context}
```

## GFV Implementation (No OpenAI Dependency)

Replace the original's OpenAI+FAISS stack with our existing tools:

### Step 1: Research
```python
# Use search_web or DuckDuckGo to find top references
# OR use opc-requesthunt to find demand signals
```

### Step 2: Content Extraction
```python
# Use read_url_content to fetch markdown from top references
# OR use firecrawl-web-search for JS-rendered pages
```

### Step 3: Generate
```python
# Feed research context + our blog prompt template to the LLM
# Apply seo-geo-claude → content-quality-auditor before publishing
```

## When to Use
- Writing new GFV Insights blog posts
- Generating competitor research articles
- Creating Fellowship program content
- Building SEO pillar pages around target keywords


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
