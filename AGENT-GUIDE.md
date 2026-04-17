# AGENT-GUIDE.md — GTM Enablement Kit

> **For AI agents.** If you are a coding agent (Claude Code, Cursor, Codex, Gemini) and this repo has been connected to your workspace, read this file first.

## What This Is

A modular skill system that transforms a coding agent into a CEO's Chief of Staff. 75 executable skills covering revenue operations, strategic advisory, content production, engineering workflows, and daily executive operations. Skills are structured markdown files (`SKILL.md`) that provide step-by-step instructions for complex workflows.

## Quick Install

```bash
# Clone
git clone https://github.com/GetFresh-Ventures/gfv_growth_by_design.git
cd gfv_growth_by_design

# Run the installer (interactive — choose your tier)
chmod +x bootstrap.sh && ./bootstrap.sh

# Windows
powershell -ExecutionPolicy Bypass -File bootstrap.ps1
```

The installer creates two local directories and symlinks skills into your agent's skill path:
- `~/ceo-brain/` — Personal: voice model, preferences, meeting notes
- `~/gtm-brain/` — Company: pipeline data, competitive intel, learnings

## Experience Levels

The installer adapts to three user personas. Each level adds skills AND behaviors:

| Level | Who it's for | Skills | Key behaviors |
|-------|-------------|--------|--------------|
| **Beginner** | New to AI assistants | 15 core skills | Auto-save memory, proactive tips, plain-English explanations, session summaries |
| **Intermediate** | Regular AI users | 45 skills | Everything in Beginner + feedback loops, weekly learning capture, voice model refinement |
| **Advanced** | Power users | All 75 skills | Everything in Intermediate + Dream Mode, agent spawning, self-improving skills, background automation |

### What each level enables by default

| Feature | Beginner | Intermediate | Advanced |
|---------|----------|-------------|----------|
| Cross-session memory (SQLite FTS5) | ✅ | ✅ | ✅ |
| Auto-approve safe commands (Dippy) | ✅ | ✅ | ✅ |
| Token cost dashboard (gfv-telemetry) | ✅ | ✅ | ✅ |
| Auto-save decisions & meetings | ✅ | ✅ | ✅ |
| Draft review before sending | ✅ | ✅ | ✅ |
| Proactive tips ("Want me to also...?") | ✅ | ✅ | ❌ |
| Plain-English explanations | ✅ | ❌ | ❌ |
| Session summary (3-bullet recap) | ✅ | ✅ | ❌ |
| Feedback loops ("Was this helpful?") | ❌ | ✅ | ✅ |
| Weekly learning capture | ❌ | ✅ | ✅ |
| Voice model refinement prompts | ❌ | ✅ | ✅ |
| Cross-session Dream Mode | ❌ | ❌ | ✅ |
| Background worker scheduling | ❌ | ❌ | ✅ |
| Self-improving skills (autoresearch) | ❌ | ❌ | ✅ |

**Agent behavior:** Read `~/ceo-brain/preferences.json` at session start. If `proactive_tips` is true, suggest related skills after completing tasks. If `feedback_loops` is true, ask for feedback after key outputs. If `auto_memory` is true, save decisions and outcomes without being asked.

Re-run `bootstrap.sh` anytime to change levels.

## Architecture

```
gfv_growth_by_design/
├── AGENT.md                 # Operating rules — read after this file
├── AGENT-GUIDE.md           # This file — skill catalog and usage
├── bootstrap.sh/.ps1        # Installer
├── skills/                  # 75 skill directories
│   └── <skill-name>/
│       └── SKILL.md         # Skill instructions (YAML frontmatter + markdown)
├── tools/                   # 10 CLI tools
├── hooks/                   # 5 lifecycle hooks
├── workflows/               # 4 multi-step workflows
├── guides/                  # Reference guides
└── SKILLS-REGISTRY.md       # Full skill catalog with categories
```

## How Skills Work

1. **Discovery:** Your agent reads skill `name` and `description` from YAML frontmatter
2. **Activation:** When a user prompt matches a skill's trigger conditions, load the full `SKILL.md`
3. **Execution:** Follow the step-by-step instructions in the skill body
4. **Chaining:** Skills reference other skills in their `## Integration` section — follow those chains

Skills trigger on natural language. Examples:
- "Review this PR" → activates `review-pr`
- "Write an email to..." → activates `email-composer`
- "What's our pipeline look like?" → activates `pipeline-pulse`

## Skills Catalog

### 🏢 Core Operations (Daily CEO Workflows)

