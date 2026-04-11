---
name: project-release
description: Governed release workflow for CEO enablement projects. Bumps semantic version, updates CHANGELOG and README, tags git, publishes GitHub Release, pushes to remote, and syncs release notes to Linear. Hard gates enforce no skipped steps.
---

# `project-release`

// turbo-all

This skill provides a structured release process for AI-powered executives managing their own codebase and infrastructure. It ensures every release is documented, cleanly versioned, published to GitHub Releases, and broadcasted to Linear.

## Prerequisites
- A git repository initialized with a `README.md` and `CHANGELOG.md`.
- Ensure there are no uncommitted changes or dirty working states prior to running this release.
- GitHub CLI (`gh`) installed and authenticated (`/opt/homebrew/bin/gh auth status`).
- (Optional) Linear Project ID for project board synchronization.

## Version Format
`vMAJOR.MINOR.PATCH` — Example: `v1.3.0`
- **MAJOR (`v2.0.0`)**: Breaking framework changes or massive structural refactors.
- **MINOR (`v1.2.0`)**: New skills, workflows, or significant system additions.
- **PATCH (`v1.1.1`)**: Small fixes, prompt tweaks, or documentation updates.

---

## STEP 1: Determine Version (GATE: must decide before proceeding)

Check the latest tags and unreleased commits:
```bash
git describe --tags --abbrev=0 2>/dev/null || echo "No tags"
git log $(git describe --tags --abbrev=0)..HEAD --oneline
```

Decide the new version number based on what changed since the last tag.
Formulate a short, punchy release title (e.g., `Autonomous Execution Hardening`).

**GATE: Do NOT proceed until the version bump and title are confirmed.**

---

## STEP 2: Pre-Flight Checks (GATE: all must pass)

Run all checks:
```bash
echo "=== GIT STATUS ===" && git status --short && echo "=== UNCOMMITTED ===" && git diff --stat
```

**GATE: The following must ALL be true before proceeding:**
- [ ] Version number decided (Step 1)
- [ ] No unexpected uncommitted changes (or they are intentional for this release)

---

## STEP 3: Update CHANGELOG.md (GATE: must include version entry)

Add a new entry at the TOP of `CHANGELOG.md` (right below the main `# Changelog` header) following this exact format:

```markdown
## YYYY-MM-DD H:MM AM/PM CT — vX.Y.Z — Release Title

### Why it matters
A 1-3 sentence summary of the strategic impact of this release and why the changes were necessary.

### Added
- **`component/file`** — Description of feature or addition

### Changed
- **`component/file`** — Description of what was modified

### Fixed
- **`component/file`** — Description of what was fixed

### Files Modified
- file1.ext, file2.ext
- path/to/file3.ext, path/to/file4.ext
```

Rules:
- Time must be in **Central Time (CT)**
- Use sections: Added, Changed, Fixed, Removed (only include non-empty sections)
- Each item must be a concrete change with the component/file bolded, not vague
- "Why it matters" is **mandatory** — explain the strategic impact
- "Files Modified" is **mandatory** — list every file touched
- Reference Linear issue IDs where applicable

**GATE: CHANGELOG.md must have the new version entry before proceeding.**

---

## STEP 4: Update README.md (GATE: must be comprehensive and CEO-accessible)

The README is the product's front door. It must be written for **two audiences** in this order:

### Audience 1: The Uninitiated CEO (top of the file)
A CEO who has never seen this project should be able to read the README and understand:
- **What this is** — in plain language, no jargon
- **Who it's for** — and who it's NOT for
- **Quick Start** — exact terminal commands to go from zero to working in under 5 minutes
- **What it can do** — a full inventory of every skill, workflow, tool, and hook with 1-line descriptions
- **How it works** — the architecture explained for a non-technical reader (brain directory, AGENT.md, skills, tools, hooks)

