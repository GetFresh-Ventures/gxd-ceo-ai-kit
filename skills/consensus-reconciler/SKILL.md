---
name: consensus-reconciler
description: >
  Multi-source data truth resolution using Byzantine fault tolerance and weighted consensus.
  Reconciles conflicting data across HubSpot, ServiceTitan, GA4, and Google Ads.
  Derived from ruflo byzantine-coordinator + consensus-coordinator patterns.
  Use when: data conflicts between systems, metric discrepancies, multi-source validation needed.
  Skip when: single-source queries, data already verified, no conflicts detected.
---

# Consensus Reconciler

## Overview

The Consensus Reconciler resolves conflicting data across GFV's multi-system landscape using **Byzantine Fault Tolerance** — requiring 2/3+ agreement from independent sources before accepting any metric as truth.

## Problem This Solves

```
Source A (HubSpot):    "Golden Rule has 12 active deals"
Source B (PandaDoc):   "Golden Rule has 8 active contracts"  
Source C (ServiceTitan):"Golden Rule has 15 active jobs"
Source D (Diraj):      "We have about 10 deals going"

→ Which number is truth? Consensus Reconciler resolves this.
```

## Consensus Algorithms

### 1. Majority Consensus (Simple)
**When**: Non-critical data, advisory metrics, trend indicators
- Each source gets 1 vote
- Majority wins
- Ties → escalate to weighted

### 2. Weighted Consensus (Default)
**When**: Most GFV operations, pipeline metrics, performance data
- **Source weights**:
  - Diraj (CEO override): **3x weight**
  - Source-of-truth system (HubSpot for deals, ServiceTitan for jobs): **2x weight**
  - Secondary systems: **1x weight**
  - Cached/memory data: **0.5x weight**
- Highest weighted total wins

### 3. Byzantine Fault Tolerance (Critical)
**When**: Financial data, client reporting, board-level metrics
- Requires **2/3 supermajority** agreement
- If not met → flag as UNRESOLVED and escalate to Diraj
- Never auto-resolve financial data without supermajority

## Reconciliation Protocol

### Step 1: Gather Sources
```
For each metric under reconciliation:
  1. Query primary source-of-truth system
  2. Query at least 2 secondary sources
  3. Check PIL cache for last-known-good value
  4. Record timestamps for each reading
```

### Step 2: Detect Conflicts
```
Conflict Thresholds:
  - Counts (deals, contacts):    > 10% variance = conflict
  - Currency (revenue, spend):   > 5% variance = conflict  
  - Percentages (rates, ratios): > 3% variance = conflict
  - Binary (yes/no status):      any disagreement = conflict
```

### Step 3: Resolve
```
Resolution Cascade:
  1. If all sources agree (within threshold) → CONFIRMED
  2. If 2/3+ agree → MAJORITY CONFIRMED (log dissenting source)
  3. If weighted consensus exceeds threshold → WEIGHTED CONFIRMED
  4. If no consensus → ESCALATE to Diraj with full data
  
  NEVER silently pick one source. Always document resolution logic.
```

### Step 4: Record Decision
```
Store to PIL:
  - Reconciled value
  - Sources consulted
  - Algorithm used
  - Confidence score
  - Dissenting sources (if any)
  - Timestamp
```

## GFV Source-of-Truth Map

| Data Domain | Primary Source | Secondary Sources |
|-------------|---------------|-------------------|
| Deals/Pipeline | HubSpot | PandaDoc, PIL memory |
| Contacts | HubSpot | Fathom, Email history |
| Revenue | QuickBooks | HubSpot, ServiceTitan |
| Ad Performance | Google Ads API | GA4, GSC |
| SEO Metrics | GSC | SEMrush, GA4 |
| Field Service | ServiceTitan | Google LSA, HubSpot |
| Meetings | Fathom | Google Calendar, PIL |
| Project Status | Linear | GitHub, PIL |

## Example: Utah LSA Reconciliation

```
Metric: "Utah LSA lead volume in March 2026"

Source readings:
  Google LSA Dashboard: 23 leads
  ServiceTitan calls:   47 calls (from LSA-attributed numbers)  
  HubSpot contacts:     18 new contacts (Utah, from LSA)
  GA4 conversions:      31 goal completions

Conflict detected: 23 vs 47 vs 18 vs 31 (>10% variance)

Weighted resolution:
  ServiceTitan (2x, source-of-truth for calls): 47 × 2 = 94
  Google LSA (2x, source-of-truth for LSA):     23 × 2 = 46
  GA4 (1x):                                     31 × 1 = 31
  HubSpot (1x):                                 18 × 1 = 18
  
  No supermajority → ESCALATE with analysis:
  "ServiceTitan shows 47 total calls but LSA dashboard credits only 23.
   The 24-call gap is likely the shadow-ban issue. Recommend investigating
   call recordings for the missing 24."
```

## Anti-Patterns

1. **NEVER** accept a single source without cross-validation for client-facing data
2. **NEVER** average conflicting numbers — find the truth, don't split the difference
3. **NEVER** silently drop a conflicting source — always log it
4. **NEVER** auto-resolve financial data — always escalate to Diraj

## References

- **Source Pattern**: [ruflo/agent-byzantine-coordinator](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/agent-byzantine-coordinator)
- **Source Pattern**: [ruflo/agent-consensus-coordinator](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/agent-consensus-coordinator)
- **GFV Standard**: Verify Before Asserting rule


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
