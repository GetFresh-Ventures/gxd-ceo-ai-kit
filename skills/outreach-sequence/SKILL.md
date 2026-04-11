---
name: outreach-sequence
description: "Design multi-touch outreach sequences with structured follow-up cadence, voice-model compliance, and CRM tracking. Use when building prospect outreach, re-engagement sequences, event follow-up, or cold outreach campaigns."
metadata:
  version: 2.0.0
  category: revenue-enablement
  origin: GFV v1 + clawchief follow-up cadence + autoagent experiment loop
  triggers:
    - outreach sequence
    - cold outreach
    - prospect follow-up
    - re-engagement
    - multi-touch
    - follow-up cadence
---

# Outreach Sequence

Design strategic multi-touch outreach for prospects who should know you — with structured cadence, CRM tracking, and experiment-loop integration.

## When to Activate

- New prospect identified (warm intro, inbound, or targeted)
- Re-engaging a dormant relationship
- Following up on a conference or event
- Launching into a new vertical or market

## Sequence Design Principles

1. **Personalized** — Every touch references something specific to them
2. **Value-first** — Lead with insight, not a pitch
3. **Multi-channel** — Email + LinkedIn + warm intro (where possible)
4. **Escalating** — Each touch adds information, never repeats
5. **Time-bound** — Clear cadence with defined end point
6. **Tracked** — Every touch logged in CRM immediately

## Follow-Up Cadence (from clawchief)

Default cadence for unanswered outreach (override per-sequence if needed):

| Touch | Timing | Purpose |
|-------|--------|---------|
| Touch 1 | Day 0 | Opening — establish relevance, no hard ask |
| Touch 2 | Day 3-5 | Value-add on second channel (LinkedIn) |
| Touch 3 | Day 7-10 | Insight drop — share something useful |
| Touch 4 | Day 14-18 | Soft ask — specific time, not "let's connect" |
| Touch 5 | Day 25-30 | Graceful close — door open, no pressure |

**Rules:**
- Reset the clock after each new outbound
- Record each touch in CRM notes immediately (not after the sequence)
- After 5th unanswered touch → STOP the sequence, surface if deal still matters
- If they respond at ANY point → switch to conversation mode, stop the sequence
- Don't auto-follow-up when thread is sensitive, clearly closed, or CEO said stop

## Standard 5-Touch Sequence

```markdown
# Outreach Sequence: [Prospect Company]
**Target**: [Name, Title]
**Reason**: [Why now? What triggered this outreach?]
**Warm path**: [Mutual connection? Shared event? Their content?]
**Experiment**: [What we're testing with this sequence — from experiment-loop]

## Touch 1: Opening (Day 0)
**Channel**: Email
**Subject**: [Specific, not generic — NEVER "Quick question" or "Reaching out"]
**Content**: [Reference their world — news, post, mutual connection.
Share one relevant insight. No ask yet beyond "worth a conversation?"]
**Goal**: Open the door
**CRM Update**: Log touch, set follow-up reminder for Day 3

## Touch 2: Value Add (Day 3-5)
**Channel**: LinkedIn (connect or comment on their post)
**Content**: [Engage with their content authentically.
If connecting, personalize the note with meeting context.]
**Goal**: Be visible on a second channel
**CRM Update**: Log LinkedIn touch, update status

## Touch 3: Insight Drop (Day 7-10)
**Channel**: Email
**Content**: [Share something genuinely useful — an article, a data point,
a relevant case study. Brief. "Thought this was relevant to what you're
building at [company]."]
**Goal**: Demonstrate value without asking
**CRM Update**: Log touch, note content shared

## Touch 4: Soft Ask (Day 14-18)
**Channel**: Email
**Content**: [Reference Touch 1 + 3. Make the ask specific:
"15 minutes this Thursday?" not "let's find time to connect."]
**Goal**: Get the meeting
**CRM Update**: Log ask, set deadline for response

## Touch 5: Graceful Close (Day 25-30)
**Channel**: Email
**Content**: [Acknowledge they're busy. Leave the door open.
"Happy to reconnect when the timing is better." No guilt, no pressure.]
**Goal**: Preserve the relationship for future
**CRM Update**: Mark sequence complete. Set 90-day re-engagement reminder.
```

## Sequence Quality Critique (3-Persona LLM-as-a-Judge)

Before finalizing any outbound sequence, process the drafted sequence through the Reflexion Critique mechanism:
1. **Persona A (Requirements Validator):** Does this sequence actually address the specific pain point of the prospect? Does it offer real value?
2. **Persona B (Solution Architect):** Is the escalation path (Touch 1->5) logically sound, appropriately spaced, and non-annoying?
3. **Persona C (Quality Reviewer):** Are the banned words completely removed? Is the tone perfectly matched to the CEO voice model?
If any judge rejects the sequence, rewrite the failing touches before presenting to Diraj.

**Death Loop Short-Circuit:** Maximum 2 critique loops allowed. If the 3 personas cannot reach consensus after 2 rewrite attempts across the sequence, you MUST break the loop. Output the sequence labeled `[BLOCKED BY JUDGMENT LOOP]` and explicitly flag the specific touches causing failure for Diraj's manual validation.

## Pre-Launch Checks (from clawchief)

Before sending the first touch:
1. ✅ Verify lead is NOT already in CRM/tracker
2. ✅ Verify lead matches target market/geography
3. ✅ Verify working website (not placeholder)
4. ✅ Find real public email (not scraped/guessed)
5. ✅ Voice model loaded and applied
6. ✅ Banned phrases eliminated

## Experiment Loop Integration

Every sequence IS an experiment:

| What to Test | How to Measure | Log Where |
|-------------|----------------|-----------|
| Subject line variants | Open rate | Experiment ledger |
| Value prop angle | Response rate | Experiment ledger |
| Cadence timing | Reply cadence | Experiment ledger |
| Channel mix | Which channel gets response | Experiment ledger |

After 10+ sequences, review the experiment ledger: What subject lines work? What cadences get replies? What channels perform? Apply learnings to future sequences.

## Quality Gate

- [ ] Every touch has a CRM update step (not "log later")
- [ ] Voice model applied — no AI smell
- [ ] Each touch adds new information (no repetition)
- [ ] Specific time offers, not "let's find time"
- [ ] Graceful close preserves relationship
- [ ] Pre-launch checks completed
- [ ] CEO approved all touches before first send

## Related Skills

- `email-composer` — For individual email drafting within the sequence
- `pipeline-pulse` — For monitoring sequence effectiveness
- `deal-review` — For reviewing stalled sequences
- `experiment-loop` — For A/B testing sequence variations
