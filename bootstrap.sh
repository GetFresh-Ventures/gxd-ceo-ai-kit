#!/usr/bin/env bash

# GetFresh CEO Enablement Kit for AI — Bootstrap Script
# Initializes the brain directory, symlinks hooks into Claude Code, and sets up Agent-Agnostic Contexts (Cursor, Claude, Gemini)

set -e

# Quick mode: ./bootstrap.sh --quick (zero interaction, uses defaults)
QUICK_MODE=false
if [[ "${1:-}" == "--quick" || "${1:-}" == "-q" ]]; then
    QUICK_MODE=true
fi

clear
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║         CEO ENABLEMENT KIT  —  AI CHIEF OF STAFF                ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "  This installs an AI Chief of Staff that knows your voice,"
echo "  your deals, and your weekly rhythm — across Claude Code,"
echo "  Cursor, Gemini, or Copilot."
echo ""
echo "  What gets created:"
echo "  ┌─────────────────────────────────────────────────────────┐"
echo "  │  ~/ceo-brain/   Your voice model, meeting notes, prefs │"
echo "  │  ~/gtm-brain/   Pipeline data, competitive intel       │"
echo "  │  ~/.claude/      Skills, hooks, and session management  │"
echo "  └─────────────────────────────────────────────────────────┘"
echo ""
echo "  Takes about 3 minutes. Your data stays local."
echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "  STEP 1 OF 2: Who are you?"
echo ""
if ! $QUICK_MODE; then
echo "  ┌─────────────────────────────────────────────────────────────┐"
echo "  │                                                             │"
echo "  │  [1]  BEGINNER                                              │"
echo "  │       \"I'm new to AI assistants.\"                           │"
echo "  │                                                             │"
echo "  │       Perfect for you if:                                   │"
echo "  │       • You've never used Claude Code, Cursor, or Copilot   │"
echo "  │       • You want help with emails, meetings, and documents  │"
echo "  │       • You prefer simple, guided interactions              │"
echo "  │                                                             │"
echo "  │       What you get:                                         │"
echo "  │       ✓ 18 core skills (email, meetings, docs, pipeline)    │"
echo "  │       ✓ Cross-session memory (AI remembers you)             │"
echo "  │       ✓ Auto-approve safe commands (no Y/n interruptions)   │"
echo "  │       ✓ Token cost dashboard (see what you're spending)     │"
echo "  │       ✓ Auto-save memory (decisions persist automatically)  │"
echo "  │       ✓ Proactive tips and inline suggestions               │"
echo "  │       ✓ Plain-English explanations for everything           │"
echo "  │                                                             │"
echo "  ├─────────────────────────────────────────────────────────────┤"
echo "  │                                                             │"
echo "  │  [2]  INTERMEDIATE                      ★ Recommended      │"
echo "  │       \"I use AI regularly but want more structure.\"         │"
echo "  │                                                             │"
echo "  │       Perfect for you if:                                   │"
echo "  │       • You already use AI for writing and research         │"
echo "  │       • You want it plugged into your CRM and calendar      │"
echo "  │       • You want weekly reports and pipeline management     │"
echo "  │                                                             │"
echo "  │       What you get (everything in Beginner, plus):          │"
echo "  │       ✓ 46 skills (content, CRM, fundraising, advisory)     │"
echo "  │       ✓ CRM integration (HubSpot, Salesforce, Pipedrive)   │"
echo "  │       ✓ Weekly feedback loops and learning capture          │"
echo "  │       ✓ Voice model training from your actual writing       │"
echo "  │                                                             │"
echo "  ├─────────────────────────────────────────────────────────────┤"
echo "  │                                                             │"
echo "  │  [3]  ADVANCED                                              │"
echo "  │       \"I want maximum autonomy and control.\"               │"
echo "  │                                                             │"
echo "  │       Perfect for you if:                                   │"
echo "  │       • You build with AI daily and want agent workflows    │"
echo "  │       • You want background automation and multi-agent ops  │"
echo "  │       • You want full C-suite advisory and war-room tools   │"
echo "  │                                                             │"
echo "  │       What you get (everything in Intermediate, plus):      │"
echo "  │       ✓ All 72 skills (full C-suite, orchestration, infra)  │"
echo "  │       ✓ Background workers and scheduled automation         │"
echo "  │       ✓ Multi-agent orchestration and parallel dispatch     │"
echo "  │       ✓ Cross-session memory consolidation ("Dream Mode")   │"
echo "  │       ✓ Self-improving skills via autoresearch loops        │"
echo "  │                                                             │"
echo "  └─────────────────────────────────────────────────────────────┘"
echo ""
read -p "  Select your level [1, 2, or 3]: " USER_TIER
fi
USER_TIER=${USER_TIER:-2}

