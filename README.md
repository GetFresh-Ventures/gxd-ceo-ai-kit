# GetFresh CEO Enablement Kit for AI
**Version**: v1.15.0  
**A GTM Enablement Kit for the AI-Powered Executive**
*Leveraging our Growth by Design (GxD) GTM model.*

*An exclusive framework for our GetFresh Ventures (GFV) portfolio and the CEOs and leaders we work with.*

---

## What is this?

The GetFresh CEO Enablement Kit for AI is a plug-and-play toolkit that turns any AI coding assistant — Claude Code, Cursor, Gemini (Antigravity), or GitHub Copilot — into a **personalized Chief of Staff** for Go-To-Market execution. 

Instead of opening your AI and starting from scratch every time — figuring out how to write an email, prep for a meeting, or analyze your pipeline — this kit pre-loads everything. Your voice, your deals, your preferences, your workflows. The AI already knows who you are and how you operate.

**Think of it this way:** right now, your AI assistant is a blank intern on day one. After installing the GetFresh CEO Enablement Kit for AI, it's a Chief of Staff who's worked with you for six months.

---

## Who is this for?

This kit is designed specifically for **CEOs and senior executives** in the GFV portfolio who:
- Already have (or want to start using) an AI coding assistant like Claude Code or Cursor
- Spend significant time on pipeline management, email, meeting prep, and outreach
- Want their AI to write in their voice — not generic B2B consultant-speak
- Need repeatable, zero-effort workflows for recurring weekly tasks (pipeline reviews, CEO briefs, deal progression)

**You do NOT need to be technical.** The setup takes 5 minutes and the kit handles all the wiring for you.

---

## 🖥 OS Compatibility & Requirements

This toolkit runs entirely in your local terminal to securely protect your data.

- **Mac / Linux:** Fully supported natively via the default UNIX Terminal.
- **Windows:** Fully supported natively via Windows PowerShell. You must run the `bootstrap.ps1` script instead of `bootstrap.sh`.

### ⚠️ The "Always-On" Infrastructure Notice
If you utilize the **EngineClaw Autonomous Layer** (the Night Shift workflow that drafts rescue emails at 2:00 AM), your machine **must be awake**. If you close your laptop at night, the background daemon will pause. To unlock the "Chief of Staff" autonomous experience, you either need an app keeping your laptop awake, or you can install this kit on an always-on cloud VM (like AWS EC2 or DigitalOcean).

---

## Quick Start (5 Minutes)

### Step 1: Clone the repo

Open your terminal (Terminal on Mac, PowerShell on Windows) and run:
```bash
git clone git@github.com:GetFresh-Ventures/gfv_growth_by_design.git ~/.gfv_growth_by_design
```

This downloads the entire kit to a hidden folder on your machine. You only do this once.

### Step 2: Run the installer

1. Navigate to the repository: `cd ~/.gfv_growth_by_design` (or `cd ~\.gfv_growth_by_design` on Windows)
2. Run the bootstrap script for your OS:
   - **Mac/Linux:** run `./bootstrap.sh`
   - **Windows:** run `.\bootstrap.ps1`
3. The script will dynamically:
   - Sets up the Claude Code hooks (the startup prompt logic)
   - Creates your personal `~/ceo-brain` (for personal tasks/voice) and `~/gtm-brain` (for active deals and campaigns)
   - Symlinks the 49 skills into the Claude Code path
   - Detects which AI tool you use (Claude Code, Cursor, or other) and wires things up accordingly
   - If you're on Claude Code: installs native `/slash` commands for instant skill access, sets up Dippy (auto-approves safe commands so you never see "Y/n" prompts), and wires session hooks
   - If you're on Cursor: creates `.cursorrules` so the AI reads your operating rules automatically

### Step 3: Start your first session

Open your AI assistant (Claude Code, Cursor, Gemini, or Copilot) in your working directory and paste this:

