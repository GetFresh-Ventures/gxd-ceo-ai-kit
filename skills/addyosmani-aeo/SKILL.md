---
name: addyosmani-aeo
description: >
  Answer Engine Optimization (AEO) toolkit by Addy Osmani. Node.js CLI for
  optimizing content visibility in AI search engines (ChatGPT, Perplexity,
  Gemini, Copilot). Analyzes pages for AI-citation readiness, schema markup,
  and structured data patterns that AI engines prefer.
  Use when: optimizing content for AI search visibility, checking if pages get cited by LLMs.
  Skip when: doing traditional SEO only (use agentic-seo or seo-audit-tools).
---

# Answer Engine Optimization (AEO)

> [!IMPORTANT]
> **GFV-Adapted Skill** — This skill runs within the GetFresh Ventures infrastructure.

### GFV Infrastructure Integration

**SEO Tools Available**: SEMrush MCP, Google Search Console MCP, GA4 MCP, Lighthouse (via Chrome DevTools MCP). Use `golden-rule-semrush`, `golden-rule-gsc`, `golden-rule-ga4` skills for client-specific queries.

**Active Client Sites for AEO**:
- goldenrulephc.com (home services — local AEO critical)
- aprioboardportal.com (SaaS — thought leadership AEO)
- getfreshventures.com (venture studio — brand AEO)

---

## Overview

AEO optimizes content for **AI-powered search engines** — ChatGPT, Perplexity, Google AI Overviews, Copilot, and Claude. Unlike traditional SEO (ranking in blue links), AEO focuses on getting your content **cited** in AI-generated answers.

## When to Use AEO vs Traditional SEO

| Scenario | Use |
|---|---|
| Content should appear in AI answers | AEO (this skill) |
| Content should rank in Google blue links | `agentic-seo` or `seo-audit-tools` |
| Schema markup / JSON-LD | Both — schema helps both |
| Content for AI Overviews | Both — AEO + SEO overlap here |

## AEO Audit Checklist

### 1. Structure for Citation

AI engines cite content that is **well-structured and directly answerable**:

- [ ] **Answer-first format** — Direct answer in first 40-60 words after each H2
- [ ] **QAE pattern** — Question (H2) → Answer → Evidence
- [ ] **TL;DR block** — 50-100 word summary at top of page
- [ ] **Key Takeaways** — 5-7 bullet points (cited ~35% more by AI)
- [ ] **FAQ section** — Explicit Q&A pairs with FAQ JSON-LD schema

### 2. Schema Markup for AI

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [{
    "@type": "Question",
    "name": "How much does AC repair cost in Salt Lake City?",
    "acceptedAnswer": {
      "@type": "Answer",
      "text": "AC repair in Salt Lake City typically costs $89-$450..."
    }
  }]
}
```

Priority schema types for AEO:
- `FAQPage` — Highest AI citation rate
- `HowTo` — Step-by-step instructions
- `Article` — Blog posts with author/date
- `LocalBusiness` — Service area pages
- `Product` — Pricing/feature pages

### 3. Content Patterns AI Prefers

| Pattern | Why AI Cites It |
|---|---|
| **Definitive statements** | "The average cost is $X" vs "costs vary" |
| **Numbered lists** | Easy to extract and cite |
| **Comparison tables** | Structured data AI can parse |
| **Original data** | Unique stats AI can't find elsewhere |
| **Expert attribution** | "According to [Name], [Title]..." |

### 4. What Kills AI Citations

- ❌ Vague language ("it depends", "results may vary")
- ❌ Walls of text with no structure
- ❌ Missing schema markup
- ❌ Thin content (<300 words)
- ❌ Duplicate content available elsewhere
- ❌ Content behind login/paywall

## CLI Usage (Node.js Tool)

```bash
# Install
npm install -g aeo-tool  # or use npx

# Audit a page
npx aeo-tool audit https://goldenrulephc.com/ac-repair-salt-lake-city

# Check AI citation readiness
npx aeo-tool check-citation https://aprioboardportal.com/board-meeting-software
```

## Related Skills
- **agentic-seo**: Traditional SEO audit (blue links)
- **seo-audit-tools**: Comprehensive site-level SEO scan
- **seo-geo-claude**: Full SEO + GEO framework
- **opc-seo-geo**: SEO + GEO analysis tool
- **seobuild-onpage**: SEO page writing for LLM citation

## References
- **Source**: [AEO by Addy Osmani](https://github.com/nichochar/aeo)
- **GEO Research**: Content with TL;DR + Key Takeaways cited ~35% more


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