# Validate
if [[ ! "$USER_TIER" =~ ^[123]$ ]]; then
    echo "  Invalid selection. Defaulting to Intermediate (2)."
    USER_TIER=2
fi

TIER_NAMES=("" "Beginner" "Intermediate" "Advanced")
echo ""
echo "  ✓ ${TIER_NAMES[$USER_TIER]} selected."
echo ""

# Step 2: Questions based on tier
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "  STEP 2 OF 2: Quick setup questions"
echo ""

if $QUICK_MODE; then
    USER_NAME="CEO"
    USER_COMPANY="My Company"
    USER_CRM="none"
    USER_AGENT="claude"
    INSTALL_ENGINECLAW="n"
    echo "  ⚡ Quick mode — using defaults (name=CEO, tier=Intermediate)"
else
    # All tiers get these basics
    read -p "  What's your first name? " USER_NAME
    USER_NAME=${USER_NAME:-"CEO"}

    read -p "  What company do you run? " USER_COMPANY
    USER_COMPANY=${USER_COMPANY:-"My Company"}

    if [[ "$USER_TIER" -ge 2 ]]; then
        # Intermediate + Advanced get CRM question
        echo ""
        echo "  Which CRM do you use? (type the name, or 'none')"
        read -p "  [HubSpot / Salesforce / Pipedrive / none]: " USER_CRM
        USER_CRM=${USER_CRM:-"none"}

        echo ""
        echo "  What AI tool are you using? (for skill wiring)"
        read -p "  [claude / cursor / gemini / copilot]: " USER_AGENT
        USER_AGENT=${USER_AGENT:-"claude"}
    fi

    if [[ "$USER_TIER" -ge 3 ]]; then
        # Only advanced get automation question
        echo ""
        echo "  Do you want background automation (runs while you work)?"
        read -p "  [y/n]: " INSTALL_ENGINECLAW
        INSTALL_ENGINECLAW=${INSTALL_ENGINECLAW:-"n"}
    fi
fi

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "  Installing for ${USER_NAME} at ${USER_COMPANY}..."
echo ""

# Target directories
CEO_BRAIN_DIR="$HOME/ceo-brain"
GTM_BRAIN_DIR="$HOME/gtm-brain"
CLAUDE_DIR="$HOME/.claude"
CLAUDE_HOOKS_DIR="$CLAUDE_DIR/hooks"
CLAUDE_SKILLS_DIR="$CLAUDE_DIR/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Create brain structure
echo "  📁 Creating ~/ceo-brain and ~/gtm-brain..."
mkdir -p "$CEO_BRAIN_DIR/meetings"
mkdir -p "$CEO_BRAIN_DIR/mementos"
mkdir -p "$CEO_BRAIN_DIR/weekly"
mkdir -p "$GTM_BRAIN_DIR/campaigns"
mkdir -p "$GTM_BRAIN_DIR/pipeline"

# Record Active Tier and profile
echo "$USER_TIER" > "$CEO_BRAIN_DIR/active-tier.txt"

# Create profile for the onboard skill to read
cat > "$CEO_BRAIN_DIR/profile.json" << EOF
{
  "name": "$USER_NAME",
  "company": "$USER_COMPANY",
  "tier": $USER_TIER,
  "tier_name": "${TIER_NAMES[$USER_TIER]}",
  "crm": "${USER_CRM:-none}",
  "agent": "${USER_AGENT:-claude}",
  "installed_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "features": {
    "auto_memory": true,
    "proactive_tips": $([ "$USER_TIER" -le 2 ] && echo "true" || echo "false"),
    "feedback_loops": $([ "$USER_TIER" -ge 2 ] && echo "true" || echo "false"),
    "background_workers": $([ "$USER_TIER" -ge 3 ] && echo "true" || echo "false"),
    "dream_mode": $([ "$USER_TIER" -ge 3 ] && echo "true" || echo "false")
  }
}
EOF
echo "  → Profile saved to ~/ceo-brain/profile.json"

