---
name: chief-of-staff
description: "Master Daily Orchestration Center. Your always-on heartbeat. Merges meeting prep, post-meeting briefings, news digests, and inbox triage into one autonomous execution loop."
short_description: "Master daily orchestration & heartbeat"
metadata:
  version: 3.0.0
  category: ceo-command-center
  origin: Consolidated from news-digest, meeting-prep, post-meeting-brief, and clawchief
  triggers:
    - what's going on
    - daily brief
    - my meetings
    - meeting prep
    - triage
    - morning sweep
---

# Chief of Staff Command Center

Your always-on daily orchestration heartbeat. This command center pulls your calendar (meetings), Slack/Email (comms), and Linear (execution) into a single sweep. It prepares you for the day, takes notes, and delegates the follow-up work automatically.

> **GxD Architectural Rule**: This skill runs on the **Resolve-First Protocol**. Assume the CEO only wants to read things they MUST decide on. For anything administrative (scheduling, task updates), the agent should Auto-Resolve in the background.

## Sub-Modes

1. **The Morning Sweep (News & Inbox)**
   - *Action*: Pulls Linear tasks due today, unread high-priority emails/Slack DMs, and relevant market news. Generates one single `morning_digest.md`.
   - *Trigger*: "Morning sweep" or "What's going on today?"

2. **Meeting Preparation**
   - *Action*: For upcoming calendar events, pulls transcript history (Fathom), open deals (HubSpot), and participant LinkedIn profiles.
   - *Trigger*: "Prep me for my next meeting" or "Who am I talking to today?"

3. **Post-Meeting Execution**
   - *Action*: Parses Fathom transcripts immediately after calls. Extracts action items, creates Linear tasks, and drafts follow-up emails for approval.
   - *Trigger*: "Process the last meeting."

## 🛑 Hard Gates (DO NOT EXECUTE WITHOUT CHECKING)
- **Priority Map**: Did you check the Priority Map (who/what matters) before surfacing an interruption?
- **Source of Truth**: Are you reading live data (Calendar, Fathom, Linear) rather than hallucinating from memory?
- **Action Bias**: Did you actually draft the email or create the Linear task, or did you just write "Need to follow up"?

## Standard Output Formats

### Morning Sweep
```markdown
# 🌅 Morning Sweep: [Date]

**The Single Priority Today:** [The highest leverage P0 task]

**Priority Inbox (Needs Reply):**
- [Sender]: [Context] - [Drafted Reply ready]

**Critical Meetings:**
- [Time] - [Meeting Name] - *[Context: e.g. "We need to close the Q3 budget here."]*
```

### Pre-Meeting Brief
```markdown
# 🤝 Meeting Prep: [Participant Name]

**Objective:** [Why is this meeting happening?]
**Recent Context:** [Last touchpoint from HubSpot/Fathom]
**Open Blockers:** [Any pending tasks in Linear related to them]
**The Play:** [Advisory on how to steer the conversation]
```

### Post-Meeting Execution
```markdown
# ⚡ Meeting Processed: [Meeting Name]

- [x] **Linear Updated:** Created 3 tasks for the ops team.
- [x] **HubSpot Updated:** Moved deal to 'Negotiation'.
- [ ] **Follow-Up Drafted:** Needs CEO approval to send.
```

## The Triage Logic (1-5 Scale)
- **Score 1-2 (Admin):** Single skill. Auto-resolve immediately (e.g., scheduling).
- **Score 3 (Strategic):** Draft-First mode. Prepare artifacts, ask for approval.
- **Score 4 (High Risk):** Multi-agent sequential handoff and peer verification.
- **Score 5 (Critical):** Escalate immediately. Spawn a "Board Meeting" debate.

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| Fathom | Live/past call transcripts | `fathom-api` |
| Google Calendar | Schedule & participants | native calendar tools |
| Linear | Task execution state | `linear-api-access` |
| HubSpot | Relationship state | `hubspot-api` |

## Confidence Tagging
- 🟢 **Verified** — Live schedule/data pulled directly via API.
- 🟡 **Medium** — Inferred urgency based on keyword matching.
- 🔴 **Assumed** — Hallucinated intent; requires user clarification.

## <verification_gate>
**Self-Verification Protocol:** 
1. Did I auto-resolve administrative work instead of just listing it?
2. Are my drafts concise (BLF format)?
3. Did I query the API context for meetings?
If NO, rewrite and process further before presenting to the CEO.
