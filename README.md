# GetFresh GTM Enablement Kit
**Version**: v1.31.1  
**Powered by the Growth by Design (GxD) Model.**

---
### What's New in v1.31.1
- **GxD Rebranding Finalization**: Completed the total structural unification of the repository to match the Growth by Design **GTM Enablement Kit** philosophy.
- **Physical Clone Paths Repathed**: Upgraded the internal dotfile logic and documentation so standard installations correctly mount to `~/Documents/GTM-Enablement-Kit`.
- **Pre-execution Resilience**: Squashed an execution-halting Python syntax edge-case inside the `session-stop` hook.

### What's New in v1.31.0
- **Zero-Click Onboarding**: The installation script now natively downloads and configures Cursor or Claude Code so executives don't deal with manual package installations.
- **Visible Architecture**: Transitioned the install directory from hidden MacOS `.gfv` dotfiles to a highly visible `~/Documents/GTM-Enablement-Kit` path to ensure seamless folder-opening for non-technical users.
- **HTTPS Git Routing**: Removed `git@github` SSH dependencies to eliminate `Permission Denied` exceptions across enterprise networks.
---

## What is this?

A plug-and-play **Edge-Native Go-to-Market Operating System** that turns Claude Code, Cursor, Gemini, or Copilot into a personalized, autonomous Chief of Staff. 

This kit enables the proprietary **Growth by Design (GxD)** architecture directly within your local environment. 

### The Growth by Design Architecture

**The Brand (GxD)**: Growth by Design is the architecture of predictable revenue, uniting Marketing, Sales, and RevOps data into a single, unified ontology to accelerate growth and solve underlying operational problems.

**The Solution**: An Edge-Native intelligence layer that installs directly onto your laptop. It removes the friction between strategic planning and agentic execution, allowing you to orchestrate complex GTM strategies autonomously.

**The Enablement**: Zero-configuration UI orchestration. You can command multi-agent swarms to execute deep data reconciliation, content generation, and pipeline audits via Cursor or Claude without writing a single line of code.

**The Proprietary Model**: Built on a decoupled, edge-native architecture. Leveraging Local SQLite FTS5 Memory Caching, edge-compute Swarm Dispatchers, and strict 1Password Secrets Marshalling to execute cross-platform integrations (Linear, HubSpot, CAAI, Slack) while guaranteeing zero data leakage.

---

## Who is this for?

**CEOs, founders, and senior GTM executives** who:
- Need to orchestrate scalable Go-to-Market strategies and run multi-agent swarms.
- Require tight alignment between Sales, Marketing, and RevOps.
- Want an AI Chief of Staff loaded with proprietary intelligence models, deal contexts, and weekly revenue rhythms.

**You do NOT need to be technical.** The setup takes 60 seconds and builds visual interfaces automatically.

### For Non-Technical Executives: Why an IDE?
If you have never written a line of code, you might be asking: *Why an IDE (Cursor, Windsurf) instead of a standard SaaS web app like ChatGPT?*

**1. Ultimate Context (No Copy-Pasting)**
A SaaS app lives in your browser; it cannot inherently scan your local files. An IDE lets you safely drag-and-drop massive PDF contracts, complex Excel pipelines, and entire folders into your workspace. The AI can read *everything* in one shot.

**2. Zero SaaS Telemetry (Total Privacy)**
When you upload financial documents to a web wrapper, you surrender data custody. Running this Executive Kit locally inside an IDE ensures that your data stays strictly on your machine and communicates *only* via secured API endpoints you control.

**3. Direct Execution Power**
An IDE doesn't just read data; it acts. Instead of giving you a summary, your AI Chief of Staff can physically generate PowerPoint presentations, slice pipeline data, and reorganize files natively on your hard drive structure.

---

## 🖥 OS Compatibility & Requirements

This toolkit runs entirely in your local terminal to securely protect your data.

- **Mac / Linux:** Fully supported natively via the default UNIX Terminal.
- **Windows:** Fully supported natively via Windows PowerShell. You must run the `bootstrap.ps1` script instead of `bootstrap.sh`.

---

## Quick Start (5 Minutes)

### Step 1: Download the Toolkit