# Create preferences.json for hooks to read (tier-aware defaults)
LEVEL_NAMES=("" "beginner" "intermediate" "advanced")
cat > "$CEO_BRAIN_DIR/preferences.json" << EOF
{
  "level": "${LEVEL_NAMES[$USER_TIER]}",
  "cross_session_memory": true,
  "auto_approve_safe": true,
  "cost_dashboard": true,
  "auto_memory": true,
  "proactive_tips": $([ "$USER_TIER" -le 2 ] && echo "true" || echo "false"),
  "inline_insights": true,
  "plain_english": $([ "$USER_TIER" -eq 1 ] && echo "true" || echo "false"),
  "draft_review": true,
  "session_summary": $([ "$USER_TIER" -le 2 ] && echo "true" || echo "false"),
  "feedback_loops": $([ "$USER_TIER" -ge 2 ] && echo "true" || echo "false"),
  "weekly_learning_capture": $([ "$USER_TIER" -ge 2 ] && echo "true" || echo "false"),
  "voice_refinement": $([ "$USER_TIER" -ge 2 ] && echo "true" || echo "false"),
  "dream_mode": $([ "$USER_TIER" -ge 3 ] && echo "true" || echo "false"),
  "agent_spawning": $([ "$USER_TIER" -ge 3 ] && echo "true" || echo "false"),
  "self_improvement": $([ "$USER_TIER" -ge 3 ] && echo "true" || echo "false"),
  "background_scheduling": $([ "$USER_TIER" -ge 3 ] && echo "true" || echo "false")
}
EOF
echo "  → Preferences saved to ~/ceo-brain/preferences.json"

# 2. Copy ALL templates if files don't exist
echo "  📄 Setting up templates..."
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

if [ ! -f "$CEO_BRAIN_DIR/weekly/weekly-pulse.md" ]; then
    cp "$REPO_DIR/templates/weekly-pulse.md" "$CEO_BRAIN_DIR/weekly/"
    echo "  → Created weekly-pulse.md in ceo-brain/weekly"
fi

if [ ! -f "$CEO_BRAIN_DIR/meetings/meeting-brief-template.md" ]; then
    cp "$REPO_DIR/templates/meeting-brief.md" "$CEO_BRAIN_DIR/meetings/meeting-brief-template.md"
    echo "  → Created meeting-brief template in ceo-brain/meetings"  
fi

# 3. Agent-Agnostic Context Routing
echo "  🤖 Applying multi-agent configuration mapping..."
if [ -f "$REPO_DIR/AGENT.md" ]; then
    ln -sf "$REPO_DIR/AGENT.md" "$REPO_DIR/CLAUDE.md"
    echo "  → Linked AGENT.md to CLAUDE.md"
fi

cat > "$REPO_DIR/.cursorrules" << 'EOF'
# GetFresh CEO Enablement Kit
You are an Executive AI Assistant operating within the GFV Kit.

CRITICAL:
1. Access the shared executive brain at ~/ceo-brain/profile.json and ~/ceo-brain/voice-model.md for context before generating external communications.
2. For specialized tasks, reference the .agents/skills/ directory.
3. Never bypass explicit 'requires_human_approval' flags.
EOF
echo "  → Generated native .cursorrules integration"

cat > "$REPO_DIR/.windsurfrules" << 'EOF'
# GetFresh CEO Enablement Kit
You are an Executive AI Assistant operating within the GFV Kit.

CRITICAL:
1. Access the shared executive brain at ~/ceo-brain/profile.json and ~/ceo-brain/voice-model.md for context before generating external communications.
2. For specialized tasks, reference the .agents/skills/ directory.
3. Never bypass explicit 'requires_human_approval' flags.
EOF
echo "  → Generated native .windsurfrules integration"

