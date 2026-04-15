# Changelog

All notable changes to the GetFresh CEO Enablement Kit for AI will be documented in this file.

## 2026-04-15 9:36 AM PT — v1.23.3 — Beginner Proactive Tip Chains

### Why it matters
3 skills promoted to Beginner in v1.23.1 lacked the "After This Skill" proactive tip chains that guide CEOs to their next action.

### Fixed
- **executive-mentor**: Added tip chain → decision-logger, board-deck-builder, email-composer
- **google-doc-creation**: Added tip chain → sharing, spreadsheet-builder, email-composer
- **spreadsheet-builder**: Added tip chain → google-doc-creation, board-deck-builder, email-composer

All 18 beginner skills now have proactive tip chains.

### Files Modified
3 files, +18 lines

---

## 2026-04-15 9:25 AM PT — v1.23.2 — Documentation Accuracy Sweep

### Why it matters
Third-pass audit found documentation that didn't match reality after the tier list changes.

### Fixed
- **GETTING-STARTED.md**: Beginner count 15→18, Intermediate 45→46, version updated
- **README.md**: Architecture diagram team.json→profile.json, tools table adds Tier column
- **SKILL-AUTHORING-STANDARD.md**: Patterns 21-22 softened from mandating specific tools

### Files Modified
3 files, +20/-18 lines

---

## 2026-04-15 9:15 AM PT — v1.23.1 — Tier List Parity + Stale Reference Cleanup

