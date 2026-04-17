---
name: agent-protocol
description: "Inter-agent communication protocol for C-suite advisory skills. Defines invocation syntax, loop prevention, isolation rules, quality verification loops, and standardized output formats. Every advisory skill MUST follow this protocol."
short_description: "C-suite advisory inter-agent communication"
attribution: Adapted from alirezarezvani/claude-skills (MIT License), hardened for GFV portfolio context.
metadata:
  version: 1.0.0
  category: c-level
  domain: agent-orchestration
  updated: 2026-04-11
---

# Agent Protocol

How C-suite agents communicate. Rules that prevent chaos, loops, circular reasoning, and unverified output reaching the CEO.

---


## Quick Start
Just say any of these:
- "Configure inter-agent communication"
- "Set up handoff protocols between advisors"
- "How do my C-suite agents share context?"


## Invocation Syntax

Any agent can query another using:

```
[INVOKE:role|question]
```

**Examples:**
```
[INVOKE:cfo|What's the burn rate impact of hiring 3 field techs in Q3?]
[INVOKE:cro|What does our pipeline look like for the next 90 days?]
[INVOKE:cmo|What's our CAC by channel for the primary market?]
```

**Valid roles:** `ceo`, `cfo`, `cro`, `cmo`, `coo`, `founder-coach`, `executive-mentor`

---

## Response Format

Invoked agents respond using this structure:

```
[RESPONSE:role]
Key finding: [one line — the actual answer]
Supporting data:
  - [data point 1]
  - [data point 2]
  - [data point 3 — optional]
Confidence: [🟢 high | 🟡 medium | 🔴 low]
Caveat: [one line — what could make this wrong]
[/RESPONSE]
```

**Example:**
```
[RESPONSE:cfo]
Key finding: Hiring 3 field techs in Q3 increases monthly burn by ~$21K but should generate $45K/mo incremental revenue within 60 days.
Supporting data:
  - Current monthly burn: $180K → increases to ~$201K (fully loaded @ $7K/tech/mo)
  - Field Service Platform data shows avg tech generates $15K/mo revenue after 30-day ramp
  - Current pipeline supports the capacity (CRO confirmed 40+ open leads/month)
Confidence: 🟡 medium
Caveat: Assumes primary market demand holds steady through summer; ramp could be longer for HVAC-only techs.
[/RESPONSE]
```

---

## Loop Prevention (Hard Rules)

These rules are enforced unconditionally. No exceptions.

### Rule 1: No Self-Invocation
An agent cannot invoke itself.
```
❌ CFO → [INVOKE:cfo|...] — BLOCKED
```

### Rule 2: Maximum Depth = 2
Chains can go A→B→C. The third hop is blocked.
```
✅ CRO → CFO → COO (depth 2)
❌ CRO → CFO → COO → CMO (depth 3 — BLOCKED)
```

### Rule 3: No Circular Calls
If agent A called agent B, agent B cannot call agent A in the same chain.
```
✅ CRO → CFO → CMO
❌ CRO → CFO → CRO (circular — BLOCKED)
```

### Rule 4: Chain Tracking
Each invocation carries its call chain:
```
[CHAIN: cro → cfo → coo]
```

**When blocked:** Return this instead of invoking:
```
[BLOCKED: cannot invoke cfo — circular call detected in chain cro→cfo]
State assumption used instead: [explicit assumption the agent is making]
```

---

## Board Meeting / Multi-Role Consultation Rules

### Phase 2 (Independent Analysis)
**NO invocations allowed.** Each role forms independent views before cross-pollination.
- Reason: prevent anchoring and groupthink
- If data needed from another role: state explicit assumption with `[ASSUMPTION: ...]`

### Phase 3 (Critic Role)
Executive Mentor can **reference** other roles' outputs but **cannot invoke** them.
- Allowed: "The CFO's projection assumes X, which contradicts the CRO's pipeline data"
- Not allowed: `[INVOKE:cfo|...]` during critique phase

### Outside Consultations
Invocations allowed freely, subject to loop prevention rules above.

---

## When to Invoke vs When to Assume

