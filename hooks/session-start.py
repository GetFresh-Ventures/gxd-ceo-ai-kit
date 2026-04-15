#!/usr/bin/env python3
"""
GetFresh CEO Enablement Kit for AI — Session Start Hook
Loads company brain context at the beginning of every Claude Code session.
Reads preferences.json to customize behavior by user level.

Install: Copy to ~/.claude/hooks/session-start.py
Trigger: SessionStart event
"""

import os
import sys
import json
from pathlib import Path
from datetime import datetime

CEO_BRAIN_DIR = Path(os.environ.get("GFV_CEO_BRAIN", Path.home() / "ceo-brain"))
GTM_BRAIN_DIR = Path(os.environ.get("GFV_GTM_BRAIN", Path.home() / "gtm-brain"))


def load_preferences():
    """Load user preferences from ~/ceo-brain/preferences.json"""
    prefs_file = CEO_BRAIN_DIR / "preferences.json"
    if prefs_file.exists():
        try:
            return json.loads(prefs_file.read_text())
        except (json.JSONDecodeError, OSError):
            pass
    return {
        "level": "beginner",
        "auto_memory": True,
        "proactive_tips": True,
        "plain_english": True,
        "session_summary": True
    }


def load_profile():
    """Load user profile from ~/ceo-brain/profile.json"""
    profile_file = CEO_BRAIN_DIR / "profile.json"
    if profile_file.exists():
        try:
            return json.loads(profile_file.read_text())
        except (json.JSONDecodeError, OSError):
            pass
    return {}


def main():
    ceo_brain_dir = CEO_BRAIN_DIR
    gtm_brain_dir = GTM_BRAIN_DIR

    if not ceo_brain_dir.exists() and not gtm_brain_dir.exists():
        print("⚠️  No executive brain directory found. Run bootstrap.sh or /onboard first.", file=sys.stderr)
        return

    prefs = load_preferences()
    profile = load_profile()
    level = prefs.get("level", "unknown")
    name = profile.get("name", "")

    context_parts = []
    context_parts.append(f"# Session Context — {datetime.now().strftime('%Y-%m-%d %H:%M')}")
    if name:
        context_parts.append(f"**User**: {name} | **Level**: {level.capitalize()}")
    else:
        context_parts.append(f"**Level**: {level.capitalize()}")
    context_parts.append("")

    # Active preferences summary
    active_features = []
    if prefs.get("auto_memory"):
        active_features.append("auto-memory")
    if prefs.get("proactive_tips"):
        active_features.append("proactive tips")
    if prefs.get("session_summary"):
        active_features.append("session summaries")
    if prefs.get("feedback_loops"):
        active_features.append("feedback loops")
    if prefs.get("dream_mode"):
        active_features.append("Dream Mode")
    if prefs.get("inline_insights"):
        active_features.append("inline insights")
    if active_features:
        context_parts.append(f"**Active features**: {', '.join(active_features)}")
        context_parts.append("")

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

    # Check for EngineClaw pending approvals (Morning Sync)
    pending_dir = gtm_brain_dir / "pending_approvals"
    if pending_dir.exists():
        drafts = list(pending_dir.glob("*.md")) + list(pending_dir.glob("*.eml"))
        if drafts:
            context_parts.append("\n" + "=" * 50)
            context_parts.append("🌅 GETFRESH EXECUTIVE MORNING SYNC 🌅")
            context_parts.append(f"EngineClaw noticed {len(drafts)} stalled deals and drafted rescue emails while you were offline.")
            context_parts.append("Do you want to review and dispatch them?")
            context_parts.append("=" * 50 + "\n")
            for draft in drafts:
                context_parts.append(f"  - 📝 {draft.name}")

    # Check for Dream Mode pending consolidation
    dream_flag = ceo_brain_dir / ".dream-pending"
    if dream_flag.exists() and prefs.get("dream_mode"):
        context_parts.append("\n🌙 Dream Mode: Memory consolidation pending from last session.")
        context_parts.append("   Run `/dream` to consolidate cross-session learnings.\n")

    # Proactive tips for beginners
    if prefs.get("proactive_tips"):
        context_parts.append("\n💡 **Quick start** — try any of these:")
        if level == "beginner":
            context_parts.append('  • "Draft an email to [name] about [topic]"')
            context_parts.append('  • "Prep me for my meeting with [name]"')
            context_parts.append('  • "Summarize this contract" (paste or attach it)')
        elif level == "intermediate":
            context_parts.append('  • "What does my pipeline look like?" → /pipeline-pulse')
            context_parts.append('  • "Write my weekly CEO brief" → /weekly-ceo-brief')
            context_parts.append('  • "Build an outreach sequence for [prospect]"')
        # Advanced users have proactive_tips: false, so this won't fire

    # Upgrade awareness for beginners who've been using the kit
    if level == "beginner" and voice_model.exists():
        context_parts.append("")
        context_parts.append("🚀 **Ready for more?** You're on the Beginner tier (18 skills).")
        context_parts.append("   Upgrade to **Intermediate** (46 skills) to unlock CRM, pipeline, and strategy tools.")
        context_parts.append('   Just say: *"What would I get if I upgraded?"* or re-run `./bootstrap.sh`')

    # Output context
    output = "\n".join(context_parts)
    print(output)

    # Write to a temp file for Claude Code to pick up
    context_file = ceo_brain_dir / ".last-session-context.md"
    if ceo_brain_dir.exists():
        context_file.write_text(output)


if __name__ == "__main__":
    main()
