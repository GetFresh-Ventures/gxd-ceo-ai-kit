---
name: eeat-content-pod
description: "Multi-agent autonomous content revocation and creation pod. Generates ultra-high E-E-A-T, historically accurate, deeply localized content by dynamically spinning up a custom Client Context Engine (via Firecrawl, GDrive, or CRM) before writing. Use when scaling local business content, bypassing generic AI slop, or overtaking national competitors in search."
short_description: "Run the E-E-A-T Content Revitalization Pod"
metadata:
  version: 1.0.0
  category: growth-engine
  triggers:
    - write content
    - refresh blog post
    - programmatic seo
    - eeat content
    - multi-agent writer
---

# E-E-A-T Content Pod

A 4-agent orchestration strategy designed to build **Generative Engine Optimized (GEO)** and **E-E-A-T verified** content for local businesses. This skill shifts content generation from "single-prompt guessing" to "multi-agent synthesis" powered by real-world proprietary data.

## Quick Start
Just say any of these:
- "Run the content pod on this competitor's article"
- "Rewrite our HVAC pricing page using the latest business system data"
- "Draft a new service page for Plumbing repair in [City], use local context"

## Architecture: The 4-Agent Pod

When invoked, the OpenClaw Orchestrator must immediately adopt the **Code 7/9 (Complex/Heavy)** coordination mode to manage the following 4 discrete agents in sequence:

### 1. The Recon Scout (Agent 1)
**Goal:** Map the enemy terrain and identify the "Helpful Content" gap.
**Instructions:**
- Run `firecrawl-web-search` against the target keyword.
- Scrape the Top 3 organic competitors.
- Extract their precise Subheading hierarchies, specific schema types (e.g., FAQPage, ProductReview), and identifying weak points (e.g., "Generic stock photos used" or "Prices not listed").

### 2. The Client Context Miner (Agent 2)
**Goal:** Gather the "Experience, Expertise, Authoritativeness" (E-E-A) proof points specific to the client.
**Instructions:**
- **Dynamic Context Search:** If local CEO Brain memory is available, query it for transcripts and actual quotes from the company leaders.
- **Client Fallback:** If local memory is not available, use `search_web` over the client's own domain (`site:clientdomain.com`) or prompt the user for relevant Fathom transcripts / internal pricing docs.
- **Output:** A strict "Truth File" containing pure facts: local pricing, names of technicians, specific zip-code challenges, and exact quotes. No fluff.

### 3. The Compliance Writer (Agent 3)
**Goal:** Synthesize the Recon gaps and the Client Context into a Master Draft.
**Instructions:**
- Do not write standard SEO paragraphs. Output strict **Bottom-Line Up-Front (BLUF)** formatting.
- Embed a proprietary Data Table (e.g., Good/Better/Best Pricing Table based on Agent 2's data).
- Write an Anti-AI format: No "In today's fast-paced world." Use direct, local syntax.
- **Mandatory Schema:** Output raw JSON-LD (FAQ, Product Review, or Service) customized to the client's localized entity.

### 4. The Publisher (Agent 4)
**Goal:** Prep the asset for zero-friction launch.
**Instructions:**
- Generate exact metadata (URL slug = do not change if refreshing, update Title and Meta Description).
- Provide the exact Gutenberg/Cornerstone HTML structure or package it for webhook delivery to the CMS via `wordpress-page-creation`.

## The Hand-Off Protocol

This skill does NOT decide *what* to write. 
- Wait for `content-strategy` to provide the **Priority Topics list**.
- Run `eeat-content-pod` per priority URL.
- Output the Draft locally, triggering the **Draft Review Before Send** executive approval gate.

## Quality Gate (E-E-A-T Check)

Before presenting the final draft to the CEO, the orchestrator must Verify:
- [ ] **Experience:** Does the content explicitly mention a past job, a local neighborhood, or a firsthand client experience?
- [ ] **Expertise:** Is a specific internal SME (Subject Matter Expert) quoted by name?
- [ ] **Authoritativeness:** Does the JSON-LD Schema match the entity data?
- [ ] **Trust:** Are the prices/figures explicitly tied to actual ranges (no generic estimated fluff)?

## E-E-A-T Scoring Framework (Dec 2025 Core Update)

Google's Dec 2025 core update **extended E-E-A-T to virtually all competitive queries**.
Even entertainment/lifestyle now requires demonstrated expertise. Generic content no longer ranks.

**Impact by industry** (source: Bhanunamikaze/Agentic-SEO-Skill):

| Industry | Avg Traffic Decline |
|----------|-------------------|
| Affiliate sites | 71% |
| Health/YMYL | 67% |
| E-commerce | 52% |

### Experience (Weight: 20%)
First-hand knowledge and personal involvement with the topic:
- [ ] Author has demonstrable first-hand experience with the topic
- [ ] Content includes original photos, screenshots, or data
- [ ] Case studies with specific details (not generic examples)
- [ ] Before/after results or outcome data
- **Strong**: Multiple first-hand experience signals, original content
- **Weak**: Generic information, no personal touch
- **None**: Clearly AI-generated or scraped

### Expertise (Weight: 25%)
Subject matter knowledge and qualifications:
- [ ] Author credentials visible in byline + linked bio page
- [ ] Content demonstrates deep subject knowledge
- [ ] Technical accuracy verified against authoritative sources
- [ ] References to relevant certifications, experience, or research

### Authoritativeness (Weight: 25%)
Recognition from peers and industry:
- [ ] Backlinks from authoritative sources
- [ ] Cited by other experts in the space
- [ ] Brand mentioned in industry publications
- [ ] Third-party reviews or endorsements

### Trustworthiness (Weight: 30%)
Accuracy, transparency, and security:
- [ ] Factual accuracy verified (no fabrications)
- [ ] Citations and sources provided for claims
- [ ] Clear business contact information
- [ ] Secure website (HTTPS, privacy policy)
- [ ] Transparent about author identity and affiliations

### YMYL Topics (Highest E-E-A-T Standards)
- Health and safety
- Financial advice and transactions
- Legal information
- News and current events
- **Elections and civic trust** (added Sept 2025)
- **Democratic processes** (added Sept 2025)

### Publish-Readiness Gate (CORE-EEAT)
Before any content goes live, score against these veto checks:
- [ ] **T04**: No unsourced claims in YMYL content → VETO if violated
- [ ] **C01**: No plagiarized or duplicate content → VETO if violated
- [ ] **R10**: No deceptive or misleading claims → VETO if violated

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| Recon | Live SERP structure | `firecrawl-web-search` |
| Intel | Local Client Context | `gfv-brain-search.py` or `search_web (site:domain)` |
| Publisher | CMS Delivery | `wordpress-page-creation` |

> **GFV Rule:** The Writer (Agent 3) must NOT hallucinate prices. If Agent 2 cannot find pricing data, Agent 3 must output a red `<Missing Data>` tag demanding the CEO inject the pricing manually.

## Confidence Tagging
All claims must utilize the index:
- 🟢 **Verified** — Confirmed natively via local memory or client domain.
- 🔴 **Assumed** — Hallucinated or generated by LLM default (must be actively pruned).

## After This Skill
💡 Suggest these next:
- "Try `wordpress-page-creation` — Deploy this E-E-A-T draft immediately to the CMS"
- "Try `social-engine` — Splinter this pillar content into 5 hyper-local Linked/Twitter posts"


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