Open your terminal (Terminal on Mac, PowerShell on Windows) and paste this line and hit Enter:
```bash
git clone https://github.com/GetFresh-Ventures/gfv_growth_by_design.git ~/Documents/GTM-Enablement-Kit
```

*(This securely downloads the toolkit to your Documents folder).*

### Step 2: Run the installer

```bash
cd ~/Documents/GTM-Enablement-Kit
./bootstrap.sh          # Mac/Linux
# .\bootstrap.ps1       # Windows
```

The installer will ask you 2-4 quick setup questions to tailor the skills for your business.

### Step 3: Launch your AI Agent

This toolkit supports **Cursor**, **Claude Code**, or **Gemini**. The script you just ran automatically installed your selected tool if you didn't already have it!

If you chose Cursor (recommended for non-technical users):
1. Open the Cursor app.
2. Click **File > Open Folder** from the top menu.
3. Select the `GTM-Enablement-Kit` folder located inside your `Documents` folder.
4. Press `Cmd+I` (Mac) or `Ctrl+I` (Windows) to open the Cursor Composer chat.

Type this to start your first session:
```
/onboard
```

Your new Chief of Staff will take it from here. It will walk you through a 5-minute setup wizard to learn your voice, your team, and your priorities. After that, you're live.

---

## Experience Levels

The kit adapts to your comfort level with AI. You choose during installation:

### Beginner — "Keep it simple"
*18 skills • Cross-session memory • Auto-approve • Proactive tips • Plain-English mode*

Perfect if you're new to AI assistants. The AI handles emails, meeting prep, and documents — and explains everything in plain English. Memory saves automatically so each session picks up where you left off. Safe commands auto-approve so you never get stuck on Y/n prompts.

**Try these first:**
- "Draft an email to [name] about [topic]"
- "Prep me for my meeting with [name]"
- "Summarize this contract"

### Intermediate — "Plug into my business" ★ Recommended
*46 skills • CRM integration • Weekly reports • Feedback loops*

Everything in Beginner, plus your AI connects to HubSpot/Salesforce, generates weekly pipeline reports, and refines your voice model over time. After key tasks, it asks "Was this helpful?" to continuously improve.

**Try these first:**
- "What does my pipeline look like?" → `/pipeline-pulse`
- "Write my weekly CEO brief" → `/weekly-ceo-brief`
- "Build an outreach sequence for [prospect]" → `/outreach-sequence`

### Advanced — "Full autonomy"
*All 72 skills • Dream Mode • Background workers • Self-improving skills*

Everything in Intermediate, plus cross-session memory consolidation (Dream Mode), background automation, multi-agent orchestration, and skills that self-improve over time. Proactive tips turn off — you know what you want.

**Try these first:**
- "Run a morning sweep" → `/chief-of-staff`
- "Model a scenario" → `/scenario-war-room`
- "Run dream mode" → consolidates all memories

### How features grow with your level

| Feature | Beginner | Intermediate | Advanced |
|---------|----------|-------------|----------|
| Cross-session memory (claude-mem) | ✅ | ✅ | ✅ |
| Auto-approve safe commands (Dippy) | ✅ | ✅ | ✅ |
| Token cost dashboard (ccflare) | ✅ | ✅ | ✅ |
| Auto-save decisions & meetings | ✅ | ✅ | ✅ |
| Draft review before sending | ✅ | ✅ | ✅ |
| Proactive tips after tasks | ✅ | ✅ | ✅ (Optional) |
| Plain-English explanations | ✅ | ✅ (Optional) | ✅ (Optional) |
| Session summary recap | ✅ | ✅ | ✅ (Optional) |
| Feedback loops ("Was this helpful?") | ❌ | ✅ | ✅ |
| Weekly learning capture | ❌ | ✅ | ✅ |
| Voice model refinement | ❌ | ✅ | ✅ |
| Cross-session Dream Mode | ❌ | ❌ | ✅ |
| Background scheduling | ❌ | ❌ | ✅ |
| Self-improving skills | ❌ | ❌ | ✅ |

You can upgrade your level anytime by re-running `./bootstrap.sh`.

