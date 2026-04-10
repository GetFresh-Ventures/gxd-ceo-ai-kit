# Growth by Design
**Version**: v1.1.0
**A GTM Enablement Kit for the AI-Powered Executive**

*An exclusive framework for GFV Portfolio CEOs.*

Growth by Design is a plug-and-play enablement kit that integrates directly into your Claude Code environment. It packages battle-tested Go-To-Market (GTM) methodologies, workflows, and prompts into a system that acts as your autonomous Chief of Staff.

## What's New in v1.1.0
- **Agent Agnostic Tools:** The kit is decoupled from Claude Code specifically, mapped to Cursor `/rules` natively via `AGENT.md`.
- **Onboarding Pipeline:** Contains `ONBOARDING_PROMPT.md` for seamless environment booting.
- **Cost Estimation:** Injected `gfv-cost-estimator.sh` to trace LLM tokens safely.

## Why This Exists
As a CEO, your time is your most constrained asset. You don't have time to write 5-touch email sequences from scratch, manually synthesize pipeline reports, or dig through CRM notes before a critical meeting. 

This repository installs the **"Brain Architecture"** directly onto your machine, turning any generic AI (whether it's **Cursor, Claude Code, Copilot, or Antigravity**) into a personalized growth engine tailored exactly to your company and your voice.

## Installation & Setup

1. **Clone the Repo:**
   ```bash
   git clone git@github.com:GetFresh-Ventures/gfv_growth_by_design.git ~/.gfv_growth_by_design
   ```

2. **Run the Bootstrap Script:**
   ```bash
   cd ~/.gfv_growth_by_design
   ./bootstrap.sh
   ```
   *This script does the magic. It creates your `~/brain` directory, identifies if you're using Claude Code or Cursor, and maps the `AGENT.md` context and skills universally.*

3. **Configure Your Voice Model:**
   Open `~/brain/voice-model.md` and fill it out. This step is critical to ensure Claude writes in your authentic voice rather than generic B2B jargon.

## The Architecture

### 1. Your `~/brain` Directory
Think of this as Claude's persistent, local memory of your company. It contains:
- `voice-model.md`: How you write and speak.
- `pipeline.md`: The current state of your deals.
- `learnings.md`: An iterative log of market feedback.
- `meetings/`: Your intelligent meeting briefs.

### 2. Multi-Agent Context (The `AGENT.md` Core)
A single truth file representing the GFV Voice Model. When you run `bootstrap.sh`, it universally links to `.cursorrules` (for Cursor users) and `CLAUDE.md` (for Claude users).

### 3. Skills (`/skills`)
Specific, parameter-driven functions your agent knows how to execute flawlessly. 
- **Claude Code Users:** Automatically mapped to `.claude/skills/` to provide blazing fast native `/slash-commands` (e.g. `/email-composer`).
- **Cursor/Other LLM Users:** Read natively from the `/skills/` directory via the universal `AGENT.md` context instructions. You can simply state: "Run the email-composer skill."
    - `email-composer`: Writes outbound in your authentic voice.
    - `meeting-prep`: Builds actionable 1-page intelligence dossiers.
    - `pipeline-pulse`: Generates executive pipeline dashboards.

### 4. Workflows (`/workflows`)
Step-by-step methodologies combining multiple skills for larger tasks.
- `weekly-pipeline-review.md`: The 30-minute Friday sanity check.
- `outreach-cadence.md`: Designing strategic, multi-touch engagement.
- `meeting-day.md`: The pre/during/post playbook.

### 5. Configs, Hooks & Tools (`/hooks` & `/tools`)
Scripts that intercept system actions or augment capabilities.
- **Tools:** Use `tools/gfv-cost-estimator.sh` to estimate LLM token pricing before you ask your agent to analyze huge CRM data exports.
- **Claude Users:** A template `claude_settings.template.json` is provided to auto-bind the `pre-send-review.py` script to prevent accidental email sending.
- **Cursor/Other Users:** Call explicitly in workflows (e.g. `python pre-send-review.py`).

## Getting Started: The Zero-Friction Quickstart
Once bootstrapped, simply copy the contents of `ONBOARDING_PROMPT.md` and paste it into any new Cursor, Claude Code, or Gemini chat to instantly align your assistant with the GFV methodologies.

---
*Proprietary Methodology © GetFresh Ventures. All Rights Reserved.*
