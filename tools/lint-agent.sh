#!/usr/bin/env bash
set -e
# lint-agent.sh
# Validates the AGENT.md file structure to prevent silent failures in Claude agent instructions.
# Captures common issues:
# - Missing Global Rules XML tags
# - Duplicate headers 
# - Broken Markdown list formatting

AGENT_FILE="$1"

if [ -z "$AGENT_FILE" ]; then
    echo "Usage: $0 /path/to/AGENT.md"
    exit 1
fi

if [ ! -f "$AGENT_FILE" ]; then
    echo "ERROR: File $AGENT_FILE not found."
    exit 1
fi

ERRORS=0

echo "🔍 Linting $AGENT_FILE..."

# Check for XML global rule wrapper
if ! grep -q "^<RULE\[[a-zA-Z0-9_]*\]>" "$AGENT_FILE"; then
    echo "❌ ERROR: Missing starting <RULE[namespace]> tag."
    ERRORS=$((ERRORS+1))
fi

if ! grep -q "^</RULE\[[a-zA-Z0-9_]*\]>" "$AGENT_FILE"; then
    echo "❌ ERROR: Missing ending </RULE[namespace]> tag."
    ERRORS=$((ERRORS+1))
fi

# Check for Duplicate H2 Headers
DUPLICATES=$(grep "^## " "$AGENT_FILE" | sort | uniq -d)
if [ -n "$DUPLICATES" ]; then
    echo "❌ ERROR: Duplicate headers found, which confuse Claude's AST parser:"
    echo "$DUPLICATES"
    ERRORS=$((ERRORS+1))
fi

# Check for large uninterrupted blocks (Claude prefers lists)
LONG_BLOCKS=$(awk '/^[^#-]/ { count++ } /^[-# \n]/ { if (count > 15) {print NR ":" count " lines of raw text"}; count=0 } END { if (count > 15) {print NR ":" count " lines of raw text"} }' "$AGENT_FILE")

if [ -n "$LONG_BLOCKS" ]; then
    echo "⚠️ WARNING: You have dense blocks of text >15 lines without formatting. Agents struggle with walls of text. Break them into bullet points."
fi

if [ $ERRORS -gt 0 ]; then
    echo "💥 Linting failed with $ERRORS error(s)."
    exit 1
else
    echo "✅ Validation passed. AGENT.md is clean and ready for execution."
    exit 0
fi