```text
Initialize GFV Chief of Staff Sequence.

1. Read the `AGENT.md` file in the root to internalize the GFV operating boundaries.
2. Ensure you have access to the `/skills/` directory.
3. IMMEDIATELY execute the `/onboard` skill to launch the interactive setup wizard. Do not output anything else; simply launch the wizard starting with Phase 0.
```

The AI will walk you through an interactive wizard to configure your voice model, pipeline priorities, and custom preferences. After that, you're live.

---

## What Can It Do?

Once installed, you have access to **48 pre-built skills** and **4 multi-step workflows** that cover everything from day-to-day execution to strategic C-suite advisory. You invoke them by saying their name (e.g., "run email-composer") or, on Claude Code, by typing the `/slash` command directly.

### Skills — Day-to-Day Execution

| Skill | What it does |
|-------|-------------|
| `/email-composer` | Writes emails in YOUR voice using your trained voice model — no buzzwords, no AI smell |
| `/meeting-prep` | Builds a 1-page intelligence dossier before any meeting — who they are, what matters to them, your angle |
| `/post-meeting-brief` | Extracts action items, decisions, and follow-up email drafts from meeting notes or transcripts |
| `/deal-review` | Honest CRM pipeline review — flags stale deals, missing next steps, and unrealistic close dates |
| `/pipeline-pulse` | Weekly pipeline health snapshot with trends, velocity metrics, and stage conversion analysis |
| `/weekly-ceo-brief` | Synthesizes your entire week — pipeline movement, key meetings, commitments, wins, risks, and next-week priorities |
| `/outreach-sequence` | Designs multi-touch outreach sequences — strategic, personalized, voice-model-compliant |
| `/voice-model` | Build and evolve your personal writing voice model over time |

### Skills — C-Suite Advisory (New in v1.4.0)

| Skill | What it does |
|-------|-------------|
| `/chief-of-staff` | Orchestration layer — routes questions to the right advisor(s), triggers multi-role consultations, synthesizes output, manages decisions |
| `/ceo-advisor` | Strategic direction, vision setting, investor narrative, company positioning |
| `/cfo-advisor` | Cash management, fundraise strategy, burn rate, financial modeling |
| `/coo-advisor` | Process design, OKR management, operational scaling, execution velocity |
| `/cmo-advisor` | Brand positioning, channel strategy, CAC optimization, competitive messaging |
| `/cro-advisor` | Pipeline management, pricing strategy, sales methodology, revenue acceleration |
| `/founder-coach` | Founder psychology, co-founder dynamics, hiring decisions, personal development |
| `/executive-mentor` | Stress-testing ideas, pre-mortem analysis, career navigation, uncomfortable truths |
| `/board-deck-builder` | Board/investor update construction with stage-specific templates |
| `/financial-analyst` | Financial modeling, ratio analysis, DCF valuation, budget variance |
| `/scenario-war-room` | Cascading multi-variable risk modeling — "what if X AND Y both happen?" |
| `/competitive-intel` | 5-layer competitive tracking with battlecard templates and win/loss analysis |

### Skills — Infrastructure

| Skill | What it does |
|-------|-------------|
| `/agent-protocol` | Inter-agent communication standard — prevents loops, enforces quality, standardizes output |
| `/context-engine` | Company context loading with staleness detection, privacy rules, and enrichment |
| `/decision-logger` | Two-layer decision memory — raw transcripts vs approved-only, conflict detection |
| `/change-management` | Organizational change, reorg planning, pivot communications |
| `/launch-strategy` | Product/service launch playbooks with GTM alignment |
| `/experiment-loop` | Scientific method for business: baseline → one change → measure → keep/discard → repeat |
| `/strategic-decision` | 5-perspective GO/NO-GO/DEFER framework for major decisions |
| `/dedupe-entities` | Mathematically resolves duplicate records using machine-learning active linkage |
| `/gfv-hooks` | Event-driven lifecycle hooks with safety gates |

### Skills — Technical / Builder

