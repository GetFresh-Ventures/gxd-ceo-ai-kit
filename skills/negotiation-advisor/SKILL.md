---
name: negotiation-advisor
description: "Data-driven negotiation orchestration. Analyzes Fathom meeting transcripts and email threads to map counter-party leverage, objections, and sentiment before generating a negotiation battle card."
short_description: "Battle-tested negotiation frameworks"
metadata:
  version: 2.0.0
  category: risk-management
  origin: Re-engineered for Fathom transcript and Email analysis
  triggers:
    - negotiation
    - deal prep
    - batna
    - contract terms
    - leverage
---

# Negotiation Advisor

**Usage**: Invoke before or during any high-stakes negotiation — vendor contracts, partnership terms, salary discussions, M&A terms, investor negotiations.

> **GxD Architectural Rule**: This skill is DATA-FIRST. Before dispensing theoretical negotiation advice, it MUST query `fathom-api` for recent transcripts OR read the provided email chains to extract the counter-party's actual words, stated objections, and sentiment.

## Quick Start
Just say any of these:
- "Analyze my last Fathom call with [Name] and build a negotiation battle card."
- "Read this email thread. What is their likely BATNA?"
- "Prep me for the final pricing call with [Client]."

## The Negotiation Operating System

### Phase 1: Intelligence Extraction (Data Grounding)
The agent will parse transcripts/emails for:
- **Stated Limitations**: Mentions of budget cuts, timelines, or board constraints.
- **Micro-Commitments**: Things they already agreed to in earlier calls.
- **Sentiment Shifts**: Tone changes when specific terms (timeline, price, scope) were discussed.

### Phase 2: Structural Analysis 
Using the extracted text, the agent models:
- **Your BATNA** (Best Alternative to Negotiated Agreement).
- **Their BATNA** (Deduced from their timeline urgency or listed objections).
- **ZOPA** (Zone of Possible Agreement).

### Phase 3: Concession Architecture
Design a structured give-and-take plan:
- **Must-Haves**: Non-negotiable items (rank-ordered).
- **Trade-offs**: Items you can concede to win Must-Haves.
- **Concession Ladder**: Pre-planned sequence of concessions.

## Standard Output Format

```markdown
# ♟️ Negotiation Battle Card: [Counter-party Name]

## 1. Intelligence Summary (Fathom/Email Data)
- **Their Urgency**: [High/Med/Low] - *Proof: "They said they need this by Q3."*
- **Their Primary Objection**: [Exact quote from transcript]

## 2. Structural Leverage (BLF)
- **Our BATNA**: [What we do if we walk away]
- **Their BATNA**: [What they do if they walk away]
- **Who has the power?**: [Clear assessment]

## 3. The Playbook
- **The Opening Anchor**: [Exact script to say when you start]
- **If they push on price**: [Script: e.g., "We can adjust price if we adjust scope. Which module should we drop?"]
- **If they threaten to walk**: [Script using Fathom data: "You mentioned last week this is a board priority..."]

## 4. Next Actions
- [ ] Review contract terms via [link]
- [ ] Say "Draft email" to send the initial terms
```

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| Fathom | Recent call transcripts | `fathom-api` |
| HubSpot | Email threads, deal timeline | `hubspot-api` |
| Local Brain | Client context | `gfv-brain-search.py` |

## Confidence Tagging
- 🟢 **Verified** — Directly cites quotes from the counter-party's transcripts or emails.
- 🟡 **Medium** — Deduced from behavioral clues in the CRM.
- 🔴 **Assumed** — Theoretical projection; high risk.

## <verification_gate>
**Self-Verification Protocol:** 
1. Did I read a Fathom transcript or Email thread BEFORE answering?
2. Did I quote the counter-party's actual words?
3. Did I provide exact scripts for the negotiation?
If not, rewrite in adherence to the Data-First rule.
