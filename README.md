<div align="center">
  <img src="https://raw.githubusercontent.com/getfreshventures/gfv-assets/main/logo/gfv-logo-dark.png" alt="GetFresh Ventures Logo" height="60">

  # Growth by Design CEO AI Kit

  <p align="center">
    <strong>Elevate an AI agent into an Executive Chief of Staff via Proactive Intelligence</strong>
  </p>

  [![Version](https://img.shields.io/badge/version-v1.38.0-blue.svg)](https://github.com/getfreshventures/gxd-ceo-ai-kit/releases)
  [![Status](https://img.shields.io/badge/status-production-success.svg)]()
  [![Python](https://img.shields.io/badge/python-3.10%2B-blue.svg)]()
  [![License](https://img.shields.io/badge/license-MIT-green.svg)]()
</div>

---

## 🚀 What's New in v1.38.0
- **Zero-Stub Guarantee**: Remediated 139 hallucinated skill script references, replacing them with pure generic instructions.
- **Universal Zero-Error Validation**: Injected missing frontmatter and verification gates across 40+ skills, ensuring 100% passage for `validate_skills.py`.
- **Venv Isolation Framework**: Overhauled `.cursorrules`/`.windsurfrules` injection to safely guide dependency-heavy API skills to the localized virtual environment without poisoning the global stdlib runner.

---

## What This Is

A plug-and-play **Edge-Native Go-to-Market Operating System** that turns Claude Code, Cursor, Gemini, or Copilot into a personalized, autonomous Chief of Staff. 

This kit enables the proprietary **Growth by Design (GxD)** architecture directly within your local environment. 

**Runtime:** Local / Edge-Compute · 194 Domain Skills · SQLite FTS5 Memory Caching

**The Brand (GxD)**: Growth by Design is the architecture of predictable revenue end-to-end including CX, retention, growth, accounting, and operations—uniting Marketing, Sales, and RevOps data into a single, unified ontology.

**The Solution**: An Edge-Native intelligence layer that installs directly onto your laptop. It removes the friction between strategic planning and agentic execution, allowing you to orchestrate complex GTM strategies autonomously.

---

## What's New in v1.37.0 (GetFresh Ventures Growth by Design CEO AI Kit Path Decoupling)
- **Universal Local Integration**: Configured `bootstrap.sh` to globally symlink all `~/.claude/tools/` into place for cross-repo edge computing stability without `venv` entanglement.
- **Zero Hallucinated Stubs**: Surgically scoured 19 mocked legacy `python3 /home/user/scripts/*` integrations spread across `google-doc-creation`, `seo-audit`, `gfv-hooks`, and `scheduling-infra` out of existence, bridging their actions to native API tools and core local modules.
- **iMessage Portation**: Replicated ElizaOS `plugin-bluebubbles` integration natively into `chief-of-staff` to command loop iOS communication streams.

---

## What's New in v1.35.0
- **Master Command Centers**: Fundamentally reorganized the architecture around 4 central command hubs: Chief of Staff, Revenue Command, Strategic Advisory, and Content Intelligence.
- **Legacy Aliasing**: Implemented a symlink-style alias layer in the bootstrap scripts, mapping legacy atomized skills like `/deal-review` to their new primary Command Centers.
- **Data-First Mandates**: Upgraded core skills (`ugc-video`, `negotiation-advisor`) to natively query HubSpot, Fathom, and linear via API for verified context before rendering output.

---

## What's New in v1.34.0
- **13-Repo Consolidation**: Deep-mined 13 external SEO/marketing repos, integrating non-redundant methodologies into 5 existing skills and adding 4 new skills (80 total).
- **Princeton GEO Framework**: Added the 9 Optimization Methods with exact visibility % boosts, AI platform ranking factor weights for ChatGPT/Perplexity/Google AI/Copilot.
- **Full Pipeline Verification**: All 80 skills pass 12-point `import-skill` pipeline — installer parity, proprietary leak scan, doc coverage, quality bar.

---

## Architecture

```
┌───────────────────────────────────────────────────────────────┐
│  AI Coding Assistants: Cursor · Windsurf · Claude Code        │
└────────────────────────────┬──────────────────────────────────┘
                             │
                             ▼
┌───────────────────────────────────────────────────────────────┐
│  AGENT.md (The Global Persona)                                │
│  Defines identity, constraints, memory rules, and syntax      │
│  Guides the LLM through the Sherpa UX Educational Protocol    │
└────────────────────────────┬──────────────────────────────────┘
                             │
                             ▼
┌───────────────────────────────────────────────────────────────┐
│  Growth by Design CEO AI Kit                                  │
└──────┬──────────────┬─────────────────┬───────────────────────┘
       │              │                 │
       ▼              ▼                 ▼
┌──────────────┐ ┌─────────────┐ ┌──────────────────────┐
│  194 Domain  │ │ Background  │ │ Local CEO Brain      │
│  Skills      │ │ Telemetry   │ │ (SQLite FTS5 Edge)   │
│  (C-Suite,   │ │ (Python)    │ │ Unified Ontology     │
│   Ops, Dev)  │ └──────┬──────┘ └──────────────────────┘
└──────┬───────┘ ┌──────┴──────┐
       │         │  Event Hooks│  
       │         │  Pre/Post   │
       │         │  Execution  │
       │         └─────────────┘
 ┌─────┴──────────────────────────────────┐
 │  Data Integrations & Web Protocols     │
 │  Linear · HubSpot · Slack              │
 │  Google Ads · SEMrush · Analytics       │
 └────────────────────────────────────────┘
```

**Zero SaaS Telemetry (Total Privacy)**:
When you upload financial documents to a web wrapper, you surrender data custody. Running this Executive Kit locally inside an IDE ensures that your data stays strictly on your machine and communicates *only* via secured API endpoints you control.

---

## How It Works

### The Agent Persona (AGENT.md)
The `AGENT.md` file defines the identity of the AI. It sets operational boundaries, memory rules, and ensures the LLM speaks in a decisive, action-oriented tone rather than generic "AI speak".
**Sherpa Protocol:** For non-technical users, it conditionally triggers "Working Out Loud" educational narratives to teach IDE command fluency.

### Edge-Native Memory
Local memory ensures contexts survive beyond a single terminal session.
- **`~/ceo-brain/`**: The runtime namespace storing your local profile (`profile.json`), expertise level, and historical SQLite databases.
- Background hooks run `session-start` and `session-stop` automatically.

### The Skills Layer
Over 194 discrete `.md` instruction files acting as programmatic apps. When you say "Run the weekly pipeline brief", the agent dynamically retrieves the `weekly-pipeline-brief` skill and follows its deep operational playbook step-by-step.

---

## Maslow Priority Hierarchy

All work is tiered based on your operational autonomy constraint inside `profile.json`.

| Tier | Name | Focus |
|------|------|-------|
| **Beginner** | Guided Operations | Manual confirmations on all tools, plain English explanations. |
| **Intermediate**| Partial Autonomy | Approves standard commands, requires hooks for sensitive actions. |
| **Advanced** | Hyper-Execution | Unlocked shell commands, no summaries needed, pure speed. |

---

## Core Integrations

| System | Role |
|----------|------|
| **Linear** | Project ops, sprint tracking, and blocked issue routing |
| **HubSpot** | CRM data, deal extraction, and sequence alignment |
| **Slack** | Team communications, crisis monitoring, and auto-dispatch |
| **Google Ads** | PPC campaign structure, ROAS checking, landing pages |
| **Google Analytics** | Traffic analysis, conversion tracking, audience insights |
| **QuickBooks** | Invoicing, expense tracking, financial reporting |

---

## Governance & CI/CD

### Event Hooks
We wrap code actions with lifecycle triggers:
- `session-start.py` — Hydrates previous cross-session context.
- `session-stop.py` — Archives findings and indexes local SQLite caching.
- `pre-send-review.py` — Security scanner preventing accidental data drops before external API execution.

### Fast Iteration
Changes happen seamlessly within the IDE workspace. All backgrounds scripts execute in `$GFV_CEO_BRAIN/.core` silently.

---


## Repository Structure

```text
gxd-ceo-ai-kit/
├── bootstrap.sh               # macOS/Linux setup installer
├── bootstrap.ps1              # Windows setup installer
├── AGENT.md                   # The Global Persona boundaries and identity
├── README.md                  # This file
├── CHANGELOG.md               # Version release history
├── SKILLS-REGISTRY.md         # Full index of all capabilities
├── SKILL-AUTHORING-STANDARD.md# Architecture rules for new skills
├── skills/                    # 194 Executable Domain Skills
│   ├── ceo-advisor/
│   ├── pipeline-pulse/
│   ├── eeat-content-pod/      # Example: 4-agent orchestration
│   └── ...                    # (grouped into 8 categories)
├── templates/                 # Reusable Markdown frameworks
├── workflows/                 # Operational multi-step playbooks
├── hooks/                     # Pre/post-execution safety validation
│   ├── session-start.json
│   └── session-stop.json
└── tools/                     # Underlying automation scripts
    ├── gfv-dream.py
    └── gfv-brain-search.py
```

---

## Full Capabilities Inventory

## Categories

### 🎯 Execution Infrastructure (13 skills)
Core operating system — the agent's brain, coordination, and decision-making.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`chief-of-staff`](skills/chief-of-staff/) | 3-layer triage with sprint execution cadence and memory hierarchy | Resolve, don't summarize |
| [`experiment-loop`](skills/experiment-loop/) | Scientific method for business: baseline → change → measure → keep/discard | One variable per cycle |
| [`strategic-decision`](skills/strategic-decision/) | 5-perspective GO/NO-GO/DEFER framework | Multi-lens evaluation |
| [`decision-logger`](skills/decision-logger/) | Two-layer memory with team activity log syncing | Nothing lost |
| [`verify-execution`](skills/verify-execution/) | Runtime observation instead of diff-reading | Trust but verify |
| [`gfv-hooks`](skills/gfv-hooks/) | Event-driven lifecycle hooks with safety gates | Governance without friction |
| [`agent-protocol`](skills/agent-protocol/) | Inter-agent communication for C-suite skills | Structured delegation |
| [`context-engine`](skills/context-engine/) | Company context loading for advisory skills | Know before advising |
| [`dedupe-entities`](skills/dedupe-entities/) | Mathematically resolves duplicate records using ML active linkage | Entity Resolution |
| [`notion-manager`](skills/notion-manager/) | Safely connect and map Notion workspaces strictly governing read/write boundaries | Verification First Boundaries |
| [`cron-scheduler`](skills/cron-scheduler/) | Configure recurring loops with 6-layer diagnostic and safe registration | Verify Silent Failures |
| [`agent-orchestrator`](skills/agent-orchestrator/) | Coordinate multi-agent pipeline tasks using DAG and Debate orchestration modes | Structured dispatch |
| [`automation-recommender`](skills/automation-recommender/) | Analyze a codebase and recommend automations (hooks, subagents, skills, plugins, MCP servers) | Optimize your setup |

### 👔 C-Suite Advisory (8 skills)
Specialized strategic advisory from each leadership perspective.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`ceo-advisor`](skills/ceo-advisor/) | Strategic leadership: portfolio oversight, GTM, talent | The buck stops here |
| [`cfo-advisor`](skills/cfo-advisor/) | Financial modeling, unit economics, fundraising | Show me the numbers |
| [`cmo-advisor`](skills/cmo-advisor/) | Brand positioning, growth models, marketing budget | Market-facing strategy |
| [`coo-advisor`](skills/coo-advisor/) | Process design, OKR execution, operational cadence | Run-rate excellence |
| [`cro-advisor`](skills/cro-advisor/) | Revenue forecasting, sales model, pricing strategy | Revenue engine |
| [`executive-mentor`](skills/executive-mentor/) | Adversarial thinking partner — stress-tests plans | Your brutal board prep |
| [`founder-coach`](skills/founder-coach/) | Personal leadership, delegation, archetype identification | CEO as a human |
| [`negotiation-advisor`](skills/negotiation-advisor/) | BATNA analysis, concession architecture, and tactical deal scripts | Close the deal |

### 💰 Revenue Enablement (8 skills)
Everything that directly generates or accelerates revenue.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`pipeline-pulse`](skills/pipeline-pulse/) | Active pipeline management with resolve-first bias | Act, don't report |
| [`deal-review`](skills/deal-review/) | Honest CRM review: flags stale deals, missing next steps | No happy ears |
| [`sales-enablement`](skills/sales-enablement/) | Pitch decks, objection docs, demo scripts, playbooks | Arm the reps |
| [`fundraise`](skills/fundraise/) | Investor materials + outreach with SSoT consistency | All numbers agree |
| [`outreach-sequence`](skills/outreach-sequence/) | Multi-touch prospecting sequences | Persistent, not annoying |
| [`competitive-intel`](skills/competitive-intel/) | Systematic competitor tracking | Know the battlefield |
| [`contract-reader`](skills/contract-reader/) | 4-layer legal contract analysis with red-flag detection and negotiation leverage | Know before you sign |
| [`domain-intel`](skills/domain-intel/) | WHOIS, DNS, and domain expiry intelligence for competitive research | Research the terrain |

### 📄 Document Processing (5 skills)
Creating, editing, and processing business documents.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`spreadsheet-builder`](skills/spreadsheet-builder/) | IB-grade Excel with color coding, formulas, scenarios | Blue = input, Black = formula |
| [`pdf-toolkit`](skills/pdf-toolkit/) | PDF merge, split, watermark, fill, encrypt, OCR | Contract processing |
| [`doc-builder`](skills/doc-builder/) | Word docs: proposals, contracts, memos | Professional formatting |
| [`doc-coauthoring`](skills/doc-coauthoring/) | 3-stage writing: Context → Section Refinement → Reader Test | Catch blind spots |
| [`google-doc-creation`](skills/google-doc-creation/) | Branded Google Docs via API | Executive-ready styling |

### 📅 Daily Operations (13 skills)
The CEO's day-to-day operating system.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`weekly-ceo-brief`](skills/weekly-ceo-brief/) | Week distilled to what matters | Lead with "so what" |
| [`meeting-prep`](skills/meeting-prep/) | Pre-meeting intelligence dossiers | Never walk in cold |
| [`post-meeting-brief`](skills/post-meeting-brief/) | Meeting → action with "not handled until in system" rule | Reading ≠ processing |
| [`email-composer`](skills/email-composer/) | CEO voice email drafting | No AI smell |
| [`voice-model`](skills/voice-model/) | Personal writing voice capture | Sound like you |
| [`scenario-war-room`](skills/scenario-war-room/) | Multi-variable what-if modeling | Plan for chaos |
| [`change-management`](skills/change-management/) | Rolling out org changes without chaos | ADKAR model |
| [`launch-strategy`](skills/launch-strategy/) | Product/feature launch planning | Coordinate the blast |
| [`support-triage`](skills/support-triage/) | Auto-classify and route inbound support queries into Linear/PandaDoc | The dash-brief output |
| [`news-digest`](skills/news-digest/) | Deeply synthesized marketplace surveillance against current pipeline entities | Verified Extracted Signal |
| [`slack-connector`](skills/slack-connector/) | Slack workspace integration — monitor, post, search, route messages | Team comms hub |
| [`sms-outreach`](skills/sms-outreach/) | SMS/WhatsApp multi-channel outreach with TCPA compliance | Beyond email |
| [`scheduling-infra`](skills/scheduling-infra/) | Meeting scheduling with pre/post automation and booking pages | Calendar intelligence |

### 🚀 Growth Engine (17 skills)
Marketing, content, and growth optimization.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`content-strategy`](skills/content-strategy/) | Pillars, calendars, buyer-stage keywords with A/B hook testing | System, not posts |
| [`social-engine`](skills/social-engine/) | Platform-native content with analytics dashboard and posting intelligence | No AI slop |
| [`larry-loop`](skills/larry-loop/) | Algorithmic content loop with winner scoring and cross-platform migration | System over Creativity |
| [`eeat-content-pod`](skills/eeat-content-pod/) | 4-agent orchestration pod (Recon, Context, Writer, Publisher) for verified content | Deployable content factory |
| [`seo-growth`](skills/seo-growth/) | Technical SEO, schema, site architecture, AI search opt | Discovery engine |
| [`seo-audit`](skills/seo-audit/) | Deterministic single-page SEO audits with Python scripts + HTML reports | Script + LLM two-layer |
| [`conversion-optimizer`](skills/conversion-optimizer/) | Forms, signups, landing pages, onboarding CRO | Fix the leaks |
| [`financial-analyst`](skills/financial-analyst/) | Ratio analysis, DCF, budget variance, rolling forecasts | Deep number work |
| [`copy-master`](skills/copy-master/) | 7-pillar copywriting with narrative submode and persuasion tactics | The Rule of One |
| [`ai-search-optimizer`](skills/ai-search-optimizer/) | Answer Engine Optimization — get AI assistants to recommend your brand | Own the AI answer |
| [`social-scheduler`](skills/social-scheduler/) | Cross-post to 28+ channels with CEO approval gate | One command, all channels |
| [`ugc-video`](skills/ugc-video/) | Script-to-video UGC production with AI talking heads | Video at scale |
| [`voice-synth`](skills/voice-synth/) | AI voice synthesis for narration, podcasts, and audio content | Sound human anywhere |
| [`geopolitical-monitor`](skills/geopolitical-monitor/) | Global intelligence with country instability scoring | International risk radar |
| [`paid-ads-strategy`](skills/paid-ads-strategy/) | Google, Meta, LinkedIn, Reddit, TikTok, YouTube campaigns with PMax, bidding, ROAS | Platform decision matrix |
| [`partnership-marketing`](skills/partnership-marketing/) | Influencer, affiliate, creator, referral, and PR programs with commission models | Partnership-driven growth |
| [`programmatic-seo`](skills/programmatic-seo/) | Template-based SEO page generation at scale with AI-enhanced copy differentiation | Pages × data = traffic |
| [`entity-optimizer`](skills/entity-optimizer/) | Knowledge Graph, Wikidata, AI entity resolution, Knowledge Panel optimization | Brand identity layer |

### 🛠️ Developer & DevOps (14 skills)
Infrastructure skills for the technical operator.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`onboard`](skills/onboard/) | Interactive setup wizard for the GTM Kit | First-run config |
| [`context-prime`](skills/context-prime/) | Repository scanning for baseline context | Map before moving |
| [`product-spec`](skills/product-spec/) | Rough idea → structured 6-part PRD | Idea to spec |
| [`analyze-issue`](skills/analyze-issue/) | GitHub/Linear issue → implementation plan | Issue to plan |
| [`review-pr`](skills/review-pr/) | PR security, logic, and strategy review | Code gate |
| [`commit-fast`](skills/commit-fast/) | Automated semantic git commits | Ship. Now. |
| [`project-release`](skills/project-release/) | Governed release: version bump, changelog, tag | No manual steps |
| [`autoresearch`](skills/autoresearch/) | Autonomous skill optimization via repeated scoring | Self-improving skills |
| [`board-deck-builder`](skills/board-deck-builder/) | Board/investor update decks from live data | Data-driven slides |
| [`create-skill`](skills/create-skill/) | Create, modify, and optimize skills with triggering accuracy | Skills that build skills |
| [`import-skill`](skills/import-skill/) | Import external repos/skills into the kit — rewrite, register, verify all touchpoints | Zero-stone intake |
| [`feature-architect`](skills/feature-architect/) | Guided feature development with codebase understanding and architecture focus | Architect first |
| [`hubspot-architect`](skills/hubspot-architect/) | HubSpot architecture for syncing, integrating, and data pipelines | CRM engineering |
| [`dev-browser`](skills/dev-browser/) | Sandboxed browser automation with persistent Playwright pages via CLI | Headless-first |


### 🤖 Agent Intelligence (1 skill)
Audio synthesis and executive briefing generation.

| Skill | Description | Key Pattern |
|-------|-------------|-------------|
| [`audio-briefing`](skills/audio-briefing/) | Synthesize textual outputs into physical executive audio briefings using cloned voice models | Hear, don't read |

---


*(For the complete machine-readable catalog, see **[AGENT-GUIDE.md](AGENT-GUIDE.md)**).*

---

## Documentation

| Doc | Purpose |
|-----|---------|
| [AGENT.md](AGENT.md) | Universal operating manual — all agents read this |
| [CHANGELOG.md](CHANGELOG.md) | Full release history |
| [SKILLS-REGISTRY.md](SKILLS-REGISTRY.md) | Registry of all active skills |
| [SKILL-AUTHORING-STANDARD.md](SKILL-AUTHORING-STANDARD.md) | Governance standard for writing new skills |
| [GETTING-STARTED.md](GETTING-STARTED.md) | Guided walk-through for first-time operation |

---

## Quick Start

```bash
git clone https://github.com/GetFresh-Ventures/gxd-ceo-ai-kit.git ~/Documents/gxd-ceo-ai-kit
cd ~/Documents/gxd-ceo-ai-kit
./bootstrap.sh          # Mac/Linux
# .ootstrap.ps1       # Windows
```

Then open `~/Documents/gxd-ceo-ai-kit` inside **Cursor** and type `/onboard` in the Composer chat.

---

## License & Repo

- **Repository:** [github.com/GetFresh-Ventures/gxd-ceo-ai-kit](https://github.com/GetFresh-Ventures/gxd-ceo-ai-kit)
- **Website:** [getfreshventures.com](https://getfreshventures.com)
- **Primary use:** Go-To-Market Enablement Operating System by GetFresh Ventures, powered by the Growth by Design (GxD) model for scaling companies.
