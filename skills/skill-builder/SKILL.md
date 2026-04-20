---
name: skill-builder
description: >
  Meta-skill for auto-generating new GFV skills from templates. Creates properly structured
  SKILL.md files with frontmatter, sections, and GFV architectural compliance.
  Derived from ruflo skill-builder + agent-base-template-generator patterns.
  Use when: creating new skills, migrating external patterns, standardizing existing skills.
  Skip when: editing existing skills, one-off tasks that don't need reuse.
---

# Skill Builder

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

**Skill Location** — All skills live in `gfv-brain/skills/`. Register in `gfv-brain/skills/REGISTRY.md`.

---

## Overview

The Skill Builder is a **meta-skill** — it generates other skills. Given a description of a capability, it produces a fully compliant SKILL.md file following GFV architectural standards.

## Skill Template

Every generated skill MUST follow this structure:

```markdown
---
name: <skill-name>
description: >
  <one-line description of what this skill does>.
  <source attribution if derived from external>.
  Use when: <trigger conditions>.
  Skip when: <skip conditions>.
---

# <Skill Title>

## Overview
<2-3 sentence description of the skill's purpose and capability>

## When to Trigger
- <trigger condition 1>
- <trigger condition 2>
- <trigger condition 3>

## When to Skip
- <skip condition 1>
- <skip condition 2>

## Core Protocol
<The main instructions for executing this skill>

## GFV Integration
<How this skill connects to existing GFV infrastructure>

## Anti-Patterns
<What NOT to do when using this skill>

## References
- **Source Pattern**: <attribution link>
- **GFV Standard**: <relevant GFV rules>
```

## Generation Protocol

### Step 1: Gather Requirements
```
Ask:
1. What problem does this skill solve?
2. What triggers it? (keywords, task types)
3. What data sources does it need?
4. What systems does it modify?
5. Is there an external source pattern?
```

### Step 2: Classify Category
```
Categories:
  🎯 Execution Infrastructure
  👔 C-Suite Advisory
  💰 Revenue Enablement
  📄 Document Processing
  📅 Daily Operations
  🚀 Growth Engine
  🛠️ Developer & DevOps
  🤖 Agent Intelligence (NEW — for ruflo-derived skills)
```

### Step 3: Generate SKILL.md
```
Using template above:
  - Fill all sections
  - Add GFV-specific integration points
  - Include anti-patterns
  - Reference source if derived
  - Add to REGISTRY.md
```

### Step 4: Register
```
After creating the skill:
  1. Create directory: .agents/skills/<skill-name>/
  2. Write SKILL.md to directory
  3. Update REGISTRY.md with new entry
  4. Update CHANGELOG.md
```

## Quality Checklist

Every generated skill must pass:
- [ ] Has `name` and `description` in frontmatter
- [ ] Has `Use when` and `Skip when` in description
- [ ] Has "Overview" section
- [ ] Has "When to Trigger" section
- [ ] Has "When to Skip" section  
- [ ] Has "Core Protocol" or equivalent
- [ ] Has "References" with source attribution
- [ ] Follows GFV design principles (Resolve, don't summarize)
- [ ] No placeholder text remaining
- [ ] Directory created at `gfv-brain/skills/<name>/`

## Design Principles for Generated Skills

1. **Resolve, don't summarize** — Every skill should DO work, not just report
2. **Source of truth or bust** — Ground in live systems, never memory alone
3. **Not handled until in the system** — Reading ≠ Processing
4. **Safe auto-resolve, draft-first for judgment** — Auto-do safely, ask for risky
5. **Voice-native** — Sound like Diraj, not like AI
6. **Draft Review Before Send** — No outbound without CEO approval

## References

- **Source Pattern**: [ruflo/skill-builder](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/skill-builder)
- **Source Pattern**: [ruflo/agent-base-template-generator](https://github.com/ruvnet/ruflo/tree/main/.agents/skills/agent-base-template-generator)
- **GFV Standard**: SKILLS-REGISTRY.md structure


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
