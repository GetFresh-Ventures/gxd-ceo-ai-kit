#!/usr/bin/env bash

# GFV GFV CEO Enablement Kit - AGENT.md / CLAUDE.md Linter
# Scans for formatting errors and leaked API keys.

set -e

FILE_TO_CHECK="AGENT.md"

if [ ! -f "$FILE_TO_CHECK" ]; then
    echo "❌ Linter Error: $FILE_TO_CHECK not found."
    exit 1
fi

echo "🔍 Linting $FILE_TO_CHECK..."
ERRORS=0

# 1. Check for Hardcoded Secrets
if grep -q -E "(sk-[a-zA-Z0-9]{20,}|xox[baprs]-[0-9]+-[a-zA-Z0-9]+|AIza[0-9A-Za-z-_]{35})" "$FILE_TO_CHECK"; then
    echo "❌ CRITICAL: Possible leaked API key found (OpenAI, Slack, or Google format) in $FILE_TO_CHECK!"
    ERRORS=$((ERRORS+1))
else
    echo "✅ No obvious leaked secrets detected."
fi

# 2. Check for File Extentension (Ensure no raw JSON without block)
if grep -q "{" "$FILE_TO_CHECK" && ! grep -q "\`\`\`json" "$FILE_TO_CHECK"; then
    echo "⚠️ Warning: Found JSON brackets without a markdown code block. This can confuse the Agent's parser."
fi

# 3. Check for specific GFV Directives
if ! grep -i -q "CRM" "$FILE_TO_CHECK"; then
    echo "⚠️ Warning: AGENT.md does not contain CRM directives. Are you sure this is a GFV GTM model?"
fi

if [ $ERRORS -eq 0 ]; then
    echo "🎉 $FILE_TO_CHECK passed linting."
    exit 0
else
    echo "🔥 $ERRORS errors found. Please fix them immediately."
    exit 1
fi