# 4. Environment-Specific Hook & Skill Bindings
echo "  🪝 Setting up hooks and native skills..."
if command -v claude &> /dev/null || [ -d "$CLAUDE_DIR" ]; then
    mkdir -p "$CLAUDE_HOOKS_DIR"
    mkdir -p "$CLAUDE_SKILLS_DIR"
    
    # Claude Code Enhancements (ALL tiers — these are foundational)
    echo "  📦 Installing Claude Code enhancements..."
    
    # Dippy — auto-approves safe commands so beginners don't get stuck on Y/n prompts
    if command -v brew &> /dev/null; then
        brew tap ldayton/dippy 2>/dev/null || true
        brew install dippy 2>/dev/null || true
        
        # Wire Dippy into Claude settings
        SETTINGS_FILE="$CLAUDE_DIR/settings.json"
        if [ ! -f "$SETTINGS_FILE" ]; then
            echo '{}' > "$SETTINGS_FILE"
        fi
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
if not any(h.get('matcher') == 'Bash' for h in data['hooks']['PreToolUse']):
    data['hooks']['PreToolUse'].append({
        'matcher': 'Bash',
        'hooks': [{'type': 'command', 'command': 'dippy'}]
    })
    with open(path, 'w') as f:
        json.dump(data, f, indent=2)
    print('  → Dippy installed (auto-approves safe commands)')
