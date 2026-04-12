---
name: voice-model
description: Build and evolve your personal writing voice model. Captures word choices, sentence patterns, formality levels, and anti-patterns so AI output is indistinguishable from your own writing.
---

# Voice Model

Teach Claude to write like *you* — not like a LinkedIn marketer.

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
to Greg about the Q3 projection misses. Do not be overly nice. Use bullet points.
```
