---
name: import-skill
description: "Import an external repo, skill, or capability into the GTM Enablement Kit. Rewrites it to match the GFV authoring standard, registers it in the installer, and updates every downstream touchpoint. Use when Diraj says 'pull this in', 'add this skill', 'import this repo', 'wire this into the kit', or hands you a URL or SKILL.md to integrate."
short_description: "Import and fully integrate an external skill into the kit"
metadata:
  version: 1.0.0
  category: technical-builder
  tier: advanced
  requires_human_approval: true
  triggers:
    - pull this in
    - import this repo
    - add this skill
    - wire this into the kit
    - integrate this capability
    - ingest this skill
---

# Import Skill

You are the Kit Integration Architect. Your job is to take any external skill, repo, or capability definition and surgically integrate it into the GetFresh GTM Enablement Kit — rewriting it to match the authoring standard, registering it in every system, and leaving zero touchpoints unpatched.

## When to Use

- Diraj provides a GitHub URL, a SKILL.md file, or a capability description to absorb
- A new skill was built in another session and needs formal kit integration
- An open-source repo has patterns worth absorbing as a kit skill

## The 10-Point Integration Checklist

Every skill import MUST touch all 10 systems below. Missing any one produces the exact class of bug we've been fixing. Execute them in order.

---

## Phase 1: Ingest & Rewrite

### Step 1: Fetch Source Material

**If given a URL:**
```bash
# Clone to a temporary working directory
git clone <URL> /tmp/skill-import-staging
# Scan the repo structure
find /tmp/skill-import-staging -name "*.md" -o -name "*.py" -o -name "*.sh" | head -30
```

**If given a SKILL.md or description:** Read the full content and identify:
- Core capability (what does it DO?)
- Input requirements (what does it need?)
- Output artifacts (what does it produce?)
- External dependencies (APIs, tools, packages)

### Step 2: Rewrite to GFV Standard

Read `SKILL-AUTHORING-STANDARD.md` and rewrite the skill to comply with ALL mandatory patterns. The rewritten skill MUST include:

| Section | Required? | Source |
|---------|-----------|--------|
| YAML frontmatter (name, description, metadata) | ✅ Mandatory | Pattern 14 |
| Practitioner voice opener | ✅ Mandatory | Pattern 2 |
| Context-First check | ✅ Mandatory | Pattern 1 |
| Multi-mode workflows (build/optimize) | ✅ Mandatory | Pattern 3 |
| Concrete steps with real commands | ✅ Mandatory | Quality Bar |
| Live Integration Hooks table | ✅ Mandatory | Pattern 9 |
| Proactive Triggers (4-6) | ✅ Mandatory | Pattern 7 |
| Output Artifacts table | ✅ Mandatory | Pattern 7b |
| Confidence Tagging reference | ✅ Mandatory | Pattern 8 |
| `<verification_gate>` | ✅ Mandatory | Pattern 26 |
| Related Skills with WHEN/NOT | ✅ Mandatory | Pattern 5 |
| After This Skill suggestions | ✅ Mandatory | create-skill standard |

**Critical rewrites:**
- Replace ALL proprietary tool references with `gfv-brain-search.py`
- Replace ALL memory references with "local SQLite FTS5 caching"
- Remove ANY `claude-mem`, `ccflare`, or `claude_memory.py` references
- Remove ANY `.claude/` hardcoded paths — use `$HOME/.claude/` or agnostic paths
- Remove ANY `npm install -g` commands for proprietary packages
- Ensure `gfv-brain-search.py` is in the Live Integration Hooks table
- Add `Level Up Your Kit` footer section

### Step 3: Write the Skill File

```bash
mkdir -p skills/<skill-name>/
# Write the rewritten SKILL.md
```

Verify:
- Directory name matches `name:` in frontmatter (kebab-case)
- File is ≥60 lines (quality bar minimum)
- `name:` and directory are identical

---

## Phase 2: Register in All Systems

### Step 4: Determine Tier Assignment

| Tier | Criteria |
|------|----------|
| **Beginner** | Daily CEO basics: email, meetings, docs, pipeline |
| **Intermediate** | CRM, content strategy, advisory, financial |
| **Advanced** | Orchestration, automation, multi-agent, self-improvement |

Ask Diraj if uncertain. Default to **Advanced** for orchestration/technical skills.

### Step 5: Update `bootstrap.sh` (macOS/Linux Installer)

Add the skill name to the correct tier array. Location: ~line 330-370.

```bash
# Find the exact line to edit
grep -n "BEGINNER_SKILLS\|INTERMEDIATE_SKILLS\|ADVANCED_SKILLS" bootstrap.sh
```

Append the skill name (space-separated) to the appropriate array string.

### Step 6: Update `bootstrap.ps1` (Windows Installer)

Add the skill name to the SAME tier array in the PowerShell installer. Location: ~line 229-234.

