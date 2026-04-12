<#
.SYNOPSIS
GetFresh CEO Enablement Kit for AI — Windows Bootstrap Script
Initializes the brain directory, symlinks hooks into Claude Code, and sets up Agent-Agnostic Contexts (Cursor, Claude, Gemini) for Windows users.
#>
$ErrorActionPreference = "Stop"

Clear-Host
Write-Host "=======================================================================" -ForegroundColor Cyan
Write-Host "  G R O W T H   B Y   D E S I G N   ——   C E O   I N S T A L L E R" -ForegroundColor Cyan
Write-Host "=======================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Welcome. This installer transforms your local AI coding assistant (Cursor,"
Write-Host "Claude Code, or Gemini) from a blank slate into a personalized, always-on"
Write-Host "Chief of Staff."
Write-Host ""
Write-Host "WHAT THIS INSTALLS AND ENABLES:"
Write-Host " 1. The Dual-Brain System (~\ceo-brain\ and ~\gtm-brain\): Local, offline"
Write-Host "    directories protecting your personal voice profile and company pipeline."
Write-Host " 2. The 49-Skill Framework: Injects native agent capabilities to rapidly"
Write-Host "    draft emails, prep for meetings, synthesize CRM data."
Write-Host " 3. The Proactive Intelligence Layer (PIL) Daemon: An always-on background"
Write-Host "    process that silently syncs Linear, HubSpot, and WhatsApp."
Write-Host " 4. Agent Tooling: NPM registries (ccflare) and local memory vectors."
Write-Host ""
Write-Host "CRITICAL INFRASTRUCTURE REQUIREMENT:"
Write-Host " For the PIL to run autonomously and sweep CRM data while you sleep, your"
Write-Host " machine must remain powered on and connected to the internet."
Write-Host ""
Write-Host "=======================================================================" -ForegroundColor Cyan
Write-Host "  E N G I N E C L A W   A U T O N O M O U S   R U N T I M E  (O P T I O N A L)" -ForegroundColor Cyan
Write-Host "=======================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "You can choose to install EngineClaw, a high-autonomy agentic runtime."
Write-Host "This replaces standard interactive sessions with an unattended, persistent worker."
Write-Host ""

$installEngineClaw = Read-Host "Install EngineClaw Autonomous Agent Runtime? [y/N]"
if ([string]::IsNullOrWhiteSpace($installEngineClaw)) { $installEngineClaw = "n" }

Write-Host ""
Write-Host "=======================================================================" -ForegroundColor Cyan
Read-Host "Press [Enter] to authorize installation and enable the Executive Kit..."
Write-Host ""

Write-Host "🚀 Initializing GetFresh CEO Enablement Kit for AI kit..." -ForegroundColor Green

$CEO_BRAIN_DIR = Join-Path $HOME "ceo-brain"
$GTM_BRAIN_DIR = Join-Path $HOME "gtm-brain"
$CLAUDE_DIR = Join-Path $HOME ".claude"
$CLAUDE_HOOKS_DIR = Join-Path $CLAUDE_DIR "hooks"
$CLAUDE_SKILLS_DIR = Join-Path $CLAUDE_DIR "skills"
$REPO_DIR = $PSScriptRoot

# 1. Create brain structure
Write-Host "📁 Creating ~\ceo-brain and ~\gtm-brain structures..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path (Join-Path $CEO_BRAIN_DIR "meetings") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $CEO_BRAIN_DIR "mementos") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $CEO_BRAIN_DIR "weekly") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $GTM_BRAIN_DIR "campaigns") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $GTM_BRAIN_DIR "pipeline") | Out-Null

# 2. Copy templates
Write-Host "📄 Setting up templates..." -ForegroundColor Green
if (!(Test-Path (Join-Path $CEO_BRAIN_DIR "voice-model.md"))) {
    Copy-Item -Path (Join-Path $REPO_DIR "templates\voice-model.md") -Destination $CEO_BRAIN_DIR
    Write-Host "  → Created voice-model.md in ceo-brain"
}

