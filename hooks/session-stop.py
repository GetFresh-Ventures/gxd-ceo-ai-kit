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
import subprocess

import portalocker

CEO_BRAIN_DIR = Path(os.environ.get("GFV_CEO_BRAIN", Path.home() / "ceo-brain"))
GTM_BRAIN_DIR = Path(os.environ.get("GFV_GTM_BRAIN", Path.home() / "gtm-brain"))

def load_preferences():
    """Load user preferences from ~/ceo-brain/preferences.json"""
    prefs_file = CEO_BRAIN_DIR / "preferences.json"
    if prefs_file.exists():
        try:
            return json.loads(prefs_file.read_text(encoding="utf-8"))
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

    # Read session ID for Telemetry
    session_id = "unknown"
    session_file = ceo_brain_dir / ".current_session_id"
    if session_file.exists():
        session_id = session_file.read_text().strip()

    # 1. Close Telemetry
    script_dir = os.path.dirname(os.path.abspath(__file__))
    telemetry_script = os.path.join(os.path.dirname(script_dir), "tools", "gfv-telemetry.py")
    if os.path.exists(telemetry_script):
        try:
            subprocess.Popen(
                [sys.executable, telemetry_script, "stop", "--session", session_id, "--status", "completed"],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
            )
        except Exception:
            pass

    # Ensure directories exist
    if not gtm_brain_dir.exists():
        gtm_brain_dir.mkdir(parents=True, exist_ok=True)
    if not ceo_brain_dir.exists():
        ceo_brain_dir.mkdir(parents=True, exist_ok=True)

    # 1. Append session marker to learnings (all tiers)
    if prefs.get("auto_memory", True):
        learnings_file = gtm_brain_dir / "learnings.md"
        with open(learnings_file, "a", encoding="utf-8") as f:
            portalocker.lock(f, portalocker.LOCK_EX)
            try:
                f.write(f"\n---\n### Session: {timestamp}\n")
                f.write(f"**Level**: {prefs.get('level', 'unknown')}\n")
                f.write("<!-- Auto-saved session marker. Key learnings from this session: -->\n\n")
            finally:
                portalocker.unlock(f)

    # 2. Session summary for beginners and intermediates
    if prefs.get("session_summary", False):
        summary_dir = ceo_brain_dir / "weekly"
        summary_dir.mkdir(parents=True, exist_ok=True)
        summary_file = summary_dir / f"session-{datetime.now().strftime('%Y-%m-%d')}.md"
        with open(summary_file, "a", encoding="utf-8") as f:
            portalocker.lock(f, portalocker.LOCK_EX)
            try:
                f.write(f"\n## Session: {timestamp}\n")
                f.write("<!-- Auto-generated session summary -->\n")
                f.write("<!-- Claude: Replace this with a 3-bullet session recap -->\n")
                f.write("- \n- \n- \n\n")
            finally:
                portalocker.unlock(f)

    # 3. Feedback loop state for intermediate+
    if prefs.get("feedback_loops", False):
        feedback_dir = ceo_brain_dir / "mementos"
        feedback_dir.mkdir(parents=True, exist_ok=True)
        feedback_file = feedback_dir / "feedback-log.md"
        with open(feedback_file, "a", encoding="utf-8") as f:
            portalocker.lock(f, portalocker.LOCK_EX)
            try:
                f.write(f"\n### {timestamp}\n")
                f.write("<!-- Auto-saved feedback checkpoint -->\n\n")
            finally:
                portalocker.unlock(f)

    # 4. Dream Mode flag for advanced users
    if prefs.get("dream_mode", False):
        dream_flag = ceo_brain_dir / ".dream-pending"
        dream_flag.write_text(f"pending_since: {timestamp}\n", encoding="utf-8")

    # 5. Native Brain Version Control (Rollbacks)
    try:
        git_dir = ceo_brain_dir / ".git"
        if not git_dir.exists():
            subprocess.run(["git", "init"], cwd=str(ceo_brain_dir), capture_output=True)
            gitignore_path = ceo_brain_dir / ".gitignore"
            if not gitignore_path.exists():
                gitignore_path.write_text(".DS_Store\n__pycache__\n", encoding="utf-8")
        
        subprocess.run(["git", "add", "."], cwd=str(ceo_brain_dir), capture_output=True)
        subprocess.run(
            ["git", "commit", "-m", f"chore(memory): auto-backup session state {timestamp}"],
            cwd=str(ceo_brain_dir), capture_output=True
        )
    except Exception:
        pass

    # 6. Rebuild Local Brain Search Index
    brain_search_script = os.path.join(os.path.dirname(script_dir), "tools", "gfv-brain-search.py")
    if os.path.exists(brain_search_script):
        try:
            subprocess.Popen(
                [sys.executable, brain_search_script, "ingest"],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
            )
        except Exception:
            pass

    # Output confirmation
    level = prefs.get("level", "unknown")
    print(f"✅ Session saved ({level} mode) — {timestamp}")
    if prefs.get("session_summary"):
        print(f"   📝 Summary template: ~/ceo-brain/weekly/session-{datetime.now().strftime('%Y-%m-%d')}.md")


if __name__ == "__main__":
    main()
