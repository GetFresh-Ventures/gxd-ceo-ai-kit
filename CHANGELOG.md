# Changelog

All notable changes to the GetFresh CEO Enablement Kit for AI will be documented in this file.

## 2026-04-12 1:04 PM PT — v1.15.0 — VoxCPM Executive Voice Engine

### Added
- **Audio Briefing Engine:** Bootstrapped native VoxCPM Text-to-Speech into the toolkit (`hooks/generate_audio.py`), explicitly integrated via the overarching `skills/audio-briefing` capability.
- **Vocal Calibration Intake:** Upgraded `skills/onboard` Executive Interview to include "Phase 4: Audio Clone Calibration", scaffolding the local `~/ceo-brain/reference_voice.wav` physical footprint for multi-lingual zero-shot voice cloning.

## 2026-04-12 2:50 PM CT — v1.14.0 — Windows Native Support and E2E Proactive Sync

### Added
- **Windows PowerShell Installer:** Engineered `bootstrap.ps1` for native Windows execution without requiring WSL2. Automatically handles Junctions, pathing, and Node build execution.
- **EngineClaw Night Shift Task:** Created `engineclaw_tasks/night_shift.md` mapping out the `skills/pipeline-pulse` instructions internally for EngineClaw to audit the CRM at 2:00 AM.
- **Morning Sync Alert:** Augmented the `session-start.py` hook to dynamically scan `~/gtm-brain/pending_approvals/` and output a "GETFRESH EXECUTIVE MORNING SYNC" alert with drafted deal rescue emails.

### Changed
- **Final Rebranding:** Deeply updated all project identifiers (README, scripts, hooks, documentation) to formally adopt "GetFresh CEO Enablement Kit for AI", aligning with the "Growth by Design" (GxD) GTM model.
- **OS Documentation:** Clarified OS compatibility in README explicitly denoting Windows execution via PowerShell.
- **Always-On Requirement Clarification:** Added strong visual warnings inside README addressing the requirement of sleep-preventing utilities or VMs for EngineClaw cron reliability.

### Fixed
- Enforced EngineClaw inheriting meta-agentic constraints by hardlinking `AGENT.md` and `SKILL-AUTHORING-STANDARD.md` natively into the EngineClaw workspace configuration inside bootstrap scripts.

## 2026-04-12 2:40 PM CT — v1.13.0 — EngineClaw Autonomous Runtime

### Why it matters
To provide CEOs with true "set and forget" autonomy, this release integrates the EngineClaw agentic runtime (powered by OpenBMB EdgeClaw internals) as a native, toggleable option within the installation pipeline. Moving beyond standard interactive Claude Code sessions, EngineClaw enables persistent, self-driven loops and LLM-as-Judge cost routing. Most importantly, it completely wires into the Dual-Brain Architecture (`~/ceo-brain` and `~/gtm-brain`), ensuring offline local data remains the sole resilient anchor payload across both reactive and proactive execution modes.

### Added
- **`bootstrap.sh` Zero-Touch Config:** `bootstrap.sh` now features an interactive toggle to automatically configure the EngineClaw instance, clone its binaries, and link its state arrays.
- **Dual-Brain Alignment:** Explicit hardlinking mapping constructed between EngineClaw's internal workspace cache and the robust `~/gtm-brain` and `~/ceo-brain` models.

### Changed
- **`README.md`** — Updated documentation scaling EngineClaw Runtime injection details.
- **`bootstrap.sh`** — EngineClaw conditional parsing added to the installer lifecycle.


## 2026-04-12 2:25 PM PT — v1.12.0 — Dual-Brain Data Segregation

### Why it matters
The original `~/brain` directory natively combined both personal executive data (voice models, delegation matrices, meeting prep) and organizational capability data (pipeline revenue, ad campaigns) into a single node. In `v1.12.0`, the monolith has been refactored into the "Dual-Brain System." The CEO Enablement Kit now strictly isolates the active GTM state (`~/gtm-brain`) from the CEO's personal configuration identity (`~/ceo-brain`). This allows portfolio CEOs running multiple concurrent organizations to operate cleanly without capability cross-pollination. 