#### Optional UX Features
While Advanced tiers disable certain UX features by default to maintain execution velocity and reduce API token bloat, they can be re-enabled in `preferences.json` at any time:
- **Proactive tips after tasks:** Automatically suggests the next logical `/slash` command based on your workflow. Great for learning the system, but turned off by default for Advanced users to preserve context window space.
- **Plain-English explanations:** Forces the AI to translate complex API outputs, JSON payloads, and diffs into conversational summaries. Turned off by default for Advanced users who prefer reading raw data.
- **Session summary recap:** Writes a 3-bullet snapshot to your weekly log upon closing terminal. Turned off by default for Advanced users since the asynchronous **Dream Mode** handles much deeper intelligence consolidation.

---

## Full Skill Catalog

Once installed, invoke any skill by saying its name or typing the `/slash` command.

> 📖 For the complete machine-readable catalog, see **[AGENT-GUIDE.md](AGENT-GUIDE.md)**.

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
| `/larry-loop` | Systematically generates, distributes, and iterates on marketing content using algorithmic doubling-down |
| `/copy-master` | Mathematical direct-response rewriting engine overriding generic AI slop |
| `/support-triage` | Classifies and pushes inbound noise into active Linear/CRM backlogs automatically |
| `/news-digest` | Synthesized intelligence on active pipeline accounts ignoring global noise |
| `/contract-reader` | Red-flag analysis of any legal contract before signing. Plain-English summary with negotiation leverage |
| `/negotiation-advisor` | Battle-tested negotiation frameworks: BATNA analysis, concession architecture, tactical playbook |
| `/social-scheduler` | Cross-post and schedule content across 28+ social channels with CEO approval gate |
| `/slack-connector` | Slack workspace integration — monitor, post, search, and route critical messages |
| `/sms-outreach` | SMS/WhatsApp multi-channel outreach with TCPA compliance gates |
| `/scheduling-infra` | Meeting scheduling infrastructure with pre/post automation hooks |

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
| `/agent-orchestrator` | Multi-agent coordination engine — executes DAG pipelines and Cross-Persona debates |
| `/context-engine` | Company context loading with staleness detection, privacy rules, and enrichment |
| `/decision-logger` | Two-layer decision memory — raw transcripts vs approved-only, conflict detection |
| `/change-management` | Organizational change, reorg planning, pivot communications |
| `/launch-strategy` | Product/service launch playbooks with GTM alignment |
| `/experiment-loop` | Scientific method for business: baseline → one change → measure → keep/discard → repeat |
| `/notion-manager` | Safely read/write to Notion preserving architecture boundaries via structural checks |
| `/cron-scheduler` | Sets background loops enforcing silent-failure protections and observability |
| `/strategic-decision` | 5-perspective GO/NO-GO/DEFER framework for major decisions |
| `/dedupe-entities` | Mathematically resolves duplicate records using machine-learning active linkage |
| `/gfv-hooks` | Event-driven lifecycle hooks with safety gates |
| `/automation-recommender` | Scans a codebase and recommends tailored automations (MCP servers, skills, hooks) |
| `/aeo-optimizer` | Answer Engine Optimization — get AI assistants to recommend your brand |
| `/ugc-video` | Script-to-video UGC production pipeline with AI talking heads and subtitles |
| `/voice-synth` | AI voice synthesis for content narration and audio production |
| `/domain-intel` | Domain WHOIS intelligence for competitive analysis and deal research |
| `/geopolitical-monitor` | Global risk scoring and supply chain impact analysis for international business |

### Skills — Technical / Builder

| Skill | What it does |
|-------|-------------|
| `/context-prime` | Scans a repo and builds full context before starting work — great for Monday mornings or entering new projects |
| `/create-prd` | Converts rough notes or meeting transcripts into a structured 6-part Product Requirements Document |
| `/analyze-issue` | Takes a GitHub or Linear issue and generates a step-by-step implementation plan |
| `/feature-architect` | Enforces a strict 7-phase architecture protocol with parallel exploratory subagents |
| `/create-skill` | Formalizes skill creation using the Anthropic methodology (intent, research, tests) |
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
  │    ├── profile.json (Your identity and preferences)
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

These ship with the kit for power users. Most CEOs never need to run them directly — skills call them when needed.

