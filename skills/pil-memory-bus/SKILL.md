---
name: pil-memory-bus
description: >
  Unified memory bus for the Proactive Intelligence Layer with 4-tier hierarchy,
  namespace management, TTL-typed storage, and vector search. Derived from ruflo
  memory-coordinator + agentdb-vector-search + hive-mind collective memory patterns.
  Use when: cross-session context needed, entity queries, intelligence retrieval, memory consolidation.
  Skip when: ephemeral data, single-use calculations, no persistence needed.
---

# PIL Memory Bus

## Overview

The PIL Memory Bus is the **unified memory layer** connecting all GFV agents to the Proactive Intelligence Layer. It implements a 4-tier hierarchy with namespace isolation, TTL-typed storage, and semantic search capabilities.

## Memory Hierarchy

```
┌─────────────────────────────────────┐
│  Tier 1: Global Memory (Permanent)  │
│  Supabase: ont_entities, ont_facts  │
│  TTL: None (persists forever)       │
├─────────────────────────────────────┤
│  Tier 2: Project Memory (Medium)    │
│  Client-specific context, deal data │
│  TTL: 90 days (auto-archive)        │
├─────────────────────────────────────┤
│  Tier 3: Session Memory (Short)     │
│  Current conversation state         │
│  TTL: 24 hours                      │
├─────────────────────────────────────┤
│  Tier 4: Task Memory (Ephemeral)    │
│  Step-level working data            │
│  TTL: 30 minutes                    │
└─────────────────────────────────────┘
```

## Namespace Schema

```
Namespace Structure:
  client/<client-name>/          → Client-specific intelligence
    deals/                       → Deal history and status
    contacts/                    → Contact records
    campaigns/                   → Campaign performance
    meetings/                    → Meeting transcripts and notes
    
  pipeline/<system>/             → System-specific data
    hubspot/                     → CRM data cache
    servicetitan/                → Field service data
    google-ads/                  → Ad performance metrics
    ga4/                         → Analytics data
    
  patterns/<category>/           → Learned patterns
    ads-optimization/            → Ad optimization strategies
    content-strategy/            → Content patterns that work
    deal-progression/            → Deal closing patterns
    
  coordination/<session>/        → Agent coordination state
    task-assignments/            → Who's doing what
    intermediate-results/        → Partial results
    agent-status/                → Agent heartbeats
```

## Memory Types with TTL

| Type | TTL | Use Case |
|------|-----|----------|
| `knowledge` | Permanent | PIL facts, entity records, architectural decisions |
| `context` | 1 hour | Current session context, active client focus |
| `task` | 30 minutes | Step-level working data, intermediate calculations |
| `result` | Permanent | Execution results, report outputs (compressed) |
| `error` | 24 hours | Error logs, failure records for debugging |
| `metric` | 1 hour | Performance metrics, API response times |
| `consensus` | Permanent | Multi-source reconciliation decisions |
| `system` | Permanent | Configuration, credentials, system state |

## Query Protocol

### Before Any Assertion (MANDATORY)

```bash
# Step 1: Check PIL for entity context
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py context --limit=10

# Step 2: Query Supabase ontology
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py query --entity="<name>"

# Step 3: Check SQLite memory
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py search --query="<topic>"

# Step 4: Vector search (semantic)
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py vector --query="<natural language>"
```

### Storing Intelligence

```bash
# Store a new fact
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py store \
  --entity="Acme Home Services" \
  --fact-type="campaign_metric" \
  --value="Utah LSA leads dropped 58% in Q1 2026" \
  --confidence=0.85 \
  --source="google-ads-api"
```

## Memory Chain Linking

Connect related facts to build intelligence graphs:

```
Fact A: "Acme Corp Utah LSA leads dropped 58%"
  ↓ linked to
Fact B: "ServiceTitan shows 58% abandonment rate on calls"
  ↓ linked to  
Fact C: "Google LSA dispute filed 2026-04-10"
  ↓ resolves to
Decision: "Abandonment is a reporting error, not genuine"
```

## Garbage Collection

- **Daily**: Archive `error` type entries older than 24h
- **Weekly**: Compress `result` type entries older than 7 days
- **Monthly**: Archive `knowledge` entries with confidence < 0.3
- **Quarterly**: Full dedup pass on ont_facts

## Performance Targets

| Operation | Target |
|-----------|--------|
| Read (cache hit) | < 5ms |
| Read (SQLite) | < 50ms |
| Read (Supabase) | < 200ms |
| Write (local) | < 10ms |
| Write (Supabase) | < 500ms |
| Vector search | < 100ms |

## References

- **Source Pattern**: [ruflo/agent-memory-coordinator](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/agent-memory-coordinator)
- **Source Pattern**: [ruflo/agentdb-vector-search](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/agentdb-vector-search)
- **GFV Standard**: PIL Read Order (context → Supabase → SQLite → vectors → search → ask user)


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
