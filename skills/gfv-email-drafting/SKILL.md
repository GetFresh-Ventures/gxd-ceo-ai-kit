---
name: gfv-email-drafting
description: >
  GFV email drafting and sending skill. Defines Diraj's voice, formatting expectations,
  banned words, and Gmail SMTP integration. Use when asked to draft, write, compose, or send
  any email. NEVER auto-send — always show draft for approval first.
  Skip when: internal notes, Slack messages, or non-email communication.
---

# GFV Email Drafting

> [!IMPORTANT]
> **GFV-Adapted Skill** — This skill runs within the GetFresh Ventures infrastructure.

### GFV Infrastructure Integration

**Credentials** — Never use `.env` files. All secrets live in macOS Keychain:
```bash
security find-generic-password -s "GFV_GMAIL_APP_PASSWORD" -w
```
Check `~/Documents/Code/gfv-brain/scripts/pil_config.py` for service mappings.

**Data Sources** — Before drafting, check PIL for context on the recipient:
- `search_pil` / `smart_search` / `entity_deep_dive` MCP tools
- Supabase tables: `ont_entities`, `ont_facts` (relationship history)
- HubSpot: deal status, last contact date, engagement history

**Output** — NEVER send without Diraj's explicit "send it" approval. Always present the full draft first.

---

## Overview

Composes emails in Diraj's authentic voice using Gmail SMTP. Every outbound message goes through a draft-review cycle — no exceptions.

## When to Trigger
- "Draft an email to..."
- "Write a follow-up to..."
- "Send an email..."
- "Reply to..."
- Any request involving outbound email communication

## When to Skip
- Slack messages → use Slack directly
- Internal notes → save to PIL/memory
- WhatsApp → different channel, different rules

## Voice Model — Diraj's Writing Style

### Tone
- **Conversational professional** — not corporate, not casual
- **Direct** — get to the point in the first sentence
- **Warm but efficient** — genuine interest, no fluff
- **Confident, not salesy** — expertise speaks, doesn't pitch

### Structure
1. **Opening**: 1 sentence, straight to the point. No "I hope this finds you well."
2. **Body**: 2-4 sentences max. One idea per paragraph.
3. **CTA**: Clear next step. Specific time/date if scheduling.
4. **Sign-off**: "Best," or "Talk soon," — never "Regards" or "Sincerely"

### Banned Words & Phrases
| ❌ Never Use | ✅ Use Instead |
|---|---|
| synergy, leverage | work together, use |
| touch base | check in, follow up |
| circle back | get back to you |
| I hope this finds you well | [skip entirely] |
| just checking in | wanted to follow up on... |
| at your earliest convenience | by [specific date] |
| best regards / sincerely | Best, / Talk soon, |
| please don't hesitate | feel free to... |
| per our conversation | as we discussed |
| low-hanging fruit | quick wins |
| paradigm shift | major change |

### Formatting Rules
- **No HTML** — plain text only
- **Short paragraphs** — 1-3 sentences each
- **Line breaks** between paragraphs
- **No bullet points** in emails (save for docs)
- **Signature**: `Diraj Goel | GetFresh Ventures | getfreshventures.com`

## Protocol

### Step 1: Gather Context
```
Before drafting, pull:
1. Recipient's entity from PIL (entity_deep_dive)
2. Last communication (HubSpot engagements, email threads)
3. Active deals or projects involving this person
4. Any pending action items from Fathom meeting notes
```

### Step 2: Draft
```
Write the email following the Voice Model above.
Include:
- Subject line (clear, specific, under 50 chars)
- Body (conversational, direct, 2-4 sentences)
- CTA (one clear next step)
- Sign-off
```

### Step 3: Present for Review
```
Show Diraj the FULL draft:
- Subject: [subject line]
- To: [recipient email]
- Body: [full email text]

Wait for explicit "send it" approval.
```

### Step 4: Send (only after approval)
```python
# Gmail SMTP via App Password
import smtplib
from email.mime.text import MIMEText

password = subprocess.check_output([
    'security', 'find-generic-password', 
    '-s', 'GFV_GMAIL_APP_PASSWORD', '-w'
]).decode().strip()

msg = MIMEText(body)
msg['Subject'] = subject
msg['From'] = 'diraj@getfreshventures.com'
msg['To'] = recipient

with smtplib.SMTP_SSL('smtp.gmail.com', 465) as s:
    s.login('diraj@getfreshventures.com', password)
    s.send_message(msg)
```

## Anti-Patterns
- ❌ Auto-sending without approval
- ❌ Using corporate buzzwords
- ❌ Long multi-paragraph emails
- ❌ Generic subject lines ("Following up", "Quick question")
- ❌ CC'ing people without a reason

## Related Skills
- **hubspot-api**: Check deal/contact context before drafting
- **fathom-api**: Pull meeting notes for follow-up emails
- **google-doc-creation**: For longer documents (proposals, reports)

## References
- **GFV Standard**: Draft Review Before Send (CLAUDE-GLOBAL.md)
- **Auth**: Gmail App Password in macOS Keychain


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
