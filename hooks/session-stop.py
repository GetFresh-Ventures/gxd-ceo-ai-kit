#!/usr/bin/env python3
"""
GetFresh CEO Enablement Kit for AI — Session Stop Hook
Saves session learnings and context to the brain directory.
Reads preferences.json to determine auto-save behavior by tier.

Install: Copy to ~/.claude/hooks/session-stop.py
Trigger: Stop event
"""

import os
import sys
import json
from pathlib import Path
from datetime import datetime

try:
    import fcntl
except ImportError:
    fcntl = None

CEO_BRAIN_DIR = Path(os.environ.get("GFV_CEO_BRAIN", Path.home() / "ceo-brain"))
GTM_BRAIN_DIR = Path(os.environ.get("GFV_GTM_BRAIN", Path.home() / "gtm-brain"))

def load_preferences():
    """Load user preferences from ~/ceo-brain/preferences.json"""
    prefs_file = CEO_BRAIN_DIR / "preferences.json"
    if prefs_file.exists():
        try:
            return json.loads(prefs_file.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            pass
    # Defaults if no preferences file exists
    return {
        "level": "beginner",
        "auto_memory": True,
        "session_summary": True,
        "feedback_loops": False,
        "dream_mode": False
    }


def main():
    ceo_brain_dir = CEO_BRAIN_DIR
    gtm_brain_dir = GTM_BRAIN_DIR
    prefs = load_preferences()
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M")

    # Ensure directories exist
    if not gtm_brain_dir.exists():
        gtm_brain_dir.mkdir(parents=True, exist_ok=True)
    if not ceo_brain_dir.exists():
        ceo_brain_dir.mkdir(parents=True, exist_ok=True)

    # 1. Append session marker to learnings (all tiers)
    if prefs.get("auto_memory", True):
        learnings_file = gtm_brain_dir / "learnings.md"
        with open(learnings_file, "a", encoding="utf-8") as f:
            if fcntl: fcntl.flock(f.fileno(), fcntl.LOCK_EX)
            try:
                f.write(f"\n---\n### Session: {timestamp}\n")
                f.write(f"**Level**: {prefs.get('level', 'unknown')}\n")
                f.write("<!-- Auto-saved session marker. Key learnings from this session: -->\n\n")
            finally:
                if fcntl: fcntl.flock(f.fileno(), fcntl.LOCK_UN)

    # 2. Session summary for beginners and intermediates
    if prefs.get("session_summary", False):
        summary_dir = ceo_brain_dir / "weekly"
        summary_dir.mkdir(parents=True, exist_ok=True)
        summary_file = summary_dir / f"session-{datetime.now().strftime('%Y-%m-%d')}.md"
        with open(summary_file, "a", encoding="utf-8") as f:
            if fcntl: fcntl.flock(f.fileno(), fcntl.LOCK_EX)
            try:
                f.write(f"\n## Session: {timestamp}\n")
                f.write("<!-- Auto-generated session summary -->\n")
                f.write("<!-- Claude: Replace this with a 3-bullet session recap -->\n")
                f.write("- \n- \n- \n\n")
            finally:
                if fcntl: fcntl.flock(f.fileno(), fcntl.LOCK_UN)

    # 3. Feedback loop state for intermediate+
    if prefs.get("feedback_loops", False):
        feedback_dir = ceo_brain_dir / "mementos"
        feedback_dir.mkdir(parents=True, exist_ok=True)
        feedback_file = feedback_dir / "feedback-log.md"
        with open(feedback_file, "a", encoding="utf-8") as f:
            if fcntl: fcntl.flock(f.fileno(), fcntl.LOCK_EX)
            try:
                f.write(f"\n### {timestamp}\n")
                f.write("<!-- Auto-saved feedback checkpoint -->\n\n")
            finally:
                if fcntl: fcntl.flock(f.fileno(), fcntl.LOCK_UN)

    # 4. Dream Mode flag for advanced users
    if prefs.get("dream_mode", False):
        dream_flag = ceo_brain_dir / ".dream-pending"
        dream_flag.write_text(f"pending_since: {timestamp}\n", encoding="utf-8")

    # Output confirmation
    level = prefs.get("level", "unknown")
    print(f"✅ Session saved ({level} mode) — {timestamp}")
    if prefs.get("session_summary"):
        print(f"   📝 Summary template: ~/ceo-brain/weekly/session-{datetime.now().strftime('%Y-%m-%d')}.md")


if __name__ == "__main__":
    main()
