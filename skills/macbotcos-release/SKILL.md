---
name: macbotcos-release
description: Push a versioned release for MACBOTCOS — updates GitHub (README, CHANGELOG, tag), Linear (project update), and respects MACBOTCOS strict python governance gates.
---


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

**Output** — Save results to `~/Documents/Code/gfv-brain/` or PIL via Supabase. Never send external messages (email, Slack, WhatsApp) without Diraj's explicit "send it" approval.

**Active Clients**:
- **Golden Rule PHC** — HVAC/plumbing/roofing: goldenrulephc.com, rivercityac.com, cornerstoneroofingexteriors.com
- **Aprio Board Portal** — SaaS governance: aprioboardportal.com
- **GetFresh Ventures** — Venture studio: getfreshventures.com

---


# MACBOTCOS Release Workflow

// turbo-all

## Prerequisites
- Repo: `/Users/dirajgoel/Documents/Code/MACBOTCOS`
- Linear API Key: `op read "op://Machine One/Golden Rule Live Linear API Key/credential"`
- Linear Team ID: `MAC`
- Linear Project ID: `9304b035-a505-4580-adf1-34dc11cf2737` (MACBOTCOS)

## Version Format
`vMAJOR.MINOR.PATCH` — Example: `v6.98.3`
- **MAJOR**: Full rebuild, breaking architecture change
- **MINOR**: New logical feature tier, significant additions
- **PATCH**: Bug fixes, task completions, styling changes

---

## STEP 1: Determine Version (GATE: must decide before proceeding)

Check the latest tags and unreleased commits:
```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && git describe --tags --abbrev=0 2>/dev/null || echo "No tags"
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && git log $(git describe --tags --abbrev=0)..HEAD --oneline
```

Decide the new version number based on what changed since the last tag.
**GATE: Do NOT proceed until the version bump (e.g. from v6.98.2 to v6.98.3) is discussed and confirmed.**

---

## STEP 2: Strict Governance Gates (GATE: all must pass)

MACBOTCOS has an absolute zero-tolerance policy for failing python governance checks. Run the core pre-release audits:

```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && echo "=== UNCOMMITTED ===" && git status --short && echo "=== DOCS STATE GATE ===" && ./venv/bin/[STUB AVOIDED] Execute docs_agent.py via available MCP/agent tools rather than a missing local script --validate-registry --strict-changed-docs --include-worktree --write-state-manifest --json && echo "=== RELEASE VALIDATOR ===" && ./venv/bin/[STUB AVOIDED] Execute release_validator.py via available MCP/agent tools rather than a missing local script --strict && echo "=== ROUTING CONVERGENCE ===" && ./venv/bin/[STUB AVOIDED] Execute validate_routing_convergence.py via available MCP/agent tools rather than a missing local script --json
```

**GATE: You must have zero output/errors on the above scripts. If anything fails, you MUST stop the release and fix the underlying issue.**

---

## STEP 3: Update CHANGELOG.md (GATE: must include version entry)

Add a new entry at the TOP of `/Users/dirajgoel/Documents/Code/MACBOTCOS/CHANGELOG.md` (after the Keep a Changelog header).
Use the format as dictated by `docs/CHANGELOG_FORMAT.md`:

```markdown
## vX.Y.Z — YYYY-MM-DD HH:MM UTC / YYYY-MM-DD H:MM AM/PM PT

### Why it matters
A 1-3 sentence summary of the strategic impact of this release and why the changes were necessary.

### Changes
- **Component name** — Detailed description of the feature or bug fix (MAC-123)
- **Another component** — Description of what was changed

### Linear Issues
- MAC-123, MAC-124
```

**GATE: Run the release integrity script to ensure your changelog entry passes strict formatting.**
```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && ./venv/bin/[STUB AVOIDED] Execute audit_release_integrity.py via available MCP/agent tools rather than a missing local script --strict-lineage
```
If this audit fails, fix the changelog until it passes.

---

## STEP 4: Update VERSION and README.md

1. Overwrite the `VERSION` file with the version string:
   ```bash
   echo "X.Y.Z" > /Users/dirajgoel/Documents/Code/MACBOTCOS/VERSION
   ```
2. Update the README.md `[![Version](...)]` badge to reflect the new version string. Do not modify other untouched sections.

---

## STEP 5: Commit, Tag, Push, and Create GitHub Release

Create the single release commit:
```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && git add -A && git commit -m "chore: release vX.Y.Z — Release Title"
```

Tag and Push (including tags):
```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && git tag -a "vX.Y.Z" -m "Release vX.Y.Z: Release Title" && git push origin main --tags
```

Create the formal GitHub release (this is what populates the repository sidebar):
```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && gh release create vX.Y.Z --title "vX.Y.Z — Release Title" --notes "See CHANGELOG.md for comprehensive release notes" --latest
```

**GATE: Verification.**
```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && gh release list && git describe --tags --exact-match HEAD
```

---

## STEP 6: Execute the bash fallback pipeline (Optional)

If there are any missed background tasks (like temporal workers, script syncs, or database records in `release_trains`), triggering the built-in deploy hooks is recommended:

```bash
cd /Users/dirajgoel/Documents/Code/MACBOTCOS && ./scripts/release_and_push.sh --push-only
```
*(This triggers backend sync routines safely without double-bumping the version).*

---

## STEP 7: Sync to Linear Project Board

Draft the exact markdown payload outlining the release to broadcast on Linear. Then use your `mcp_linear-mcp-server_save_status_update` tool (or native Linear UI) to post the update to the MACBOTCOS project.

**Project Info:**
- **projectId**: `9304b035-a505-4580-adf1-34dc11cf2737`
- **teamId**: `07c647e0-3eba-4c90-b095-c6b9462dc112`

Post content format:
```markdown
## vX.Y.Z — Release Title

Overview of why this release matters...

**Key Changes:**
- Detail 1
- Detail 2

**Git Commit:** [view on github](https://github.com/dpgvan/MACBOTCOS/commit/YOUR_COMMIT_HASH)
```

**Health:** `onTrack` (or `atRisk` if issues arose).

---

## STEP 8: Post-Release Verification

**ALL gates must pass:**
- [ ] CHANGELOG.md passes the python integrity script
- [ ] VERSION file updated
- [ ] Pushed to `origin/main` with tags
- [ ] Linear project update successfully posted
- [ ] No uncommitted files remain in worktree


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
