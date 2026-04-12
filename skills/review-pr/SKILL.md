---
name: review-pr
description: Perform a deep security, logic, and GTM strategy review on an open Pull Request, modified files, or tracking script deployment before closing a Linear issue. Modeled directly on the Anthropic internal security review prompts.
---

# `review-pr` (GTM Deployment Review)

## Context
Modeled directly after Anthropic's internal Claude system prompts for security and code review, this skill forces the agent into a highly critical "Reviewer" mindset. Do not use this to write code. Use this strictly to critique staged edits, tracking scripts, or infrastructure updates before they are pushed to production.

## How to use this skill
Executes a multi-stage review pass against either an active git branch, or a specific set of modified files.

1. **Invoke Review:** Run `/review-pr` and provide the target (e.g. "Review my uncommitted changes" or "Review branch feature/gclid-tracking").
2. **Context Intake:** As the reviewer agent, do not guess what the changes are. Use `git diff` or `git show` to read the exact diff payload.
3. **Execution Protocol:** 
   Execute three distinct isolated evaluation passes on the diff. Do **not** blend them.
   
   - **Pass 1: Security & Syntax (The Brittle Check)**: Look for exposed API keys (Linear, Supabase, Google Ads), missing closing tags natively in HTML, or malformed JSON payloads.
   - **Pass 2: The Silent Failure Check**: For GTM tracking scripts (like GCLID or GA4 tags), trace the data layer. Is it firing before the DOM loads? Are there race conditions? Will Ad-blockers aggressively block this exact implementation?
   - **Pass 3: GTM Strategic Intent**: Connect the code back to the Linear issue. Does this diff actually fulfill the commercial goal, or did the developer just superficially2. Provide specific, actionable code reviews for the PR.
3. Write the resulting evaluation locally to `~/gtm-brain/pr-review-[timestamp].md`.

   Using a strict, emotionless, engineering tone (no buzzwords), highlight:
   - **Critical Blockers:** [List of things that MUST be fixed before deploying]
   - **Warnings:** [Non-breaking but highly unoptimized patterns]
   - **Approval Status:** [APPROVED | CHANGES REQUESTED]

5. **Linear Integration:** If the project uses Linear, create a brief comment on the associated Linear Issue with the summary of the PR review status.