### Audience 2: The Advanced User (lower in the file)
Below the CEO-friendly sections, include:
- Agent-agnostic architecture details (how AGENT.md maps to different IDEs)
- Advanced tooling (Dream protocol, Ralph loop, autoresearch, cost routing)
- How to extend the kit (adding new skills, workflows)
- Release history showing every version's "What's New"

### README Structural Requirements
- `**Version**: vX.Y.Z` badge at the top, updated to the new version
- "Release History" section with a `What's New in vX.Y.Z` block for the current release
- Previous release "What's New" blocks must remain below the current one
- Full repository tree showing the directory structure
- Tables for skill/workflow/tool inventories — not just bullet lists

**GATE: README.md must reference the new version AND meet the comprehensiveness standard above before proceeding. If the README is just a version bump without substantive context, the release MUST NOT proceed.**

---

## STEP 5: Git Commit + Tag

Stage and commit:
```bash
git add -A && git status
```

Then commit and tag:
```bash
git commit -m "vX.Y.Z: Release Title" && git tag -a "vX.Y.Z" -m "vX.Y.Z: Release Title"
```

**GATE: Commit and tag must exist. Verify:**
```bash
git log -1 --oneline && git describe --tags --exact-match HEAD
```

---

## STEP 6: Push to GitHub

```bash
git push origin main --tags --force-with-lease
```

**GATE: Push must succeed. Verify:**
```bash
git log -1 --oneline origin/main
```

---

## STEP 7: Publish GitHub Release

Extract the changelog body into a temp file and publish using the GitHub CLI:
```bash
/opt/homebrew/bin/gh release create vX.Y.Z --title "vX.Y.Z: Release Title" -F /tmp/vX.Y.Z_release_notes.md
```

The release notes file must include:
- "Why it matters" summary
- All Added/Changed/Fixed sections
- Files Modified listing
- Link to the git commit hash

**GATE: `gh release create` must succeed and return the GitHub release URL.**

---

## STEP 8: Linear Sync (If Applicable)

If the active environment is tied to a Linear Project:
1. Draft a markdown payload matching this format:

```markdown
## vX.Y.Z — Release Title (Date)

### Why it matters
Strategic summary...

**Key Changes:**
- Detail 1
- Detail 2

**Files Modified:**
- file1.ext, file2.ext

**Git:** [commit_hash](https://github.com/ORG/REPO/commit/FULL_HASH)
```

2. Use the `mcp_linear-mcp-server_save_status_update` tool to publish the payload as a Project Update. Set health to `onTrack`.

**GATE: Linear update must be created successfully.**

---

## STEP 9: Post-Release Verification

Final verification:
```bash
echo "=== LAST COMMIT ===" && git log -1 --format="%H %s (%ai)" && echo "=== TAG ===" && git describe --tags --exact-match HEAD && echo "=== REMOTE SYNC ===" && git status -sb
```

**ALL gates must pass:**
- [ ] CHANGELOG.md has new version entry with CT timestamp and "Why it matters"
- [ ] README.md references new version in badge and What's New
- [ ] Git commit message follows format `vX.Y.Z: Title`
- [ ] Git tag matches version
- [ ] Pushed to origin/main with tags
- [ ] GitHub Release published (visible in repo Releases tab)
- [ ] Linear project update created (if applicable)
- [ ] No uncommitted changes remain

---

## Quick Reference

### Commit Message Examples
```
v1.3.0: Autonomous Execution Hardening
v1.2.1: Fix ccflare cache token parsing
v2.0.0: Multi-agent orchestration rebuild
```

### Linear Health Status
- `onTrack` — Default for routine releases
- `atRisk` — When blockers exist or timeline is slipping
- `offTrack` — When critical systems are broken

### Time Conversion
- PDT → CDT: add 2 hours (e.g., 3:00 PM PDT = 5:00 PM CDT)
- UTC → CDT: subtract 5 hours (e.g., 22:00 UTC = 5:00 PM CDT)
