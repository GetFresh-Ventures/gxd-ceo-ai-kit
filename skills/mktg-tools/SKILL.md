---
name: mktg-tools
description: >-
  60 zero-dependency Node.js CLI wrappers for marketing APIs (GA4, Semrush,
  Ahrefs, Google Ads, HubSpot, Apollo, Clearbit, Mixpanel, etc.) plus 70+
  integration guides. Use when querying external marketing APIs from the
  command line. Each tool supports --dry-run for safe previews.
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


# Marketing CLI Tools

60 zero-dependency Node.js CLI wrappers for marketing APIs.

## Usage Pattern
```bash
node tools/clis/<tool-name>.js            # Show usage/help
node tools/clis/<tool-name>.js <cmd> --dry-run  # Preview without sending
```

## Categories & Tools

### Analytics
ga4, mixpanel, amplitude, plausible, adobe-analytics, segment, hotjar

### SEO
semrush, ahrefs, dataforseo, keywords-everywhere, google-search-console

### Advertising
google-ads, meta-ads, linkedin-ads, tiktok-ads

### Email & Marketing Automation
mailchimp, klaviyo, customer-io, sendgrid, postmark, resend, brevo, beehiiv, kit

### CRM & Sales
close, apollo, hunter, snov, instantly, lemlist, outreach

### Data Enrichment
clearbit, clay, supermetrics, coupler

### Referral & Affiliate
rewardful, partnerstack, mention-me, tolt

### Other
calendly, savvycal, buffer, dub, typeform, wistia, trustpilot, g2,
intercom, pendo, onesignal, optimizely, demio, livestorm, crossbeam

## Integration Guides
See `tools/integrations/` for detailed API setup instructions for each tool.

## Tool Registry
See `tools/REGISTRY.md` for the full matrix of capabilities per tool.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
