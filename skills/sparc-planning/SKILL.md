---
name: sparc-planning
description: >
  5-phase structured planning methodology: Specification, Pseudocode, Architecture, Refinement, Completion.
  Enhances GFV planning mode with formalized phases and quality gates.
  Derived from ruflo sparc-methodology.
  Use when: new feature implementation, complex integrations, architectural changes, unclear requirements.
  Skip when: simple bug fixes, config changes, well-defined small tasks, routine maintenance.
---

# SPARC Planning Methodology

> [!IMPORTANT]
> **GFV-Adapted Skill** — This skill runs within the GetFresh Ventures infrastructure. Follow these conventions.

### GFV Infrastructure Integration

**Credentials** — Never use `.env` files. All secrets live in macOS Keychain:
```bash
security find-generic-password -s "<service>" -a "<account>" -w
```
Check `~/Documents/Code/gfv-brain/scripts/pil_config.py` for service mappings.

**Data Sources** — Before querying external APIs, check PIL first:
- `search_pil` / `smart_search` / `vector_search` MCP tools (491K+ embeddings, 81K entities)
- Supabase tables: `entity_embeddings`, `ont_entities`, `ont_facts`
- Local SQLite: WhatsApp (59K msgs), Slack (2.5K msgs), `gfv_memory.db`

**Output** — Save results to `~/Documents/Code/gfv-brain/` or PIL via Supabase. Never send external messages without Diraj's explicit "send it" approval.

---

## Overview

SPARC is a **5-phase structured development workflow** that ensures thorough planning before execution. It replaces ad-hoc implementation with a disciplined approach that catches design flaws early.

```
S → P → A → R → C
│   │   │   │   │
│   │   │   │   └── Completion: Verify + document
│   │   │   └────── Refinement: Iterate on feedback
│   │   └────────── Architecture: Design system structure
│   └────────────── Pseudocode: High-level logic flow
└────────────────── Specification: Define requirements
```

## Phase 1: Specification

**Goal**: Define exactly what needs to happen, for whom, and what "done" looks like.

### Deliverables
- [ ] Problem statement (1-2 sentences)
- [ ] Success criteria (measurable)
- [ ] Acceptance tests (minimum 3)
- [ ] Constraints and dependencies
- [ ] Out of scope (explicit)

### Template
```markdown
## Specification

### Problem
[What's broken or missing?]

### Success Criteria
1. [Measurable outcome 1]
2. [Measurable outcome 2]
3. [Measurable outcome 3]

### Acceptance Tests
- [ ] Given [context], when [action], then [result]
- [ ] Given [context], when [action], then [result]
- [ ] Given [context], when [action], then [result]

### Constraints
- [Technical constraint]
- [Business constraint]
- [Timeline constraint]

### Out of Scope
- [Explicitly excluded item 1]
- [Explicitly excluded item 2]
```

## Phase 2: Pseudocode

**Goal**: Write the logic in plain language before touching any code.

### Rules
- No programming syntax — English only
- Focus on the WHAT, not the HOW
- Every branch condition explicit
- Error cases included

### Template
```
FUNCTION: [name]
  INPUT: [what goes in]
  OUTPUT: [what comes out]
  
  1. Validate input
     - IF missing required fields → return error
  2. Check prerequisites
     - IF prerequisite not met → explain why
  3. Execute core logic
     - FOR each item in collection
       - Process item
       - Store result
  4. Verify output
     - IF output doesn't match spec → retry once → fail gracefully
  5. Return result with metadata
```

## Phase 3: Architecture

**Goal**: Design the system structure, interfaces, and dependencies.

### Deliverables
- [ ] Component diagram
- [ ] Interface contracts (inputs/outputs for each component)
- [ ] Data flow diagram
- [ ] Dependency map
- [ ] Security boundaries

### Template
```markdown
## Architecture

### Components
| Component | Responsibility | Depends On |
|-----------|---------------|------------|
| [Name]    | [What it does]| [Dependencies] |

### Interfaces
- `Component A → Component B`: [data format, protocol]
- `Component B → Component C`: [data format, protocol]

### Data Flow
[Input] → [Processing] → [Output] → [Storage]

### Security Boundaries
- [What's trusted]
- [What's untrusted]
- [Validation points]
```

## Phase 4: Refinement

**Goal**: Iterate on the design based on feedback and edge cases.

### Checklist
- [ ] Edge cases identified and handled
- [ ] Error recovery tested
- [ ] Performance implications considered
- [ ] Security review completed
- [ ] User review obtained (if applicable)

### Refinement Questions
1. What happens when [input is missing]?
2. What happens when [API is down]?
3. What happens when [data is corrupted]?
4. What happens when [concurrent access]?
5. What happens when [capacity exceeded]?

## Phase 5: Completion

**Goal**: Finalize implementation with tests, documentation, and verification.

### Deliverables
- [ ] All acceptance tests pass
- [ ] Documentation updated
- [ ] Changelog entry added
- [ ] Performance verified
- [ ] Security review signed off
- [ ] Walked through with user

### Verification Protocol
```bash
# Run tests
[test command]

# Verify against spec
[verification steps]

# Performance check
[benchmark or timing]

# Security scan
[security check]
```

## GFV Integration

This methodology maps directly to GFV's existing planning mode:

| SPARC Phase | GFV Artifact | Enhancement |
|-------------|-------------|-------------|
| Specification | User request analysis | Add structured requirements template |
| Pseudocode | (NEW) | Add before implementation plan |
| Architecture | implementation_plan.md | Formalize with interface contracts |
| Refinement | User review cycle | Add automated checklist |
| Completion | walkthrough.md | Add verification protocol |

## References

- **Source Pattern**: [ruflo/sparc-methodology](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/sparc-methodology)
- **GFV Standard**: Planning Mode workflow


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
