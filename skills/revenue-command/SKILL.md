---
name: revenue-command
description: "Master GTM Visibility Command Center. Merges pipeline monitoring, deal deep-dives, sales enablement, and conversion optimization into a single, data-first revenue hub. Requires live data from HubSpot, ServiceTitan, or GA4 before responding."
short_description: "Master GTM visibility & pipeline orchestration"
metadata:
  version: 1.0.0
  category: ceo-command-center
  origin: Consolidated from pipeline-pulse, deal-review, sales-enablement, conversion-optimizer
  triggers:
    - revenue
    - pipeline
    - metrics
    - conversions
    - deals
    - sales
---

# Revenue Command Center

Your Master GTM Visibility Hub. Stop scanning 15 different dashboards. This command center aggregates pipeline state, flags at-risk deals, models conversion choke points, and builds the collateral needed to close.

> **GxD Architectural Rule**: This skill is DATA-FIRST. It must query HubSpot, ServiceTitan, Linear, or GA4 APIs before generating a response. Hallucinated pipeline numbers will result in immediate failure.

## Sub-Modes
Revenue Command dynamically routes your request to one of four internal engines:

1. **Pipeline Pulse** (Macro View)
   - *Trigger*: "What's our pipeline looking like?"
   - *Action*: Pulls total deal value, stage distribution, momentum (wins/losses), and stalled deals.

2. **Deal War Room** (Micro View)
   - *Trigger*: "Deep dive into the [X] enterprise deal."
   - *Action*: Aggregates all call transcripts (Fathom), emails (HubSpot/Gmail), and stakeholder maps to identify leverage points and blockers.

3. **Sales Enablement** (Tactical Execution)
   - *Trigger*: "I need a one-pager addressing SOC2 objections for [Client]."
   - *Action*: Synthesizes current deal objections and generates targeted pitch decks, one-pagers, or negotiation battle cards.

4. **Conversion Optimizer** (Funnel Mechanics)
   - *Trigger*: "Why did demo requests drop this week?"
   - *Action*: Analyzes GA4 traffic vs HubSpot form submissions to pinpoint friction in landing pages, forms, or onboarding flows.

---

## 🛑 Hard Gates (DO NOT EXECUTE WITHOUT CHECKING)
- **Data Presence**: Have you queried the CRM (HubSpot/ServiceTitan) via MCP or CLI?
- **Bottom Line First**: Does the output start with the most critical number or action?
- **Actionability**: For every stalled deal or metric drop, have you drafted a specific corrective action (e.g., an email or Linear issue)?

## Standard Output Format (The Pulse)

```markdown
# Revenue Pulse: [Date Snapshot]

## 1. Executive Summary (BLF)
- **Total Pipeline**: $X (↑/↓ $X)
- **At-Risk Value**: $Y (Requires immediate CEO intervention)
- **Conversion Friction**: [Identified bottleneck]

## 2. The Bottlenecks (Action Required)
| Stage | Metric / Deal | Root Cause | Recommended Action | Owner |
|-------|---------------|------------|--------------------|-------|
| [Stage] | [Drop or Deal] | [Evidence-based] | [Concrete Step] | [@name] |

## 3. Deal Strategy
- **[Deal Name]**: [Context]. 
  - *Leverage Point*: [Detail]
  - *Next Play*: [Drafted follow up or collateral required]

## 4. Execution Logs
- [x] Analyzed `hubspot-api` for pipeline momentum.
- [ ] Drafted follow-up for [Stalled Deal].
```

## Proactive Triggers

Surface these issues WITHOUT being asked when you notice them in context:
- **Abandoned Gold**: High-value deals with 0 touchpoints in >10 days.
- **Conversion Leak**: A sudden variance (>15%) in mid-funnel conversion rates (e.g. Traffic -> Demo).
- **Collateral Gap**: Recurring objections in Fathom transcripts that we do not have a Sales Enablement document for.

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| HubSpot | Deal state, contact activity | `hubspot-api` via CLI/MCP |
| ServiceTitan | Closed/won offline revenue | `servicetitan-api` |
| GA4 / GSC | Top-of-funnel traffic & events | `ga4-api` or SEMrush MCP |
| Fathom | Call transcripts & objections | `fathom-api` |

## Confidence Tagging
All revenue claims must utilize the following confidence index:
- 🟢 **Verified** — Pulled natively via live CRM/Analytics data in this session.
- 🟡 **Medium** — Deduced from last known states or local memory logs.
- 🔴 **Assumed** — No data source pulled; strictly a theoretical model.

## <verification_gate>
**Self-Verification Protocol:** 
1. Did I read live data? 
2. Did I highlight the most critical risk first? 
3. Did I tag confidence levels? 
If any are NO, rewrite before outputting to the user.
