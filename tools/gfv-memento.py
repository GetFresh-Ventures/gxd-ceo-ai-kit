import os
import sys
import json
from datetime import datetime

import portalocker

CEO_BRAIN_DIR = os.environ.get("GFV_CEO_BRAIN", os.path.expanduser("~/ceo-brain"))
MEMENTO_DIR = os.path.join(CEO_BRAIN_DIR, "mementos")

def save_memento(task_id, content):
    os.makedirs(MEMENTO_DIR, exist_ok=True)
    filepath = os.path.join(MEMENTO_DIR, f"{task_id}.txt")
    with open(filepath, "a", encoding="utf-8") as f:
        portalocker.lock(f, portalocker.LOCK_EX)
        try:
            f.write(f"\n--- {datetime.utcnow().isoformat()} ---\n")
            f.write(content)
        finally:
            portalocker.unlock(f)
    print(f"✅ Memento saved: {filepath}")

def load_memento(task_id):
    filepath = os.path.join(MEMENTO_DIR, f"{task_id}.txt")
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            portalocker.lock(f, portalocker.LOCK_SH)
            try:
                print(f.read())
            finally:
                portalocker.unlock(f)
    else:
        print(f"❌ Memento not found: {task_id}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 gfv-memento.py [save|load] [task_id] [content...]")
        sys.exit(1)
    
    action = sys.argv[1]
    task_id = sys.argv[2]
    
    if action == "save":
        content = " ".join(sys.argv[3:])
        save_memento(task_id, content)
    elif action == "load":
        load_memento(task_id)
