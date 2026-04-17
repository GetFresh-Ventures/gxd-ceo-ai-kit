---
name: competitive-intel
description: "Systematic competitor tracking that feeds CMO positioning, CRO battlecards, and CEO strategic decisions. Use when analyzing competitors, building sales battlecards, tracking market moves, or when user mentions competitive intelligence, competitor research, or market positioning."
short_description: "Track competitors and market positioning"
attribution: Adapted from alirezarezvani/claude-skills (MIT License), hardened for GFV portfolio context.
metadata:
  version: 1.0.0
  category: c-level
  domain: competitive-strategy
  updated: 2026-04-11
---

# Competitive Intelligence

Systematic competitor tracking. Not obsession — intelligence that drives real decisions.

**Trigger phrases:** "competitor", "competitive", "battlecard", "win/loss", "market positioning", "who else", "they just launched", "they just raised"

---

## Quick Start

```
/ci:landscape         — Map your competitive space (direct, indirect, future)
/ci:battlecard [name] — Build a sales battlecard for a specific competitor
/ci:winloss           — Analyze recent wins and losses by reason
/ci:update [name]     — Track what a competitor did recently
/ci:map               — Build competitive positioning map
```

---

## Layer 1: Competitor Identification

**Direct competitors:** Same ICP, same problem, comparable solution, similar price point.
**Indirect competitors:** Same budget, different solution (including "do nothing" and "build in-house").
**Future competitors:** Well-funded startups in adjacent space; large incumbents with stated roadmap overlap.

**The 2x2 Threat Matrix:**

| | Same ICP | Different ICP |
|---|---|---|
| **Same problem** | Direct threat | Adjacent (watch) |
| **Different problem** | Displacement risk | Ignore for now |

Update quarterly. Who's moved quadrants?

---

## Layer 2: Tracking Dimensions

Track 8 dimensions per competitor:

| Dimension | Sources | Cadence |
|-----------|---------|---------|
| **Product moves** | Website, G2/Capterra, social media | Monthly |
| **Pricing changes** | Pricing page, sales call intel, customer feedback | Triggered |
| **Funding** | Crunchbase, TechCrunch, LinkedIn | Triggered |
| **Hiring signals** | LinkedIn job postings, Indeed | Monthly |
| **Partnerships** | Press releases, co-marketing | Triggered |
| **Customer wins** | Case studies, review sites, LinkedIn | Monthly |
| **Customer losses** | Win/loss interviews, churned accounts | Ongoing |
| **Messaging shifts** | Homepage, ads (Facebook/Google Ad Library) | Quarterly |

---

## Layer 3: Analysis Frameworks

### SWOT per Competitor
- **Strengths:** What do they do well? Where do they win?
- **Weaknesses:** Where do they lose? What do customers complain about?
- **Opportunities:** What could they do that would threaten you?
- **Threats:** What's their existential risk?

### Competitive Positioning Map (2 axis)
Choose axes that matter for your buyers:
- Common: Price vs Quality; Speed vs Customization; Local vs National
- Pick axes that show YOUR differentiation clearly

### Feature/Service Gap Analysis

| Feature/Service | You | Competitor A | Competitor B | Gap Status |
|-----------------|-----|-------------|-------------|------------|
| [Feature] | ✅ | ✅ | ❌ | Your advantage |
| [Feature] | ❌ | ✅ | ✅ | Gap — address? |
| [Feature] | ✅ | ❌ | ❌ | Moat |

---

## Layer 4: Output Formats

**For Sales (CRO):** Battlecards — one page per competitor, designed for pre-call prep.

### Battlecard Template
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BATTLECARD: [Competitor Name]
Last updated: [DATE]

OVERVIEW
[2-3 sentences: what they do, who they serve, their position]

THEIR STRENGTHS (acknowledge these)
• [Strength 1]
• [Strength 2]