if (!(Test-Path (Join-Path $GTM_BRAIN_DIR "pipeline.md"))) {
    Copy-Item -Path (Join-Path $REPO_DIR "templates\pipeline-report.md") -Destination (Join-Path $GTM_BRAIN_DIR "pipeline.md")
    Write-Host "  → Created pipeline.md in gtm-brain"
}

if (!(Test-Path (Join-Path $GTM_BRAIN_DIR "learnings.md"))) {
    $learningsContent = "# Ongoing Learnings Log`nThis file captures tactical marketing/sales feedback over time."
    Set-Content -Path (Join-Path $GTM_BRAIN_DIR "learnings.md") -Value $learningsContent
    Write-Host "  → Created learnings.md in gtm-brain"
}

# 3. Agent-Agnostic Context Routing
Write-Host "🤖 Applying multi-agent configuration mapping..." -ForegroundColor Green
if (Test-Path (Join-Path $REPO_DIR "AGENT.md")) {
    # Using Copy-Item instead of HardLink to avoid drive boundary issues or permission errors on some Windows setups
    Copy-Item -Path (Join-Path $REPO_DIR "AGENT.md") -Destination (Join-Path $REPO_DIR ".cursorrules") -Force
    Write-Host "  → Copied AGENT.md to .cursorrules"
    Copy-Item -Path (Join-Path $REPO_DIR "AGENT.md") -Destination (Join-Path $REPO_DIR "CLAUDE.md") -Force
    Write-Host "  → Copied AGENT.md to CLAUDE.md"
}

# 4. Environment-Specific Hook & Skill Bindings
Write-Host "🪝 Setting up Claude Code specific hooks and native skills..." -ForegroundColor Green
if ((Get-Command "claude" -ErrorAction SilentlyContinue) -or (Test-Path $CLAUDE_DIR)) {
    New-Item -ItemType Directory -Force -Path $CLAUDE_HOOKS_DIR | Out-Null
    New-Item -ItemType Directory -Force -Path $CLAUDE_SKILLS_DIR | Out-Null
    
    if (Get-Command "npm" -ErrorAction SilentlyContinue) {
        Write-Host "📦 Installing Advanced Claude Tools (ccflare)..."
        npm i -g ccflare
        Write-Host "  → ccflare installed globally."
        Write-Host "  🧠 Installing Claude-Mem (Persistent Vector Memory)..."
        npx claude-mem install
        Write-Host "  → Claude-Mem installed system-wide."
    } else {
        Write-Host "  ⚠️ NPM not found. Skipping ccflare and claude-mem installation." -ForegroundColor Yellow
    }

    # Hooks setup
    Copy-Item -Path (Join-Path $REPO_DIR "hooks\pre-send-review.py") -Destination (Join-Path $CLAUDE_HOOKS_DIR "pre-send-review.py") -Force
    Copy-Item -Path (Join-Path $REPO_DIR "hooks\session-start.py") -Destination (Join-Path $CLAUDE_HOOKS_DIR "session-start.py") -Force
    Copy-Item -Path (Join-Path $REPO_DIR "hooks\session-stop.py") -Destination (Join-Path $CLAUDE_HOOKS_DIR "session-stop.py") -Force
    Write-Host "  → Hooks successfully copied to ~\.claude\hooks"

    # Map native skills (using Junctions for directories, works without Admin)
    $skillsDir = Join-Path $REPO_DIR "skills"
    if (Test-Path $skillsDir) {
        Get-ChildItem -Path $skillsDir -Directory | ForEach-Object {
            $skillName = $_.Name
            $targetDir = Join-Path $CLAUDE_SKILLS_DIR $skillName
            if (Test-Path $targetDir) { Remove-Item -Path $targetDir -Force -Recurse -ErrorAction SilentlyContinue }
            New-Item -ItemType Junction -Path $targetDir -Value $_.FullName | Out-Null
            Write-Host "  → Registered native slash command: /$skillName"
        }
    }
} else {
    Write-Host "  ℹ️  Claude Code directory not found locally; skipping native ~\.claude hooks mapping." -ForegroundColor Gray
}

