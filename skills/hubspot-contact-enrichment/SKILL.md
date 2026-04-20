---
name: hubspot-contact-enrichment
description: Enrich incomplete HubSpot contacts using internal data sources (PIL ontology, Fathom transcripts, email domain heuristics, HubSpot company records) and external APIs. Fixes missing last names, emails, phone numbers, company associations, and linkedin URLs. Use when CRM data quality needs improvement or contacts have incomplete records.
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

**CRM**: HubSpot (PAT auth, deals + contacts + companies). Use `hubspot-api` skill. Linear for project tracking. Use `linear-api-access` skill.


# HubSpot Contact Enrichment Skill

## When to Use
- User asks to "enrich contacts", "fix missing data in HubSpot", "fill in incomplete contacts"
- After a CRM audit reveals contacts with missing fields (no last name, no email, no company)
- During onboarding new data sources that surface contact gaps
- Periodic CRM hygiene maintenance

## Architecture

### Enrichment Waterfall (Priority Order)
For each incomplete contact, the enricher tries these sources in order:

1. **HubSpot Internal Cross-Reference**
   - Match email domain → existing HubSpot company records
   - Match first name → other contacts at same company for lastname patterns
   - Pull company associations for unlinked contacts

2. **PIL Ontology (Supabase)**
   - Match name/email against `ont_entities` (type=person)
   - Pull `ont_facts` for LinkedIn, phone, company associations
   - Check `entity_embeddings` for Fathom/GDrive metadata

3. **Email Domain Heuristics**
   - Extract company name from email domain (e.g., `julie@medmc.ca` → "MedMC")
   - For first-name-only contacts, try `{first}.{last}@domain` pattern matching
   - Validate against known email patterns at that domain

4. **Fathom Meeting Transcripts**
   - Search PIL embeddings for contacts who appeared in meetings
   - Extract full names, titles, and company from meeting metadata

5. **External APIs** (when available)
   - Apollo.io: Phone number enrichment via `people/match` endpoint
   - Clearbit/Hunter.io: Email validation and company enrichment
   - LinkedIn profile URLs from PIL facts

### Data Flow
```
┌─────────────────────────────────────────────────────────────────────┐
│                    HubSpot CRM (Source of Truth)                    │
│   18K contacts → identify incomplete → enrich → write back         │
└─────────────┬──────────────────────────────────────────┬────────────┘
              │ Missing: lastname, email, company        │ Enriched fields
              ▼                                          ▲
┌─────────────────────────────────┐    ┌────────────────────────────┐
│   Enrichment Waterfall          │    │   HubSpot PATCH API        │
│   1. HS Company cross-ref      │───►│   /crm/v3/objects/contacts  │
│   2. PIL ontology (Supabase)   │    │   Update: lastname, phone, │
│   3. Email domain heuristics   │    │   company, jobtitle,        │
│   4. Fathom meeting metadata   │    │   linkedin URL              │
│   5. External APIs (Apollo)    │    └────────────────────────────┘
└─────────────────────────────────┘
```

## Scripts

### Main Enrichment Script
`gfv-brain/scripts/hubspot_contact_enricher.py`

```bash
# Audit mode — report all enrichment opportunities
[STUB AVOIDED] Execute hubspot_contact_enricher.py via available MCP/agent tools rather than a missing local script --audit

# Dry-run — preview what would be updated
[STUB AVOIDED] Execute hubspot_contact_enricher.py via available MCP/agent tools rather than a missing local script --dry-run

# Execute — write enriched data back to HubSpot
[STUB AVOIDED] Execute hubspot_contact_enricher.py via available MCP/agent tools rather than a missing local script --execute

# Target specific issues
[STUB AVOIDED] Execute hubspot_contact_enricher.py via available MCP/agent tools rather than a missing local script --fix-lastnames --execute
[STUB AVOIDED] Execute hubspot_contact_enricher.py via available MCP/agent tools rather than a missing local script --fix-companies --execute
[STUB AVOIDED] Execute hubspot_contact_enricher.py via available MCP/agent tools rather than a missing local script --fix-emails --execute
```

### Companion Scripts
- `hubspot_contact_cleaner.py` — Fix name formatting issues (suffixes, casing, spam)
- `hubspot_contact_to_company.py` — Migrate corporate-named contacts to company records

## Environment Variables
- `HUBSPOT_PAT` — HubSpot Private Access Token
- `SUPABASE_URL` — PIL Supabase endpoint (default: vhldndtyuuxjrvkjjdbl.supabase.co)
- `SUPABASE_ONTOLOGY_ANON_KEY` — Supabase anon key for ontology queries

## Safety
- Always run `--audit` first to understand the scope
- `--dry-run` previews all changes without writing
- HubSpot updates use PATCH (non-destructive, preserves existing data)
- Only fills empty/null fields — never overwrites existing data
- Rate-limited to respect HubSpot API limits (10 req/sec)

## Patterns Borrowed From
| Source | Pattern | How We Use It |
|--------|---------|---------------|
| kaymen99/google-maps-lead-generator | Email domain → company name extraction | Extract company from email domain for unassociated contacts |
| LessieAI/lessie-skill | Multi-source enrichment waterfall | Priority-ordered source cascade: internal → PIL → external |
| SirSeriki/HubSpotDataEnrichment | Apollo.io API → HubSpot PATCH loop | Batch enrich phone numbers, write back to HubSpot properties |
| ankaboot-source/leadminer | Email dedup & contact normalization | Deduplicate contacts by email before enrichment |
| IMI-Tool-Project/imi-enrichment-contact | Entity type classification pipeline | Cross-validate person entities across multiple sources |


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