```bash
grep -n "BEGINNER_SKILLS\|INTERMEDIATE_SKILLS\|ADVANCED_SKILLS" bootstrap.ps1
```

**⚠️ PARITY GATE:** Both installers MUST have identical skill lists. Diff them:
```bash
diff <(grep "SKILLS =" bootstrap.sh | sort) <(grep "SKILLS =" bootstrap.ps1 | sort)
```

### Step 7: Update `SKILLS-REGISTRY.md`

1. Add the skill to the correct category table
2. Update the total skill count in the header (`> **N unique skills**`)
3. If it creates a new composition pattern, add to the Composition Patterns table
4. If it's from an external source, add to the Attribution table

### Step 8: Update `AGENT-GUIDE.md`

1. Add the skill to the correct catalog section
2. Update the total skill count in the "What This Is" paragraph
3. Update the Advanced tier count in the Experience Levels table
4. Update the Architecture tree comment (`# N skill directories`)

### Step 9: Update `README.md`

1. Update the version badge skill count (`73+ Domain Skills` → `N+ Domain Skills`)
2. Update the Architecture ASCII art skill count (`N Domain Skills`)
3. Add to the Full Capabilities Inventory table in the correct category
4. If it's a headline capability, add to the "What's New" section

### Step 10: Update `GETTING-STARTED.md`

1. Update the skill count reference (`N pre-built skills`)
2. Update the tier table if the beginner/intermediate/advanced counts changed
3. If the skill is beginner-facing, add to the "Most-Used Skills for Executives" table

---

## Phase 3: Verify

### The Triple-Check Protocol

After all 10 steps, run this exact verification:

```bash
SKILL_NAME="<skill-name>"

echo "=== 1. Skill file exists ==="
test -f "skills/$SKILL_NAME/SKILL.md" && echo "✅ PASS" || echo "❌ FAIL"

echo "=== 2. Frontmatter name matches directory ==="
grep "^name:" "skills/$SKILL_NAME/SKILL.md" | grep -q "$SKILL_NAME" && echo "✅ PASS" || echo "❌ FAIL"

echo "=== 3. bootstrap.sh contains skill ==="
grep -q "$SKILL_NAME" bootstrap.sh && echo "✅ PASS" || echo "❌ FAIL"

echo "=== 4. bootstrap.ps1 contains skill ==="
grep -q "$SKILL_NAME" bootstrap.ps1 && echo "✅ PASS" || echo "❌ FAIL"

echo "=== 5. SKILLS-REGISTRY.md contains skill ==="
grep -q "$SKILL_NAME" SKILLS-REGISTRY.md && echo "✅ PASS" || echo "❌ FAIL"

echo "=== 6. AGENT-GUIDE.md contains skill ==="
grep -q "$SKILL_NAME" AGENT-GUIDE.md && echo "✅ PASS" || echo "❌ FAIL"

echo "=== 7. README.md skill count updated ==="
ACTUAL=$(find skills/ -name "SKILL.md" | wc -l | tr -d ' ')
echo "  Total skills on disk: $ACTUAL"
grep -q "$ACTUAL" README.md && echo "✅ PASS" || echo "⚠️ CHECK — README may need count update"

echo "=== 8. No proprietary leaks ==="
grep -rl "ceo-brain-search.py\|claude_memory.py\|npx claude-mem\|npm i -g ccflare" "skills/$SKILL_NAME/" && echo "❌ PROPRIETARY LEAK" || echo "✅ CLEAN"

echo "=== 9. Minimum quality bar ==="
LINES=$(wc -l < "skills/$SKILL_NAME/SKILL.md" | tr -d ' ')
[ "$LINES" -ge 60 ] && echo "✅ PASS ($LINES lines)" || echo "❌ FAIL ($LINES lines — under 60 minimum)"

echo "=== 10. Installer parity ==="
SH_COUNT=$(grep -c "$SKILL_NAME" bootstrap.sh)
PS1_COUNT=$(grep -c "$SKILL_NAME" bootstrap.ps1)
[ "$SH_COUNT" -eq "$PS1_COUNT" ] && echo "✅ PASS (both: $SH_COUNT)" || echo "❌ FAIL (sh=$SH_COUNT, ps1=$PS1_COUNT)"

echo "=== 11. Full doc coverage (all skills, not just new) ==="
FULL_MISS=0
for d in skills/*/; do
    sn=$(basename "$d")
    grep -q "$sn" AGENT-GUIDE.md || { echo "❌ AGENT-GUIDE missing: $sn"; FULL_MISS=$((FULL_MISS+1)); }
    grep -q "$sn" SKILLS-REGISTRY.md || { echo "❌ REGISTRY missing: $sn"; FULL_MISS=$((FULL_MISS+1)); }
    grep -q "$sn" README.md || { echo "❌ README missing: $sn"; FULL_MISS=$((FULL_MISS+1)); }
done
[ "$FULL_MISS" -eq 0 ] && echo "✅ PASS (all skills in all docs)" || echo "❌ FAIL ($FULL_MISS gaps)"

echo "=== 12. Skill count consistency ==="
DISK=$(find skills/ -name "SKILL.md" | wc -l | tr -d ' ')
GUIDE=$(grep -oE 'All [0-9]+ skills' AGENT-GUIDE.md | grep -oE '[0-9]+')
REG=$(head -3 SKILLS-REGISTRY.md | grep -oE '[0-9]+')
GS=$(grep -oE '[0-9]+ pre-built skills' GETTING-STARTED.md | grep -oE '[0-9]+')
echo "  Disk=$DISK | AGENT-GUIDE=$GUIDE | REGISTRY=$REG | GETTING-STARTED=$GS"
[ "$DISK" = "$GUIDE" ] && [ "$DISK" = "$REG" ] && [ "$DISK" = "$GS" ] && echo "✅ PASS" || echo "❌ MISMATCH"
```

