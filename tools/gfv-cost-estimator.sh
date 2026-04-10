#!/usr/bin/env bash

# GFV Cost Estimator
# Usage: ./gfv-cost-estimator.sh <file_or_directory>
# Helps CEOs estimate the token payload cost of analyzing CRM exports or codebase directories

if [ -z "$1" ]; then
    echo "Usage: ./gfv-cost-estimator.sh <file_or_directory>"
    exit 1
fi

TARGET="$1"

# Standard rule of thumb: 1 token ≈ 4 chars in English text
# Claude 3.5 Sonnet / Opus / Gemini 1.5 Pro input cost rough estimation: ~$3.00 per 1M tokens

if [ -d "$TARGET" ]; then
    echo "Scanning directory: $TARGET"
    CHARS=$(find "$TARGET" -type f -not -path "*/\.*" -exec cat {} + | wc -m | tr -d ' ')
elif [ -f "$TARGET" ]; then
    echo "Scanning file: $TARGET"
    CHARS=$(wc -m < "$TARGET" | tr -d ' ')
else
    echo "Error: $TARGET is not a valid file or directory"
    exit 1
fi

TOKENS=$((CHARS / 4))
COST_ESTIMATE=$(echo "scale=4; ($TOKENS / 1000000) * 3.0" | bc)

echo "------------------------------------------------"
echo "📊 Token Estimate: ~$TOKENS tokens"
echo "💰 Estimated Cost: ~$COST_ESTIMATE USD (assuming $3/1M input pricing)"
echo "------------------------------------------------"
echo "If this cost is high (> $1.00), consider pre-filtering your CRM data using Python scripts before passing to the Agent."