| Skill | What it does |
|-------|-------------|
| `/context-prime` | Scans a repo and builds full context before starting work — great for Monday mornings or entering new projects |
| `/create-prd` | Converts rough notes or meeting transcripts into a structured 6-part Product Requirements Document |
| `/analyze-issue` | Takes a GitHub or Linear issue and generates a step-by-step implementation plan |
| `/commit-fast` | Reviews staged files, generates semantic commit messages, and commits without manual copy-pasting |
| `/review-pr` | Deep 3-pass review on any PR or deployment — Security, Logic, and GTM Strategy alignment |
| `/autoresearch` | Meta-skill: autonomously benchmarks and improves any other skill using experimental loops |
| `/verify-execution` | Verifies changes via runtime observation instead of just reading diffs |
| `/project-release` | Governed release workflow: version bump → CHANGELOG → README → git → GitHub Release → Linear |
| `/ui-ux-pro-max` | AI-powered design intelligence mathematically scaling 161 industry-specific UI systems |
| `/onboard` | Interactive setup wizard for first-time configuration |
| `/google-doc-creation` | Professional Google Docs creation with branded styling |

### Workflows — Recurring Rhythms

Workflows combine multiple skills into larger routines. You can run them by name:

| Workflow | When to use it |
|----------|---------------|
| `weekly-pipeline-review` | Friday afternoon — the 30-minute sanity check on your entire pipeline |
| `outreach-cadence` | When designing strategic, multi-touch engagement sequences for prospects |
| `meeting-day` | Morning of a heavy meeting day — preps all your meetings in sequence |
| `deal-progression` | When actively working a deal through stages — ensures nothing falls through the cracks |

---

## How It Works — The Architecture

### 1. `~/ceo-brain` & `~/gtm-brain` — Your Persistent Local Memory

When you run `bootstrap.sh`, it creates a dual-brain directory system on your machine. This is the AI's long-term memory about you and your company:

```text
~ (Home Directory)
  ├── ceo-brain/
  │    ├── voice-model.md (Your linguistic rules)
  │    ├── team.json (Who reports to you)
  │    └── meetings/ (Your prep)
  └── gtm-brain/
       ├── pipeline.md (Active revenue deals)
       ├── learnings.md (Experiment results)
       └── campaigns/ (Ads structure)
```

**Why this matters:** most AI tools have no memory between sessions. Every new chat starts from zero. With this system, your AI picks up exactly where you left off.

### 2. `AGENT.md` — The Operating Rules

This is the single source of truth that governs how your AI behaves. It enforces:

- **Communication safety:** The AI will never send an email or message autonomously. It always drafts first and waits for your explicit "send it."
- **Voice compliance:** All outbound writing pulls from your trained voice model — no generic B2B jargon.
- **Data discipline:** The AI verifies facts against source data before making claims about your pipeline.
- **Execution velocity:** If the path is clear, the AI executes instead of asking permission to plan.
- **Cost awareness:** Lightweight tasks route to cheaper models; complex tasks use full-capability models.

When `bootstrap.sh` runs, it symlinks `AGENT.md` to `.cursorrules` (for Cursor) and `CLAUDE.md` (for Claude Code) so every AI tool reads the same operating rules.

### 3. `skills/` — The Skill Library

Each skill is a self-contained markdown file (`SKILL.md`) with structured instructions the AI follows precisely. They live in `skills/` and are automatically registered as native `/slash` commands on Claude Code.

Skills follow a strict pattern:
1. **Inputs:** What the skill needs from you (a deal name, a meeting link, etc.)
2. **Process:** Step-by-step instructions the AI follows
3. **Output:** What gets produced (an email draft, a brief, a dashboard)

### 4. `tools/` — Background Utilities

