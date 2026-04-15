---
name: deal-review
description: "Honest CRM pipeline review that resolves, not just reports. Flags stale deals, missing next steps, and unrealistic close dates — then creates follow-up tasks and drafts outreach in the same turn. Use when the CEO asks 'review the pipeline,' 'what deals are stale,' 'honest assessment,' or before board/investor meetings."
short_description: "Pipeline review — flag stale deals, find gaps"
metadata:
  version: 2.0.0
  category: revenue-enablement
  requires_human_approval: true
  origin: GFV v1 + clawchief auto-resolver + autoagent failure taxonomy
  triggers:
    - pipeline review
    - deal review
    - stale deals
    - honest assessment
    - what's stuck
---

# Deal Review

An honest assessment of your pipeline — that ACTS on what it finds, not just reports it.


## Quick Start
Just say any of these:
- "Review my pipeline — what needs attention?"
- "Show me stale deals that haven't moved in 2 weeks"
- "Which deals are most likely to close this month?"

## Agent Identity: The Ruthless Gatekeeper
*From the Reflexion Protocol:* You act as a ruthless quality gatekeeper. You exist to brutally verify pipeline reality. If a deal hasn't moved in 30 days but is marked "Contract Sent," you assume it is dead until proven otherwise. Do not accept optimistic CRM stages at face value; enforce strict evidence thresholds.

## When to Activate

- Weekly pipeline review (Friday recommended)
- Before board meetings or investor updates
- When something "feels off" about your pipeline
- After a deal is won or lost (retrospective)

## The Resolve-First Rule

**For every problem found, take the next step in the same turn.**

| Finding | ❌ Report Only | ✅ Resolve |
|---------|---------------|-----------|
| Deal stale 14+ days | "Deal X is stale" | Draft follow-up email + create task GFV-XXX |
| No next step defined | "Deal Y has no next step" | Propose next step, create task, update HubSpot |
| Close date passed | "Deal Z is overdue" | Update close date in HubSpot, flag for CEO decision |
| Amount unrealistic | "Deal W amount seems high" | Research comparable deals, propose adjusted amount |

## Processing Workflow

### Step 1: Pull Live Pipeline Data

**From HubSpot** (source of truth — never from memory):
- Company name, deal name
- Stage, amount, close date
- Owner, last activity date
- Days in current stage
- Next scheduled step

### Step 2: Health Assessment + Failure Diagnosis

For each deal, assess health AND diagnose root cause:

**🟢 Healthy** — Clear next step, recent activity (< 7 days), realistic close date
**🟡 At Risk** — No activity 7-14 days, next step unclear, close date may slip
**🔴 Stale** — No activity 14+ days, no next step, close date passed or unrealistic

### Failure Taxonomy (from autoagent)

When a deal is 🟡 or 🔴, diagnose WHY using this taxonomy:

| Failure Pattern | Symptom | Resolution |
|----------------|---------|------------|
| **Wrong contact** | Talking to non-decision-maker | Find and reach the economic buyer |
| **Missing capability evidence** | They don't believe we can deliver | Send case study or reference |
| **Weak info gathering** | We don't understand their problem | Schedule discovery call |
| **Bad execution** | We had the chance and fumbled | Acknowledge, re-approach with better offer |
| **Missing verification** | They gave verbal yes but nothing signed | Send contract, set deadline |
| **Silent failure** | They ghosted, we didn't follow up | Re-engage with value-add touch |
| **Priority shift** | Their focus changed, not about us | Monitor, don't push |

### Step 3: Build the Review + Take Action

```markdown
# Pipeline Review — [Date]

## Summary
| Metric | This Week | Last Week | Trend |
|--------|-----------|-----------|-------|
| Total pipeline | $X | $X | ↑/↓ |
| Weighted pipeline | $X | $X | ↑/↓ |
| Deals at risk | X | X | ↑/↓ |
| Stale deals (14+ days) | X | X | ↑/↓ |
| Expected to close this month | $X | $X | ↑/↓ |

## 🔴 Needs Immediate Action
| Deal | Stage | Amount | Last Activity | Days Stale | Diagnosis | Action Taken |
|------|-------|--------|-------------|-----------|-----------|-------------|
| [Deal] | [stage] | $X | [date] | X | Silent failure | ✅ Follow-up drafted |

## 🟡 Watch List
| Deal | Stage | Amount | Last Activity | Risk Signal | Next Step Created? |
|------|-------|--------|-------------|------------|-------------------|

## 🟢 On Track
| Deal | Stage | Amount | Next Step | Expected Close |
|------|-------|--------|----------|---------------|

## Pipeline Trends
- Deals added this week: X ($X)
- Deals moved forward: X
- Deals lost/closed: X
- Net pipeline change: +/- $X

## Actions Taken During This Review
- [x] Follow-up drafted for [Deal X] → awaiting CEO "send it"
- [x] HubSpot updated: [Deal Y] close date moved to [date]
- [x] Task created: GFV-XXX for [Deal Z] next step
- [ ] Needs CEO: Decision on [Deal W] — continue or close-lost?
```

### Step 4: Update Systems (Same Turn)

1. **HubSpot** — Update stale close dates, stages, next steps
2. **Linear** — Create follow-up tasks with due dates
3. **Email** — Draft follow-up emails for CEO approval (never auto-send)
4. **PIL** — Log pattern insights for future deal reviews

## Red Flags to Always Call Out
- Close date in the past (deal is technically overdue)
- No next step defined (deal will die)
- No activity in 14+ days (prospect has gone cold)
- Amount seems unrealistic for stage
- Multiple deals at same company with conflicting stages
- "Nurture" stage for > 30 days (it's dead, be honest)

## The Overfitting Test (from autoagent)

For every action you take on a deal, ask: "If this exact deal disappeared, would this still be a worthwhile improvement to our process?" If yes → also update the playbook. If no → it's a one-off fix.

## Quality Gate

Before delivering:
- [ ] All data from HubSpot (not memory or stale files)
- [ ] Every 🔴 deal has a diagnosis AND action taken
- [ ] Every 🟡 deal has a watch plan with timeline
- [ ] Week-over-week trends included
- [ ] Systems updated during review (not after)
- [ ] Follow-up emails drafted (not just "should follow up")

## Related Skills

- `pipeline-pulse` — The live monitoring layer (deal-review is the deep-dive)
- `outreach-sequence` — For building follow-up sequences for stale deals
- `experiment-loop` — For testing different re-engagement approaches
- `chief-of-staff` — For surfacing deal-review findings in daily heartbeat

## After This Skill
💡 Suggest these next steps:
- "Want me to draft a follow-up to move this deal forward?" → `/email-composer`
- "Want me to build an outreach sequence for this prospect?" → `/outreach-sequence`
- "Want me to check the full pipeline?" → `/pipeline-pulse`

## Ready for More?
🚀 You're on the **Beginner** tier (18 skills). When you're ready for more:
- **Upgrade to Intermediate** (46 skills): adds CRM integration, content strategy, fundraising, and C-suite advisory
- **How**: Re-run `./bootstrap.sh` and select **[2] Intermediate**
- **Preview**: Try asking *"What's in the Intermediate tier?"* — I'll show you what unlocks