### Added
- **Dual-Brain Boot Sequence**: `bootstrap.sh` now independently maps and protects `~/ceo-brain` vs `~/gtm-brain` during the executive installation.
- **Context Multiplexer**: The `session-start.py` Claude hook now scans and binds the state of both data models concurrently to compose the `context` without colliding entity mappings.
- **Governance Refactoring**: `AGENT.md` Rule 0 and Rule 3 strictly mandate all skills to execute writes based on classification (Corporate signals write to GTM; Identity signals write to CEO).

### Deprecated
- `~/brain/` is entirely dismantled and deprecated out of all 49 skills, system prompts, hooks, and documentation templates.

## 2026-04-12 2:10 PM CT — v1.11.0 — White-Glove Intake & Entity Deduplication

### Why it matters
This release elevates the CEO Enablement Kit from a developer scaffold to an enterprise-grade "White-Glove" executive experience. It eliminates the manual text configuration prompts and implements a zero-touch agentic boot process that immediately runs a 4-phase ecosystem, delegation, and voice calibration wizard. Additionally, it integrates ML-based record linkage (Dedupe) to eliminate fragmented CRM entity data across the GFV ontology, and solidifies 3 new prompt-engineering constraints to prevent agent overfitting and boilerplate scripting.

### Added
- **`skills/onboard/SKILL.md`** — Completely rewrote the interactive wizard to extract the CEO's tech stack (Ecosystem Map), reporting structure (Delegation Map), and authenticate voice via URLs, culminating in a demonstration of immediate calendar MCP power.
- **`AGENT.md`** — Injected "Rule 0: Zero-Touch Boot Setup", enforcing the immediate payload execution of `/onboard` without requiring copied prompt text.
- **`SKILL-AUTHORING-STANDARD.md`** — Formally codified Pattern 29 (The Overfitting Barrier), Pattern 30 (Specialized Tool Isolation / Anti-Boilerplate), and Pattern 31 (Root-Cause Failure Grouping).
- **`tools/gfv-dedupe.py` & `skills/dedupe-entities/SKILL.md`** — Added headless Python utility and associated execution skill for interactive active-learning matching of disjointed CRM, PandaDoc, and Linear datasets.

### Removed
- **`ONBOARDING_PROMPT.md`** — Deleted the legacy, manual copy-paste mechanism for onboarding.

### Changed
- **`bootstrap.sh`** — Refactored to provide clean, silent initialization parameters rather than outputting manual payload instructions.

## 2026-04-11 12:10 PM PT — v1.10.0 — System Resilience Protocol

### Why it matters
This release closes the final two structural vulnerabilities in the GFV Enterprise OS. First, it implements a headless daemon (`pil_morning_digest.py`) allowing the agentic OS to synthesize CRM/Linear data entirely behind the scenes without requiring an active chat session. Second, it enforces "Untrusted DOM Paranoia" to prevent malicious Prompt Injection from parsing third-party web properties.

### Added
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 28: Prompt Injection Barrier (Untrusted DOM). Banned the primary orchestrator from directly parsing untrusted external DOMs and mandated sandboxed subagent extraction.
- **`gfv-brain/scripts/pil_morning_digest.py`** — Created the headless Orchestrator daemon that sequentially sweeps Linear, HubSpot APIs, and WhatsApp to update the PIL without active user context.
- **`.agents/skills/ui-ux-pro-max/`** — Installed the core intelligence engine to mathematically enforce frontend aesthetics.

### Files Modified
- CHANGELOG.md, README.md, SKILL-AUTHORING-STANDARD.md
- gfv-brain/scripts/pil_morning_digest.py, .agents/skills/REGISTRY.md

## 2026-04-11 12:05 PM PT — v1.9.0 — Structural Map Priority

