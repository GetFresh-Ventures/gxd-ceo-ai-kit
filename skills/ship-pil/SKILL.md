---
name: ship-pil
description: End-to-end verification + Linear evidence + PR for PIL changes. Use after modifying any pil_*.py script or LaunchAgent plist. Runs dry-runs, checks the delivery gate, verifies heartbeats, drafts a Linear evidence comment, and opens a PR. Use when the user says "ship", "ship pil", "verify and ship", or asks to mark PIL Linear issues done.
---

# ship-pil — PIL Verification & Shipping Skill

The "Verify Before Done" discipline from `gfv-brain/CLAUDE-GLOBAL.md` Rule #4, automated. Inspired by Boris Cherny's `/go` pattern (Opus 4.7 dogfooding tips): verify end-to-end, then ship.

Use this any time you've edited PIL scripts, the delivery gate, sentinel logic, or LaunchAgent plists and want to close a Linear issue or open a PR.

## When to invoke

- User says "ship", "ship pil", "ship this", "verify", or "mark GTM-### done"
- After a batch of PIL edits, before creating a PR
- Before updating Linear status from In Progress → Done

## Preconditions

- At least one file in `gfv-brain/scripts/pil_*.py`, `gfv-brain/scripts/linkedin_*.py`, or `~/Library/LaunchAgents/com.gfv.*.plist` has been edited in the current git working tree
- `gh` CLI authenticated
- Linear MCP available (`mcp__abd5a1fe-*`)

## Steps

### 1. Identify what changed

```bash
cd ~/Documents/Code/gfv-brain
git status --short
git diff --stat
```

List the edited files. For each, determine which PIL agent it corresponds to (map script → LaunchAgent label via `com.gfv.<label>.plist`).

### 2. Compile-check everything

```bash
cd ~/Documents/Code/gfv-brain/scripts
for f in <edited_files>; do
  python3 -c "import py_compile; py_compile.compile('$f', doraise=True); print('OK $f')"
done
```

If any file fails, STOP. Report the error and do not proceed.

### 3. Import-smoke-test

```bash
cd ~/Documents/Code/gfv-brain/scripts
for f in <edited_modules>; do
  python3 -c "import $f" 2>&1 | head -5
done
```

Catches broken imports, missing dependencies, circular refs.

### 4. Dry-run affected delivery scripts

For `pil_morning_digest.py`, `pil_daily_inbound_brief.py`, `pil_log_rotator.py`, or any edited script that supports `--dry-run`:

```bash
[STUB AVOIDED] Execute <script>.py via available MCP/agent tools rather than a missing local script --dry-run
```

Expected: completes, prints output, writes heartbeat. If it raises or hangs, STOP.

### 5. Check delivery gate health

Query `delivery_history.db` for any blocked sends in the last hour — a regression would show up as fresh `status='blocked'` rows with `reason` matching an edited script:

```bash
sqlite3 ~/Documents/Code/gfv-brain/db/delivery_history.db \
  "SELECT ts, reason, status, detail FROM deliveries
   WHERE ts >= datetime('now', '-1 hour')
   ORDER BY ts DESC LIMIT 20;"
```

If blocked rows appear for an edited script's reason, investigate before shipping. The gate is the safety net — respect its signals.

### 6. Verify heartbeats

```bash
cat ~/Documents/Code/gfv-brain/db/agent_heartbeats.json | python3 -m json.tool
```

Each delivery script that ran should have a timestamp within the expected interval. A missing or stale entry means the script didn't reach its success path.

### 7. Verify log rotator hygiene

```bash
python3 ~/Documents/Code/gfv-brain/scripts/pil_log_rotator.py --dry-run
du -sh ~/Documents/Code/gfv-brain/logs/scheduled-tasks/
```

Expected: total < 100MB, no individual file flagged for rotation > 10MB. If a file grew unexpectedly since the last shipping cycle, emit a `log_rotator_alarm` signal.

### 8. Sentinel heartbeat gate check

Confirm the sentinel's heartbeat-aware staleness logic is intact:

```bash
grep -n "_heartbeat_age_secs\|_count_force_runs_24h\|_record_force_run" \
  ~/Documents/Code/gfv-brain/scripts/pil_sentinel.py
```

Expected: 3+ matches. If missing, someone removed the circuit breaker — refuse to ship and raise with the user.

### 9. Identify affected Linear issues

Match edited files to open Linear issues (typically GTM-####). The parent epic for PIL reliability is **GTM-1004**; children are GTM-1005–GTM-1013.

```
mcp__abd5a1fe-*__list_issues with query="pil" and state="In Progress"
```

For each matched issue, draft an evidence block (see step 10).

### 10. Draft Linear evidence comment

Post to the **parent epic** if multiple children are affected, otherwise on the individual issue. Evidence format:

```markdown
## Verification run — <DATE>

**Edited:**
- `<file1>` (lines changed)
- `<file2>` (lines changed)

**Compile:** ✅ all pass
**Import smoke:** ✅ all modules resolve
**Dry-runs:** ✅ <list>
**Delivery gate:** 0 blocked rows for reasons: `<reasons>`
**Heartbeats:** fresh (<iso-ts>) for <scripts>
**Log hygiene:** <total size>, no files > 10MB
**Sentinel circuit breaker:** intact (heartbeat + 24h budget both present)

Ready to merge.
```

Use `mcp__abd5a1fe-*__save_comment` with `issueId` set to the matching GTM issue.

### 11. Update CHANGELOG

Append to `gfv-brain/CHANGELOG.md` under the current version heading. Follow DOC_STANDARDS pattern from `gfv-brain/docs/DOC_STANDARDS.md`:

- UTC + PT timestamps in the heading
- Subsection per change type (Added / Changed / Fixed / Infrastructure)
- Link to GTM-#### in each bullet

### 12. Open PR

```bash
cd ~/Documents/Code/gfv-brain
git add <edited_files> CHANGELOG.md
git commit -m "<conventional-prefix>: <short summary>

<body with Linear links>

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
git push -u origin <branch>
gh pr create --title "..." --body "$(cat <<EOF
## Summary
- <bullet>

## Test plan
- [ ] Overnight run completes, heartbeats fresh
- [ ] No blocked-send rows in deliveries
- [ ] Disk under 100MB

Closes #GTM-####
EOF
)"
```

### 13. Report back to user

Concise recap:
- Compile + dry-run status
- Delivery-gate blocked count (must be 0 for edited scripts)
- Heartbeat freshness
- Linear issues updated
- PR URL

Keep the recap under 15 lines. Boris's point: the user trusts the model; they just want the final result + a PR URL.

## Fail-closed rules

- Any compile error → STOP, report, do not open PR
- Any dry-run failure → STOP, report with stack trace
- `delivery_gate_blocked` signal within last hour for edited script's reason → STOP, investigate
- Sentinel heartbeat/circuit-breaker missing → REFUSE to ship, raise with user
- Don't state=Done on any Linear issue. Leave that for the user after PR review. (The `verify-done.py` hook will block it anyway if evidence is missing.)

## Non-goals

- This skill does NOT write tests (not how PIL is structured)
- This skill does NOT merge the PR (human-in-the-loop)
- This skill does NOT modify `settings.json` or permissions
- This skill does NOT touch `gfv_gtm` or non-PIL code

## Links

- Parent epic: https://linear.app/getfresh-ventures/issue/GTM-1004
- PIL Architecture: `gfv-brain/docs/PIL-ARCHITECTURE.md`
- Delivery Gate: `gfv-brain/scripts/pil_delivery_gate.py`
- Sentinel: `gfv-brain/scripts/pil_sentinel.py`


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
