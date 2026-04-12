#!/usr/bin/env bash

# Growth by Design — Bootstrap Script
# Initializes the brain directory, symlinks hooks into Claude Code, and sets up Agent-Agnostic Contexts (Cursor, Claude, Gemini)

set -e

clear
echo "======================================================================="
echo "  G R O W T H   B Y   D E S I G N   ——   C E O   I N S T A L L E R"
echo "======================================================================="
echo ""
echo "Welcome. This installer transforms your local AI coding assistant (Cursor,"
echo "Claude Code, or Gemini) from a blank slate into a personalized, always-on"
echo "Chief of Staff."
echo ""
echo "WHAT THIS INSTALLS AND ENABLES:"
echo " 1. The GFV Brain (~/brain/): A local, offline directory protecting your"
echo "    active deals, voice profile, and pipeline from public AI clouds."
echo " 2. The 49-Skill Framework: Injects native agent capabilities to rapidly"
echo "    draft emails, prep for meetings, synthesize CRM data, and audit pipelines."
echo " 3. The Proactive Intelligence Layer (PIL) Daemon: An always-on background"
echo "    process that silently syncs Linear, HubSpot, and WhatsApp into your"
echo "    local offline semantic ontology."
echo " 4. Agent Tooling: Homebrew packages (dippy), NPM registries (ccflare),"
echo "    and local memory vectors to prevent massive context-window amnesia."
echo ""
echo "THE RESULT:"
echo " Upon completion, you will rarely have to provide background context again."
echo " Your AI inherently knows your organization, proactively extracts signals,"
echo " governs your architecture mathematically, and speaks in your voice."
echo ""
echo "CRITICAL INFRASTRUCTURE REQUIREMENT:"
echo " For the PIL to run autonomously and sweep CRM data while you sleep, your"
echo " machine must remain powered on and connected to the internet (or you must"
echo " host this kit on an always-on VM/server)."
echo ""
echo "======================================================================="
read -p "Press [Enter] to authorize installation and enable the Executive Kit..."
echo ""

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
    
    # Advanced Tooling (Dippy & ccflare)
    echo "📦 Installing Advanced Claude Tools (Dippy & ccflare)..."
    if command -v brew &> /dev/null; then
        brew tap ldayton/dippy || true
        brew install dippy || true
        
        # Wire up Dippy in settings.json safely
        if [ -f "$CLAUDE_DIR/settings.json" ]; then
            python3 -c "
import json, os
path = os.path.expanduser('~/.claude/settings.json')
try:
    with open(path, 'r') as f:
        data = json.load(f)
except Exception:
    data = {}
if 'hooks' not in data: data['hooks'] = {}
if 'PreToolUse' not in data['hooks']: data['hooks']['PreToolUse'] = []
# Avoid duplicates
if not any(h.get('matcher') == 'Bash' for h in data['hooks']['PreToolUse']):
    data['hooks']['PreToolUse'].append({
        'matcher': 'Bash',
        'hooks': [{'type': 'command', 'command': 'dippy'}]
    })
    with open(path, 'w') as f:
        json.dump(data, f, indent=2)
    print('  → Dippy hook wired into ~/.claude/settings.json')
"
        fi
    else
        echo "  ⚠️ Homebrew not found. Skipping Dippy installation."
    fi

    if command -v npm &> /dev/null; then
        npm i -g ccflare || true
        echo "  → ccflare installed globally."
        echo "  🧠 Installing Claude-Mem (Persistent Vector Memory)..."
        npx claude-mem install || true
        echo "  → Claude-Mem installed system-wide."
    else
        echo "  ⚠️ NPM not found. Skipping ccflare and claude-mem installation."
    fi

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
echo "1. Open your terminal and type 'claude' (or open Cursor/Gemini)."
echo "2. Say 'Hello'. The AI will automatically detect your fresh"
echo "   system state and guide you through the executive setup."
echo "   (No configuration files or prompts to copy/paste required.)"
echo ""
