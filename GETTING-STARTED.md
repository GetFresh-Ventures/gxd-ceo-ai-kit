# Getting Started — Your First 30 Minutes

**The Executive Enablement Walkthrough**
*For CEOs, founders, and senior leaders using the GetFresh GTM Enablement Kit (Growth by Design).*

---

## What You're About to Install

In the next 30 minutes, you will go from "AI is a blank chatbot" to "AI is my Chief of Staff." Here's exactly what happens:

| Step | What | Time | Outcome |
|------|------|------|---------|
| 1 | Clone the kit | 2 min | Kit downloaded to your machine |
| 2 | Run the installer | 5 min | Skills, memory, and hooks wired up |
| 3 | Run the onboarding wizard | 15 min | AI learns your voice, team, and priorities |
| 4 | Your first real task | 5 min | AI delivers immediate value |

**You do NOT need to be technical.** If you can open a terminal window and paste a command, you can do this.

---

## Before You Start

### What You Need
- [ ] A Mac, Linux machine, or Windows PC
- [ ] Access to the GetFresh Ventures GitHub organization (ask your GFV contact for an invite)
- [ ] **No pre-installed apps required.** The installation script will automatically download and set up your preferred AI Tool (Cursor or Claude Code) if you don't have it!

### What You Should Have Ready
These aren't required, but having them handy will make the onboarding wizard dramatically more useful:
- [ ] 3–5 recent emails you've written (to train your voice model)
- [ ] Your current deal pipeline (the names of your top 5 deals or prospects)
- [ ] Your weekly calendar rhythm (what recurring meetings do you have?)

---

## Step 1: Download the Kit (2 minutes)

Open your terminal:
- **Mac:** Open the "Terminal" app (search Spotlight for "Terminal")
- **Windows:** Open "PowerShell" (search Start for "PowerShell")

Paste this command and press Enter:

```bash
git clone https://github.com/GetFresh-Ventures/gfv_growth_by_design.git ~/Documents/GTM-Enablement-Kit
```

> **What just happened?** You downloaded the entire kit to a highly visible folder in your Documents. Your data stays local — nothing is uploaded to the cloud.

---

## Step 2: Run the Installer (5 minutes)

Navigate to the kit and run the bootstrap script:

**Mac / Linux:**
```bash
cd ~/Documents/GTM-Enablement-Kit
./bootstrap.sh
```

**Windows:**
```powershell
cd ~\\Documents\\GTM-Enablement-Kit
.\\bootstrap.ps1
```

### The installer will ask you two things:

**1. Your experience level:**

| Level | Best for | What you get |
|-------|----------|-------------|
| **Beginner** | New to AI assistants | 18 core skills, cross-session memory, auto-approve, proactive tips, plain-English mode |
| **Intermediate** ★ | Regular AI users | 46 skills + CRM integration, feedback loops, weekly learning capture |
| **Advanced** | Power users | All 75 skills + Dream Mode, background automation, self-improving skills |

> **Not sure?** Pick **Intermediate**. You can change your level anytime by re-running the installer.

**2. A few quick setup questions** (your name, company, and — for Intermediate/Advanced — which CRM and AI tool you use).

### What the installer sets up:
- `~/ceo-brain/` — Your personal AI memory (voice model, meeting notes, preferences)
- `~/gtm-brain/` — Your company intelligence (pipeline data, competitive intel, learnings)
- Cross-session memory (SQLite FTS5) — so the AI remembers you between sessions
- Auto-approve safe commands (Dippy) — so you never get stuck on Y/n prompts
- Token cost dashboard (gfv-telemetry) — see what you're spending in real time

---

## Step 3: Run the Onboarding Wizard (15 minutes)

This part sounds intimidating, but it's just opening a folder and typing a message.

1. Open **Cursor** (the application you downloaded earlier).
2. From the top menu bar, click **File > Open Folder**.
3. Navigate to your `Documents` folder and select the `GTM-Enablement-Kit` folder.
4. Once the folder opens, press **Cmd+I** (Mac) or **Ctrl+I** (Windows) to open the Cursor Composer Chat panel.

In the chat box, type:

```
/onboard
```

The AI will walk you through a personalized setup based on your level:

### All levels get:
- **Voice calibration** — Paste an email or link to your LinkedIn. The AI analyzes your writing style and builds a voice model so everything it writes sounds like you — not a chatbot.

### Intermediate and Advanced also get:
- **Team map** — Tell the AI who's on your team and what they handle
- **Pipeline setup** — Enter your top deals so the AI can track and advise on them

### Advanced also gets:
- **Tool connections** — Wire up HubSpot, Slack, Notion, or other integrations

> 💡 **Tip:** Be honest and specific during onboarding. The more context you give, the more leverage you get from every future interaction.

---

## Step 4: Your First Real Task (5 minutes)

Now that you're set up, try one of these:

### If you're a Beginner:

> *"Draft an email to [Name] about [topic]."*

The AI writes using your voice model — not generic AI speak. Read it. Does it sound like you? If not, paste another email sample and say "update my voice model."

### If you're Intermediate:

> *"What does my pipeline look like?"*

The AI reviews your active deals, flags anything stale, and suggests follow-up actions.

### If you're Advanced:

> *"Run a morning sweep across all systems."*

The AI checks pipeline state, pending approvals, meeting schedule, and surfaces anything that needs your attention.

---

## Understanding Your Skill Library

You have access to **75 pre-built skills** organized into 8 categories. You don't need to memorize them — just describe what you need and the AI will route to the right skill automatically.

### Most-Used Skills for Executives

| When You Need... | Say This | Skill Used |
|-------------------|----------|------------|
| Meeting prep | "Prep me for my call with [Name]" | `meeting-prep` |
| Process meeting notes | "Here are my notes from [call]" | `post-meeting-brief` |
| Pipeline review | "What's closing this month?" | `pipeline-pulse` |
| Write an email | "Draft an email to [Name]" | `email-composer` |
| Weekly synthesis | "What mattered this week?" | `weekly-ceo-brief` |
| Strategic advice | "Should I [decision]?" | `chief-of-staff` → routes to advisors |
| Deal evaluation | "Is this deal real?" | `deal-review` |
| Contract review | "Check this contract for red flags" | `contract-reader` |
| Audio briefing | "Give me a briefing I can listen to" | `audio-briefing` |

### The Full Category Map

| Category | Skills | Examples |
|----------|--------|----------|
| 🎯 Execution Infrastructure | 11 | chief-of-staff, decision-logger, verify-execution |
| 👔 C-Suite Advisory | 8 | ceo-advisor, cfo-advisor, cmo-advisor, founder-coach |
| 💰 Revenue Enablement | 10 | deal-review, pipeline-pulse, outreach-sequence |
| 📄 Document Processing | 6 | contract-reader, board-deck-builder, google-doc-creation |
| 📅 Daily Operations | 8 | email-composer, meeting-prep, weekly-ceo-brief |
| 🚀 Growth Engine | 13 | copy-master, aeo-optimizer, seo-growth, social-scheduler |
| 🛠 Technical / Builder | 10 | create-prd, analyze-issue, feature-architect |
| 🤖 Agent Intelligence | 5 | agent-orchestrator, agent-protocol |

---

## Safety Guarantees

This kit is designed with executive-grade safety controls built in:

### 📧 No Autonomous Sending
The AI will **never** send an email, Slack message, or any communication without showing you the full draft and getting your explicit "send it" approval. It always drafts first.

### 🔒 Local-First Data
Your voice model, pipeline data, and meeting prep live on YOUR machine in `~/ceo-brain` and `~/gtm-brain`. They are not uploaded to any cloud service.

### ✅ Source Verification
The AI verifies claims against live data sources (CRM, calendar, etc.) before asserting facts about your pipeline. It doesn't guess — it checks.

### 🛡 Credential Security
All API keys and tokens are stored in your system's secure credential manager (macOS Keychain / Windows Credential Manager). Nothing is hardcoded in files.

---

## Recurring Rhythms — Building the Habit

The real ROI comes from consistent weekly use. Here's the recommended cadence:

