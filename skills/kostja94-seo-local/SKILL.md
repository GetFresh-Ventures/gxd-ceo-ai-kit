---
name: local-seo
description: When the user wants to optimize for local search, set up Google Business Profile, or build local citations. Also use when the user mentions "local SEO," "Google Business Profile," "Google Maps," "NAP," "citations," "local search," "local business," or "service area." For location pages, use programmatic-seo.
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

**SEO Tools Available**: SEMrush MCP, Google Search Console MCP, GA4 MCP, Lighthouse (via Chrome DevTools MCP). Use `golden-rule-semrush`, `golden-rule-gsc`, `golden-rule-ga4` skills for client-specific queries.


# SEO: Local

Guides local SEO: Google Business Profile, NAP consistency, and citation building. Businesses with accurate NAP across 40+ authoritative sites see ~19% higher visibility in Google Maps. Use this skill when optimizing for local search, setting up GBP, or auditing citations.

**When invoking**: On **first use**, if helpful, open with 1–2 sentences on what this skill covers and why it matters, then provide the main output. On **subsequent use** or when the user asks to skip, go directly to the main output.

## Initial Assessment

**Check for project context first:** If `.claude/project-context.md` or `.cursor/project-context.md` exists, read Sections 4 (Audience), 5 (Website).

Identify:
1. **Business type**: Storefront vs service-area
2. **Location**: Single or multiple
3. **Current listings**: Existing GBP, directories

## NAP Consistency

**NAP** = Name, Address, Phone. Critical for local rankings.

| Rule | Guideline |
|------|-----------|
| **Exact match** | "Street" vs "St." or "LLC" inconsistency = Google may treat as different entities |
| **Fix first** | Audit and fix inconsistencies before adding new citations |
| **Tools** | BrightLocal, Whitespark, Moz Local for audit |

## Google Business Profile

| Element | Guideline |
|---------|-----------|
| **Address** | Physical address; no P.O. boxes |
| **Description** | 750 chars; primary keywords in first 100 |
| **Hours** | Accurate; seasonal availability |
| **Category** | Primary category matches business type |
| **Service-area** | Hide address if no storefront; define service areas |

## Citation Building

**Targeted precision** over submitting to every directory.

**Priority order**:
1. Google Business Profile
2. Apple Maps
3. Yelp, Bing Places, Facebook
4. Better Business Bureau, Foursquare, Nextdoor
5. Niche directories (Healthgrades, Angi, etc.)

## Citation Audit

- Incorrect or outdated data
- Duplicate entries
- Missing listings on key directories

Fix before adding; compounding errors harm rankings.

## Output Format

- **NAP** (exact format for consistency)
- **GBP** optimization checklist
- **Citation** priority list
- **Audit** findings (if applicable)

## Related Skills

- **geo**: GEO for AI search; local + AI overlap
- **localization-strategy**: Multilingual; local + i18n
- **directory-submission**: Directory listings; different from local citations


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
