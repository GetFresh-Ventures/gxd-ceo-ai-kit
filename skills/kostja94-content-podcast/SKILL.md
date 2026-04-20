---
name: podcast-marketing
description: When the user wants to plan, create, or market a podcast. Also use when the user mentions "podcast," "podcast strategy," "podcast SEO," "show notes," "podcast distribution," "Spotify podcast," "Apple Podcasts," "podcast discoverability," "PodcastEpisode schema," or "podcast repurposing." For show notes, use article-content.
metadata:
  version: 1.0.1
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


# Content: Podcast

Guides podcast strategy, content creation, distribution, marketing, and SEO. Podcasts compete in a crowded space (3M+ active shows, 500M+ listeners globally); discoverability is the primary challenge. Discovery channels: ~32% search engines, ~28% podcast apps, ~24% social media, ~16% word-of-mouth.

**When invoking**: On **first use**, if helpful, open with 1–2 sentences on what this skill covers and why it matters, then provide the main output. On **subsequent use** or when the user asks to skip, go directly to the main output.

## Initial Assessment

**Check for project context first:** If `.claude/project-context.md` or `.cursor/project-context.md` exists, read for audience, positioning, and content strategy.

Identify:
1. **Stage**: Planning, launching, growing
2. **Format**: Interview, solo, co-hosted, narrative
3. **Niche**: Target audience, listener personas
4. **Goals**: Downloads, authority, lead gen, repurposing

## Content Strategy

| Element | Guideline |
|---------|-----------|
| **Niche focus** | Define audience through listener personas; tailored content cuts through noise |
| **Quality over gimmicks** | Sticky, unique, valuable content; most hosts see major growth after 5–6 months of consistency |
| **Episode structure** | Intro, main content, CTA; consistent format aids retention |

## Distribution & Discovery

| Channel | Share | Optimization |
|---------|-------|---------------|
| **Search engines** | ~32% | Transcripts, show notes, SEO-optimized titles/descriptions |
| **Podcast apps** | ~28% | Title, description, cover art; category selection |
| **Social media** | ~24% | Clips, quotes, repurposed content |
| **Word-of-mouth** | ~16% | Cross-promotion, guest appearances |

**Multi-channel**: Repurpose across platforms to multiply discovery surface.

## SEO for Podcasts

Search engines cannot listen to audio. Text-based content is essential:

| Element | Guideline |
|---------|-----------|
| **Transcripts** | Full or key-moment transcripts; indexable, accessible |
| **Show notes** | SEO-optimized; pull organic search traffic; include keywords naturally |
| **Titles** | ≤60 chars; keywords; engaging language |
| **Descriptions** | Episode-specific; keywords; voice-search friendly |
| **Backlinks** | Build links to show notes, guest posts, directory listings |

**Schema**: Use **PodcastEpisode** and **PodcastSeries** for rich results. See **schema-markup** for implementation.

## Cross-Promotion & Partnerships

| Tactic | Use |
|--------|-----|
| **Feed drops** | Swap episodes with similar-sized podcasts |
| **Ad swaps** | Promote each other's shows |
| **Guest appearances** | Tap into pre-existing engaged audiences |

## Repurposing

| Format | Use |
|--------|-----|
| **Clips** | Short-form for social (TikTok, YouTube Shorts, X) |
| **Blog posts** | Expand show notes; pillar content |
| **Newsletter** | Episode summaries, key takeaways |
| **Quotes** | Pull quotable moments for social |

## Output Format

- **Strategy** (niche, format, distribution mix)
- **SEO checklist** (transcripts, show notes, schema)
- **Launch checklist** (cover art, description, category, RSS)
- **Repurposing plan** (clips, blog, newsletter)

## Related Skills

- **schema-markup**: PodcastEpisode, PodcastSeries schema
- **video-marketing**: Video content; podcast-to-video repurposing
- **copywriting**: Show notes, episode descriptions, social copy
- **content-marketing**: Content strategy, repurposing framework
- **youtube-seo**: If publishing podcast to YouTube


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
