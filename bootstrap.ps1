<#
.SYNOPSIS
GetFresh CEO Enablement Kit for AI — Windows Bootstrap Script (v1.23.0)
Initializes the brain directory, configures tier-appropriate skills, installs
hooks, and sets up Agent-Agnostic Contexts (Cursor, Claude, Gemini) for Windows.
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
Write-Host " 2. Tier-Appropriate Skills: From 14 beginner essentials to 72 advanced"
Write-Host "    capabilities — matched to your comfort level with AI."
Write-Host " 3. Session Hooks: Auto-loading context at session start, auto-saving"
Write-Host "    learnings at session end."
Write-Host " 4. Agent Tooling: Memory persistence and proactive intelligence."
Write-Host ""
Write-Host "=======================================================================" -ForegroundColor Cyan
Write-Host "  E X P E R T I S E   C A L I B R A T I O N" -ForegroundColor Cyan
Write-Host "=======================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To configure your system perfectly, please select your AI expertise level:"
Write-Host ""
Write-Host " [1] Beginner — I'm new to AI coding assistants" -ForegroundColor Green
Write-Host "     14 core skills: email, meetings, documents, contracts, pipeline."
Write-Host "     Proactive tips enabled. Auto-save learnings. Guided experience."
Write-Host "     Memory always on (so your AI remembers you between sessions)."
Write-Host ""
Write-Host " [2] Intermediate — I use AI tools regularly" -ForegroundColor Yellow
Write-Host "     40+ skills: + SEO, content strategy, sales enablement, C-suite advisory."
Write-Host "     Feedback checkpoints. Cross-skill chains. CRM integrations."
Write-Host ""
Write-Host " [3] Advanced — I build with AI daily" -ForegroundColor Red
Write-Host "     72 skills: + agent orchestration, cron scheduling, experiment loops."
Write-Host "     Full autonomy. Dream mode. EngineClaw background runtime."
Write-Host ""
Write-Host "NOTE: You can re-run this script anytime to change your tier."
Write-Host "=======================================================================" -ForegroundColor Cyan
$userTier = Read-Host "Select Tier [1, 2, or 3]"
if ([string]::IsNullOrWhiteSpace($userTier)) { $userTier = "1" }

$tierNames = @{ "1" = "beginner"; "2" = "intermediate"; "3" = "advanced" }
$tierName = $tierNames[$userTier]
if (-not $tierName) { $tierName = "beginner"; $userTier = "1" }

if ($userTier -eq "3") {
    $installEngineClaw = "y"
} else {
    $installEngineClaw = "n"
}

Write-Host ""
Write-Host "=======================================================================" -ForegroundColor Cyan
Read-Host "Press [Enter] to authorize installation and enable the Executive Kit..."
Write-Host ""

Write-Host "🚀 Initializing GetFresh CEO Enablement Kit for AI..." -ForegroundColor Green

$CEO_BRAIN_DIR = Join-Path $HOME "ceo-brain"
$GTM_BRAIN_DIR = Join-Path $HOME "gtm-brain"
$CLAUDE_DIR = Join-Path $HOME ".claude"
$CLAUDE_HOOKS_DIR = Join-Path $CLAUDE_DIR "hooks"
$CLAUDE_SKILLS_DIR = Join-Path $CLAUDE_DIR "skills"
$REPO_DIR = $PSScriptRoot

# ─────────────────────────────────────────────────────────
# 1. Create brain structure
# ─────────────────────────────────────────────────────────
Write-Host "📁 Creating ~\ceo-brain and ~\gtm-brain structures..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path (Join-Path $CEO_BRAIN_DIR "meetings") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $CEO_BRAIN_DIR "mementos") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $CEO_BRAIN_DIR "weekly") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $GTM_BRAIN_DIR "campaigns") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $GTM_BRAIN_DIR "pipeline") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $GTM_BRAIN_DIR "logs") | Out-Null

# ─────────────────────────────────────────────────────────
# 2. Profile + Preferences (NEW — matches bootstrap.sh)
# ─────────────────────────────────────────────────────────
$profilePath = Join-Path $CEO_BRAIN_DIR "profile.json"
if (!(Test-Path $profilePath)) {
    Write-Host ""
    Write-Host "📋 Quick Profile Setup (used to personalize your AI):" -ForegroundColor Cyan
    $userName = Read-Host "  Your name"
    $userCompany = Read-Host "  Your company name"
    $userRole = Read-Host "  Your role (e.g., CEO, Founder)"
    $userIndustry = Read-Host "  Your industry"

    $profile = @{
        name = $userName
        company = $userCompany
        role = $userRole
        industry = $userIndustry
        tier = $tierName
        created = (Get-Date -Format "yyyy-MM-dd")
    } | ConvertTo-Json -Depth 3

    Set-Content -Path $profilePath -Value $profile
    Write-Host "  → Profile saved to ~\ceo-brain\profile.json"
}