| Tool | Purpose |
|------|---------|
| `ccflare.py` | Executive dashboard showing real-time Claude token usage and cost burn rate (including cache tokens) |
| `gfv-dedupe.py` | Headless execution wrapper for ML entity resolution, matching disconnected datasets across hubs |
| `gfv-dream.sh` | Autonomous memory consolidation — scans recent Claude session logs and compresses insights into `~/gtm-brain` and `~/ceo-brain` |
| `gfv-ralph.sh` | Batch execution loop — process hundreds of URLs or CRM logs fully unattended |
| `gfv-cost-estimator.sh` | Estimate LLM token costs before feeding large CRM exports or data files |
| `lint-agent.sh` | Validates `AGENT.md` formatting to prevent silent IDE tooling failures |
| `gfv-audit.sh` | Audit tool for operational health checks |
| `lint-claude-md.sh` | Validates Claude-specific markdown formatting |
| `gfv-memento.py` | Context pager — allows agents to compress and save 10k+ line documents without blowing up token history |
| `gfv-generalist.sh` | Headless execution wrapper — spins complex python scripts out into a background `nohup` process so the agent doesn't paralyze the chat |

### 5. `hooks/` — Lifecycle Interceptors

Hooks fire automatically at key moments in your Claude Code session:

| Hook | What it does |
|------|-------------|
| `session-start.py` | Runs at session start — loads your brain context and recent state |
| `session-stop.py` | Runs at session end — persists state changes back to your brain |
| `pre-send-review.py` | Intercepts outbound messages for safety review before sending |

### 6. `guides/` — Best Practices Documentation

| Guide | What it covers |
|-------|---------------|
| `ceo-mindset.md` | How to think about AI as a CEO — delegation patterns, trust boundaries |
| `prompting-for-executives.md` | How to give instructions that produce excellent results |
| `voice-model-guide.md` | How to build and refine your personal voice model |
| `prompt-eval-guide.md` | How to write binary evaluations so `/autoresearch` can reliably improve your skills |

### 7. `templates/` — Starter Files

Pre-built templates that `bootstrap.sh` copies into your `~/ceo-brain` and `~/gtm-brain` directories:

- `voice-model.md` — Blank template for building your writing voice profile
- `pipeline-report.md` — Template for weekly pipeline snapshots
- `meeting-brief.md` — Template for pre-meeting intelligence dossiers
- `weekly-pulse.md` — Template for the weekly CEO brief

### 8. Security & Governance (`SKILL-AUTHORING-STANDARD.md`)

The kit operates under strict mathematical and structural guardrails to prevent hallucination and prompt-injection attacks:
- **Subagent Verification Protocol (Patterns 23-26):** Agents are strictly banned from verifying their own execution. The Primary Orchestrator must spawn isolated subagents to independently verify changes or review code.
- **Structural Map Priority (Pattern 27):** Forbids dumping large files (500+ lines) directly into the agent's context window. The agent must sequentially execute `Index -> Outline -> Unfold` to preserve reasoning capability.
- **Untrusted DOM Paranoia (Pattern 28):** The Primary Orchestrator is banned from directly parsing unverified remote DOMs/UIs. All external data scraping is shunted to sandboxed subagents to mitigate adversarial prompt injection.

---

## For Advanced Users

### Agent-Agnostic Architecture

GetFresh CEO Enablement Kit for AI is not locked to any single AI tool. The `AGENT.md` core uses a universal `<RULE>` format that works across:

| Tool | How it reads the rules |
|------|----------------------|
| **Claude Code** | `CLAUDE.md` (symlinked from `AGENT.md`) + native `/skills` directory + hooks |
| **Cursor** | `.cursorrules` (symlinked from `AGENT.md`) + skills read from `/skills/` on demand |
| **Gemini / Antigravity** | Reads `AGENT.md` directly as workspace context |
| **GitHub Copilot** | Reads `AGENT.md` and skills when prompted |

### The "Dream" Memory Protocol

For long-running engagements, context loss across sessions is the #1 killer of AI productivity. The Dream protocol (inspired by OpenClaude) solves this:

```bash
./tools/gfv-dream.sh
```

This script:
1. Scans your recent Claude `.jsonl` session logs
2. Extracts key decisions, learnings, and action items
3. Merges them into your `~/brain` files with absolute timestamps
4. Prunes stale or contradicted entries

