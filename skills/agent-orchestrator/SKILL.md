---
name: agent-orchestrator
description: "Coordinate multi-agent pipeline tasks using Linear handoff, DAG parallel execution, and Debate cross-examination. Powered by hooks/task_manager.py. Use when you need multi-perspective analysis, parallel data gathering, or iterative build-review cycles."
metadata:
  version: 2.0.0
  category: agent-intelligence
  tier: advanced
  triggers:
    - multi-agent analysis
    - run a debate
    - parallel analysis
    - DAG pipeline
    - orchestrate agents
---

# Agent Orchestrator

Coordinate multi-agent pipeline tasks using three orchestration modes. All modes are powered by `hooks/task_manager.py`, which persists state to `~/gtm-brain/team-tasks/`.

**This is a real system with real commands. Every example below is executable.**

## When to Use

| Scenario | Mode | Example |
|----------|------|---------|
| Multi-step sequential work | **Linear** | Build → test → deploy pipeline |
| Gather data from multiple sources simultaneously | **DAG** | Fetch CRM + accounting + calendar in parallel |
| Strategic decision needing multiple perspectives | **Debate** | CFO vs CRO on deal pricing |
| Iterative build-verify loop | **Planner-Runner** | Code → test → refine cycle |

## Mode 1: Linear Hand-off

Sequential pipeline where each step's output feeds the next.

### Setup
```bash
# Initialize a linear project
python3 hooks/task_manager.py init morning-sweep --mode linear -g "Daily executive morning sweep"
```

This creates a default 4-stage pipeline: `code-agent → test-agent → docs-agent → monitor-bot`. Customize stages with `assign`:

```bash
# Assign specific tasks to each stage
python3 hooks/task_manager.py assign morning-sweep code-agent --desc "Check pipeline for stale deals (14+ days no activity)"
python3 hooks/task_manager.py assign morning-sweep test-agent --desc "Verify data against CRM source of truth"
python3 hooks/task_manager.py assign morning-sweep docs-agent --desc "Generate executive brief"
python3 hooks/task_manager.py assign morning-sweep monitor-bot --desc "Flag anything that needs CEO attention"
```

### Execution
```bash
# Get the next pending stage
python3 hooks/task_manager.py next morning-sweep

# Mark current stage as in-progress
python3 hooks/task_manager.py update morning-sweep code-agent --status in-progress

# Log progress
python3 hooks/task_manager.py log morning-sweep code-agent "Found 3 stale deals: Acme (21d), Beta (18d), Gamma (14d)"

# Set result and mark done
python3 hooks/task_manager.py result morning-sweep code-agent "3 stale deals identified, follow-up emails drafted"
python3 hooks/task_manager.py update morning-sweep code-agent --status done

# Auto-advances to next stage
python3 hooks/task_manager.py next morning-sweep
```

### Status Check
```bash
python3 hooks/task_manager.py status morning-sweep
```

---

## Mode 2: DAG (Parallel Execution)

Run independent tasks simultaneously, with dependent tasks waiting for their inputs.

### Setup
```bash
# Initialize a DAG project
python3 hooks/task_manager.py init quarterly-review -m dag -g "Q3 Quarterly Business Review preparation"

# Add independent tasks (no dependencies — run in parallel)
python3 hooks/task_manager.py add quarterly-review fetch-revenue \
  -a revenue-agent --desc "Pull revenue data from QuickBooks for Q3"

python3 hooks/task_manager.py add quarterly-review fetch-pipeline \
  -a pipeline-agent --desc "Pull pipeline data from HubSpot — deals, stages, win rates"

python3 hooks/task_manager.py add quarterly-review fetch-marketing \
  -a marketing-agent --desc "Pull campaign metrics — ad spend, conversions, CPL"

# Add a dependent task (waits for all three above)
python3 hooks/task_manager.py add quarterly-review synthesize \
  -a synthesis-agent -d "fetch-revenue,fetch-pipeline,fetch-marketing" \
  --desc "Merge all data into executive QBR deck"

# Add another dependent task
python3 hooks/task_manager.py add quarterly-review generate-slides \
  -a slides-agent -d "synthesize" \
  --desc "Generate presentation slides from synthesized data"
```

### Visualize the DAG
```bash
python3 hooks/task_manager.py graph quarterly-review
```

Output:
```
quarterly-review (dag)
├── fetch-revenue [pending]
├── fetch-pipeline [pending]
├── fetch-marketing [pending]
├── synthesize [blocked] ← depends on: fetch-revenue, fetch-pipeline, fetch-marketing
└── generate-slides [blocked] ← depends on: synthesize
```

### Execution
```bash
# See what's ready to run (no pending dependencies)
python3 hooks/task_manager.py ready quarterly-review
# Returns: fetch-revenue, fetch-pipeline, fetch-marketing

# Execute all ready tasks (simulate parallel execution)
python3 hooks/task_manager.py update quarterly-review fetch-revenue --status in-progress
# ... do the work ...
python3 hooks/task_manager.py result quarterly-review fetch-revenue "Q3 revenue: $2.4M, up 12% QoQ"
python3 hooks/task_manager.py update quarterly-review fetch-revenue --status done

# After all 3 complete, synthesize becomes ready
python3 hooks/task_manager.py ready quarterly-review
# Returns: synthesize
```

### Cycle Detection
The task manager automatically detects circular dependencies:
```bash
# This would fail with a cycle error:
python3 hooks/task_manager.py add proj task-a -a agent -d "task-b"
python3 hooks/task_manager.py add proj task-b -a agent -d "task-a"
# Error: Detected cycle: task-a → task-b → task-a
```