| Skill | What it does |
|-------|-------------|
| `chief-of-staff` | Always-on executive triage — calendar, pipeline, blockers, morning sweep |
| `email-composer` | Write emails in the CEO's voice using `~/ceo-brain/voice-model.md` |
| `meeting-prep` | Pre-meeting intelligence dossier from CRM, email, and web research |
| `post-meeting-brief` | Extract action items, decisions, and follow-ups from meeting notes |
| `weekly-ceo-brief` | Synthesize the week into pipeline movement, key decisions, action items |
| `audio-briefing` | Generate audio-ready executive briefing scripts for commute listening |
| `news-digest` | Curated intelligence brief from market signals relevant to your portfolio |
| `decision-logger` | Two-layer memory for CEO decisions — raw transcripts + distilled insights |
| `support-triage` | Classify, prioritize, and route inbound requests by severity |
| `scheduling-infra` | Set up cron jobs, launchd plists, and background automation |
| `onboard` | White-glove executive intake — builds voice model, team file, brain directories |

---

### 💰 Revenue & Pipeline

| Skill | What it does |
|-------|-------------|
| `pipeline-pulse` | Active pipeline management — flag stale deals, missing next steps, risk signals |
| `deal-review` | Deep-dive on a specific deal — timeline, stakeholders, probability assessment |
| `cro-advisor` | Revenue strategy — forecasting, sales model design, quota planning |
| `sales-enablement` | Create pitch decks, one-pagers, objection handlers, competitor battlecards |
| `outreach-sequence` | Design multi-touch outreach with follow-up cadence and voice-matched copy |
| `fundraise` | Investor materials — pitch deck, financial model, one-pager, data room |
| `negotiation-advisor` | Deal negotiation frameworks — BATNA analysis, anchoring, concession strategy |
| `sms-outreach` | SMS/WhatsApp outbound for CEO communications |
| `contract-reader` | Plain-English contract summary with red-flag detection |

---

### 📈 Content & Marketing

| Skill | What it does |
|-------|-------------|
| `content-strategy` | Plan topic pillars, content calendar, and distribution strategy |
| `seo-growth` | Technical SEO audit, on-page optimization, schema markup, site structure |
| `social-engine` | Create platform-native content for LinkedIn, X, Instagram, newsletters |
| `social-scheduler` | Cross-post and schedule content across 28+ social channels |
| `copy-master` | High-conversion copywriting — headlines, CTAs, landing page copy |
| `ai-search-optimizer` | Answer Engine Optimization for AI search visibility (Perplexity, ChatGPT) |
| `eeat-content-pod` | 4-agent orchestration pod (Recon, Context, Writer, Publisher) for verified content |
| `larry-loop` | Autonomous content validation — distribution, indexing, and performance |
| `conversion-optimizer` | Optimize forms, signup flows, landing pages, and onboarding funnels |
| `ugc-video` | Script-to-video production pipeline with AI talking heads |
| `voice-synth` | Audio-optimized scripts with pacing markers and pronunciation guides |

---

### 🎯 Strategic & C-Suite Advisory

| Skill | What it does |
|-------|-------------|
| `ceo-advisor` | Strategic portfolio oversight — thesis tracking, resource allocation, board prep |
| `cfo-advisor` | Financial modeling, unit economics, cash flow management, fundraise timing |
| `cmo-advisor` | Brand positioning, growth model design, channel strategy, marketing ROI |
| `coo-advisor` | Process design, OKR execution, operational efficiency, team structure |
| `competitive-intel` | Systematic competitor tracking — market position, messaging, product moves |
| `scenario-war-room` | Cross-functional what-if modeling for cascading multi-variable decisions |
| `board-deck-builder` | Assemble board/investor update decks from live data |
| `executive-mentor` | Adversarial thinking partner — stress-test plans, probe blind spots |
| `founder-coach` | Personal leadership development, archetype mapping, feedback processing |
| `change-management` | ADKAR model rollouts for organizational changes |
| `strategic-decision` | Multi-framework decision analysis (Porter, SWOT, Eisenhower) |
| `experiment-loop` | Scientific method for CEO initiatives — hypothesis, test, measure, iterate |
| `launch-strategy` | Product launch and release planning with go-to-market playbooks |
| `financial-analyst` | Financial ratio analysis, DCF valuation, budget variance analysis |
| `geopolitical-monitor` | Country instability scoring and geopolitical risk assessment |

---

### 🔧 Technical & Engineering

| Skill | What it does |
|-------|-------------|
| `review-pr` | Structured code review with 4-severity rubric and security checklist |
| `analyze-issue` | Systematic 4-phase debugging — reproduce, trace, hypothesize, fix |
| `commit-fast` | Auto-generate semantic commits from diffs with conventional commit format |
| `context-prime` | Load full project context — architecture, deps, tests, git state |
| `product-spec` | Convert rough ideas into structured 6-section Product Requirements Docs |
| `create-skill` | Meta-skill for authoring new skills with quality validation |
| `verify-execution` | Runtime verification through observation, not just diff-reading |
| `feature-architect` | Guided feature development with codebase understanding |
| `domain-intel` | WHOIS, DNS, SSL, and tech stack detection for any domain |
| `dedupe-entities` | Mathematically resolve duplicate entities in CSV datasets |
| `agent-orchestrator` | Multi-agent dispatch and coordination for parallel workloads |
| `automation-recommender` | Identify repetitive workflows and recommend skill automation |
| `import-skill` | Import external repos/skills — rewrite, register, and verify all touchpoints |
| `dev-browser` | Sandboxed browser automation with persistent Playwright pages via CLI |