**Invoke when:**
- The question requires domain-specific data you don't have
- An error would materially change the recommendation
- The question is cross-functional (e.g., hiring impact on budget AND capacity)

**Assume when:**
- The data is directionally clear and precision isn't critical
- You're in Phase 2 isolation (always assume, never invoke)
- The chain is already at depth 2
- The question is minor for your main analysis

**When assuming, always state it:**
```
[ASSUMPTION: runway ~12 months based on typical burn profile — not verified with CFO]
```

---

## Conflict Resolution

When two invoked agents give conflicting answers:

1. **Flag the conflict explicitly:**
   ```
   [CONFLICT: CFO projects 14-month runway; CRO expects pipeline to close 80% → implies 18+ months]
   ```
2. **State the resolution approach:**
   - Conservative: use the worse case
   - Probabilistic: weight by confidence scores
   - Escalate: flag for CEO decision
3. **Never silently pick one** — surface the conflict to the CEO.

---

## Internal Quality Loop

No role presents to the CEO without passing through this verification loop.

### Step 1: Self-Verification (every role, every time)

```
SELF-VERIFY CHECKLIST:
□ Source Attribution — Where did each data point come from?
  ✅ "Revenue is $2.1M (from HubSpot pipeline, Q1 actuals)"
  ❌ "Revenue is around $2M" (no source, vague)

□ Assumption Audit — What am I assuming vs what I verified?
  Tag every assumption: [VERIFIED: checked against data] or [ASSUMED: not verified]
  If >50% of findings are ASSUMED → flag low confidence

□ Confidence Score — How sure am I?
  🟢 High: verified data, established pattern, multiple sources
  🟡 Medium: single source, reasonable inference, some uncertainty
  🔴 Low: assumption-based, limited data, first-time analysis

□ Contradiction Check — Does this conflict with known context?
  Check against company context and recent decisions
  If contradicts a past decision → flag explicitly

□ "So What?" Test — Does every finding have a business consequence?
  If you can't answer "so what?" in one sentence → cut it
```

### Step 2: Peer Verification (cross-functional validation)

When a recommendation impacts another role's domain, validate BEFORE presenting.

| If your recommendation involves... | Validate with... |
|-------------------------------------|------------------|
| Financial numbers or budget | CFO Advisor |
| Revenue projections | CRO Advisor |
| Operational process changes | COO Advisor |
| Marketing spend or positioning | CMO Advisor |
| Personnel or culture changes | Founder Coach |
| Strategic direction | CEO Advisor |

**Peer validation format:**
```
[PEER-VERIFY:cfo]
Validated: ✅ Burn rate calculation correct
Adjusted: ⚠️ Timeline should be Q3 not Q2 (budget constraint)
Flagged: 🔴 Missing equity cost in projection
[/PEER-VERIFY]
```

**Skip peer verification when:**
- Single-domain question with no cross-functional impact
- Time-sensitive proactive alert
- CEO explicitly asked for a quick take

### Step 3: Critic Pre-Screen (high-stakes only)

For **irreversible, high-cost, or bet-the-company** decisions:

**Triggers:**
- Involves spending >20% of remaining runway
- Affects >30% of the team
- Changes company strategy or direction
- Involves external commitments (fundraising, partnerships, M&A)
- Any recommendation where all roles agree (suspicious consensus)

```
[CRITIC-SCREEN]
Weakest point: [single biggest vulnerability]
Missing perspective: [what nobody considered]
If wrong, the cost is: [quantified downside]
Proceed: ✅ With noted risks | ⚠️ After addressing [gap] | 🔴 Rethink
[/CRITIC-SCREEN]
```

### Step 4: Course Correction (after CEO feedback)

```
1. CEO approves → log decision (Layer 2), assign actions
2. CEO modifies → update analysis with corrections, re-verify changed parts
3. CEO rejects → log rejection with DO_NOT_RESURFACE, understand WHY
4. CEO asks follow-up → deepen analysis on specific point, re-verify
```

### Verification Level by Stakes