---

## Mode 3: Debate (Multi-Perspective Analysis)

For strategic decisions requiring multiple viewpoints, cross-examination, and synthesis.

### When to Use Debate Mode
- Pricing decisions (CFO vs CRO perspectives)
- Risk assessment (optimist vs pessimist)
- Deal evaluation (sales vs finance vs operations)
- Strategic planning (growth vs profitability)

### Setup
```bash
# Initialize a debate
python3 hooks/task_manager.py init pricing-strategy --mode debate \
  -g "Should we offer a 20% discount to close Acme Corp this quarter?"

# Add debaters with distinct roles
python3 hooks/task_manager.py add-debater pricing-strategy cfo-agent \
  --role "Chief Financial Officer: focused on margin protection, cash flow impact, and precedent risk"

python3 hooks/task_manager.py add-debater pricing-strategy cro-agent \
  --role "Chief Revenue Officer: focused on quarterly targets, competitive dynamics, and account expansion potential"

python3 hooks/task_manager.py add-debater pricing-strategy coo-agent \
  --role "Chief Operating Officer: focused on delivery capacity, resource allocation, and operational risk"
```

### Round Execution
```bash
# Start Round 1: Initial positions
python3 hooks/task_manager.py round pricing-strategy start

# Collect each debater's position (role-play as each persona)
python3 hooks/task_manager.py round pricing-strategy collect cfo-agent \
  "Oppose the 20% discount. Our gross margin is already at 62% — this drops it to 49% on a $400K deal. We set a dangerous precedent for future enterprise negotiations. Counter-proposal: offer 10% with a 2-year commitment."

python3 hooks/task_manager.py round pricing-strategy collect cro-agent \
  "Support the discount. Acme is a logo-tier account that opens the financial services vertical. Expected account expansion to $1.2M ARR by Year 2. The 20% is effectively a CAC investment. Without it, we lose to Competitor X who is offering similar terms."

python3 hooks/task_manager.py round pricing-strategy collect coo-agent \
  "Conditional support. We can absorb Acme at current capacity, but only if onboarding starts in Q3. If delayed to Q4, we'd need to hire, pushing payback out 6 months. Recommend: 15% discount contingent on Q3 start date."

# Cross-review: each debater reviews others' positions
python3 hooks/task_manager.py round pricing-strategy cross-review
# This outputs each debater's critique of the other positions

# Synthesize: produce a unified recommendation
python3 hooks/task_manager.py round pricing-strategy synthesize
# This produces the final recommendation incorporating all viewpoints
```

### Multi-Round Debates
For complex decisions, run additional rounds:
```bash
# Start Round 2 with refined positions
python3 hooks/task_manager.py round pricing-strategy start
# Collect updated positions based on cross-review feedback...
```

---

## Mode 4: Planner-Runner-Orchestrator (Iterative Build)

For development tasks requiring build → verify → refine cycles.

### The Pattern
```
PLANNER      → Decomposes goal into atomic tasks with acceptance criteria
RUNNER       → Executes one task, produces verifiable artifact
ORCHESTRATOR → Checks artifact against criteria: accept / revise / abort
```

### Execution Protocol

1. **Planner** runs ONCE at session start:
   ```markdown
   ## Task Plan: [Feature]
   
   1. [ ] Create `src/widget.ts` — acceptance: exports `Widget` class with `render()` method
   2. [ ] Add tests `tests/widget.test.ts` — acceptance: 3+ test cases, all pass
   3. [ ] Update `README.md` — acceptance: documents Widget API
   ```

2. **Runner** executes tasks one at a time. Each produces a verifiable artifact (file, test output, screenshot).

3. **Orchestrator** runs AFTER each artifact:
   - ✅ **Accept**: Criteria met → advance to next task
   - 🔄 **Revise**: Specific issue found → send back with feedback (max 3 revisions)
   - ❌ **Abort**: Fundamental problem → halt and escalate to CEO

4. **Cycle limit**: Maximum 3 revision cycles per task. After 3 failures, auto-abort with explanation.

### When to Use Each Mode

| Decision Factor | Linear | DAG | Debate | Planner-Runner |
|----------------|--------|-----|--------|---------------|
| Tasks depend on each other | ✅ | ❌ | ❌ | ✅ |
| Tasks are independent | ❌ | ✅ | ❌ | ❌ |
| Need multiple perspectives | ❌ | ❌ | ✅ | ❌ |
| Need build-verify loop | ❌ | ❌ | ❌ | ✅ |
| Typical task count | 3-6 | 5-15 | 2-5 | 3-10 |

---

## Management Commands

```bash
# List all active projects
python3 hooks/task_manager.py list

# Check status of any project
python3 hooks/task_manager.py status [project-slug]

# View history/logs for a specific task
python3 hooks/task_manager.py history [project-slug] [task-id]

# Reset a stuck task
python3 hooks/task_manager.py reset [project-slug] [task-id]

# Reset entire project
python3 hooks/task_manager.py reset [project-slug] --all
```

## Red Flags — When NOT to Orchestrate

- Single API call → just do it directly
- Simple CRUD operation → no orchestration needed
- < 3 data sources → use sequential execution
- User wants a quick answer → don't spin up a debate

## After This Skill
💡 Suggest these next steps:
- "Want me to build a feature using this pipeline?" → `/feature-architect`
- "Want me to create a recurring automation?" → `/automation-recommender`
- "Want me to run a strategic debate?" → start with debate mode above