# Create preferences.json for hooks to read
$prefsPath = Join-Path $CEO_BRAIN_DIR "preferences.json"
$prefs = @{
    tier = $tierName
    proactive_tips = ($userTier -eq "1")
    auto_save_sessions = ($userTier -le "2")
    memory_enabled = $true
    feedback_checkpoints = ($userTier -eq "2")
    dream_mode = ($userTier -eq "3")
} | ConvertTo-Json -Depth 3
Set-Content -Path $prefsPath -Value $prefs
Write-Host "  → Preferences saved to ~\ceo-brain\preferences.json"

# ─────────────────────────────────────────────────────────
# 3. Copy templates
# ─────────────────────────────────────────────────────────
Write-Host "📄 Setting up templates..." -ForegroundColor Green

$templateMap = @{
    "voice-model.md" = @{ Source = "templates\voice-model.md"; Dest = $CEO_BRAIN_DIR; DestName = "voice-model.md" }
    "pipeline.md" = @{ Source = "templates\pipeline-report.md"; Dest = $GTM_BRAIN_DIR; DestName = "pipeline.md" }
    "weekly-pulse.md" = @{ Source = "templates\weekly-pulse.md"; Dest = (Join-Path $CEO_BRAIN_DIR "weekly"); DestName = "weekly-pulse.md" }
    "meeting-brief.md" = @{ Source = "templates\meeting-brief.md"; Dest = (Join-Path $CEO_BRAIN_DIR "meetings"); DestName = "meeting-brief.md" }
}

foreach ($tpl in $templateMap.GetEnumerator()) {
    $destFile = Join-Path $tpl.Value.Dest $tpl.Value.DestName
    if (!(Test-Path $destFile)) {
        $srcFile = Join-Path $REPO_DIR $tpl.Value.Source
        if (Test-Path $srcFile) {
            Copy-Item -Path $srcFile -Destination $destFile -Force
            Write-Host "  → Created $($tpl.Value.DestName)"
        }
    }
}

if (!(Test-Path (Join-Path $GTM_BRAIN_DIR "learnings.md"))) {
    Set-Content -Path (Join-Path $GTM_BRAIN_DIR "learnings.md") -Value "# Ongoing Learnings Log`nThis file captures tactical marketing/sales feedback over time."
    Write-Host "  → Created learnings.md in gtm-brain"
}

# ─────────────────────────────────────────────────────────
# 4. Agent-Agnostic Context Routing
# ─────────────────────────────────────────────────────────
Write-Host "🤖 Applying multi-agent configuration mapping..." -ForegroundColor Green
if (Test-Path (Join-Path $REPO_DIR "AGENT.md")) {
    Copy-Item -Path (Join-Path $REPO_DIR "AGENT.md") -Destination (Join-Path $REPO_DIR ".cursorrules") -Force
    Write-Host "  → Copied AGENT.md to .cursorrules"
    Copy-Item -Path (Join-Path $REPO_DIR "AGENT.md") -Destination (Join-Path $REPO_DIR "CLAUDE.md") -Force
    Write-Host "  → Copied AGENT.md to CLAUDE.md"
}

# ─────────────────────────────────────────────────────────
# 5. Tier-Appropriate Skill Installation
# ─────────────────────────────────────────────────────────
Write-Host "🪝 Setting up Claude Code hooks and skills..." -ForegroundColor Green

# Define tier skill sets (matches bootstrap.sh exactly)
$BEGINNER_SKILLS = "email-composer meeting-prep post-meeting-brief deal-review pipeline-pulse weekly-ceo-brief voice-model doc-builder pdf-toolkit contract-reader onboard chief-of-staff decision-logger audio-briefing support-triage executive-mentor spreadsheet-builder google-doc-creation"

$INTERMEDIATE_SKILLS = "content-strategy seo-growth social-engine copy-master conversion-optimizer outreach-sequence sales-enablement fundraise ceo-advisor cfo-advisor cmo-advisor coo-advisor cro-advisor competitive-intel board-deck-builder founder-coach financial-analyst scenario-war-room hubspot-architect notion-manager slack-connector news-digest negotiation-advisor doc-coauthoring change-management launch-strategy context-prime voice-synth"

$ADVANCED_SKILLS = "social-scheduler ugc-video larry-loop aeo-optimizer sms-outreach domain-intel geopolitical-monitor agent-orchestrator agent-protocol context-engine experiment-loop verify-execution create-prd create-skill commit-fast review-pr analyze-issue feature-architect autoresearch cron-scheduler scheduling-infra dedupe-entities gfv-hooks project-release strategic-decision automation-recommender"

switch ($userTier) {
    "1" { $skillList = $BEGINNER_SKILLS }
    "2" { $skillList = "$BEGINNER_SKILLS $INTERMEDIATE_SKILLS" }
    "3" { $skillList = "$BEGINNER_SKILLS $INTERMEDIATE_SKILLS $ADVANCED_SKILLS" }
}
$skills = $skillList -split '\s+'

