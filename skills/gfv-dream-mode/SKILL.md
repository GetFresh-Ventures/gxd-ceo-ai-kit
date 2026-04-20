---
name: gfv-dream-mode
description: Run the GFV Dream Mode to autonomously consolidate fragmented session memories, logs, and findings into durable architectural knowledge in the Proactive Intelligence Layer (PIL).
---

# GFV Dream Mode: Memory Consolidation Routine

## Context
When portfolio CEOs and deployment teams execute long, dense sessions—such as scraping competitors, restructuring Google Ads, or writing architecture code—the granular context is temporarily held in session logs and raw JSONL files. 

**Dream Mode** is an autonomous capability (inspired by `openclaude`) designed to do a "reflective pass" over these disconnected files. It synthesizes what was learned into durable, well-organized memories within your SQLite/Supabase Intelligence Layer, meaning the agent never loses context over time.

## When to use this skill
- At the end of a heavily productive day or week.
- When the agent starts "forgetting" decisions made a few days ago.
- Before transitioning from a "Planning Phase" to an "Execution Phase".

## Three-Phase Memory Protocol (from ruflo three-phase memory)

Dream Mode uses a 3-phase lifecycle so that interrupted runs can resume from the last checkpoint.

### Phase 1: STATUS (Pre-Flight)
Before starting, record initial state:
```bash
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py store \
  --key "dream_mode_status" \
  --value '{"status":"running","started":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","sessions_to_process":3}'
```

### Phase 2: PROGRESS (Per-Session)
After each session is processed, update the checkpoint:
```bash
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py store \
  --key "dream_mode_progress" \
  --value '{"session":"SESSION_ID","facts_extracted":N,"progress":"1/3"}'
```

### Phase 3: COMPLETE (Post-Flight)
After all sessions are processed:
```bash
python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py store \
  --key "dream_mode_complete" \
  --value '{"status":"complete","total_facts":N,"duration_seconds":T,"sessions_processed":3}'
```

### Failure Recovery
If dream mode is interrupted, the next run checks `dream_mode_status`:
- If `status=running` and `started` > 30 min ago → **resume from last `progress` checkpoint**
- If `status=complete` and last run < 6 hours → **skip unless forced**
- If no status found → **full fresh run**

## Execution Steps

1. **Invoke the Dream Script**
   ```bash
   ~/Documents/Code/gfv_growth_by_design/tools/gfv-dream.sh
   ```
   *Action:* The agent will run this script. The script parses the last 3 sessions from the Claude Code `~/brain/` memory tier, and autonomously extracts the facts, writing them to SQLite or updating markdown artifacts.

2. **Verify Memory Compaction**
   Check the `~/brain/` directory or run `python3 ~/Documents/Code/gfv-brain/scripts/claude_memory.py list` to verify that new concepts (strategies, pipeline updates) have been successfully written as long-term Knowledge Items.

3. **Prune Stale Caches**
   If the Dream completes successfully, clear the active cache to reset the agent's short-term memory limit:
   ```bash
   rm -rf ~/.claude/session-cache/*
   ```

## Background Worker Scheduling (from ruflo daemon workers)

### Autonomous Consolidation
Dream Mode can run autonomously on a schedule instead of manual invocation:

| Worker | Priority | Trigger | Action |
|--------|----------|---------|--------|
| `consolidate` | Low | Every 6 hours or session end | Parse logs → extract facts → write to PIL |
| `stale-detect` | Low | Weekly (Sunday 2am) | Flag facts older than 30 days for review |
| `intelligence-surface` | Normal | Session start | Surface top 3 relevant PIL facts for context |

### launchd Schedule (macOS)
```bash
# Memory consolidation — every 6 hours
# Create ~/Library/LaunchAgents/com.gfv.dream-mode.plist
# Or add to crontab:
0 */6 * * * ~/Documents/Code/gfv_growth_by_design/tools/gfv-dream.sh >> /tmp/dream.log 2>&1
```

## CEO Communication
Once Dream Mode is finished, report to the CEO:
- The top 3 core architectural or strategic facts that were successfully permanently memorized.
- Phase completion status (all 3 phases passed or which phase failed).
- A confirmation that the short-term cache has been flushed and the agent is ready for a fresh, high-velocity session.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