### Monday Morning (5 min)
> *"Write my weekly CEO brief. What are my priorities this week?"*

### Before Each Meeting (2 min)
> *"Prep me for my [time] meeting with [Name]."*

### After Each Meeting (3 min)
> *"Process these notes from my call with [Company]: [paste notes]"*

### Friday Afternoon (5 min)
> *"Run pipeline-pulse. What moved this week? What's stuck?"*

### Sunday Night (Optional, 2 min — Advanced only)
> *"Run dream mode to consolidate this week's learnings."*

---

## Upgrading Your Level

You can change your experience level anytime:

```bash
cd ~/.gfv_growth_by_design
./bootstrap.sh
```

The installer is idempotent — it only adds what's missing, never overwrites your data. Your voice model, pipeline, and learnings are always preserved.

### Signs You're Ready for the Next Level

| From → To | You're ready when... |
|-----------|---------------------|
| Beginner → Intermediate | You're comfortable with email, meetings, and docs — now you want CRM integration, pipeline dashboards, and content strategy |
| Intermediate → Advanced | You want background agents running while you work, multi-agent orchestration, and autonomous improvement loops |

### What Each Level Unlocks

**Intermediate** (adds 28 skills to the 18 you already have):
- 📊 **CRM & Revenue**: `pipeline-pulse`, `deal-review`, `sales-enablement`, `hubspot-architect`
- 📝 **Content & Marketing**: `content-strategy`, `seo-growth`, `social-engine`, `copy-master`
- 💰 **Finance & Fundraising**: `fundraise`, `financial-analyst`, `board-deck-builder`
- 🧠 **C-Suite Advisory**: `ceo-advisor`, `cfo-advisor`, `cmo-advisor`, `coo-advisor`, `cro-advisor`
- 🤝 **Negotiations & Launches**: `negotiation-advisor`, `launch-strategy`, `change-management`

**Advanced** (adds 26 more skills):
- 🤖 **Automation**: `agent-orchestrator`, `cron-scheduler`, `scheduling-infra`
- 🔬 **Self-Improvement**: `autoresearch`, `experiment-loop`, `create-skill`
- 🌍 **Intelligence**: `geopolitical-monitor`, `competitive-intel`, `domain-intel`
- 🎥 **Media**: `ugc-video`, `social-scheduler`, `sms-outreach`

### Preview Without Committing

Want to see what's available before upgrading? Just ask:
> *"What skills are in the Intermediate tier?"*
> *"Show me what I'd get if I upgraded to Advanced."*

The AI can describe any skill — you just can't run it until you upgrade.

---

## Troubleshooting

### "The AI doesn't know who I am"
Run the onboarding wizard again: type `/onboard`. Or check that `~/ceo-brain/voice-model.md` exists and has content.

### "The AI sounds generic"
Your voice model needs more samples. Paste 3–5 more emails and say: *"Update my voice model with these samples."*

### "I can't clone the repo"
You need an SSH key connected to your GitHub account AND access to the GetFresh-Ventures organization. Ask your GFV contact to add you.

### "The installer failed on Windows"
Make sure you're running PowerShell as Administrator. Use `.\bootstrap.ps1` (not `./bootstrap.sh`).

### "Memory doesn't persist between sessions"
Ensure the `~/ceo-brain/` and `~/gtm-brain/` directories exist and `gfv-brain-search.py` is accessible. Re-run `./bootstrap.sh` to verify the installation.

### "How do I update to the latest version?"
```bash
cd ~/.gfv_growth_by_design
git pull
./bootstrap.sh
```

---

## What's Next?

Once you're comfortable with the basics:

1. **Build Your Voice Model** — Read `guides/voice-model-guide.md` for advanced voice calibration
2. **Master Executive Prompting** — Read `guides/prompting-for-executives.md` for high-payoff prompt patterns
3. **CEO Mindset** — Read `guides/ceo-mindset.md` for the mental model shift that unlocks 10x AI leverage
4. **Extend the Kit** — Create custom skills specific to your business using `/create-skill`

---

*Version 1.32.2 — April 2026*
*Proprietary Methodology © GetFresh Ventures. All Rights Reserved.*