| Tool | Purpose | Tier |
|------|---------|------|
| `ccflare.py` | Token cost dashboard — see real-time Claude usage and burn rate | All |
| `gfv-dedupe.py` | ML entity resolution — matches duplicates across CRM/data sources | Advanced |
| `gfv-dream.sh` | Memory consolidation — compresses session learnings into durable memory | Advanced |
| `gfv-ralph.sh` | Batch loop — process hundreds of items unattended | Advanced |
| `gfv-cost-estimator.sh` | Estimate token costs before feeding large files | Advanced |
| `gfv-audit.sh` | Operational health check on session logs | Advanced |
| `gfv-memento.py` | Context pager — compresses 10k+ line docs to prevent token overflow | Advanced |
| `gfv-generalist.sh` | Background offloader — spins scripts into `nohup` so the chat stays fast | Advanced |
| `lint-agent.sh` | Validates AGENT.md formatting | Developer |
| `lint-claude-md.sh` | Validates CLAUDE.md configuration | Developer |

### 5. `hooks/` — Lifecycle Interceptors

Hooks fire automatically at key moments in your Claude Code session:

| Hook | What it does |
|------|-------------|
| `session-start.py` | Runs at session start — loads your brain context and recent state |
| `session-stop.py` | Runs at session end — safely persists state changes via OS file locking |
| `pre-send-review.py` | Intercepts outbound messages for safety review before sending |
| `task_manager.py` | Dynamically intercepts and gates tasks requiring executive approval (`requires_human_approval: true`) |

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

The kit operates under strict mathematical and structural guardrails to prevent hallucination, data corruption, and prompt-injection attacks:
- **Human-in-the-Loop Circuit Breakers:** Any skill marked with `requires_human_approval: true` is intercepted by the `task_manager.py` hook, forcing a hard halt until the CEO explicitly overrides it. Ensures high-risk automations (pricing, outbound, contracts) never run autonomously.
- **Verification Gates Protocol:** Agents are strictly banned from verifying their own execution. The Primary Orchestrator must spawn isolated subagents to independently verify changes or review code before marking a task as cleared.
- **Cross-Platform Operation Locks:** All file I/O operations utilize zero-collision `fcntl` level OS locking to prevent document corruption during DAG multi-agent execution.
- **Structural Map Priority (Pattern 27):** Forbids dumping large files (500+ lines) directly into the agent's context window. The agent must sequentially execute `Index -> Outline -> Unfold` to preserve reasoning capability.
- **Untrusted DOM Paranoia (Pattern 28):** The Primary Orchestrator is banned from directly parsing unverified remote DOMs/UIs. All external data scraping is shunted to sandboxed subagents to mitigate adversarial prompt injection.

---

## For Advanced Users

### Agent-Agnostic Architecture

**GetFresh GTM Enablement Kit** is not locked to any single AI tool. The `AGENT.md` core uses a universal `<RULE>` format that works across:

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

### What's New in v1.30.0 (Hyper Capability & Swarm Execution)
- **Background Swarm Dispatcher:** The introduction of `tools/gfv-spawn.py` enables the offloading of extremely long tasks (scraping, auditing, mass processing) to a detached local sub-process. This unlocks instantaneous UI feedback in the main terminal while the agents crunch data in parallel.
- **Native Local Brain Search:** The inclusion of `tools/gfv-brain-search.py` means the kit no longer lags or relies on remote database integrations. Context recall across thousands of files is instantaneous via the local FTS5 SQLite indexer, automatically updated upon workspace exit.
- **Immutable Git Sandbox:** Every session stop automatically triggers a local `git commit` inside your `~/ceo-brain` array, providing an unlimited safety net and instant rollbacks in case the assistant ever overwrites context or hallucinates data.
- **Strict Secrets Marshalling:** We created an inescapable auth gateway via `tools/gfv-auth.py` ensuring pipeline operations never mysteriously crash mid-flight due to broken credentials—keys are extracted via 1Password CLI exclusively.
- **Pytest Pipeline Stability:** We cemented the cross-platform file locking (`portalocker`) and background hooks against strict unittests to assure stable runtime continuity.

For historical release notes (v1.0.0 - v1.29.0), please see [CHANGELOG.md](CHANGELOG.md).
