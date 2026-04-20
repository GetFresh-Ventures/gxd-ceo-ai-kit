---
name: seo-geo-claude
description: >-
  SEO + GEO (Generative Engine Optimization) framework from aaron-he-zhu.
  Covers build, commands, connectors, cross-cutting concerns, monitoring,
  optimization, and research workflows for both traditional and AI search.
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


# SEO-GEO Claude Skills

Comprehensive SEO+GEO framework with modules for:
- **build/** — page construction and deployment
- **commands/** — CLI automation
- **connectors/** — API integrations (GSC, GA4, etc.)
- **cross-cutting/** — shared patterns (auth, logging, caching)
- **monitor/** — rank tracking, indexation monitoring
- **optimize/** — on-page, technical, content optimization
- **research/** — keyword research, competitor analysis

See AGENTS.md for full agent configuration.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
