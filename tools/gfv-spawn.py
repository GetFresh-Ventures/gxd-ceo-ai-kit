#!/usr/bin/env python3
"""
GFV Swarm Dispatcher (Headless Parallel Execution)

This tool allows the primary agent to dispatch long-running tasks seamlessly 
in the background. It utilizes `claude --print` to bypass the interactive 
terminal, routing output directly to the ceo-brain spawns directory.
"""

import os
import sys
import uuid
import argparse
import subprocess
from datetime import datetime
from pathlib import Path

# Paths
CEO_BRAIN_DIR = Path(os.environ.get("GFV_CEO_BRAIN", Path.home() / "ceo-brain"))
SPAWNS_DIR = CEO_BRAIN_DIR / "spawns"

def dispatch_task(task_description: str, agent_persona: str = "Research Analyst"):
    """Spawns a detached Claude subprocess for background execution."""
    SPAWNS_DIR.mkdir(parents=True, exist_ok=True)
    
    # Generate unique swarm ID
    spawn_id = f"spawn_{datetime.now().strftime('%Y%m%d%H%M')}_{uuid.uuid4().hex[:6]}"
    output_file = SPAWNS_DIR / f"{spawn_id}.md"
    
    # Wrap prompt in persona
    prompt = f"[{agent_persona} Persona Active]\n\nTask: {task_description}\n\nExecute this task headlessly and produce a final summarized report."

    # Dispatch to background (detached)
    # Using claude -p (print mode) to ensure it runs to completion without blocking
    try:
        with open(output_file, 'w') as f:
            f.write(f"--- \nstatus: running\nspawn_id: {spawn_id}\npersona: {agent_persona}\nstarted: {datetime.now().isoformat()}\n---\n\n")
            
        print(f"🚀 Dispatching Swarm [{spawn_id}] -> {output_file}")
        
        # Fire and forget
        subprocess.Popen(
            ["claude", "-p", prompt],
            stdout=open(output_file, 'a'),
            stderr=subprocess.STDOUT,
            start_new_session=True # Detach entirely from the current terminal
        )
        return spawn_id
        
    except Exception as e:
        print(f"❌ Failed to dispatch swarm: {e}", file=sys.stderr)
        return None

def list_spawns():
    """Lists current running or completed background spawns."""
    if not SPAWNS_DIR.exists():
        print("No spawns found.")
        return
        
    for file in SPAWNS_DIR.glob("*.md"):
        print(f"📍 {file.name}")

def main():
    parser = argparse.ArgumentParser(description="GFV Headless Swarm Dispatcher")
    parser.add_argument("action", choices=["run", "list"], help="Action to perform")
    parser.add_argument("--task", help="The task description for the agent")
    parser.add_argument("--persona", default="Research Analyst", help="Agent persona/specialty")
    
    args = parser.parse_args()
    
    if args.action == "run":
        if not args.task:
            print("❌ Must provide --task with run action")
            sys.exit(1)
        dispatch_task(args.task, args.persona)
    elif args.action == "list":
        list_spawns()

if __name__ == "__main__":
    main()