" 2>/dev/null
    else
        echo "  ⚠️ Homebrew not found. Skipping Dippy (optional — install later with: brew install ldayton/dippy/dippy)"
    fi

    # ccflare — token cost visibility
    # claude-mem — persistent cross-session memory
    if command -v npm &> /dev/null; then
        npm i -g ccflare 2>/dev/null || true
        echo "  → ccflare installed (token cost dashboard)"
        
        echo "  🧠 Installing Claude-Mem (cross-session memory)..."
        npx claude-mem install 2>/dev/null || true
        echo "  → Claude-Mem installed (your AI remembers across sessions)"
    else
        echo "  ⚠️ NPM not found. Skipping ccflare and claude-mem."
        echo "    To install later: npm i -g ccflare && npx claude-mem install"
    fi

    # Hooks (all tiers)
    ln -sf "$REPO_DIR/hooks/pre-send-review.py" "$CLAUDE_HOOKS_DIR/pre-send-review.py"
    chmod +x "$REPO_DIR/hooks/pre-send-review.py"
    ln -sf "$REPO_DIR/hooks/session-start.py" "$CLAUDE_HOOKS_DIR/session-start.py"
    chmod +x "$REPO_DIR/hooks/session-start.py"
    ln -sf "$REPO_DIR/hooks/session-stop.py" "$CLAUDE_HOOKS_DIR/session-stop.py"
    chmod +x "$REPO_DIR/hooks/session-stop.py"
    echo "  → Hooks symlinked to ~/.claude/hooks"

    # Skills — filter by tier
    BEGINNER_SKILLS="email-composer meeting-prep post-meeting-brief deal-review pipeline-pulse weekly-ceo-brief voice-model doc-builder pdf-toolkit contract-reader onboard chief-of-staff decision-logger audio-briefing support-triage executive-mentor spreadsheet-builder google-doc-creation"
    
    INTERMEDIATE_SKILLS="content-strategy seo-growth social-engine copy-master conversion-optimizer outreach-sequence sales-enablement fundraise ceo-advisor cfo-advisor cmo-advisor coo-advisor cro-advisor competitive-intel board-deck-builder founder-coach financial-analyst scenario-war-room hubspot-architect notion-manager slack-connector news-digest negotiation-advisor doc-coauthoring change-management launch-strategy context-prime voice-synth"
    
    ADVANCED_SKILLS="social-scheduler ugc-video larry-loop ai-search-optimizer sms-outreach domain-intel geopolitical-monitor agent-orchestrator agent-protocol context-engine experiment-loop verify-execution product-spec create-skill commit-fast review-pr analyze-issue feature-architect autoresearch cron-scheduler scheduling-infra dedupe-entities gfv-hooks project-release strategic-decision automation-recommender"
    
    for skill_dir in "$REPO_DIR/skills/"*; do
        if [ -d "$skill_dir" ]; then
            skill_name=$(basename "$skill_dir")
            should_install=false
            
            if [[ "$USER_TIER" -ge 1 ]] && echo "$BEGINNER_SKILLS" | grep -qw "$skill_name"; then
                should_install=true
            fi
            if [[ "$USER_TIER" -ge 2 ]] && echo "$INTERMEDIATE_SKILLS" | grep -qw "$skill_name"; then
                should_install=true
            fi
            if [[ "$USER_TIER" -ge 3 ]] && echo "$ADVANCED_SKILLS" | grep -qw "$skill_name"; then
                should_install=true
            fi
            
            if $should_install; then
                ln -sfn "$skill_dir" "$CLAUDE_SKILLS_DIR/$skill_name"
            fi
        fi
    done
    
    INSTALLED_COUNT=$(ls -d "$CLAUDE_SKILLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')
    echo "  → Registered $INSTALLED_COUNT skills as /slash commands"
else
    echo "  ℹ️  Claude Code directory not found; skipping hooks (Cursor or alternative IDE will read AGENT.md directly)"
fi

# 5. Optional EngineClaw Integration (Advanced only)
if [[ "${INSTALL_ENGINECLAW:-n}" =~ ^[Yy]$ ]]; then
    echo ""
    echo "  🤖 Installing EngineClaw Autonomous Runtime..."
    if ! command -v pnpm &> /dev/null; then
        echo "  ℹ️  Installing pnpm..."
        npm install -g pnpm 2>/dev/null || echo "  ⚠️ Failed to install pnpm"
    fi
    
    ENGINECLAW_DIR="$HOME/engineclaw-runtime"
    if [ ! -d "$ENGINECLAW_DIR" ]; then
        git clone https://github.com/openbmb/edgeclaw.git "$ENGINECLAW_DIR" 2>/dev/null
    else
        echo "  ℹ️  EngineClaw already exists, pulling latest..."
        (cd "$ENGINECLAW_DIR" && git pull 2>/dev/null)
    fi
    
    if command -v pnpm &> /dev/null; then
        echo "  📦 Building EngineClaw..."
        (cd "$ENGINECLAW_DIR" && pnpm install && pnpm build) 2>/dev/null || echo "  ⚠️ EngineClaw build failed — run manually"
    fi
    
    ENGINECLAW_STATE="$HOME/.engineclaw"
    mkdir -p "$ENGINECLAW_STATE/workspace"
    ln -sfn "$CEO_BRAIN_DIR" "$ENGINECLAW_STATE/workspace/ceo-brain"
    ln -sfn "$GTM_BRAIN_DIR" "$ENGINECLAW_STATE/workspace/gtm-brain"
    ln -sfn "$REPO_DIR/AGENT.md" "$ENGINECLAW_STATE/workspace/AGENT.md"
    
    echo "  → EngineClaw runtime installed and linked."
fi

# 6. Final summary
echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║  ✅  INSTALLATION COMPLETE                                      ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "  Welcome, ${USER_NAME}! Your AI Chief of Staff is ready."
echo ""
echo "  Level: ${TIER_NAMES[$USER_TIER]}"
echo "  Skills: ${INSTALLED_COUNT:-72} installed"
echo "  Memory: ~/ceo-brain/ and ~/gtm-brain/ created"
echo ""
echo "  ┌──────────────────────────────────────────────────────────────┐"
echo "  │  WHAT TO DO NEXT                                            │"
echo "  │                                                              │"
echo "  │  1. Open your AI tool (Claude Code, Cursor, or Gemini)      │"
echo "  │  2. Type: /onboard                                          │"
echo "  │     (This starts a 5-minute setup wizard that teaches the   │"
echo "  │      AI your voice, your team, and your priorities)         │"
echo "  │                                                              │"
echo "  │  After onboarding, try these:                               │"
echo "  │"
if [[ "$USER_TIER" -eq 1 ]]; then
echo "  │    • \"Draft an email to [name] about [topic]\"               │"
echo "  │    • \"Prep me for my meeting with [name]\"                   │"
echo "  │    • \"Summarize this contract\" (paste/attach it)            │"
elif [[ "$USER_TIER" -eq 2 ]]; then
echo "  │    • \"What does my pipeline look like?\"                     │"
echo "  │    • \"Write my weekly CEO brief\"                            │"
echo "  │    • \"Build an outreach sequence for [prospect]\"            │"
else
echo "  │    • \"Run a morning sweep across all systems\"               │"
echo "  │    • \"Spin up a war room for [scenario]\"                    │"
echo "  │    • \"Run dream mode to consolidate my memories\"            │"
fi
echo "  │                                                              │"
echo "  │  You can re-run this installer anytime to change levels.    │"
echo "  └──────────────────────────────────────────────────────────────┘"
echo ""