Run this at the end of a heavy work session, or schedule it to run automatically.

### Multi-Model Cost Routing

The `AGENT.md` enforces an `agentRouting` paradigm:
- **Exploration tasks** (reading logs, listing files, extracting status): routed to lightweight/cheap models
- **Execution tasks** (writing code, drafting client deliverables, complex planning): uses full-capability models

This prevents you from burning expensive Opus tokens on tasks that Haiku could handle.

### Self-Optimizing Skills with `/autoresearch`

Any skill in this kit can be autonomously improved using Karpathy's autoresearch methodology:

1. Say: *"Run autoresearch on the email-composer skill"*
2. The AI runs the skill repeatedly, scores outputs against binary evaluations
3. It mutates the prompt, tests again, keeps improvements
4. Outputs: an improved `SKILL.md`, a results log, and a changelog of every mutation tried

### The Ralph Execution Loop

For batch processing — analyzing hundreds of URLs, processing CRM exports, or running bulk outreach drafts:

```bash
./tools/gfv-ralph.sh
```

This runs the AI in an unattended loop, executing tasks from a queue file. Ideal for overnight batch jobs.

### Extending the Kit

To add a new skill:
1. Create a directory under `skills/` (e.g., `skills/my-new-skill/`)
2. Write a `SKILL.md` with the `---` frontmatter header (name + description)
3. Run `bootstrap.sh` again to register it as a native `/slash` command

To add a new workflow:
1. Create a markdown file under `workflows/` describing the multi-step process
2. Reference existing skills by name in the steps

---

## Release History

### What's New in v1.13.0 (EngineClaw Autonomous Runtime)
- **Zero-Touch Config:** Provided a built-in toggle in the `bootstrap.sh` script to install the highly autonomous EngineClaw agentic runtime.
- **Dual-Brain Alignment:** Ensured the EngineClaw instance natively wires its memory and contextual workspace into `~/ceo-brain` and `~/gtm-brain` to ensure a unified system of record.
- **Agentic Capabilities Unlocked:** CEOs can now spin up background cron jobs, let EngineClaw sub-agents scrape pipelines, and utilize LLM-as-Judge routing for significant token savings.

### What's New in v1.12.0 (Dual-Brain Data Segregation)
- **Zero-Touch Configuration**: Introduced `Rule 0` to autonomously boot the 4-phase White-Glove Onboarding Wizard for new CEOs without manual text prompts.
- **Entity Resolution**: Added `gfv-dedupe.py` and the `dedupe-entities` skill for resolving fragmented CRM, PandaDoc, and Linear datasets via active-learning ML algorithms.
- **Meta-Agent Optimization Constraints**: Hardened the authoring standard with Patterns 29, 30, and 31 (The Overfitting Barrier, Specialized Tool Isolation, and Root-Cause Failure Grouping).

### What's New in v1.10.0 (System Resilience Protocol)
- **Headless Synthesis Daemon:** Built `pil_morning_digest.py` to allow the OS to update the Supabase Proactive Intelligence Layer from Linear/HubSpot automatically in the background.
- **Prompt Injection Guard (Pattern 28):** Instituted a hard parity boundary banning orchestrators from directly reading browser UI DOMs, mitigating adversarial prompt attacks.
- **UI/UX Intelligence Engine:** Shipped the `ui-ux-pro-max` BM25 search engine to mathematically govern 161 industry-specific design systems without LLM diffusion.

### What's New in v1.9.0 (Structural Map Priority)
- **Anti-File-Dump Constraint (Pattern 27):** Hard ban on pulling 500+ line files into standard context windows without first extracting a line-bounded structural map/outline of functions and classes.

### What's New in v1.8.0 (The Subagent Verification Protocol)
- **Subagent Reporting Contract (Pattern 23):** Orchestrators must reject any findings that do not cite file paths, API names, and copyable snippets. 
- **Phase 0 Discovery (Pattern 24):** Agents must read documentation explicitly prior to any execution to ban API hallucination.
- **Progressive Disclosure Loops (Pattern 25):** Strict 3-Layer memory gating (Index -> Timeline -> Fetch) applied to all PIL queries for 10x token efficiency.
- **Verification Isolation (Pattern 26):** Agents are banned from verifying their own execution. Orchestrators must deploy isolated Verification, Anti-Pattern, and Code Review bounds before creating a git commit.

