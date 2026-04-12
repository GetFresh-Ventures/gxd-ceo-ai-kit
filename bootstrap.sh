#!/usr/bin/env bash

# GetFresh CEO Enablement Kit for AI — Bootstrap Script
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
echo " 1. The Dual-Brain System (~/ceo-brain/ and ~/gtm-brain/): Local, offline"
echo "    directories protecting your personal voice profile and company pipeline"
echo "    from public AI clouds."
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
echo "  E N G I N E C L A W   A U T O N O M O U S   R U N T I M E  (O P T I O N A L)"
echo "======================================================================="
echo ""
echo "You can choose to install EngineClaw, a high-autonomy agentic runtime."
echo "This replaces standard interactive sessions with an unattended, persistent worker."
echo ""
echo "WHAT IT ENABLES:"
echo " 1. Self-Driven Loops: Background execution, sub-agents, and cron jobs."
echo " 2. Cost-Aware Routing: LLM-as-Judge redirects simple prompts to cheaper models."
echo " 3. Deep Memory Engine: Claude Code-like persistent memory architecture."
echo " 4. Tool Governance: Advanced security sandboxing for autonomous execution."
echo ""
echo "WHAT IT TURNS THE AGENT EXPERIENCE INTO:"
echo " Instead of turn-by-turn chat, you give EngineClaw an objective ('reconcile"
echo " HubSpot data every 4 hours') and it loops until finished. It works"
echo " autonomously in the background while you focus on high-leverage tasks."
echo ""
echo "WHAT IT INSTALLS:"
echo " - Clones OpenBMB/EdgeClaw (EngineClaw internals) to ~/engineclaw-runtime"
echo " - Installs Node JS dependencies via pnpm"
echo " - Configures EngineClaw memory to map directly into your ~/ceo-brain and ~/gtm-brain"
echo ""
echo "Always-On Requirement: EngineClaw needs a running background daemon (gateway run)."
echo "======================================================================="
read -p "Install EngineClaw Autonomous Agent Runtime? [y/N] " INSTALL_ENGINECLAW
INSTALL_ENGINECLAW=${INSTALL_ENGINECLAW:-n}
echo ""
echo "======================================================================="
read -p "Press [Enter] to authorize installation and enable the Executive Kit..."
echo ""


echo "🚀 Initializing GetFresh CEO Enablement Kit for AI kit..."

# Target directories
CEO_BRAIN_DIR="$HOME/ceo-brain"
GTM_BRAIN_DIR="$HOME/gtm-brain"
CLAUDE_DIR="$HOME/.claude"
CLAUDE_HOOKS_DIR="$CLAUDE_DIR/hooks"
CLAUDE_SKILLS_DIR="$CLAUDE_DIR/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Create brain structure
echo "📁 Creating ~/ceo-brain and ~/gtm-brain structures..."
mkdir -p "$CEO_BRAIN_DIR/meetings"
mkdir -p "$CEO_BRAIN_DIR/mementos"
mkdir -p "$CEO_BRAIN_DIR/weekly"
mkdir -p "$GTM_BRAIN_DIR/campaigns"
mkdir -p "$GTM_BRAIN_DIR/pipeline"

# 2. Copy templates if files don't exist
echo "📄 Setting up templates..."
if [ ! -f "$CEO_BRAIN_DIR/voice-model.md" ]; then
    cp "$REPO_DIR/templates/voice-model.md" "$CEO_BRAIN_DIR/"
    echo "  → Created voice-model.md in ceo-brain"
fi

if [ ! -f "$GTM_BRAIN_DIR/pipeline.md" ]; then
    cp "$REPO_DIR/templates/pipeline-report.md" "$GTM_BRAIN_DIR/pipeline.md"
    echo "  → Created pipeline.md in gtm-brain"
fi

if [ ! -f "$GTM_BRAIN_DIR/learnings.md" ]; then
    echo "# Ongoing Learnings Log" > "$GTM_BRAIN_DIR/learnings.md"
    echo "This file captures tactical marketing/sales feedback over time." >> "$GTM_BRAIN_DIR/learnings.md"
    echo "  → Created learnings.md in gtm-brain"
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

# 5. Optional EngineClaw Integration
if [[ "$INSTALL_ENGINECLAW" =~ ^[Yy]$ ]]; then
    echo ""
    echo "🤖 Installing EngineClaw Autonomous Runtime..."
    if ! command -v pnpm &> /dev/null; then
        echo "  ℹ️  Installing pnpm..."
        npm install -g pnpm || echo "  ⚠️ Failed to install pnpm! Please install it manually."
    fi
    
    ENGINECLAW_DIR="$HOME/engineclaw-runtime"
    if [ ! -d "$ENGINECLAW_DIR" ]; then
        git clone https://github.com/openbmb/edgeclaw.git "$ENGINECLAW_DIR"
    else
        echo "  ℹ️  EngineClaw already exists at $ENGINECLAW_DIR, pulling latest..."
        (cd "$ENGINECLAW_DIR" && git pull)
    fi
    
    if command -v pnpm &> /dev/null; then
        echo "  📦 Building EngineClaw (this may take a minute)..."
        (cd "$ENGINECLAW_DIR" && pnpm install && pnpm build) || echo "  ⚠️ Warning: EngineClaw build failed. You may need to run 'pnpm install && pnpm build' inside $ENGINECLAW_DIR manually."
    else
        echo "  ⚠️ pnpm is still missing. Skipping EngineClaw build step."
    fi
    
    # Map EngineClaw data into dual-brain to ensure single source of truth
    ENGINECLAW_STATE="$HOME/.engineclaw"
    mkdir -p "$ENGINECLAW_STATE/workspace"
    ln -sfn "$CEO_BRAIN_DIR" "$ENGINECLAW_STATE/workspace/ceo-brain"
    ln -sfn "$GTM_BRAIN_DIR" "$ENGINECLAW_STATE/workspace/gtm-brain"
    
    # 🔗 Ensure EngineClaw inherits the Meta-Agentic constraints
    ln -sfn "$REPO_DIR/AGENT.md" "$ENGINECLAW_STATE/workspace/AGENT.md"
    ln -sfn "$REPO_DIR/SKILL-AUTHORING-STANDARD.md" "$ENGINECLAW_STATE/workspace/SKILL-AUTHORING-STANDARD.md"
    
    echo "  → EngineClaw runtime installed."
    echo "  → EngineClaw workspace linked to Dual-Brain architecture (~/ceo-brain and ~/gtm-brain)."
    echo "  → To start the EngineClaw daemon later, run: cd $ENGINECLAW_DIR && node openclaw.mjs gateway run"
fi

# 5. Final Instructions
echo ""
echo "🎉 GetFresh CEO Enablement Kit for AI Bootstrap Complete!"
echo "----------------------------------------"
echo "Next Steps:"
echo "1. Open your terminal and type 'claude' (or open Cursor/Gemini)."
echo "2. Say 'Hello'. The AI will automatically detect your fresh"
echo "   system state and guide you through the executive setup."
if [[ "$INSTALL_ENGINECLAW" =~ ^[Yy]$ ]]; then
echo "3. Try running your EngineClaw autonomous background worker:"
echo "   cd ~/engineclaw-runtime && node openclaw.mjs gateway run"
fi
echo "   (No configuration files or prompts to copy/paste required.)"
echo ""