if ((Get-Command "claude" -ErrorAction SilentlyContinue) -or (Test-Path $CLAUDE_DIR)) {
    New-Item -ItemType Directory -Force -Path $CLAUDE_HOOKS_DIR | Out-Null
    New-Item -ItemType Directory -Force -Path $CLAUDE_SKILLS_DIR | Out-Null

    # Install hooks
    foreach ($hook in @("pre-send-review.py", "session-start.py", "session-stop.py")) {
        $hookSrc = Join-Path $REPO_DIR "hooks\$hook"
        if (Test-Path $hookSrc) {
            Copy-Item -Path $hookSrc -Destination (Join-Path $CLAUDE_HOOKS_DIR $hook) -Force
        }
    }
    Write-Host "  → Hooks installed to ~\.claude\hooks"

    # Install tier-appropriate skills via junctions
    $skillsSourceDir = Join-Path $REPO_DIR "skills"
    $installedCount = 0
    foreach ($skillName in $skills) {
        $skillSrc = Join-Path $skillsSourceDir $skillName
        $skillDest = Join-Path $CLAUDE_SKILLS_DIR $skillName
        if (Test-Path $skillSrc) {
            if (Test-Path $skillDest) { Remove-Item -Path $skillDest -Force -Recurse -ErrorAction SilentlyContinue }
            New-Item -ItemType Junction -Path $skillDest -Value $skillSrc | Out-Null
            $installedCount++
        }
    }
    Write-Host "  → Installed $installedCount skills for $tierName tier"

    # Install claude-mem and ccflare for all tiers (memory is fundamental)
    if (Get-Command "npm" -ErrorAction SilentlyContinue) {
        Write-Host "🧠 Installing memory and agent tools..." -ForegroundColor Green
        try {
            npm i -g ccflare 2>$null
            Write-Host "  → ccflare installed"
        } catch {
            Write-Host "  ⚠️ ccflare install failed — run 'npm i -g ccflare' manually" -ForegroundColor Yellow
        }
        try {
            npx claude-mem install 2>$null
            Write-Host "  → claude-mem installed (persistent memory across sessions)"
        } catch {
            Write-Host "  ⚠️ claude-mem install failed — run 'npx claude-mem install' manually" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  ⚠️ NPM not found. Install Node.js for memory and advanced tools." -ForegroundColor Yellow
    }
} else {
    Write-Host "  ℹ️  Claude Code not found; skills and hooks registered for manual use." -ForegroundColor Gray
}

# ─────────────────────────────────────────────────────────
# 6. Optional EngineClaw Integration (Advanced only)
# ─────────────────────────────────────────────────────────
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
        Write-Host "  📦 Building EngineClaw..." -ForegroundColor Green
        Set-Location $ENGINECLAW_DIR
        try {
            pnpm install
            pnpm build
        } catch {
            Write-Host "  ⚠️ EngineClaw build failed — run manually" -ForegroundColor Yellow
        }
    }

    $ENGINECLAW_STATE = Join-Path $HOME ".engineclaw"
    $WORKSPACE_DIR = Join-Path $ENGINECLAW_STATE "workspace"
    New-Item -ItemType Directory -Force -Path $WORKSPACE_DIR | Out-Null

    $ceoJunction = Join-Path $WORKSPACE_DIR "ceo-brain"
    $gtmJunction = Join-Path $WORKSPACE_DIR "gtm-brain"
    if (Test-Path $ceoJunction) { Remove-Item $ceoJunction -Force -ErrorAction SilentlyContinue }
    if (Test-Path $gtmJunction) { Remove-Item $gtmJunction -Force -ErrorAction SilentlyContinue }
    New-Item -ItemType Junction -Path $ceoJunction -Value $CEO_BRAIN_DIR | Out-Null
    New-Item -ItemType Junction -Path $gtmJunction -Value $GTM_BRAIN_DIR | Out-Null

    Copy-Item -Path (Join-Path $REPO_DIR "AGENT.md") -Destination (Join-Path $WORKSPACE_DIR "AGENT.md") -Force
    Write-Host "  → EngineClaw runtime installed and linked."
}

# Restore location
Set-Location $PSScriptRoot

# ─────────────────────────────────────────────────────────
# 7. Final summary
# ─────────────────────────────────────────────────────────
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅  CEO ENABLEMENT KIT — INSTALLATION COMPLETE                  ║" -ForegroundColor Green
Write-Host "╠═══════════════════════════════════════════════════════════════════╣" -ForegroundColor Green
Write-Host "║                                                                   ║" -ForegroundColor Green
Write-Host "║  Tier:   $tierName                                               ║" -ForegroundColor Green
Write-Host "║  Skills: $installedCount installed                               ║" -ForegroundColor Green
Write-Host "║  Brain:  ~\ceo-brain\ + ~\gtm-brain\                            ║" -ForegroundColor Green
Write-Host "║                                                                   ║" -ForegroundColor Green
Write-Host "╠═══════════════════════════════════════════════════════════════════╣" -ForegroundColor Green
Write-Host "║  NEXT STEPS:                                                      ║" -ForegroundColor Green
Write-Host "║  1. Open your terminal and type 'claude' (or open Cursor/Gemini)  ║" -ForegroundColor Green
Write-Host "║  2. Type '/onboard' to complete your voice + CRM setup            ║" -ForegroundColor Green
Write-Host "║  3. Try '/email-composer' for your first skill                    ║" -ForegroundColor Green
Write-Host "║                                                                   ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
