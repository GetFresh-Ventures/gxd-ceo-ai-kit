---
name: agent-spawner
description: >
  Dynamic agent creation and task delegation for parallel GTM execution.
  Routes tasks to specialized agents based on intent classification.
  Derived from ruflo swarm-orchestration + agent-coordinator-swarm-init patterns.
  Use when: 3+ data sources need querying, new client onboarding, cross-system reconciliation.
  Skip when: single API call, simple status check, config change.
---

# Agent Spawner

## Overview

The Agent Spawner dynamically creates and manages specialist agents for parallel task execution across the GFV ecosystem. It implements **hierarchical topology** with anti-drift controls to prevent agent divergence.

## Spawn Decision Matrix

```
┌────────────────────────┬──────────┬────────────────┐
│ Task Complexity         │ Agents   │ Topology       │
├────────────────────────┼──────────┼────────────────┤
│ Simple (1 source)       │ 0 (self) │ Direct exec    │
│ Medium (2-3 sources)    │ 1-2      │ Sequential     │
│ Complex (4+ sources)    │ 3-5      │ Hierarchical   │
│ Mission-critical        │ 5-8      │ Consensus      │
└────────────────────────┴──────────┴────────────────┘
```

## Agent Types

### Researcher Agent
**Specialization**: Data gathering, intelligence synthesis, competitive analysis
**Trigger**: "research", "find out", "what do we know about", "investigate"
```
Skills: pil-context-synthesis, firecrawl-web-search, fathom-api
Output: Intelligence brief with confidence scores
```

### Analyst Agent
**Specialization**: Data processing, metrics calculation, trend analysis
**Trigger**: "analyze", "compare", "what's the trend", "performance review"
```
Skills: golden-rule-ga4, golden-rule-google-ads, golden-rule-gsc
Output: Data tables, charts, trend analysis
```

### Builder Agent
**Specialization**: Content creation, landing pages, reports, documents
**Trigger**: "create", "build", "generate", "draft"
```
Skills: wordpress-page-creation, gfv-report-builder, google-doc-creation
Output: Finished deliverables
```

### Connector Agent
**Specialization**: API operations, system sync, data transfer
**Trigger**: "sync", "update", "push", "pull", "connect"
```
Skills: hubspot-api, servicetitan-api, quickbooks-api, pandadoc-api
Output: System state changes with confirmation
```

### Auditor Agent
**Specialization**: Quality checks, compliance verification, health monitoring
**Trigger**: "audit", "check", "verify", "validate"
```
Skills: ads-optimization-audit, consensus-reconciler, security-pii-scanner
Output: Audit report with findings
```

## Spawn Protocol

### Step 1: Classify Intent
```
Parse the task description:
  1. Extract action verb → maps to agent type
  2. Extract target entity → maps to skill chain
  3. Assess complexity → determines agent count
  4. Check for urgency → determines priority
```

### Step 2: Allocate Resources
```
For each spawned agent:
  - Assign specific sub-task
  - Provide relevant context (from PIL)
  - Set timeout (default: 5 minutes per agent)
  - Define output format
```

### Step 3: Execute with Monitoring
```
Parallel execution with coordinator oversight:
  - Agents execute independently
  - Coordinator monitors progress
  - Results merge into unified output
  - Conflicts resolved by consensus-reconciler
```

### Step 4: Consolidate Results
```
After all agents complete:
  - Merge outputs
  - Resolve conflicts
  - Generate unified response
  - Store patterns for future optimization
```

## Anti-Drift Controls

### MANDATORY Rules
1. **Hierarchical only** — Every spawned agent reports to the coordinator
2. **No agent-to-agent** — Agents don't talk to each other directly
3. **Timeout enforcement** — Kill any agent that exceeds 2x expected duration
4. **Output validation** — Coordinator validates every agent output before merging
5. **Single brain** — Only the coordinator makes strategic decisions

### Drift Detection
```
Flag as drift if:
  - Agent output doesn't match expected format
  - Agent makes unauthorized external calls
  - Agent execution time > 2x expected
  - Agent attempts to spawn sub-agents (not allowed)
```

## Composition with Existing Skills

| Spawn Pattern | Agent Chain | Use Case |
|---------------|-------------|----------|
| **Intel Sweep** | Researcher × 3 | New client onboarding |
| **System Audit** | Auditor × 4 | Monthly health check |
| **Report Build** | Analyst + Builder | Weekly reporting |
| **Pipeline Sync** | Connector × 3 | Cross-system reconciliation |
| **Campaign Review** | Analyst + Auditor | Ad performance review |

## References

- **Source Pattern**: [ruflo/swarm-orchestration](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/swarm-orchestration)
- **Source Pattern**: [ruflo/agent-coordinator-swarm-init](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/agent-coordinator-swarm-init)
- **GFV Standard**: Execution Speed workflow, Parallel Execution workflow


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
