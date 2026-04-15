#!/usr/bin/env bash
set -e
#
# gfv-audit.sh
# Extract and format bash command history generated directly by the AI (Claude Code).
# Allows the CEO to audit exactly what the agent ran on their local machine.
#

# Discover the Claude project log directory dynamically
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ESCAPED_CWD=$(echo "$REPO_DIR" | sed 's|/|-|g')
PROJECT_LOGS_DIR="$HOME/.claude/projects/$ESCAPED_CWD"

if [ ! -d "$PROJECT_LOGS_DIR" ]; then
    echo "No log directory found at $PROJECT_LOGS_DIR"
    exit 1
fi

echo "🔍 Scanning recent Claude Code JSONL transcripts for execution history..."
echo ""

# Find the 5 most recent jsonl files and parse for Bash
find "$PROJECT_LOGS_DIR" -type f -name "*.jsonl" -depth 1 -print0 | xargs -0 ls -1t | head -n 5 | while read logfile; do
    echo "--- Session Log: $(basename "$logfile") ---"
    jq -r 'select(.type == "assistant" and .message != null) | .timestamp as $ts | .message.content[]? | select(.type == "tool_use" and .name == "Bash") | "[\($ts)] \n$ \(.input.command)\n"' "$logfile" 2>/dev/null
    echo ""
done
