#!/usr/bin/env bash

# Growth by Design — Bootstrap Script
# Initializes the brain directory, symlinks hooks into Claude Code, and sets up Agent-Agnostic Contexts (Cursor, Claude, Gemini)

set -e

echo "🚀 Initializing Growth by Design kit..."

# Target directories
BRAIN_DIR="$HOME/brain"
CLAUDE_DIR="$HOME/.claude"
CLAUDE_HOOKS_DIR="$CLAUDE_DIR/hooks"
CLAUDE_SKILLS_DIR="$CLAUDE_DIR/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Create brain structure
echo "📁 Creating ~/brain structure..."
mkdir -p "$BRAIN_DIR/meetings"
mkdir -p "$BRAIN_DIR/campaigns"
mkdir -p "$BRAIN_DIR/weekly"

# 2. Copy templates if files don't exist
echo "📄 Setting up templates..."
if [ ! -f "$BRAIN_DIR/voice-model.md" ]; then
    cp "$REPO_DIR/templates/voice-model.md" "$BRAIN_DIR/"
    echo "  → Created voice-model.md"
fi

if [ ! -f "$BRAIN_DIR/pipeline.md" ]; then
    cp "$REPO_DIR/templates/pipeline-report.md" "$BRAIN_DIR/pipeline.md"
    echo "  → Created pipeline.md"
fi

if [ ! -f "$BRAIN_DIR/learnings.md" ]; then
    echo "# Ongoing Learnings Log" > "$BRAIN_DIR/learnings.md"
    echo "This file captures tactical marketing/sales feedback over time." >> "$BRAIN_DIR/learnings.md"
    echo "  → Created learnings.md"
fi

# 3. Agent-Agnostic Context Routing
echo "🤖 Applying multi-agent configuration mapping..."
if [ -f "$REPO_DIR/AGENT.md" ]; then
    # Cursor
    ln -sf "$REPO_DIR/AGENT.md" "$REPO_DIR/.cursorrules"
    echo "  → Linked AGENT.md to .cursorrules"
    # Claude Code
    ln -sf "$REPO_DIR/AGENT.md" "$REPO_DIR/CLAUDE.md"
    echo "  → Linked AGENT.md to CLAUDE.md"
fi

# 4. Environment-Specific Hook & Skill Bindings
echo "🪝 Setting up Claude Code specific hooks and native skills..."
if command -v claude &> /dev/null || [ -d "$CLAUDE_DIR" ]; then
    mkdir -p "$CLAUDE_HOOKS_DIR"
    mkdir -p "$CLAUDE_SKILLS_DIR"
    
    # Pre-send review hook
    ln -sf "$REPO_DIR/hooks/pre-send-review.py" "$CLAUDE_HOOKS_DIR/pre-send-review.py"
    chmod +x "$REPO_DIR/hooks/pre-send-review.py"

    # Session start hook
    ln -sf "$REPO_DIR/hooks/session-start.py" "$CLAUDE_HOOKS_DIR/session-start.py"
    chmod +x "$REPO_DIR/hooks/session-start.py"

    # Session stop hook
    ln -sf "$REPO_DIR/hooks/session-stop.py" "$CLAUDE_HOOKS_DIR/session-stop.py"
    chmod +x "$REPO_DIR/hooks/session-stop.py"
    
    echo "  → Hooks successfully symlinked to ~/.claude/hooks"

    # Map native skills
    for skill_dir in "$REPO_DIR/skills/"*; do
        if [ -d "$skill_dir" ]; then
            skill_name=$(basename "$skill_dir")
            ln -sfn "$skill_dir" "$CLAUDE_SKILLS_DIR/$skill_name"
            echo "  → Registered native slash command: /$skill_name"
        fi
    done
else
    echo "  ℹ️  Claude Code directory not found locally; skipping native ~/.claude hooks mapping (Cursor or alternative IDE will read scripts manually according to AGENT.md)"
fi

# 5. Final Instructions
echo ""
echo "🎉 Growth by Design Bootstrap Complete!"
echo "----------------------------------------"
echo "Next Steps:"
echo "1. Type 'cat ONBOARDING_PROMPT.md' and paste its contents into your primary Agent session (Cursor, Claude Code, or Gemini) to bootstrap it."
echo "2. Open $HOME/brain/voice-model.md and fill out your specific writing patterns."
echo "3. Try asking your agent to review your active deals using the skills provided."
echo ""
