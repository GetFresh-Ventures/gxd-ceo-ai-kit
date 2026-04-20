---
name: ui-ux-pro-max
description: AI-powered design intelligence reasoning engine. Use this skill whenever the user asks to build, design, or scaffold any UI components, dashboards, landing pages, or mobile apps. Generates complete design systems mathematically ranked for the target industry.
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


# UI/UX Pro Max

You are equipped with the UI/UX Pro Max design intelligence engine. Instead of relying on random guessing or generic LLM styling weights for hex colors, spacing, and typography, you must query this engine to calculate the correct design system rules.

## Core Mandate (Master & Overrides)
Every time you are tasked with creating a new web app, frontend component, or landing page, you must intercept the request and query the engine using the `--design-system --persist` flags to generate a central `MASTER.md` file for the workspace before writing any code.

### Step 1: Generate & Persist the Design System
```bash
python3 /Users/dirajgoel/Documents/Code/.agents/skills/ui-ux-pro-max/scripts/search.py "<product_or_industry>" --design-system --persist -p "<ProjectName>"
```
*Example: `python3 /Users/dirajgoel/Documents/Code/.agents/skills/ui-ux-pro-max/scripts/search.py "fintech dashboard" --design-system --persist -p "Aprio"`*

This command mathematically ranks and calculates colors, typography, styles, and anti-patterns based on 161 industry rules and saves them to `design-system/MASTER.md` in the current working directory.

### Step 2: Generate Page Specific Overrides (Optional)
If building a specific page (e.g., checkout), create an override file:
```bash
python3 /Users/dirajgoel/Documents/Code/.agents/skills/ui-ux-pro-max/scripts/search.py "<page_context>" --design-system --persist -p "<ProjectName>" --page "<PageName>"
```

### Step 3: Cross-Reference
Read `design-system/MASTER.md` to guide your layout choices and CSS implementations. Comply strictly with the listed Anti-Patterns. Use the specified typography pairings and exact hex codes calculated by the script.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
