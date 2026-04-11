---
name: email-composer
description: "Write emails in the CEO's authentic voice — no buzzwords, no AI smell. Loads voice model, checks CRM context, drafts with banned-word enforcement, and NEVER auto-sends. Use when drafting any outbound email, follow-up, intro, client communication, or prospect outreach."
metadata:
  version: 2.0.0
  category: daily-operations
  origin: GFV v1 + clawchief EA templates + auto-resolver draft-first pattern
  triggers:
    - draft email
    - write email
    - follow up email
    - intro email
    - send email
---

# Email Composer

Write outbound emails that sound like *you* wrote them — not a chatbot. **Never auto-send. Never.**

## When to Activate

- Drafting prospect outreach
- Following up after meetings
- Client communications
- Intro emails connecting two people
- Any email that represents the CEO or GFV

## How It Works

### Step 1: Load Voice Model
Read voice-model.md before drafting. This contains:
- Word choices and phrases you actually use
- Sentence structures and patterns
- Formality levels by audience
- Anti-patterns (words/phrases you'd never say)

### Step 2: Gather Context (Source-of-Truth Rule)

**Never draft from memory alone.** Check live systems:

| Source | What to Look For |
|--------|-----------------|
| **HubSpot** | Deal status, last interaction, open tasks, relationship stage |
| **Email history** | When you last emailed this person, what was said, any open threads |
| **Calendar** | Recent or upcoming meetings with this contact |
| **Meeting notes** | Any unprocessed action items from recent meetings |
| **PIL** | Relationship context, entity history, past commitments |

### Step 3: Draft with Rules

**HTML Format:**
```html
<body style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: #333; line-height: 1.5;">
  <!-- Email content here -->
</body>
```

**Core Rules:**
- Match the voice model's tone for THIS audience type
- Keep it concise — CEOs don't write novels
- Include a clear ask or next step
- CC relevant team members on client outreach
- Before intro emails: verify both parties don't already know each other
- Reference something concrete from context (meeting, deal, shared interest)

**Thread Rules (from clawchief):**
- For replies to existing threads → reply in-thread, not a new message with "Re:"
- Preserve real To/CC recipients
- Read the full thread before replying — don't miss context
- If cancelling/rescheduling → reply in-thread, don't start fresh

### Step 4: Auto-Resolve vs Draft-First

Apply the auto-resolver boundary:

| Email Type | Action |
|-----------|--------|
| Scheduling confirmation | ✅ Auto-draft (low risk, operational) |
| Meeting follow-up | ✅ Auto-draft (but CEO approves before send) |
| Cold prospect outreach | ✅ Auto-draft (voice model applied) |
| Investor/board email | 🟡 Draft-first (CEO must review wording carefully) |
| Legal/contract email | 🔴 Escalate (don't draft, surface the need) |
| Press/public-facing | 🔴 Escalate (CEO voice critical) |
| Emotionally sensitive | 🔴 Escalate (judgment call) |

### Step 5: High-Stakes Critique (3-Persona LLM-as-a-Judge)

For Investor/Board, Legal, or High-Value Prospect emails, **do not** just present a single draft. Employ the Reflexion Critique mechanism instead:
1. **Persona A (Requirements Validator):** CoVe (Chain-of-Verification) - Does this email meet the exact intent of the goal?
2. **Persona B (Solution Architect):** CoVe - Is this the right strategic angle/leverage?
3. **Persona C (Quality Reviewer):** CoVe - Is the tone exact? Does it strictly adhere to the banned words list?
If they disagree, synthesize an executive summary of the debate, and present the final perfected draft based on this strict critique.

**Death Loop Short-Circuit:** Maximum 2 critique loops allowed. If the 3 personas cannot reach consensus after 2 rewrite attempts, you MUST break the loop. Output the best draft labeled `[BLOCKED BY JUDGMENT LOOP]` and explicitly flag it for Diraj's manual intervention to prevent token burning.

### Step 6: Present for Approval

Show the full email inline. Wait for explicit **"send it"** before any action.

**Never auto-send. Never. This is the hardest rule and the most important one.**

## Banned Phrases (Always Enforced)

These words and phrases are NEVER acceptable in any email:
- "I wanted to reach out" / "reaching out"
- "circle back" / "touch base"
- "align" (as verb) / "leverage" (as verb)
- "unlock" / "seamlessly" / "holistic"
- "transformative" / "game-changer" / "robust"
- "empower" / "move the needle"
- "synergy" / "at the end of the day"
- "excited to" / "thrilled to"
- "I hope this email finds you well"

## Reply Templates (from clawchief)

### Offer Times
```
Hey [NAME] —

Here are a few times that work:
- [OPTION 1]
- [OPTION 2]
- [OPTION 3]

If one works, I'll send the invite. If not, send a couple windows that do.

— Diraj
```

### Short Follow-Up
```
Hey [NAME] —

Following up on the note below in case it got buried.
Happy to move this forward whenever you're ready.

— Diraj
```

### Holding Reply
```
Got it — checking on this and will get back to you shortly.
```

## Quality Gate

Before presenting:
- [ ] Sounds like a real person, not an AI
- [ ] Has a specific ask or next step
- [ ] References something concrete (meeting, deal, shared context)
- [ ] No banned words or AI-sounding filler
- [ ] Appropriate length for the relationship stage
- [ ] CC list is correct
- [ ] Context gathered from live systems (not assumptions)
- [ ] Thread context preserved (if replying)
- [ ] Voice model applied for this audience type

## Related Skills

- `voice-model` — The source of truth for how Diraj writes
- `outreach-sequence` — For multi-touch sequences (email-composer handles individual emails)
- `post-meeting-brief` — Generates the follow-up email after meetings
- `chief-of-staff` — Triggers email drafting from inbox sweeps