### What's New in v1.7.0 (Deep Infrastructure Safeguards)
- **Untrusted Browser Paranoia:** New meta-rules to safeguard against prompt injection when reading visual DOM elements.
- **Context Paging (Memento Protocol):** `gfv-memento.py` tool added to allow the agent to read 40-page documents, compress the insights, and flush its history without crashing.
- **Generalist Headless Sponge:** `gfv-generalist.sh` tool added to allow the agent to spawn any loop over 5 steps into a background thread instantly.

### What's New in v1.6.0 (The "Frontier OS" Hardening)
- **Zero-Chitchat UX / High-Signal Output:** Global ban on conversational filler and time-estimation. UI is forced into flat markdown lists.
- **PlanMode Execution Barrier:** High-risk tasks (Score 4 & 5) now require explicit user approval on a `plan.md` artifact before any execution tokens are spent.
- **Speculative Parallelism (Turn-Penalty):** All agents process file searches sequentially as parallel arrays upfront across the repo to eliminate wasted context turns.
- **Git Amend Failsafe (Truncate-Don't-Amend):** Hard ban on `git commit --amend` to prevent pipeline corruption over failed commit hooks.

### What's New in v1.5.0 (Battle-Tested Skill Elevation)
- **9 Skills Elevated to v2:** chief-of-staff, post-meeting-brief, pipeline-pulse, weekly-ceo-brief, deal-review, verify-execution, email-composer, outreach-sequence, meeting-prep
- **New: experiment-loop** — Scientific method for CEO initiatives from autoagent's hill-climbing pattern
- **New: SKILLS-REGISTRY.md** — Complete registry of all 48 skills with categories, trigger phrases, and composition patterns
- **Resolve-First Pattern** (clawchief) — Skills now ACT on findings instead of just reporting them
- **Failure Taxonomy** (autoagent) — 7-category diagnosis framework for debugging any operational failure
- **Source-of-Truth Enforcement** — Every skill now requires live system verification, never memory alone
- **Composition Patterns** — Documented skill chains for full meeting lifecycle, deal progression, fundraise cycles
- **Skill count: 35 → 48** across advisory, operational, technical, and infrastructure categories

### What's New in v1.4.0 (CEO Enablement Infrastructure)
- **Full C-Suite Advisory System:** 12 advisory skills (CEO, CFO, COO, CMO, CRO, Founder Coach, Executive Mentor, Board Deck Builder, Financial Analyst, Scenario War Room, Competitive Intel, Chief of Staff v2.0)
- **Agent Protocol:** Formal inter-agent communication standard — `[INVOKE:role|question]` syntax, loop prevention, 4-step quality verification before any output reaches the CEO
- **Context Engine:** Company context loading with staleness detection (<30d/30-90d/>90d confidence tiers), privacy rules, and mid-session enrichment
- **Decision Logger:** Two-layer memory — raw transcripts never auto-loaded, approved decisions loaded every session. `DO_NOT_RESURFACE` enforcement prevents re-litigating rejected proposals
- **Scenario War Room:** Cascading multi-variable risk modeling — model compound adversity across all functions with severity levels, early warning signals, and hedging strategies
- **Competitive Intelligence:** 5-layer tracking system with battlecard templates, win/loss analysis, and intelligence cadence scheduling
- **Skill Authoring Standard v2:** New Patterns 10-12 mandate agent protocol compliance, standardized output formats, and decision memory integration for all advisory skills
- **Skill count: 17 → 35** across advisory, operational, technical, and infrastructure categories

### What's New in v1.3.0 (Autonomous Execution Hardening)
- **Precise Token Monitoring (`ccflare.py`):** Executive dashboard for real-time Claude usage costs including cache creation/read tokens
- **Autonomous Memory Consolidation (`gfv-dream.sh`):** Natively parses Claude session `.jsonl` logs and compresses insights into persistent memory
- **Strict Deployment Pipeline (`/review-pr`):** 3-pass security review modeled on Anthropic's internal protocols
- **Agent Validation (`lint-agent.sh`):** Prevents silent IDE failures from malformed agent configuration
- **Smarter Auto-research (`/autoresearch`):** Now requires explicit interview phases before applying mutations

### What's New in v1.2.0 (Awesome Claude Edition)
- Persistent State Vector DB (`claude-mem`) for cross-session memory
- Self-Optimizing Architecture (`/autoresearch`) for autonomous skill improvement
- Frictionless Permissions (Dippy) for uninterrupted flow state
- Cost & Usage Dashboards via `ccflare`
- The "Ralph" Execution Loop for batch processing
- Agent Agnostic Tools — works with Claude Code, Cursor, and Gemini

### What's New in v1.1.0 (Agent Agnostic Universal Architecture)
- `ONBOARDING_PROMPT.md` for zero-friction agent spinning
- `tools/gfv-cost-estimator.sh` for pre-analysis cost estimation
- Converted `CLAUDE.md` to universal `AGENT.md`
- Bootstrapper now dynamically links to Cursor and Claude contexts simultaneously

### v1.0.0 (Initial Release)
- Core `README.md`, `bootstrap.sh`, foundational skills and workflows
- Pre-send review hook for communication safety

---

## Repository Structure

```
gfv_growth_by_design/
├── AGENT.md                         ← AI operating rules (universal)
├── CHANGELOG.md                     ← Versioned release history
├── ONBOARDING_PROMPT.md             ← Copy-paste prompt for first session
├── README.md                        ← This file
├── SKILL-AUTHORING-STANDARD.md      ← The 28 absolute rules for structural integrity
├── bootstrap.sh                     ← One-command setup script
├── claude_settings.template.json    ← Claude Code settings template
├── SKILLS-REGISTRY.md               ← Complete skill registry (48 skills, 6 categories)
├── skills/                          ← 48 pre-built skills (slash commands)
│   ├── agent-protocol/              ← Inter-agent communication standard
│   ├── chief-of-staff/              ← C-suite orchestration layer
│   ├── ceo-advisor/                 ← Strategic advisory
│   ├── cfo-advisor/                 ← Financial advisory
│   ├── context-engine/              ← Company context management
│   ├── decision-logger/             ← Two-layer decision memory
│   ├── scenario-war-room/           ← Cascading risk modeling
│   ├── competitive-intel/           ← Competitive intelligence
│   ├── email-composer/
│   ├── meeting-prep/
│   ├── pipeline-pulse/
│   ├── ... (24 more)
├── workflows/                       ← Multi-step recurring routines
│   ├── weekly-pipeline-review.md
│   ├── meeting-day.md
│   ├── outreach-cadence.md
│   └── deal-progression.md
├── tools/                           ← Python/bash execution utilities
│   ├── ccflare.py
│   ├── gfv-dream.sh
│   ├── gfv-ralph.sh
│   └── ... (4 more)
├── hooks/                           ← Session lifecycle interceptors
│   ├── pre-send-review.py
│   ├── session-start.py
│   └── session-stop.py
├── guides/                          ← Best practices documentation
│   ├── ceo-mindset.md
│   ├── prompting-for-executives.md
│   ├── voice-model-guide.md
│   └── prompt-eval-guide.md
├── templates/                       ← Starter files for ~/ceo-brain and ~/gtm-brain
│   ├── voice-model.md
│   ├── meeting-brief.md
│   └── weekly-pulse.md
```

---

## Support

This is a proprietary GFV methodology. For onboarding help, troubleshooting, or feature requests, contact the GFV engineering team directly.

---

*Proprietary Methodology © GetFresh Ventures. All Rights Reserved.*