### Why it matters
Extracting the final critical architectural parameter from the dotmack `claude-mem` codebase, this release officially eradicates the most common cause of context window degradation: the raw file dump. Agents are now mathematically barred from reading massive files purely to navigate them. They must index line bounds via AST/headers before loading line-specific implementations.

### Added
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 27: Structural Map Priority (Anti-File-Dump) mandating the `Index -> Outline -> Unfold` orchestration loop strictly over raw full-file extraction logic.

### Files Modified
- CHANGELOG.md, README.md, SKILL-AUTHORING-STANDARD.md

## 2026-04-11 11:58 AM PT — v1.8.0 — The Subagent Verification Protocol

### Why it matters
This release systematically eliminates "Orchestrator Hallucination" by grafting four core patterns extracted from the dotmack `claude-mem` codebase. It fundamentally alters the agent execution loop by removing execution authority from the main orchestrator, mandating evidence-based subagent reporting, and enforcing isolated post-execution verification to mathematically guarantee commit integrity.

### Added
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 23: The Subagent Reporting Contract to enforce hard citations (file paths, exact APIs) from any data-gathering step.
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 24: Phase 0 Documentation Discovery to require explicit, isolated API verification prior to any code generation.
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 25: Progressive Disclosure Memory Loop to enforce 10x token efficiency (Index -> Timeline -> Fetch) for all search tools.
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 26: Post-Execution Verification Isolation to mandate parallel verification and anti-pattern grep checks before an agent can commit.
- **`.agents/workflows/pil-context-synthesis.md`** — Mandated Progressive Disclosure 3-Layer fetching parameters for all PIL querying commands.

### Files Modified
- CHANGELOG.md, README.md, SKILL-AUTHORING-STANDARD.md
- /workflows/pil-context-synthesis.md (outside repo, internal state)

## 2026-04-11 11:55 AM PT — v1.7.0 — Deep Infrastructure Safeguards

### Why it matters
This release completes the Frontier OS architecture implementation by addressing the final systemic vulnerabilities discovered during the leak payload analysis. It hardens visual/browser execution against prompt injection, introduces native background execution capability, and enforces a compression framework ensuring the parent agent process never suffers context degradation or OOM when handling massive enterprise data dumps.

### Added
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 20: Untrusted UI / Browser Paranoia to enforce strict bounds on executing text scraped via the DOM, preventing injection attacks.
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 21: Context Paging (The Memento Protocol) and shipped its native tool `tools/gfv-memento.py` to allow orchestrators to compress multi-megabyte payloads to local memory safely.
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 22: The Generalist Sponge (Headless Offloading) and shipped its native tool `tools/gfv-generalist.sh` to allow the orchestrator to offload any loop >5 steps to the background via `nohup` python execution, preserving chat responsiveness.

### Files Modified
- CHANGELOG.md, README.md, SKILL-AUTHORING-STANDARD.md
- tools/gfv-memento.py, tools/gfv-generalist.sh

## 2026-04-11 11:47 AM PT — v1.6.0 — The "Frontier OS" Hardening

### Why it matters
This release incorporates the state-of-the-art meta-agentic constraints found in leaked system prompts from frontier models (Claude Code, OpenAI Codex, GPT-5 Agent Mode, Gemini CLI). It strictly enforces contextual economy, hard execution barriers for high-risk operations, and zero-chitchat commands, elevating the Kit from a robust advisory harness into an enterprise-grade autonomous operating system that mirrors internal orchestration at Anthropic and Google.