### Why it matters
Second-pass audit found email-composer (the #1 beginner skill) was never getting installed via bootstrap.sh. Tier skill lists between .sh and .ps1 didn't match.

### Fixed
- **6 skills missing from tier lists**: email-composer, executive-mentor, spreadsheet-builder, google-doc-creation added to Beginner. All 72 skills now assigned (18+28+26) — [GTM-858]
- **bootstrap.sh ↔ ps1 parity**: Both scripts now install identical skills per tier — [GTM-859]
- **Stale paths**: voice-model-guide.md ~/brain/ → ~/ceo-brain/, onboard team.json → profile.json — [GTM-860]
- **Internal tool refs**: AGENT.md Dream Protocol cleaned, AGENT-GUIDE.md tools table adds "Who Uses It" column — [GTM-861]

### Files Modified
6 files, +26/-24 lines

---


## 2026-04-14 7:25 PM PT — v1.23.0 — Full Codebase Audit Remediation

### Why it matters
End-to-end audit of all 113 files in the repo. Found 6 issues across 4 severity levels, fixed all of them.

### Fixed
- **`bootstrap.ps1`** (220→299 lines): Complete rewrite with tier selection, profile/preferences, all templates, tier skills — [GTM-842]
- **`AGENT.md`**: Removed Claude-Mem MCP refs that don't ship, fixed team.json → profile.json — [GTM-843]
- **`references/`**: Removed 331MB of dev data from repo (336MB → ~5MB) — [GTM-844]
- **`README.md`**: 14 old release sections moved to CHANGELOG — [GTM-845]
- **`slack-connector`** (41→161): Full Slack App setup + API commands — [GTM-846]
- **`social-scheduler`** (46→173): Buffer API integration — [GTM-846]
- **`sms-outreach`** (48→187): Twilio + TCPA 3-gate compliance — [GTM-846]
- **`ceo-mindset.md`** (31→86): Real examples, voice model checklist, workflow table — [GTM-847]
- **`prompting-for-executives.md`** (37→100): 10 prompts with explanations + pro-tips — [GTM-847]

### Files Modified
10 files, +920/-330 lines

---


## 2026-04-14 6:30 PM PT — v1.22.1 — Production Skill Ports

### Why it matters
4 advanced skills were stubs with vague instructions. Now they're production-quality with executable commands, concrete examples, and real `task_manager.py` integration.

### Rewritten
- **`automation-recommender`** (50→175 lines): 3-phase analysis with impact/effort scoring matrix — [GTM-805]
- **`feature-architect`** (43→223 lines): 7-phase protocol with DAG-parallel codebase exploration — [GTM-806]
- **`create-skill`** (117→197 lines): Mandatory interview → build → test → register process — [GTM-807]
- **`agent-orchestrator`** (74→284 lines): All 4 modes (Linear, DAG, Debate, Planner-Runner) with executable commands — [GTM-803]

### Files Modified
4 skill files rewritten, +756/-177 lines

---

## 2026-04-14 5:10 PM PT — v1.22.0 — Beginner Experience Hardening

### Why it matters
The entire memory pipeline was broken: session-stop wrote to the wrong directory, hooks couldn't read user preferences, and the executive walkthrough was stale. This release fixes all 12 gaps from the beginner/intermediate audit.

### Fixed (Critical)
- **`hooks/session-stop.py`**: Was writing to `~/brain/` (doesn't exist). Fixed to `~/gtm-brain/` — [GTM-832]
- **`bootstrap.sh`**: Now creates `preferences.json` with tier-aware defaults so hooks work before onboarding — [GTM-833]
- **`hooks/session-start.py`**: Reads preferences.json, shows active features, proactive tips for beginners — [GTM-834]
- **`hooks/session-stop.py`**: Tier-aware auto-save: summaries for beginners, feedback for intermediate, Dream Mode flags for advanced — [GTM-835]
- **`GETTING-STARTED.md`**: Complete rewrite matching Beginner/Intermediate/Advanced system — [GTM-836]

### Fixed (Moderate)
- **14 beginner skills**: Added "After This Skill" proactive tip chains — [GTM-837]
- **`bootstrap.sh`**: Copies all 4 templates (weekly-pulse, meeting-brief) — [GTM-838]
- **Beginner tier**: Swapped `context-prime` (developer tool) for `audio-briefing` (executive tool) — [GTM-839]
- **`contract-reader`**: Added `<private>` tag instruction for claude-mem auto-memory — [GTM-840]
- **Troubleshooting**: Added claude-mem/Bun installation recovery instructions — [GTM-841]

### Files Modified
18 files changed across hooks/, bootstrap.sh, GETTING-STARTED.md, and 14 beginner skills

---

## 2026-04-14 3:30 PM PT — v1.21.1 — Foundational Tools for All Tiers

### Why it matters
Beginners were promised cross-session memory and frictionless UX but the tools that deliver it (claude-mem, Dippy, ccflare) were gated behind Tier 2+. This patch moves all foundational tools to every tier.

### Changed
- **`bootstrap.sh`**: Moved claude-mem, Dippy, and ccflare installation out of Tier 2+ gate — all tiers now get cross-session memory, auto-approve safe commands, and token cost dashboards.
- **`skills/onboard/SKILL.md`**: Updated beginner defaults to include `cross_session_memory`, `auto_approve_safe`, `cost_dashboard`, and `inline_insights`.
- **`README.md`** and **`AGENT-GUIDE.md`**: Added 3 new rows to feature progression tables (claude-mem, Dippy, ccflare).

### Files Modified
- bootstrap.sh, skills/onboard/SKILL.md, README.md, AGENT-GUIDE.md

---

## 2026-04-14 3:20 PM PT — v1.21.0 — Adaptive Onboarding: Beginner/Intermediate/Advanced

### Why it matters
Complete redesign of the onboarding experience. The previous tier system (Novice/Practitioner/Orchestrator) was vague and didn't adapt questions or features to the user's actual experience level. The new system uses clear personas with progressive feature unlocking.

### Added
- **3-level persona system**: Beginner ("Keep it simple"), Intermediate ("Plug into my business"), Advanced ("Full autonomy")
- **Persona-specific setup questions**: Beginners answer 2 questions; Advanced answer 4
- **Progressive feature table**: Visual matrix showing what turns on at each level
- **Level-specific "A-Ha" moment**: Immediate value delivery tailored to each persona after onboarding

### Changed
- **`bootstrap.sh`**: Rewritten installer with visual level selection, selective skill installation (15/45/72), profile.json and preferences.json creation
- **`skills/onboard/SKILL.md`**: Adaptive 6-phase wizard — different questions per level, auto-configures memory/tips/feedback preferences
- **`README.md`**: Simplified for new users — level descriptions with "try this first" suggestions, feature progression table
- **`AGENT-GUIDE.md`**: Updated experience levels section with feature progression table and agent behavior instructions

### Files Modified
- bootstrap.sh, skills/onboard/SKILL.md, README.md, AGENT-GUIDE.md

---

## 2026-04-14 9:15 AM PT — v1.18.1 — Interactive Tier Installer

### Why it matters
Following the v1.18.0 documentation release, this patch physically integrates the 3-Tier Expertise Calibration flow directly into the `bootstrap.sh` CLI installer. This ensures the CEO is prompted to choose their AI comfort level (Novice, Practitioner, Orchestrator) on day one, and their choice is seamlessly passed to the chat-based `/onboard` wizard via persistent memory.

### Added
- **Interactive Expertise Calibration Menu (`bootstrap.sh`)**: Replaced the generic EngineClaw binary prompt with a full 3-Tier selection menu that explains what each tier does.
- **Cross-Boundary State Transfer (`active-tier.txt`)**: The shell installer now locks the executive's Tier choice into `~/ceo-brain/active-tier.txt`. This bridges the context gap so the LLM session natively knows how to handle the CEO upon startup.

### Changed
- **`bootstrap.sh`**: Auto-provisions the EngineClaw daemon exclusively for Tier 3 Orchestrators, preventing feature-bloat for Novice and Practitioner paths.

### Files Modified
- bootstrap.sh, README.md, CHANGELOG.md

## 2026-04-14 9:00 AM PT — v1.18.0 — Security Hardening & Executive Walkthrough

### Why it matters
This release closes two critical gaps: (1) a full credential hygiene sweep removing all hardcoded API secrets from infrastructure scripts and replacing them with OS-native credential store lookups, and (2) the first comprehensive executive onboarding document — `GETTING-STARTED.md` — a 30-minute step-by-step walkthrough designed for non-technical CEOs and senior leaders who are installing the kit for the first time.

### Added
- **`GETTING-STARTED.md`** — Executive Enablement Walkthrough: 30-minute guide covering installation, onboarding wizard phases, first task recommendations, full skill category map, safety guarantees, weekly cadence recommendations, and troubleshooting. Written for non-technical executives.

### Enhanced — Security Infrastructure
- **Credential Hygiene Sweep:** Removed hardcoded Linear API keys from 5 infrastructure scripts across `gfv-brain/`:
  - `scripts/linear_cache.sh` → macOS Keychain lookup
  - `hooks/check-linear-task.sh` → macOS Keychain + graceful fallback
  - `scripts/check-linear-task.sh` → macOS Keychain + graceful fallback
  - `hooks/linear-manager.py` → subprocess Keychain lookup
  - `scripts/pull_transcripts.py` → subprocess Keychain lookup
- **Zero hardcoded secrets remaining** across the entire codebase (verified via `grep -rn 'lin_api_'`)

### Enhanced — 4 Skills (in `.agents/skills`, not this repo)
The following upgrades were applied to the shared `.agents/skills` directory used by the operational GFV workspace. They are referenced here for release tracking but do not ship as part of the CEO Enablement Kit repo:
- **`openclaw-orchestrator`** — Added Auto-Complexity Detection with 11 Routing Codes
- **`security-pii-scanner`** — Added Protected File Patterns and Hardcoded Credential Scanner
- **`gfv-dream-mode`** — Added Three-Phase Memory Protocol with checkpoint resumption
- **`hook-automation`** — Added Protected File Patterns with pre-edit hooks

### Changed
- **`README.md`** — Bumped version to v1.18.0. Updated repo structure section.
- **`bootstrap.sh`** — Updated skill count references.

### Files Modified
- GETTING-STARTED.md (new), CHANGELOG.md, README.md
- gfv-brain/scripts/linear_cache.sh, gfv-brain/hooks/check-linear-task.sh
- gfv-brain/scripts/check-linear-task.sh, gfv-brain/hooks/linear-manager.py
- gfv-brain/scripts/pull_transcripts.py

## 2026-04-14 8:20 AM PT — v1.17.0 — Ruflo Swarm Intelligence Integration (74 Skills)

### Why it matters
Deep-audited 90+ agent skills, 30+ agent definitions, and 21 v3 modules from the [ruvnet/ruflo](https://github.com/ruvnet/ruflo) repository — the most comprehensive open-source agentic orchestration platform available. Extracted 8 high-value patterns and implemented them as production GFV skills, adding multi-agent swarm orchestration, Byzantine consensus for data reconciliation, 4-tier memory hierarchy, SPARC structured planning, lifecycle hooks, PII scanning, dynamic agent spawning, and a meta-skill that builds new skills. This represents the transition from "single-agent" to "multi-agent orchestrated" GTM intelligence.

### Added — 8 New Skills (2 New Categories)

#### 🤖 Agent Intelligence (5 skills)
| Skill | Source Pattern | What It Does |
|-------|---------------|-------------|
| `openclaw-orchestrator` | queen-coordinator + hive-mind | Queen-led coordinator with strategic/tactical/adaptive modes |
| `pil-memory-bus` | memory-coordinator + agentdb-vector | 4-tier memory hierarchy with TTL types and namespace isolation |
| `consensus-reconciler` | byzantine-coordinator + consensus | Byzantine fault tolerance for multi-source data truth |
| `agent-spawner` | swarm-orchestration + swarm-init | Dynamic agent creation with hierarchical anti-drift topology |
| `sparc-planning` | sparc-methodology | 5-phase planning: Specification → Pseudocode → Architecture → Refinement → Completion |

#### 🔒 Safety & Automation (3 skills)
| Skill | Source Pattern | What It Does |
|-------|---------------|-------------|
| `hook-automation` | hooks-automation + @claude-flow/hooks | Pre/post task lifecycle hooks for quality gates |
| `security-pii-scanner` | AIMDS + @claude-flow/aidefence | Automated PII detection and redaction |
| `skill-builder` | skill-builder + template-generator | Meta-skill: auto-generates new GFV-compliant skills |

### Enhanced — Design Principles + Composition Patterns
- Added 2 new design principles: "Hierarchical topology only" and "One brain, many hands" (from ruflo)
- Added 4 new composition patterns: Swarm Intelligence, Data Reconciliation, New Skill Creation, Secure Client Report
- Updated SKILLS-REGISTRY.md to 74 skills across 8 categories (was 66/6)

### Architecture — Anti-Drift Controls
- **Hierarchical only topology**: No mesh/ring patterns that cause agent divergence
- **Status heartbeat protocol**: Agents report status every major decision
- **Output validation**: Coordinator validates every spawned agent's output
- **Timeout enforcement**: Kill any agent exceeding 2x expected duration

### Audit Report
Full technical audit of all 90 ruflo skills available in: `ruflo_integration_audit.md`

## 2026-04-13 8:40 PM PT — v1.16.0 — LarryBrain Marketplace Integration (66 Skills)

### Why it matters
Audited 101 skills from the LarryBrain AI Agent Skill Marketplace. Rejected 73 (security risk, consumer-grade, or raw DevOps infrastructure). Rewrote 11 net-new skills and enhanced 17 existing skills, following strict GFV architectural principles: Resolve-First, Source-of-Truth, Untrusted-DOM-Paranoia, and the Draft-Review-Before-Send gate for all outbound communication.

### Added — 11 New Skills
- **`contract-reader`** — 4-layer legal contract analysis: key terms → obligations → red flags → negotiation leverage. All processing is local LLM with no external API calls to preserve attorney-client privilege.
- **`negotiation-advisor`** — Tactical negotiation frameworks: BATNA analysis, concession architecture, 3-phase flow (prep → table → close), and per-deal battle-card output.
- **`aeo-optimizer`** — Answer Engine Optimization ensuring brand presence in AI-generated answers. 5-step framework with structured data schema and citation architecture.
- **`social-scheduler`** — Multi-channel cross-posting across 28+ platforms with CEO approval gate. Platform-specific adaptation matrix for content transformation.
- **`slack-connector`** — Slack workspace integration for monitoring, posting, searching, and routing critical messages. Auto-summarizes noisy channels for executive-level consumption.
- **`sms-outreach`** — SMS/WhatsApp multi-channel outreach with strict TCPA compliance gates. Multi-carrier support with delivery tracking and opt-out handling.
- **`ugc-video`** — Script-to-video UGC production pipeline with AI talking heads, B-roll sourcing, subtitle burn-in, and platform-specific format optimization.
- **`domain-intel`** — Domain registration intelligence via RDAP: WHOIS, DNS, nameserver, and expiry tracking for competitive analysis and deal research.
- **`voice-synth`** — AI voice synthesis for content narration, podcast intros, and audio newsletters. CEO voice cloning requires explicit opt-in with AI disclosure.
- **`geopolitical-monitor`** — Global intelligence pipeline with country instability scoring (1-10), supply chain impact analysis, and pipeline cross-reference for international business risk.
- **`scheduling-infra`** — Meeting scheduling infrastructure with bookable event templates, availability management, and pre/post meeting automation hooks.

### Enhanced — 17 Existing Skills
- **`social-engine` v1.1** — Added analytics dashboard (post performance tracking, engagement heatmaps), optimal posting time intelligence, thread drop-off analysis, and winner amplification loop.
- **`copy-master` v1.1** — Added narrative submode (5-beat StoryMaster arc) and persuasion tactics layer (social proof, future pacing, loss aversion, authority transfer, specificity anchors, contrast framing).
- **`chief-of-staff` v2.1** — Added 5-minute sprint execution cadence (Sprint OS method) and 4-layer memory architecture (L1 ephemeral → L4 source-of-truth hierarchy).
- **`cron-scheduler` v1.1** — Added 6-layer silent failure diagnostic checklist (Cron Debugger method) and safe registration protocol with dry-run verification.
- **`agent-orchestrator` v1.1** — Added Planner-Runner-Orchestrator pattern for iterative autonomous execution with accept/revise/abort verification loops.
- **`content-strategy` v1.1** — Added A/B hook testing protocol (data/story/contrarian variants) with winner-becomes-template methodology.
- **`decision-logger` v1.1** — Added team activity log with cross-session sync protocol (5 action types: DECISION, CHANGE, DISCOVERY, BLOCKER, HANDOFF).
- **`larry-loop` v1.1** — Added quantitative winner scoring system (100-point scale), format trend detection, and cross-platform winner migration routes.
- **`support-triage`** — Confirmed full coverage of Support Dashboard methodology.
- **`notion-manager`** — Confirmed full coverage of Notion Manager + Notion API patterns.
- **`news-digest`** — Confirmed full coverage of NewsDigest synthesis methodology.
- **`email-composer`** — Confirmed IMAP read capability already integrated.
- **`ui-ux-pro-max`** — Confirmed full coverage of UI/UX-Design-Claw patterns.
- **`google-doc-creation`** — Confirmed Google Docs API integration coverage.
- **`competitive-intel`** — Confirmed full competitive tracking coverage.
- **`seo-growth`** — Confirmed SEO technical coverage including AI search optimization.
- **`financial-analyst`** — Confirmed DCF, ratio analysis, and forecasting coverage.

### Changed
- **`SKILLS-REGISTRY.md`** — Complete rewrite. Now organized across 6 categories with 66 skills, composition patterns, and LarryBrain attribution.
- **`README.md`** — Bumped version to v1.16.0. Updated skill count from 55 → 66. Added all 11 new skills to capability tables.

### Rejected — 73 LarryBrain Skills
72% of marketplace skills rejected for: consumer-grade scope (generic AI wrappers), raw DevOps infrastructure (Kubernetes, Terraform), insecure patterns (unvalidated URL scraping, credential passthrough), or redundancy with existing GFV skills. Full audit documented in `larrybrain_full_audit.md`.

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

---

## Historical Release Notes

### What's New in v1.18.0 (Security Hardening & Executive Walkthrough)
- **Credential Hygiene Sweep:** Removed all hardcoded API keys from 5 infrastructure scripts. All secrets now read from OS-native credential stores (macOS Keychain / Windows Credential Manager) at runtime — zero secrets in source code.
- **Executive Enablement Guide:** Shipped `GETTING-STARTED.md` — a comprehensive 30-minute walkthrough for CEOs and executives covering installation, onboarding wizard, first tasks, skill discovery, safety guarantees, and weekly cadence.
- **Skill Enhancements:** Upgraded 4 core skills with advanced operational patterns: auto-complexity routing (openclaw-orchestrator), protected file gates (security-pii-scanner, hook-automation), 3-phase memory protocol (gfv-dream-mode), and atomic rollback for multi-system operations (hook-automation).
- **Bootstrap Modernization:** Updated installer skill count and documentation to reflect current 74-skill architecture.

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
├── GETTING-STARTED.md               ← Executive enablement walkthrough (start here)
├── README.md                        ← This file
├── SKILL-AUTHORING-STANDARD.md      ← The 31 absolute rules for structural integrity
├── SKILLS-REGISTRY.md               ← Complete skill registry (72 skills, 8 categories)
├── bootstrap.sh                     ← One-command setup script (Mac/Linux)
├── bootstrap.ps1                    ← One-command setup script (Windows)
├── claude_settings.template.json    ← Claude Code settings template
├── skills/                          ← 72 pre-built skills (slash commands)
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
