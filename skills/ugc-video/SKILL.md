---
name: ugc-video
description: "Script-to-video production orchestration. Enforces GxD visual standards, the Rule of One for scripts, and orchestrates AI talking heads, B-roll, and auto-captioning for high-converting social content."
short_description: "Script-to-video production pipeline"
metadata:
  version: 2.0.0
  category: brand-execution
  origin: Re-engineered for GxD Visual Standards
  triggers:
    - video
    - ugc
    - reel
    - short
    - talking head
---

# UGC Video

**Usage**: Transform a script, blog post, or strategic decision into a finished UGC-style video with AI-generated talking head, voiceover, and pacing.

> **GxD Architectural Rule**: No generic stock footage or monotonous AI voices. This skill enforces the GxD Visual Standards (high-contrast captions, rhythmic jump-cuts, >90% hook retention). Every script MUST adhere to the Rule of One.

## Quick Start
Just say any of these:
- "Script a 60-second product demo video"
- "Turn this meeting decision into a talking-head video script"
- "Format this copy for a TikTok execution"

## The UGC Content Machine

User-Generated Content style videos drive 4x higher engagement when they feel native, unpolished, and high-energy. This skill prepares the asset for production (or API orchestration).

## Pipeline

### 1. Script Generation (The Rule of One)
- **Input**: Raw topic, blog post URL, meeting notes.
- **Action**: Strip all secondary points. Generate a tight 30-60 second script.
- **Structure**: Core GxD Video Hook (0-3s) → The Tension (3-15s) → The Payoff (15-45s) → The Action (45-60s).

### 2. Visual Production & Pacing (GxD Formatting)
Output the script with explicit visual directives:
- `[JUMP CUT]` indicated every 4-6 seconds to maintain retention.
- `[B-ROLL]` callouts using highly specific emotional states, not generic nouns (e.g., "Frustrated executive rubbing temples", not "Business meeting").
- `[TEXT OVERLAY]` for highlighting the exact numbers or quotes that matter.

### 3. Voice Clone & Avatar Orchestration
Prepare the JSON payload or parameter guide for external video API tools (HeyGen, Synthesia, ElevenLabs):
- Define voice style (energetic, serious, contrarian).
- Define background aesthetic (office, casual, abstract).

## Standard Output Format

```markdown
# 🎬 Video Production Plan: [Topic]

## 1. Executive Summary
- **Target Platform**: [TikTok/LinkedIn/Shorts]
- **The Core Hook**: [The 3-second attention grabber]
- **Voice Profile**: [e.g., ElevenLabs "Rachel" - High Energy]

## 2. The Script
| Time | Visual / Cut | Audio / Spoken Script | Overlay |
|------|--------------|-----------------------|---------|
| 0:00 | [Shot type] | "Did you know that..." | [TEXT]  |
| 0:03 | [JUMP CUT] | "Here's the truth." |         |
| ...  | ...          | ...                   | ...     |

## 3. Production Next Steps
- [ ] Render Voiceover via ElevenLabs API
- [ ] Send to HeyGen API for avatar sync
- [ ] Post to `social-engine` for scheduling
```

## Constraints
- Never script an intro (e.g., "Hi guys"). Start with the hook immediately.
- 95% of social video is watched on mute. All scripts must include caption directives.
- If voice cloning is requested, the CEO must have explicitly provided consent.

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| Client CRM | Past content performance | `hubspot-api` |
| Local Memory | Previous approved scripts | `gfv-brain-search.py` |

## Confidence Tagging
- 🟢 **Verified** — Script strictly adheres to GxD timings and proven hooks.
- 🟡 **Medium** — Deviates from optimal pacing but fits the narrative.
- 🔴 **Assumed** — Experimental format.

## <verification_gate>
**Self-Verification Protocol:** 
1. Does the script start with a 3-second hook?
2. Did I remove all introductory fluff?
3. Are there jump cuts or b-roll calls every 4-6 seconds?
If not, rewrite for higher retention before presenting.
