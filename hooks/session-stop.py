#!/usr/bin/env python3
"""
GFV CEO Enablement Kit — Session Stop Hook
Saves session learnings and context to the brain directory.

Install: Copy to ~/.claude/hooks/session-stop.py
Trigger: Stop event
"""

import os
import sys
from pathlib import Path
from datetime import datetime


def main():
    brain_dir = Path.home() / "brain"

    if not brain_dir.exists():
        return  # Nothing to save to

    learnings_file = brain_dir / "learnings.md"
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M")

    # Append a session marker
    with open(learnings_file, "a") as f:
        f.write(f"\n---\n### Session: {timestamp}\n")
        f.write("<!-- Claude: append key learnings from this session below -->\n")
        f.write("<!-- Example: - Learned that Acme Corp's Q3 budget is $500K -->\n")
        f.write("<!-- Example: - Sarah prefers Tuesday afternoon meetings -->\n\n")


if __name__ == "__main__":
    main()