---

### 📄 Document & Data Processing

| Skill | What it does |
|-------|-------------|
| `google-doc-creation` | Create branded Google Docs with executive styling via API |
| `doc-builder` | Create/edit Word documents (.docx) — proposals, contracts, memos |
| `doc-coauthoring` | Structured 3-stage document writing: gather → draft → refine |
| `pdf-toolkit` | Read, merge, split, fill, watermark, and encrypt PDFs |
| `spreadsheet-builder` | Build/analyze Excel spreadsheets with formulas and charts |
| `voice-model` | Build and evolve the CEO's personal writing voice model |

---

### 🏗️ Infrastructure & Integrations

| Skill | What it does |
|-------|-------------|
| `hubspot-architect` | HubSpot CRM integrations — CRUD, UPSERT sync, pipeline setup, batch ops |
| `notion-manager` | Notion API — database queries, page creation, property updates |
| `slack-connector` | Read, post, and manage Slack team communications |
| `agent-protocol` | Multi-agent communication protocol and message routing |
| `context-engine` | Load and manage company context for all C-suite advisory skills |
| `cron-scheduler` | Configure recurring background tasks with safety constraints |
| `gfv-hooks` | Lifecycle hooks for pre-tool, post-tool, and session management |
| `project-release` | Governed release workflow with semver, changelog, and deployment |
| `autoresearch` | Autonomous research pipeline — web crawl, synthesize, cite |

---

## Tools (10)

These utilities ship with the kit for power users. Most CEOs never need to run them directly — skills call them automatically when needed.

| Tool | Purpose | Who Uses It |
|------|---------|-------------|
| `gfv-telemetry.py` | Token cost tracking and session metrics dashboard | All tiers |
| `gfv-audit.py` | Audit Claude session logs for patterns and learnings | Advanced |
| `gfv-cost-estimator.py` | Estimate API costs before feeding large files | Advanced |
| `gfv-dedupe.py` | Deduplicate entities across CRM/data sources | Advanced |
| `gfv-dream.py` | Background memory consolidation (auto-run by hooks) | Advanced |
| `gfv-spawn.py` | Headless Swarm Dispatcher for long-running detached agents | Advanced |
| `gfv-memento.py` | Compress large documents to prevent context overflow | Advanced |
| `gfv-telemetry.py` | Logs execution metrics to local SQLite database | Advanced |
| `gfv-auth.py` | Intercepts validation for 1Password/ENV integration | Advanced |
| `gfv-ralph.sh` | Batch processing loop for repetitive operations | Advanced |
| `lint-agent.sh` | Validate AGENT.md formatting | Developers |
| `lint-claude-md.sh` | Validate CLAUDE.md configuration | Developers |

## Hooks (5)

| Hook | Fires when | What it does |
|------|-----------|-------------|
| `pre-send-review.py` | Before any outbound message tool | Blocks auto-sends, requires CEO approval |
| `session-start.py` | Session begins | Loads context from brain directories |
| `session-stop.py` | Session ends | Persists learnings and session state |
| `task_manager.py` | Task lifecycle events | Manages team task routing and tracking |
| `generate_audio.py` | Audio content requested | Triggers TTS rendering pipeline |

## Workflows (4)

| Workflow | Purpose |
|----------|---------|
| `deal-progression.md` | Step-by-step deal advancement through pipeline stages |
| `meeting-day.md` | Full meeting day protocol — prep → attend → debrief |
| `outreach-cadence.md` | Multi-touch outreach execution with timing rules |
| `weekly-pipeline-review.md` | Weekly pipeline hygiene and forecasting ritual |

## First Session Checklist

If this is a fresh install, the agent should:

1. ✅ Read `AGENT.md` for operating rules
2. ✅ Check if `~/ceo-brain/voice-model.md` exists — if not, run `/onboard`
3. ✅ Check if `~/gtm-brain/pipeline.md` exists — if not, ask what CRM to connect
4. ✅ Run `/context-prime` on any active project
5. ✅ Run `/chief-of-staff` for a morning sweep

## Environment Variables

| Variable | Purpose | Required |
|----------|---------|----------|
| `HUBSPOT_PAT` | HubSpot Private App Token | For CRM skills |
| `NOTION_API_KEY` | Notion integration token | For Notion skills |
| `ELEVENLABS_API_KEY` | ElevenLabs TTS | For audio skills |
| `OPENAI_API_KEY` | OpenAI API | For TTS fallback |

All secrets should be stored in macOS Keychain or environment variables — never hardcoded.
