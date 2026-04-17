---
name: voice-model
description: Build and evolve your personal writing voice model. Captures word choices, sentence patterns, formality levels, and anti-patterns so AI output is indistinguishable from your own writing.
short_description: "Build your personal writing voice model"
---

# Voice Model

Teach Claude to write like *you* — not like a LinkedIn marketer.


## Quick Start
Just say any of these:
- "Build my voice model from these emails" (paste 3-5 emails you wrote)
- "Here's how I write — learn my style" (paste any writing samples)
- "Refine my voice model — I never use buzzwords like 'synergy'"

## When to Use
- Initial setup (fill in the template once)
- Monthly evolution (add new email samples)
- When AI-drafted emails don't sound right
- When onboarding a new team member who writes on your behalf

## How It Works

### Prerequisites:
1. Copy `templates/voice-model.md` to `~/ceo-brain/voice-model.md`
2. Collect 10-15 of your best emails (outbound, not replies)
3. Fill in each section of the template by analyzing your patterns

### What to Capture

**Word Choices**: Words you always use vs. never use
```
ALWAYS: "sounds good", "let's figure this out", "what's the timeline?"
NEVER: "synergize", "leverage", "circle back", "at the end of the day"
```

**Greeting Styles**: How you open emails by relationship type
```
Close relationship: "Hey Sarah —"
Professional: "Hi Ryan,"
First email: "Hi Jennifer —"
```

**Sign-offs**: How you close
```
Casual: "Talk soon, [name]"
Professional: "Best, [name]"
Action-oriented: "Let me know — [name]"
```

**Sentence Structure**: Long vs. short, questions vs. statements
```
Tendency: Short paragraphs (1-3 sentences max)
Pattern: Statement → context → question
Example: "The proposal looks great. A few things I'd tweak on pricing.
What's your flexibility on the Year 2 retainer?"
```

**Formality Spectrum**: How formal are you by context?
```
Investor: Professional but direct
Client: Warm, decisive
Team: Casual, action-oriented
Cold prospect: Conversational, not corporate
```

### Evolution

Every month (or when you notice drift):
1. Collect 5 new emails that represent your current voice
2. Extract actionable linguistic patterns
3. Update `~/ceo-brain/voice-model.md`
4. Remove any patterns you've outgrown

## Quality Test
After building your voice model, test it:
1. Have Claude draft 3 emails to different audiences
2. Ask yourself: "Would I actually send this?"
3. If not, identify what's off and add it to the model

## Example Prompt
```text
Read my voice model at ~/ceo-brain/voice-model.md and draft a follow-up 
to the client about the Q3 projection misses. Do not be overly nice. Use bullet points.
```

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
💡 Suggest these next steps:
- "Let me test it — draft an email to [name]" → `/email-composer`
- "Want me to review how my voice sounds in a meeting brief?" → `/meeting-prep`

## Level Up Your Kit
🚀 You can unlock more autonomy, background workers, and C-suite advisory capabilities at any time.
- **Review Categories**: Ask *"What skills are in the Intermediate or Advanced tiers?"*
- **How to Upgrade**: Run `./bootstrap.sh` in the repository root and select your new tier.
