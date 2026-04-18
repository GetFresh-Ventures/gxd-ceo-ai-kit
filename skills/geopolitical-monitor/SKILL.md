---
name: geopolitical-monitor
description: "Data-first global intelligence pipeline. Queries external instability APIs and cross-references them against active CRM pipelines to identify specific at-risk revenue."
short_description: "Global intelligence and risk monitoring"
metadata:
  version: 2.0.0
  category: risk-management
  origin: Re-engineered for data-first API querying
  triggers:
    - geopolitical
    - global risk
    - country risk
    - instability
---

# Geopolitical Monitor

**Usage**: For CEOs with international exposure — track geopolitical events that could impact supply chains, market expansion plans, or client operations.

> **GxD Architectural Rule**: This skill is DATA-FIRST. Before reporting on geopolitical status, it MUST query live data endpoints (e.g., Perplexity/Firecrawl for recent news, or specific instability indicator APIs) AND cross-reference the affected region against active CRM deals. 

## Quick Start
Just say any of these:
- "What's the risk level for our deals in [country]?"
- "Brief me on geopolitical events affecting [industry] in [region]"

## Execution Flow

1. **Live Data Acquisition**: Query external search APIs (e.g. `firecrawl-web-search`, or Perplexity) for confirmed regulatory changes, sanctions, tariffs, or political instability in the target region within the last 7 days.
2. **CRM Cross-Reference**: Query `hubspot-api` filtering by properties related to the affected country/region to identify active pipeline at risk.
3. **Instability Scoring (1-10)**: Assign a rigid numerical score based on the severity of the exact events found.
4. **BLF Reporting**: Output the Bottom Line First report identifying exact revenue at risk with recommended actions.

## 🛑 Hard Gates (DO NOT EXECUTE WITHOUT CHECKING)
- **No Hallucination**: Are you citing a specific search result or news API? If not, stop and run the search query first.
- **Pipeline Tie-In**: Did you search HubSpot for matching country/region data?
- **Action Bias**: Did you draft an action plan to mitigate the specific risks identified?

## Standard Output Format

```markdown
# 🌍 Global Risk Brief: [Region/Country]

## 1. Executive Summary (BLF)
- **Instability Score**: [X/10] (🟢 Stable / 🟡 Monitor / 🔴 Critical)
- **Pipeline Value At Risk**: $[Total Value] in HubSpot
- **Primary Threat**: [Single greatest geopolitical dynamic]

## 2. API Validated Events (Last 7 Days)
- [Event 1] - [Source]
- [Event 2] - [Source]

## 3. Impact Matrix
| Active Deal | Region | Risk Vector | Mitigation Action |
|-------------|--------|-------------|-------------------|
| [Deal Name] | [City] | [Tariff/etc]| [Action required] |

## 4. Next Steps
- [ ] [Mitigation Action 1] (Say "Execute" to run)
- [ ] [Mitigation Action 2]
```

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| HubSpot | Active pipeline in affected regions | `hubspot-api` |
| Web Search | Real-time global event data | `firecrawl-web-search` / Search API |
| Local Memory | Previous risk assessments | `gfv-brain-search.py` |

## Confidence Tagging
- 🟢 **Verified** — Validated via Reuters/AP/FT and cross-matched in CRM.
- 🟡 **Medium** — Event is verified, but CRM impact is unconfirmed.
- 🔴 **Assumed** — Theoretical projection; high risk of inaccuracy.

## <verification_gate>
**Self-Verification Protocol:** 
1. Did I actually run a search tool to get real news data?
2. Did I actually check the CRM for pipeline overlap?
3. Is my output strictly formatted as BLF?
If not, rewrite and re-run.