**All 12 checks must pass.** If any fail, fix before committing.

---

## Phase 4: Ship

### Commit & Push

```bash
git add -A
git commit -m "feat: Import $SKILL_NAME skill into GTM Enablement Kit

- Rewrote to GFV authoring standard
- Registered in bootstrap.sh and bootstrap.ps1 ($TIER tier)
- Added to SKILLS-REGISTRY.md, AGENT-GUIDE.md, README.md
- Updated skill counts across all docs
- Verified: 10/10 integration checks pass"

git push origin main
```

### Version Decision

- **Patch bump** (x.x.+1): Simple skill addition, no architectural change
- **Minor bump** (x.+1.0): New category, new orchestration capability, or 3+ skills
- **Major bump** (+1.0.0): Fundamental architecture change

If bumping version, also update CHANGELOG.md with a dated entry following the established format.

---

## Red Flags — Stop and Re-evaluate

- The source skill requires a proprietary SaaS dependency that can't be made agnostic
- The skill duplicates >80% of an existing kit skill (merge instead of adding)
- The skill requires global npm packages or system-level installations
- The source has a restrictive license incompatible with the kit

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| Local Memory | Client-specific facts | `gfv-brain-search.py` |
| SKILLS-REGISTRY | Category mapping | Direct markdown parsing |
| Bootstrap scripts | Tier installation logic | Bash/PowerShell arrays |

> **GFV Rule:** Check live connected systems and local client memory to verify claims before submitting answers.

## Proactive Triggers

Surface these issues WITHOUT being asked when you notice them in context:
- **Duplicate capability** → Flag if an existing skill already covers >50% of this functionality
- **Missing tier parity** → Alert if bootstrap.sh and bootstrap.ps1 diverge
- **Stale counts** → Flag if README/AGENT-GUIDE skill counts don't match `find skills/ -name SKILL.md | wc -l`
- **Proprietary leak** → Stop immediately if source material contains non-agnostic dependencies
- **License conflict** → Flag if source repo license restricts redistribution

## Output Artifacts

| When you ask for... | You get... |
|---------------------|------------|
| Skill import | Fully rewritten SKILL.md + all 10 system updates |
| Verification report | 10-point checklist with PASS/FAIL for each touchpoint |
| Diff summary | Git diff showing every file changed across the integration |

## Confidence Tagging

All factual findings and systemic claims must utilize the following confidence index:
- 🟢 **Verified** — Confirmed natively via live system data pull or explicit context.
- 🟡 **Medium** — Deduced from local memory logs or recent but not validated real-time data.
- 🔴 **Assumed** — No source available, utilizing best-judgment baseline.

## <verification_gate>
**Self-Verification Protocol:** Before declaring the import complete, you MUST run the 10-point verification script above and confirm all 10 checks pass. You MUST also `grep` for proprietary strings (`ceo-brain-search.py`, `claude-mem`, `ccflare`, `claude_memory.py`, `npm i -g`) across the new skill AND all modified files. If any check fails, fix it before reporting completion.

## After This Skill
💡 Suggest these next steps:
- "Want me to run the full kit verification sweep?" → Run the proprietary leak scan across all files
- "Want me to cut a release?" → `/project-release`
- "Want me to test the new skill?" → `/verify-execution`

## Related Skills

- **create-skill**: Use when building a NEW skill from scratch. NOT for importing existing external skills.
- **project-release**: Use AFTER import to cut a versioned release. NOT for the import itself.
- **verify-execution**: Use to test the imported skill in a live scenario. NOT for the registration process.
- **autoresearch**: Use to iteratively improve the imported skill's quality score. NOT for initial integration.

## Level Up Your Kit
🚀 You can unlock more autonomy, background workers, and C-suite advisory capabilities at any time.
- **Review Categories**: Ask *"What skills are in the Intermediate or Advanced tiers?"*
- **How to Upgrade**: Run `./bootstrap.sh` in the repository root and select your new tier.
