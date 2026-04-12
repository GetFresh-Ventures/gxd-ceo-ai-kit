#!/usr/bin/env python3
"""
GFV CEO Enablement Kit — Session Start Hook
Loads company brain context at the beginning of every Claude Code session.

Install: Copy to ~/.claude/hooks/session-start.py
Trigger: SessionStart event
"""

import os
import sys
import json
from pathlib import Path
from datetime import datetime


def main():
    ceo_brain_dir = Path.home() / "ceo-brain"
    gtm_brain_dir = Path.home() / "gtm-brain"

    if not ceo_brain_dir.exists() and not gtm_brain_dir.exists():
        print("⚠️  No executive brain directory found. Run bootstrap.sh or /onboard first.", file=sys.stderr)
        return

    context_parts = []
    context_parts.append(f"# Session Context — {datetime.now().strftime('%Y-%m-%d %H:%M')}\n")

    # Load voice model summary
    voice_model = ceo_brain_dir / "voice-model.md"
    if voice_model.exists():
        content = voice_model.read_text()
        if len(content) > 200:
            context_parts.append("✅ Voice model loaded (~/ceo-brain/voice-model.md)")
        else:
            context_parts.append("❌ No voice model found — run /onboard to generate ~/ceo-brain/voice-model.md")
    else:
        context_parts.append("❌ No voice model found — run /onboard to generate ~/ceo-brain/voice-model.md")

    # Load pipeline state
    pipeline = gtm_brain_dir / "pipeline.md"
    if pipeline.exists():
        content = pipeline.read_text()
        context_parts.append(f"✅ Pipeline state loaded ({len(content.splitlines())} lines)")
    else:
        context_parts.append("⚠️  No pipeline.md — create one with current deal state")

    # Load recent learnings (last 20 lines)
    learnings = gtm_brain_dir / "learnings.md"
    if learnings.exists():
        lines = learnings.read_text().splitlines()
        if len(lines) > 5:
            context_parts.append(f"✅ Learnings log has {len(lines)} entries")
            context_parts.append("\nRecent learnings:")
            for line in lines[-10:]:
                if line.strip():
                    context_parts.append(f"  {line}")

    # Check for meeting briefs
    meetings_dir = ceo_brain_dir / "meetings"
    if meetings_dir.exists():
        briefs = sorted(meetings_dir.glob("*.md"), reverse=True)[:3]
        if briefs:
            context_parts.append(f"\n📋 Recent meeting briefs: {len(briefs)}")
            for brief in briefs:
                context_parts.append(f"  - {brief.name}")

    # Output context
    output = "\n".join(context_parts)
    print(output)

    # Write to a temp file for Claude Code to pick up
    context_file = ceo_brain_dir / ".last-session-context.md"
    if ceo_brain_dir.exists():
        context_file.write_text(output)


if __name__ == "__main__":
    main()
