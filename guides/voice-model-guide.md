# Building Your Voice Model

The difference between AI that sounds like a robot and AI that sounds indistinguishable from you is your Voice Model.

## Why You Need This
If you ask Claude to "write a professional email," it will use words like *leverage, seamless, transformative, and synergy.* It will construct perfect, boring 5-paragraph corporate memos. 

If you're a founder or CEO, your power is in your authenticity, brevity, and directness. The Voice Model captures this.

## How to Build It (Takes 20 Minutes)

1. Open your "Sent" folder in your email client.
2. Find 5-10 emails you've written recently that represent your authentic voice. Look for:
   - A follow-up after a good meeting
   - A cold outreach that actually got a reply
   - An internal memo to your team
   - A firm but polite pushback
3. Open `templates/voice-model.md` and save a copy to `~/ceo-brain/voice-model.md`.
4. Analyze your sent emails and fill in the blanks.

### What to Look For:

**Length and Density**
Look at the visual shape of your emails. 
- Are they long blocks of text? 
- One-sentence paragraphs? 
- Bullet points?

**The Anti-Patterns (Banned Words)**
What words make you cringe when you read them in B2B emails? Put them on your "Never Use" list. 
*(Common CEO bans: impactful, leaning in, circle back, touch base).*

**Your Catchphrases**
What are the verbal tics you actually use? 
*(Examples: "Makes sense," "Let's figure this out," "What's the delta here?")*

**Sign-offs**
How do you actually end emails? It's rarely "Sincerely."

## Testing the Model
Once deployed to `~/ceo-brain/voice-model.md`, test it:

> "Read my voice model. Draft an email to Ryan at Acme saying I reviewed their proposal, the timeline works, but we need to talk about the Year 2 pricing. Keep it to my usual length."

If it sounds 90% like you, the model is working. Tweak the model as you evolve.
