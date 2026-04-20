---
name: hook-automation
description: >
  Pre/post task lifecycle hooks for quality gates, trajectory recording, and automated follow-through.
  Wraps every GFV operation with validation, logging, and pattern learning.
  Derived from ruflo hooks-automation + @claude-flow/hooks patterns.
  Use when: any task that modifies state, sends output, or touches client data.
  Skip when: read-only queries, internal-only calculations.
---

# Hook Automation

## Overview

Hook Automation wraps every GFV task with **pre-task validation** and **post-task follow-through**, ensuring nothing ships without quality gates and every outcome feeds the learning system.

## Hook Lifecycle

```
┌─────────────┐     ┌─────────────┐     ┌──────────────┐
│  PRE-TASK    │ ──→ │  EXECUTION  │ ──→ │  POST-TASK   │
│  Validation  │     │  (The Work) │     │  Follow-up   │
└─────────────┘     └─────────────┘     └──────────────┘
     │                                        │
     ├── Check PIL context                    ├── Log outcome to PIL
     ├── Validate permissions                 ├── Update Linear/HubSpot
     ├── Confirm scope                        ├── Record pattern
     ├── Load relevant memory                 ├── Archive artifacts
     └── Verify dependencies                  └── Trigger next steps
```

## Pre-Task Hooks

### 1. Context Loading (MANDATORY for all tasks)
```bash
# Always run before any substantive work
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py context --limit=10
```

### 2. Permission Check
```
Before modifying external systems, verify:
- [ ] Is this a read or write operation?
- [ ] Does this touch client-facing data?
- [ ] Does this send any outbound communication?
- [ ] Has Diraj approved this action (if write/send)?
```

### 3. Scope Validation
```
Confirm before execution:
- [ ] Task aligns with current Linear sprint
- [ ] No conflicting operations in progress
- [ ] Required API credentials are available
- [ ] Target system is accessible
```

### 4. Dependency Check
```
For multi-step tasks:
- [ ] All prerequisite tasks completed
- [ ] Required data is fresh (< TTL threshold)
- [ ] No blocking issues in Linear
```

## Post-Task Hooks

### 1. Outcome Logging (MANDATORY)
```
After every task completion:
- Log success/failure to PIL
- Record execution time
- Note any anomalies
- Tag with task category
```

### 2. Three-System Sync
```
After any state change:
- Update Linear issue status
- Update HubSpot (if deal-related)
- Record in PIL (CAAI layer)
All three or none.
```

### 3. Pattern Recording
```
After successful task completion:
- What worked? → Store in patterns/<category>
- What was the approach? → Record methodology
- How long did it take? → Benchmark for future
- Any optimizations discovered? → Log for next time
```

### 4. Draft Review Gate
```
Before any outbound communication:
  ┌─────────────────────────────────┐
  │  STOP — Show Diraj the draft    │
  │  Wait for explicit "send it"    │
  │  NEVER auto-send anything       │
  └─────────────────────────────────┘
```

### 5. Next-Step Trigger
```
After task completion, check:
- Is there a follow-up task in Linear?
- Does this unlock a blocked task?
- Should a notification go out?
- Is a report due?
```

## Hook Templates by Task Type

### Data Query Hook
```
PRE:  Load context → Check cache → Verify API access
POST: Cache result → Log timing → Update freshness timestamp
```

### Client Work Hook
```
PRE:  Load client context → Check deal status → Verify permissions
POST: Update HubSpot → Log to PIL → Trigger follow-up task
```

### Report Generation Hook
```
PRE:  Pull all data sources → Validate freshness → Check template
POST: Save artifact → Draft email to stakeholders → Update Linear
```

### System Change Hook
```
PRE:  Backup current state → Verify rollback plan → Confirm scope
POST: Verify change → Run smoke test → Log change → Notify team
```

## Protected File Patterns (from ruflo hooks-automation)

### Files Requiring CEO Approval Before Modification
```
.env*                          — credential files
*_api_key*, *_token*           — secret storage
send_email.py                  — outbound communication
*.service_account.json         — GCP service accounts
linear_cache.sh                — Linear API integration
setup_google_ads_oauth.py      — OAuth credentials
claude-flow.config.json        — agent configuration
```

### Pre-Edit Hook for Protected Files
Before modifying any protected file:
1. Display the exact diff to CEO
2. Explain WHY the change is needed
3. Wait for explicit approval
4. Create a backup before editing: `cp file file.bak.$(date +%s)`

## Atomic Rollback Protocol (from ruflo github-release-management)

### Multi-System Operations
For tasks that touch multiple systems (e.g., releases, onboarding):
```
1. Record pre-operation state of ALL systems
2. Execute changes in dependency order
3. If ANY step fails → roll back ALL completed steps
4. Log the failure point and root cause to PIL
5. Notify CEO with exact failure details
```

### Rollback Commands by System
| System | Rollback Action |
|--------|----------------|
| Git | `git tag -d vX.Y.Z && git push origin :refs/tags/vX.Y.Z` |
| GitHub Release | DELETE via API: `gh release delete vX.Y.Z` |
| Linear | Revert status via GraphQL mutation |
| HubSpot | Revert deal stage via API |
| PIL | Mark fact as `rolled_back` with reason |

## Safety Gates

### NEVER Auto-Execute
- Email/Slack/SMS sends
- HubSpot deal status changes
- Google Ads budget changes
- PandaDoc document sends
- Any financial transactions
- Protected file modifications

### Auto-Execute Allowed
- PIL memory reads/writes
- Local file operations
- Data aggregation and analysis
- Report generation (not sending)
- Internal status updates

## References

- **Source Pattern**: [ruflo/hooks-automation](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/hooks-automation)
- **Source Pattern**: [ruflo/@claude-flow/hooks](https://github.com/ruvnet/ruflo/tree/main/v3/@claude-flow/hooks)
- **GFV Standard**: Draft Review Before Send rule, Three-System Sync


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
