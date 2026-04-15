#!/usr/bin/env bash
set -e
# gfv-generalist.sh - Executes background python or bash scripts safely with logging.
# Used for Context Sponge Headless Offloading (Pattern 22)

SCRIPT_PATH="$1"
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: Script not found at $SCRIPT_PATH"
  exit 1
fi

LOG_FILE="${SCRIPT_PATH}.log"

echo "Spawning Generalist Sponge (Background Job) for $SCRIPT_PATH..."
echo "Logging output to $LOG_FILE"

nohup python3 "$SCRIPT_PATH" > "$LOG_FILE" 2>&1 &
PID=$!
echo "✅ Job spawned with PID: $PID"
echo "The session orchestrator can now move on and remain clean."
