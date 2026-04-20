---
name: pinterest-posts
description: When the user wants to create Pinterest Pins, optimize Pin descriptions, or grow Pinterest presence. Also use when the user mentions "Pinterest," "Pin," "Pinterest SEO," "Pinterest description," "Pinterest board," or "Pinterest marketing." For asset specs, use visual-content.
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


# Platforms: Pinterest

Guides Pinterest Pin creation and optimization. Pinterest users search differently than Google; long-tail keywords like "easy fall dinner recipes" perform better than broad terms. Use this skill when creating Pins, optimizing boards, or planning Pinterest content.

**When invoking**: On **first use**, if helpful, open with 1–2 sentences on what this skill covers and why it matters, then provide the main output. On **subsequent use** or when the user asks to skip, go directly to the main output.

## Initial Assessment

**Check for project context first:** If `.claude/project-context.md` or `.cursor/project-context.md` exists, read Sections 6 (Keywords), 11 (Content Strategy).

Identify:
1. **Content type**: Product, recipe, tutorial, inspiration
2. **Board**: Where Pin will be saved first (shapes Pinterest's understanding)
3. **Goal**: Traffic, sales, email signups

## Pin Title

| Rule | Guideline |
|------|-----------|
| **Length** | Up to 100 chars; first 40 visible in feeds |
| **Keyword** | Primary keyword in first 40 chars |
| **Business name** | In first sentence → 54% higher email signup conversion |

## Pin Description

| Rule | Guideline |
|------|-----------|
| **Length** | 220–232 chars optimal |
| **Keywords** | Main + 2–3 related; natural placement |
| **CTA** | Clear, actionable → 70% signup boost, 6% sales lift |
| **Price** | When relevant → 28% sales increase |

## Board SEO

- **Board name** and description are ranking factors
- **First save** board shapes Pinterest's content understanding
- Use keywords in board title and description

## 2025 Algorithm Notes

- **Fresh content**: New URL + new image + new board = max distribution
- **Alt text**: Pins with alt text earn ~25% more impressions, 123% more clicks
- **Consistency**: Keyword-optimized content to relevant boards

## Output Format

- **Title** (under 100 chars)
- **Description** (220–232 chars)
- **Board** recommendation
- **Alt text** suggestion

## Related Skills

- **content-marketing**: Pinterest as channel
- **display-ads**: Pinterest Ads (if paid)
- **visual-content**: Cross-channel visual planning; Pinterest Pin specs in context
- **url-slug-generator**: URL for landing page


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
