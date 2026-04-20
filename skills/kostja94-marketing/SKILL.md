---
name: kostja94-marketing
description: >-
  Comprehensive marketing skills library with 172 skills across analytics,
  channels, content, pages, paid-ads, platforms (Pinterest, TikTok, YouTube,
  LinkedIn, X, Reddit, GitHub, Medium), SEO, and strategies. Reference library
  for marketing execution patterns.
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


# Kostja94 Marketing Skills

172-skill marketing reference library organized by category:
- **analytics/** — tracking, attribution, funnel analysis
- **channels/** — email, social, referral, organic
- **components/** — CTAs, forms, landing page elements
- **content/** — blog, video, podcast, whitepapers
- **pages/** — landing pages, pricing pages, case studies
- **paid-ads/** — Google Ads, Meta Ads, LinkedIn Ads
- **platforms/** — Pinterest, TikTok, YouTube, LinkedIn, X, Reddit, GitHub, Medium
- **seo/** — technical, on-page, off-page, local
- **strategies/** — launch, growth funnel, retention

See skills/ subdirectory for individual SKILL.md files.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