| Stakes | Self-Verify | Peer-Verify | Critic Pre-Screen |
|--------|-------------|-------------|-------------------|
| Low (informational) | ✅ Required | ❌ Skip | ❌ Skip |
| Medium (operational) | ✅ Required | ✅ Required | ❌ Skip |
| High (strategic) | ✅ Required | ✅ Required | ✅ Required |
| Critical (irreversible) | ✅ Required | ✅ Required | ✅ Required + consultation |

---

## Standard Output Format (Single-Role Response)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 [ROLE] — [Topic]

BOTTOM LINE
[One sentence. The answer. No preamble.]

WHAT
• [Finding 1 — most critical] [VERIFIED: source] 🟢
• [Finding 2] [ASSUMED: basis] 🟡
(Max 5 bullets. If more → reference doc.)

WHY THIS MATTERS
[1-2 sentences. Business impact. Not theory — consequence.]

HOW TO ACT
1. [Action] → [Owner] → [Deadline]
2. [Action] → [Owner] → [Deadline]

⚠️ RISKS (if any)
• [Risk + what triggers it]

🔑 YOUR DECISION (if needed)
Option A: [Description] — [Trade-off]
Option B: [Description] — [Trade-off]
Recommendation: [Which and why, in one line]

📎 DETAIL: [reference doc or data source for deep-dive]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Proactive Alert Format (Unsolicited)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚩 [ROLE] — Proactive Alert

WHAT I NOTICED
[Specific trigger — not vague]

WHY IT MATTERS
[Business consequence — in dollars, time, or risk]

RECOMMENDED ACTION
[Who does what by when]

URGENCY: 🔴 Act today | 🟡 This week | ⚪ Next review

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Multi-Role Synthesis Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 CONSULTATION — [Date] — [Topic]

DECISION REQUIRED
[Frame in one sentence]

PERSPECTIVES
  CEO: [one-line position]
  CFO: [one-line position]
  CRO: [one-line position]

WHERE THEY AGREE
• [Consensus 1]
• [Consensus 2]

WHERE THEY DISAGREE
• [Conflict] — CEO says X, CFO says Y

CRITIC'S VIEW (Executive Mentor)
[The uncomfortable truth nobody else said]

RECOMMENDED DECISION
[Clear recommendation with rationale]

ACTION ITEMS
1. [Action] → [Owner] → [Deadline]
2. [Action] → [Owner] → [Deadline]

🔑 YOUR CALL
[Options if you disagree with the recommendation]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Communication Rules (Non-Negotiable)

1. **Bottom line first.** Always. The CEO's time is the scarcest resource.
2. **Results and decisions only.** No process narration ("First I analyzed...").
3. **What + Why + How.** Every finding explains WHAT, WHY it matters, HOW to act.
4. **Max 5 bullets per section.** Longer = reference doc.
5. **Actions have owners and deadlines.** "We should consider" is **banned**.
6. **Decisions framed as options.** Not "what do you think?" — "Option A or B, trade-off, recommendation."
7. **The CEO decides.** Roles recommend. CEO approves, modifies, or rejects.
8. **Risks are concrete.** Not "there might be risks" — "if X happens, Y breaks, costing $Z."
9. **No jargon without explanation.** If you use a term, explain it on first use.
10. **Silence is an option.** If there's nothing to report, don't fabricate updates.

---

## GFV System Integration

All data assertions MUST be verified against live systems before presenting:

| Data Type | Verify Against |
|-----------|---------------|
| Deal status, pipeline | HubSpot (via HubSpot API) |
| Revenue, invoices, cash | QuickBooks (via QuickBooks API) |
| Task status, project progress | Linear (via Linear MCP) |
| Customer data, job history | Field Service Platform (via Field Service API) |
| Entity relationships | Local Memory (via gfv-brain-search.py) |
| Meeting notes, action items | Fathom (via Fathom API) |

**Three-System Sync Rule:** Every status assertion touches Linear + HubSpot + Memory — all three or none.

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
💡 Suggest these next:
- "Try `agent-orchestrator` — Coordinate multi-agent task pipelines"
- "Try `ceo-advisor` — Strategic leadership and portfolio guidance"
- "Try `context-engine` — Load company context for advisory skills"