THEIR WEAKNESSES (exploit these)
• [Weakness 1 — how we're better]
• [Weakness 2 — how we're better]

WHEN WE WIN AGAINST THEM
• [Scenario/condition where we win]
• [What to emphasize in the conversation]

WHEN WE LOSE TO THEM
• [Scenario/condition where they win]
• [What to avoid or reframe]

LANDMINES (things they'll say about us)
• "[Claim]" → Counter: "[Response]"

KILLER QUESTIONS (ask the prospect these)
• "[Question that exposes their weakness]"

PRICING COMPARISON
• Them: [pricing model]
• Us: [pricing model]
• Advantage: [who wins on value, not just price]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**For Marketing (CMO):** Positioning update — message shifts, new differentiators.
**For CEO/Board:** Monthly competitive summary — 1-page: who moved, what it means, recommended responses.

---

## Layer 5: Intelligence Cadence

**Monthly (scheduled):**
- Review tier-1 competitors (direct threats, top 3)
- Update battlecards with new intel
- Publish 1-page summary to leadership

**Triggered (event-based):**
- Competitor raises funding → assess implications within 48 hours
- Competitor launches major feature/service → product + sales response within 1 week
- Competitor poaches key customer → win/loss interview within 2 weeks
- Competitor changes pricing → analyze and respond within 1 week

**Quarterly:**
- Full competitive landscape review
- Update positioning map
- Refresh threat assessment
- Add/remove companies from tracking list

---

## Win/Loss Analysis

Highest-signal competitive data. Most companies do it too rarely.

**When to interview:**
- Every lost deal >$10K (or equivalent for your stage)
- Every churn >6 months tenure
- Every competitive win (learn why — it may not be what you think)

**Question structure:**
1. "Walk me through your evaluation process"
2. "Who else were you considering?"
3. "What were the top 3 criteria in your decision?"
4. "Where did [our company] fall short?"
5. "What was the deciding factor?"
6. "What would have changed your decision?"

**Aggregate monthly:** Win reasons, loss reasons, competitor win rates, patterns over time.

---

## Red Flags

| Signal | What It Means |
|--------|---------------|
| Competitor's win rate >50% in your core segment | Fundamental positioning problem |
| Same objection from 5+ deals | Feature/service gap that's real |
| Competitor hired 10+ people in your domain | Major investment incoming |
| Competitor raised >$20M and targets your ICP | 12-month competitive pressure |
| Prospects evaluate you to justify competitor decision | You're the "check box" — fix perception |

---

## The Balance: Intelligence Without Obsession

**Signs you're over-tracking:**
- Decisions are driven by "they just did X"
- Team morale drops when competitors fundraise
- You're building features you don't believe in to match their checklist

**Signs you're under-tracking:**
- Your team gets blindsided on calls
- Prospects know more about competitors than you do
- Your positioning hasn't changed in 12+ months despite market moves

**The right posture:**
- Know competitors well enough to win against them
- Don't let them set your agenda
- Your strategy is led by customer problems, informed by competitive gaps

---

## GFV Portfolio Application

### Home Services (Portfolio Co A, Portfolio Co C)
Competitors: local HVAC/plumbing companies, national franchises (Service Experts, ARS), digital-first (Comfort Systems)
- Track Google Ads positioning (Ad Library)
- Monitor Google Business Profile reviews
- Watch for new LSA entrants in your active markets
- Field Service Platform market reports for regional benchmarking

### SaaS / AI-Native (Portfolio Co B, pipeline companies)
Competitors: varies by vertical
- Track G2/Capterra reviews and rankings
- Monitor Product Hunt launches
- Watch for YC/TechStars companies in adjacent space
- GitHub activity for open-source alternatives

---

## Proactive Triggers

- **CEO mentions a competitor by name** → offer battlecard or landscape update
- **Lost deal attributed to competitor** → trigger win/loss analysis
- **Competitor funding announcement detected** → flag with 48-hour assessment
- **Competitor pricing page changes** → alert CMO + CRO
- **Market report mentions new entrant** → add to tracking list

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Can't find competitor data | Start with their job postings, press releases, and G2/Capterra reviews |
| Analysis becomes stale | Set up Google Alerts for competitor names + key product terms |

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| Client CRM | Real-time pipeline state | `hubspot-api` / `salesforce-api` |
| Local Memory | Client-specific facts | `gfv-brain-search.py` |

> **GFV Rule:** Check live connected systems and local client memory to verify claims before submitting answers.

## Proactive Triggers

Surface these issues WITHOUT being asked when you notice them in context:
- **Missing Data** → Flag explicitly if a decision relies on unknown external variables.
- **Scope Creep** → Alert if the requested operation spans beyond immediate context goals.
- **Executive Bottlenecks** → Warn if the action plan relies entirely on unassigned human approval gates.
- **Financial Risk** → Call out actions that may trigger unexpected OPEX burn (e.g. infinite LLM agent loops).

## Output Artifacts

| When you ask for... | You get... |
|---------------------|------------|
| Process Map | A mermaid.js chronological diagram |
| Executive Decision | BOTTOM LINE FIRST layout with options + trade-offs |
| Data Audit | A structured table grouping issues by severity |
| Code Execution | Isolated, copy-ready code blocks + terminal commands |

## Confidence Tagging

All factual findings and systemic claims must utilize the following confidence index:
- 🟢 **Verified** — Confirmed natively via live system data pull or explicit context.
- 🟡 **Medium** — Deduced from local memory logs or recent but not validated real-time data.
- 🔴 **Assumed** — No source available, utilizing best-judgment baseline.

## <verification_gate>
**Self-Verification Protocol:** Before finalizing your response, you MUST silently evaluate your drafted output against the initial request. Have you provided concrete Action Items with ownership? Did you use the Bottom Line First formatting? Have you applied Confidence Tags to your claims? If not, rewrite the response before submitting.

## After This Skill
💡 Suggest these next:
- "Try `news-digest` — Extract intelligence from news and feeds"
- "Try `seo-growth` — Audit and optimize SEO — technical and content"
- "Try `sales-enablement` — Create sales collateral reps actually use"
