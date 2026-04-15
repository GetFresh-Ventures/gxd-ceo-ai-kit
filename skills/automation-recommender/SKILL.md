---
name: automation-recommender
description: "Analyze any codebase or workflow and recommend specific automations — hooks, skills, MCP servers, cron jobs, and agent pipelines. Use when the user asks 'what can I automate?', 'optimize my setup', 'what am I missing?', or 'recommend improvements'."
metadata:
  version: 2.0.0
  category: technical-builder
  tier: advanced
  triggers:
    - what can I automate
    - optimize my setup
    - what am I missing
    - recommend improvements
    - automation audit
---

# Automation Recommender

Analyze a codebase, workflow, or business process and produce a prioritized, actionable automation plan. Every recommendation includes exact implementation steps — no hand-waving.

## When to Use

- User asks "what should I automate?"
- After onboarding, to suggest next-level optimizations
- When reviewing a new project for skill/hook opportunities
- When the user feels like they're doing repetitive work
- Post-sprint, to identify patterns that should become skills

## Phase 1: Discovery & Inventory

### 1A. Codebase Scan
Run these checks to build a project fingerprint:

```bash
# Language and framework detection
ls package.json pyproject.toml Cargo.toml go.mod Gemfile pom.xml 2>/dev/null
cat package.json 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print('deps:', list(d.get('dependencies',{}).keys())[:20])"

# Structure analysis
find . -maxdepth 3 -type d | head -30
find . -name "*.test.*" -o -name "*_test.*" -o -name "test_*" | wc -l

# Existing automation
ls .github/workflows/ 2>/dev/null
ls .husky/ 2>/dev/null
cat Makefile 2>/dev/null | head -20
ls hooks/ 2>/dev/null
```

### 1B. Workflow Pattern Detection
Look for these automation-ready patterns:

| Signal | What it means | Automation type |
|--------|-------------|-----------------|
| Manual `git add && git commit` | No commit workflow | Pre-commit hook |
| Repeated API calls in code | API wrapper candidate | Skill or MCP server |
| Copy-paste between files | Template candidate | Scaffolding skill |
| Manual deployment steps | CI/CD candidate | GitHub Action or skill |
| Recurring data transforms | Pipeline candidate | Cron + DAG orchestration |
| Email/Slack copy-paste | Communication template | Skill with voice model |
| Repeated prompts | Prompt template | Skill with steps |

### 1C. User Interview
Ask these 3 questions:

1. "What task do you do repeatedly that feels tedious?"
2. "What breaks most often, or what do you forget to do?"
3. "What data do you wish was automatically available when you start working?"

## Phase 2: Recommendation Engine

Score each candidate automation on a 2x2 matrix:

```
                    HIGH IMPACT
                        │
     ┌──────────────────┼──────────────────┐
     │                  │                  │
     │   Quick Wins     │   Strategic      │
     │   (do first)     │   (plan & build) │
     │                  │                  │
LOW ─┼──────────────────┼──────────────────┤── HIGH EFFORT
     │                  │                  │
     │   Skip           │   Defer          │
     │   (not worth it) │   (future sprint)│
     │                  │                  │
     └──────────────────┼──────────────────┘
                        │
                    LOW IMPACT
```

### Recommendation Categories

**🪝 Hooks** (lowest effort, immediate value)
- Pre-commit: lint, format, block secrets
- Pre-send: draft review gate
- Session-start: context loading
- Session-stop: memory persistence

**🎯 Skills** (medium effort, high reuse)
- Any workflow with 3+ steps that repeats weekly
- Any analysis that requires the same data sources
- Any communication that follows a template

**🔌 MCP Servers** (medium effort, deep integration)
- Match against user's stack:
  - React/Next.js → Context7 for docs
  - Supabase → Supabase MCP
  - Stripe → Stripe MCP
  - PostgreSQL → PostgreSQL MCP
  - Browser testing → Playwright MCP

**⏰ Cron/Scheduled Tasks** (higher effort, autonomous value)
- Pipeline health checks (daily)
- Stale deal alerts (weekly)
- Competitor monitoring (weekly)
- Report generation (weekly)

**🤖 Agent Pipelines** (highest effort, transformative)
- Multi-source data reconciliation (DAG mode)
- Strategic analysis with debate (Debate mode)
- Autonomous development with verification (Planner-Runner)

## Phase 3: Output Report

Generate this exact format:

```markdown
# Automation Recommendations for [Project Name]

## 📊 Project Profile
- **Type**: [e.g., Next.js web app, Python API, monorepo]
- **Stack**: [key dependencies]
- **Existing automation**: [what's already in place]
- **Automation maturity**: [None / Basic / Intermediate / Advanced]

## 🏆 Quick Wins (do this week)

### 1. [Automation Name]
- **Type**: Hook / Skill / MCP Server
- **Impact**: [what it saves/prevents]
- **Effort**: ~[X] minutes to set up
- **Implementation**:
  ```bash
  [exact commands to implement]
  ```

## 🎯 Strategic Builds (plan for next sprint)

### 2. [Automation Name]
- **Type**: [type]
- **Impact**: [what it enables]
- **Effort**: ~[X] hours
- **Design**: [brief architecture]
- **First step**: [what to do right now]

## 📋 Full Priority Matrix

| # | Automation | Type | Impact | Effort | Priority |
|---|-----------|------|--------|--------|----------|
| 1 | [name]    | Hook | High   | 10min  | Now      |
| 2 | [name]    | Skill| High   | 1hr    | This week|
| 3 | [name]    | MCP  | Medium | 30min  | This week|
```

## Red Flags — When to Stop

- If the user has < 5 files in their project, they don't need automation yet
- If existing CI/CD covers most workflows, focus on AI-specific additions only
- Never recommend automating something the user does once a quarter

## After This Skill
💡 Suggest these next steps:
- "Want me to build the top recommendation?" → `/create-skill` or `/feature-architect`
- "Want me to set up the hooks?" → implement directly
- "Want me to schedule the cron jobs?" → `/cron-scheduler`