# 5. Optional EngineClaw Integration
if ($installEngineClaw -match "^[Yy]$") {
    Write-Host ""
    Write-Host "🤖 Installing EngineClaw Autonomous Runtime..." -ForegroundColor Green
    if (!(Get-Command "pnpm" -ErrorAction SilentlyContinue)) {
        Write-Host "  ℹ️  Installing pnpm..."
        npm install -g pnpm
    }
    
    $ENGINECLAW_DIR = Join-Path $HOME "engineclaw-runtime"
    if (!(Test-Path $ENGINECLAW_DIR)) {
        git clone https://github.com/openbmb/edgeclaw.git $ENGINECLAW_DIR
    } else {
        Write-Host "  ℹ️  EngineClaw already exists, pulling latest..."
        Set-Location $ENGINECLAW_DIR
        git pull
    }
    
    if (Get-Command "pnpm" -ErrorAction SilentlyContinue) {
        Write-Host "  📦 Building EngineClaw (this may take a minute)..." -ForegroundColor Green
        Set-Location $ENGINECLAW_DIR
        try {
            pnpm install
            pnpm build
        } catch {
            Write-Host "  ⚠️ Warning: EngineClaw build failed. You may need to run 'pnpm build' manually." -ForegroundColor Yellow
        }
    } else {
        Write-Host "  ⚠️ pnpm is still missing. Skipping EngineClaw build step." -ForegroundColor Yellow
    }
    
    # Map EngineClaw data into dual-brain to ensure single source of truth
    $ENGINECLAW_STATE = Join-Path $HOME ".engineclaw"
    $WORKSPACE_DIR = Join-Path $ENGINECLAW_STATE "workspace"
    New-Item -ItemType Directory -Force -Path $WORKSPACE_DIR | Out-Null
    
    # Using Junctions for cross-directory connections
    $ceoJunction = Join-Path $WORKSPACE_DIR "ceo-brain"
    $gtmJunction = Join-Path $WORKSPACE_DIR "gtm-brain"
    if (Test-Path $ceoJunction) { Remove-Item $ceoJunction -Force -ErrorAction SilentlyContinue }
    if (Test-Path $gtmJunction) { Remove-Item $gtmJunction -Force -ErrorAction SilentlyContinue }
    New-Item -ItemType Junction -Path $ceoJunction -Value $CEO_BRAIN_DIR | Out-Null
    New-Item -ItemType Junction -Path $gtmJunction -Value $GTM_BRAIN_DIR | Out-Null
    
    # Explicit rules copy
    Copy-Item -Path (Join-Path $REPO_DIR "AGENT.md") -Destination (Join-Path $WORKSPACE_DIR "AGENT.md") -Force
    Copy-Item -Path (Join-Path $REPO_DIR "SKILL-AUTHORING-STANDARD.md") -Destination (Join-Path $WORKSPACE_DIR "SKILL-AUTHORING-STANDARD.md") -Force
    
    Write-Host "  → EngineClaw runtime installed."
    Write-Host "  → EngineClaw workspace linked to Dual-Brain architecture (~\ceo-brain and ~\gtm-brain)."
    Write-Host "  → To start the EngineClaw daemon later, run: cd $ENGINECLAW_DIR ; node openclaw.mjs gateway run"
}

# Restore location in case we moved
Set-Location $PSScriptRoot

Write-Host ""
Write-Host "🎉 GetFresh CEO Enablement Kit for AI Bootstrap Complete!" -ForegroundColor Green
Write-Host "----------------------------------------"
Write-Host "Next Steps:"
Write-Host "1. Open your terminal and type 'claude' (or open Cursor/Gemini)."
Write-Host "2. Say 'Hello'. The AI will automatically detect your fresh"
Write-Host "   system state and guide you through the executive setup."
if ($installEngineClaw -match "^[Yy]$") {
Write-Host "3. Try running your EngineClaw autonomous background worker:"
Write-Host "   cd ~\engineclaw-runtime ; node openclaw.mjs gateway run"
}
Write-Host "   (No configuration files or prompts to copy/paste required.)"
Write-Host ""
