#!/usr/bin/env bash

# GFV GFV CEO Enablement Kit - The Ralph Orchestration Loop
# Inspired by ralph-orchestrator. Allows unattended batch executions of an agent via CLI.

set -e

if [ -z "$1" ]; then
    echo "Usage: ./gfv-ralph.sh <prompt_string> [max_iterations]"
    echo "Example: ./gfv-ralph.sh 'Process the next 10 rows in pipeline.csv' 5"
    exit 1
fi

PROMPT="$1"
MAX_ITERATIONS=${2:-10}
ITERATION=1

PREVIOUS_OUTPUT=""
CIRCUIT_BREAKER_STRIKES=0

echo "🚂 Starting Ralph Loop for '$PROMPT'"
echo "Max Iterations: $MAX_ITERATIONS"

while [ $ITERATION -le $MAX_ITERATIONS ]; do
    echo "---"
    echo "🔄 Iteration $ITERATION / $MAX_ITERATIONS"
    
    # Check if Claude Code is installed
    if command -v claude &> /dev/null; then
        # Capture output to detect infinite loops
        TMP_FILE=$(mktemp)
        claude -p "$PROMPT" > "$TMP_FILE" 2>&1 || true
        CURRENT_OUTPUT=$(cat "$TMP_FILE")
        cat "$TMP_FILE"
        rm "$TMP_FILE"
    else
        echo "❌ Error: Claude CLI not found. Ralph Loop requires the 'claude' command line tool."
        exit 1
    fi
    
    # --------------------------------
    # CIRCUIT BREAKERS
    # --------------------------------
    # 1. Identical Output Detection
    if [ "$CURRENT_OUTPUT" == "$PREVIOUS_OUTPUT" ] && [ -n "$CURRENT_OUTPUT" ]; then
        echo "⚠️ Circuit Breaker: Agent returned exact same output as previous iteration."
        CIRCUIT_BREAKER_STRIKES=$((CIRCUIT_BREAKER_STRIKES+1))
    else
        CIRCUIT_BREAKER_STRIKES=0
    fi

    if [ $CIRCUIT_BREAKER_STRIKES -ge 2 ]; then
        echo "🛑 FATAL: Circuit Breaker triggered. Agent is stuck in an infinite loop. Exiting."
        exit 1
    fi

    PREVIOUS_OUTPUT="$CURRENT_OUTPUT"

    # 2. DONE.flag detection
    if [ -f "DONE.flag" ]; then
        echo "🏁 DONE.flag found! Agent signaled task completion."
        rm DONE.flag
        break
    fi

    ITERATION=$((ITERATION+1))
    
    echo "💤 Sleeping for 5s to avoid rate limits..."
    sleep 5
done

if [ $ITERATION -gt $MAX_ITERATIONS ]; then
    echo "⚠️ Ralph Loop reached max iterations ($MAX_ITERATIONS) without completing."
else
    echo "🎉 Ralph Loop Complete."
fi