### Added
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 18: Speculative Parallelism (Turn-Penalty Heuristic) ensuring zero back-and-forth wasted context turns by blasting parallel queries upfront.
- **`SKILL-AUTHORING-STANDARD.md`** — Added Pattern 19: Git Failsafe (Truncate-Don't-Amend) enforcing a strict ban on `git commit --amend` to protect repository histories.
- **`SKILL-AUTHORING-STANDARD.md`** — Upgraded Pattern 17 (Score 4 & 5 tasks) with the "EnterPlanMode" execution barrier preventing execution token burn without user approval.

### Changed
- **`workflows/session-protocol.md`** — Added the Zero Chitchat (High-Signal Output) boundary. Banned conversational filler ("Done", "Got it") and arbitrary time estimates. Emphasized flat UX constraints.
- Promoted `README.md` to version 1.6.0 reflecting the new Frontier OS constraints.

### Files Modified
- CHANGELOG.md, README.md, SKILL-AUTHORING-STANDARD.md
- ../.agents/workflows/session-protocol.md

## 2026-04-11 11:30 AM PT — v1.5.1 — Meta-Agentic Hardening

### Why it matters
This patch release implements the advanced "Context Engineering" and "Reflexion" mechanisms required to resolve context degradation (hallucinations resulting from oversized prompt windows) and eliminate unverified assumptions within the agent runtime. It establishes the "Ruthless Gatekeeper" identity constraint and formalizes a multi-persona LLM-as-a-Judge mechanism.

### Changed
- **`skills/verify-execution`** — Enforced the **Dependency & Impact Verification (HARD RULE)**. The agent now acts as a Ruthless Gatekeeper, strictly bound to verify downstream dependencies before declaring an execution complete.
- **`skills/chief-of-staff`** — Added the **Task Complexity Triage** protocol, forcing deep validation on highly complex inputs instead of immediately auto-resolving.
- **`skills/deal-review`** — Added strict gatekeeping constraint: agents must assume stale deals are dead until proven otherwise, rejecting optimistic CRM statuses.
- **`skills/email-composer` & `skills/outreach-sequence`** — Implemented the **3-Persona Sequence Quality Critique (LLM-as-a-Judge)** loop: Requirements Validator, Solution Architect, and Quality Reviewer must independently co-sign high-stakes outbound emails or sequences.
- **`workflows/pil-context-synthesis.md`** — Codified the **4-Bucket Context Degradation Framework**: Write, Select, Compress (Observation Masking), and Isolate. Enforced RULER U-curve limitations and the strict "Truncate, Don't Correct" rule to avoid context poisoning.

## 2026-04-11 10:50 AM PT — v1.5.0 — Battle-Tested Skill Elevation

### Why it matters
This release takes 9 core operational skills from "report mode" to "resolve mode" by integrating battle-tested patterns from two production founder operating systems: Ryan Carson's clawchief (daily autonomous chief-of-staff for Untangle) and kevinrgu's autoagent (autonomous agent engineering harness). The kit also gains the experiment-loop skill (scientific method for business optimization), a comprehensive SKILLS-REGISTRY with 48 skills categorized and cross-referenced, and every operational skill now enforces source-of-truth grounding and action-first behavior.

### Added
- **`skills/experiment-loop`** — Scientific method for any CEO initiative: baseline → one change → measure → keep/discard → repeat. Keep/discard ledger, overfitting test, simplicity criterion, failure analysis framework. Inspired by autoagent's autonomous hill-climbing methodology.
- **`SKILLS-REGISTRY.md`** — Complete registry of all 48 skills across 6 categories (Execution Infrastructure, C-Suite Advisory, Revenue Enablement, Document Processing, Daily Operations, Growth Engine). Includes trigger phrases, composition patterns (skill chains), design principles, and full source attribution.

### Elevated (v1 → v2)
- **`skills/chief-of-staff`** — 3-layer architecture from clawchief: Priority Map (P0-P3 urgency) → Auto-Resolver (4 resolution modes: auto-resolve / draft-first / escalate / ignore) → Heartbeat (orchestration). Meeting notes ingestion pipeline, inbox clearing rules with auto-handle/escalate boundary, safe auto-resolve lane.
- **`skills/post-meeting-brief`** — "Not handled until outputs are in the system" rule: meeting notes are only processed when tasks are in Linear, deals updated in HubSpot, follow-ups on calendar, and follow-up email drafted. Auto-resolve bias for operational follow-ups.
- **`skills/pipeline-pulse`** — Resolve-first: for every stalled deal, draft the follow-up and create the task in the same turn. Structured follow-up cadence (2d → 5d → 7d → stop and escalate). Source-of-truth enforcement: tracker updated in same turn as action.
- **`skills/weekly-ceo-brief`** — Resolve during synthesis: create tasks, draft emails, update systems while building the brief. Open loops resolved, not just listed. Simplicity criterion: scannable in < 3 minutes.
- **`skills/deal-review`** — Autoagent failure taxonomy (7 diagnosis patterns: wrong contact, missing capability evidence, weak info gathering, bad execution, missing verification, silent failure, priority shift). Overfitting test: "If this exact deal disappeared, would this still be worthwhile?"
- **`skills/verify-execution`** — Full failure taxonomy, overfitting test, simplicity criterion. "Not verified until captured" rule: saying "it works" ≠ verified, only captured runtime output = verified.
- **`skills/email-composer`** — Source-of-truth gathering before drafting, clawchief thread rules (reply in-thread, preserve CC), auto-resolver draft-first boundary, reply templates for scheduling/follow-up/holding.
- **`skills/outreach-sequence`** — Structured follow-up cadence with CRM update at every touch. Pre-launch verification checks. Experiment-loop integration: every sequence is an experiment tracked in the ledger.
- **`skills/meeting-prep`** — Confidence tags (🟢 verified / 🟡 inferred / 🔴 assumed). Open loop detection from previous interactions. Post-meeting handoff instructions.

### Design Patterns Integrated
- **Resolve, don't summarize** — Every skill should DO work, not just report (clawchief)
- **Source of truth or bust** — Always ground in live systems, never memory alone (clawchief)
- **One variable per experiment** — From experiment-loop, but applies everywhere (autoagent)
- **Not handled until in the system** — Reading ≠ Processing (clawchief)
- **Failure taxonomy** — 7 diagnosis categories for debugging any failure (autoagent)
- **Overfitting test** — "Would this still help if the exact case disappeared?" (autoagent)
- **Simplicity criterion** — Same result + simpler approach = keep simpler (autoagent)

### Files Modified
- CHANGELOG.md, README.md, SKILLS-REGISTRY.md (new)
- skills/experiment-loop/SKILL.md (new)
- skills/chief-of-staff/SKILL.md, skills/post-meeting-brief/SKILL.md
- skills/pipeline-pulse/SKILL.md, skills/weekly-ceo-brief/SKILL.md
- skills/deal-review/SKILL.md, skills/verify-execution/SKILL.md
- skills/email-composer/SKILL.md, skills/outreach-sequence/SKILL.md
- skills/meeting-prep/SKILL.md

## 2026-04-11 8:40 AM PT — v1.4.0 — CEO Enablement Infrastructure

### Why it matters
This release transforms the GFV Enablement Kit from an advisory skill collection into a governed orchestration platform. CEOs now get inter-agent communication standards (preventing circular reasoning and groupthink), two-layer decision memory (so rejected proposals don't resurface), cascading risk modeling (modeling compound adversity across all business functions), and competitive intelligence systems. The chief-of-staff orchestrator was upgraded to v2.0 with 34-skill awareness, 5-phase consultation protocol, and formal quality verification loops before any output reaches the founder.

### Added
- **`skills/agent-protocol`** — Inter-agent communication standard: invoke/response syntax, loop prevention (depth=2, no circular), 4-step quality verification loop (self-verify → peer-verify → critic pre-screen → course correction), 3 standardized output formats, 10 non-negotiable communication rules
- **`skills/context-engine`** — Company context loading with staleness detection (<30d/30-90d/>90d confidence tiers), privacy/anonymization rules, enrichment loop for capturing new context mid-session, /cs:setup onboarding questionnaire, PIL/HubSpot/Linear integration
- **`skills/decision-logger`** — Two-layer decision memory: Layer 1 (raw transcripts, never auto-loaded), Layer 2 (approved-only decisions, loaded every session). DO_NOT_RESURFACE enforcement, conflict detection before logging, supersession tracking, /cs:decisions and /cs:review slash commands
- **`skills/scenario-war-room`** — Cascading multi-variable risk modeling (max 3 variables): domain impact mapping across all C-suite roles, cascade effect mapping with interrupt points, 3 severity levels (base/stress/severe), early warning signals, hedging strategies with cost/impact/owner/deadline, stage-specific templates (pre-seed through Series B+, home services)
- **`skills/competitive-intel`** — 5-layer competitive intelligence: competitor identification (2x2 threat matrix), 8-dimension tracking, analysis frameworks (SWOT, positioning maps, feature gap analysis), battlecard templates for sales, intelligence cadence (monthly scheduled + triggered events), win/loss analysis framework
- **`skills/google-doc-creation`** — Professional Google Docs creation with branded styling via service account
- **`skills/ceo-advisor`** — CEO strategic advisor with GFV portfolio context
- **`skills/cfo-advisor`** — CFO financial advisor with burn/runway/fundraise frameworks
- **`skills/coo-advisor`** — COO operational advisor with process/OKR/scaling guidance
- **`skills/cmo-advisor`** — CMO marketing advisor with channel/brand/GTM strategy
- **`skills/cro-advisor`** — CRO revenue advisor with pipeline/pricing/sales methodology
- **`skills/founder-coach`** — Founder psychology, co-founder dynamics, personal development
- **`skills/executive-mentor`** — Stress-testing, pre-mortem analysis, career navigation
- **`skills/board-deck-builder`** — Board/investor update deck construction
- **`skills/change-management`** — Organizational change, reorg, pivot communications
- **`skills/launch-strategy`** — Product/service launch playbooks
- **`skills/financial-analyst`** — Financial modeling, ratio analysis, valuation
- **`skills/deal-review`** — Deal evaluation and pipeline health checks

### Changed
- **`skills/chief-of-staff`** — Major upgrade to v2.0: formal `[INVOKE:role|question]` syntax, 5-phase multi-role consultation protocol (framing → isolation → critique → synthesis → decision), 34-skill routing matrix, decision-logger integration, agent-protocol quality enforcement, loop prevention rules
- **`SKILL-AUTHORING-STANDARD.md`** — Added Patterns 10-12: agent protocol compliance, standard output format specs (single-role, proactive alert, multi-role synthesis), decision memory integration requirement
- **`skills/project-release`** — Upgraded with GitHub Releases via `gh` CLI, PT timezone enforcement, "Why it matters" requirement, Files Modified mandate, comprehensive README quality gate
- **`README.md`** — Promoted to v1.4.0 with comprehensive CEO-first documentation

### Files Modified
- CHANGELOG.md, README.md, SKILL-AUTHORING-STANDARD.md
- skills/agent-protocol/SKILL.md, skills/context-engine/SKILL.md, skills/decision-logger/SKILL.md
- skills/scenario-war-room/SKILL.md, skills/competitive-intel/SKILL.md
- skills/chief-of-staff/SKILL.md, skills/ceo-advisor/SKILL.md
- skills/cfo-advisor/SKILL.md, skills/coo-advisor/SKILL.md, skills/cmo-advisor/SKILL.md
- skills/cro-advisor/SKILL.md, skills/founder-coach/SKILL.md, skills/executive-mentor/SKILL.md
- skills/board-deck-builder/SKILL.md, skills/change-management/SKILL.md
- skills/launch-strategy/SKILL.md, skills/financial-analyst/SKILL.md
- skills/deal-review/SKILL.md, skills/google-doc-creation/SKILL.md
- skills/project-release/SKILL.md

## 2026-04-10 4:53 PM PT — v1.3.0 — Autonomous Execution Hardening

### Why it matters
This release hardens the GFV Enablement Kit from a static prompt library into a self-monitoring autonomous agent framework. CEOs now have native tooling for token cost visibility, secure deployment reviews, and persistent memory consolidation — closing the gap between ad-hoc AI usage and governed, repeatable execution.

### Added
- **`tools/ccflare.py`** — Local executive dashboard for real-time Claude token burn tracking, including cache creation/read costs
- **`tools/gfv-dream.sh`** — Autonomous memory consolidation script that parses Claude `.jsonl` session logs and compresses insights into durable knowledge
- **`skills/review-pr`** — 3-pass deployment review skill (Security, Logic, GTM Strategy) modeled on Anthropic's internal security protocols
- **`tools/lint-agent.sh`** — AST integrity validator for `AGENT.md` to prevent silent IDE tooling failures
- **`skills/project-release`** — Governed release workflow for version management
- **`skills/verify-execution`** — Post-task verification skill
- **`skills/onboard`** — Zero-friction CEO onboarding skill

### Changed
- **`AGENT.md`** — Formally adopted multi-model agent routing, multi-agent pipelining, and parallel planning frameworks
- **`skills/autoresearch`** — Now requires explicit "Interview Phase" before applying environment mutations
- **`ONBOARDING_PROMPT.md`** — Updated for v1.3.0 capabilities
- **`bootstrap.sh`** — Refined for new tool registrations
- Promoted `README.md` to version 1.3.0

### Files Modified
- AGENT.md, CHANGELOG.md, ONBOARDING_PROMPT.md, README.md, bootstrap.sh
- skills/autoresearch/SKILL.md, skills/onboard/SKILL.md, skills/project-release/SKILL.md
- skills/review-pr/SKILL.md, skills/verify-execution/SKILL.md
- tools/ccflare.py, tools/gfv-audit.sh, tools/gfv-dream.sh, tools/gfv-ralph.sh, tools/lint-agent.sh


## 2026-04-10 8:10 AM PT — v1.2.0 — Awesome Claude Edition

### Added
- Integrated `claude-mem` for persistent background vector-database memory across sessions natively via `bootstrap.sh`.
- Added the `/autoresearch` meta-skill for autonomous multi-loop skill evaluation and mutation testing.
- Integrated `ccflare` dashboard for cost and latency token visualization.
- Implemented `Dippy` friction removal to auto-approve non-destructive system tools.
- Included the "Ralph" (`tools/gfv-ralph.sh`) background execution loop.
- Wrote `guides/prompt-eval-guide.md` to standardize custom binary evaluations.

### Changed
- Promoted `README.md` to version 1.2.0, documenting all new awesome-claude capabilities.
- Redefined `AGENT.md` to mandate proactive consumption of `# search`, `# timeline`, and `# get_observations` memory events prior to polling the user.

## 2026-04-09 7:44 PM PT — v1.1.0 — Agent Agnostic Universal Architecture

### Added
- `ONBOARDING_PROMPT.md` template for zero-friction agent spinning and quickstarts.
- `tools/gfv-cost-estimator.sh` to estimate LLM costs on large payloads (CRM files/exports).
- `claude_settings.template.json` logic for automated guardrails mapping.

### Changed
- Converted `CLAUDE.md` to `AGENT.md` (universal context rules).
- Refactored `bootstrap.sh` to dynamically link the `AGENT.md` to `.cursorrules` and `CLAUDE.md` contexts simultaneously.
- Refactored `bootstrap.sh` to conditionally symlink skills into `.claude/skills` only if Claude is detected.
- Updated README to reflect universal availability across Claude Code, Cursor, and Gemini architectures.

## 2026-04-09 6:50 PM PT — v1.0.0 — Initial Release: Enablement Kit Foundation

### Added
- Core enablement `README.md` containing full architecture reference.
- `bootstrap.sh` script for rapid setup and symlinking of the environment.
- Foundational `skills/` directory (email-composer, meeting-prep, pipeline-pulse).
- Foundational `workflows/` directory (weekly-pipeline-review, outreach-cadence, meeting-day).
- Pre-send review hook implementation for communication safety.
