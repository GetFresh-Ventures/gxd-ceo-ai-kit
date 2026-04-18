# Changelog

All notable changes to the GetFresh GTM Enablement Kit for AI will be documented in this file.

## 2026-04-17 8:29 PM PT — v1.34.0 — External Skill Consolidation (13 Repos → 80 Skills)

### Why it matters
This release completes a comprehensive audit and consolidation of 13 external open-source SEO and marketing repositories into the kit. Instead of blindly importing, we deep-mined each repo for non-redundant tactical methodologies and folded them into existing skills — the domain-consolidation model. All 80 skills now pass the 12-point `import-skill` verification pipeline (file integrity, installer parity, doc coverage, proprietary leak scan, quality bar).

### Added
- **`skills/paid-ads-strategy/`** — PPC campaign strategy, bidding, audience targeting, and ROAS optimization across Google Ads, Meta, LinkedIn. Source: kostja94/marketing-skills.
- **`skills/partnership-marketing/`** — Co-marketing, affiliate programs, technology partnerships, and partner ecosystem development. Source: kostja94/marketing-skills.
- **`skills/programmatic-seo/`** — Template-based SEO pages at scale: location pages, comparison pages, integration pages, data-driven landing pages. Source: kostja94/marketing-skills.
- **`skills/entity-optimizer/`** — Entity-first SEO for Knowledge Graph presence, entity linking, Knowledge Panel optimization, and semantic entity relationships. Source: aaron-he-zhu/seo-geo-claude-skills.

### Enhanced (Methodology Imports from External Repos)
- **`ai-search-optimizer`** (+228 lines) — Added Princeton GEO 9 Optimization Methods with exact % boosts (Citations +40%, Statistics +37%, Keyword Stuffing -10%), AI platform ranking factor weights for ChatGPT/Perplexity/Google AI/Copilot, Query Fanout competitive analysis workflow, 230-rule audit coverage taxonomy, AEO 100-point scoring, robots.txt AI crawler rules, llms.txt standard, and GEO drift tracking.
- **`seo-growth`** (+52 lines) — Added P0/P1/P2 priority classification for technical SEO checks, AI bot access as P1, Bing indexing for Copilot, IndexNow protocol, GSC cannibalization detection, striking distance keywords, Z-score anomaly detection, and opportunity matrix.
- **`eeat-content-pod`** (+59 lines) — Added E-E-A-T weighted scoring framework (Dec 2025 update), industry impact data, YMYL topic standards, and CORE-EEAT publish-readiness veto checks.
- **`seo-audit`** (+54 lines) — Added 100-point content quality scoring checklist across 7 categories (title, meta, headings, depth, intent, technical, readability).
- **`content-strategy`** (+42 lines) — Added content decay lifecycle management with detection triggers, triage matrix, refresh templates, and Google freshness signals.

### Source Attribution
| Source Repo | What We Took |
|-------------|-------------|
| kostja94/marketing-skills | 3 new skills (paid-ads, partnerships, pSEO) |
| aaron-he-zhu/seo-geo-claude-skills | 1 new skill (entity-optimizer), GEO drift, content decay, EEAT veto |
| ReScienceLab/opc-skills | Princeton GEO methods, AI platform ranking factors, P0/P1/P2 system |
| brightdata/geo-ai-agent | Query Fanout 6-step competitive workflow |
| squirrelscan/squirrelscan | 21-category, 230-rule audit taxonomy |
| addyosmani/agentic-seo | AEO scoring, llms.txt, Featured Snippet rules |
| Bhanunamikaze/Agentic-SEO-Skill | E-E-A-T framework, Dec 2025 impact data |
| gbessoni/seobuild-onpage | 100-point content quality checklist |
| saurabhsharma2u/search-console-mcp | GSC intelligence analysis methods |
| JeffLi1993/seo-audit-skill | Deterministic audit checklist patterns |

### Verified
- 80/80 skills pass 12-point pipeline (file, name, bootstrap.sh, bootstrap.ps1, registry, agent-guide, README, leak scan, quality bar, parity, doc coverage, count consistency)
- Installer parity: bootstrap.sh = bootstrap.ps1 = 80 skills
- Doc counts: Disk=80, AGENT-GUIDE=80, REGISTRY=80, GETTING-STARTED=80

## 2026-04-17 7:07 PM PT — v1.33.0 — Kit Integrity Hardening + Skill Imports

### Why it matters
This release is a comprehensive integrity hardening milestone. A 6-pass end-to-end audit across all 75 skills, documentation, and infrastructure scripts purged every instance of client-specific data (ServiceTitan, Aprio, Golden Rule PHC), geographic leaks (Utah, Iowa, Des Moines), personal identifiers, and legacy proprietary system references (PIL, Supabase, CAAI, ccflare) that had leaked into the product codebase during operational skill authoring. The kit now ships as a clean, fully agnostic GFV product — ready for any executive deployment without modification. Additionally, two new skills were imported: `import-skill` (deterministic external skill intake) and `dev-browser` (Playwright-based browser automation).

### Added
- **`skills/import-skill/`** — Deterministic external skill intake with 10-point verification protocol. Ensures any skill imported from GitHub, npm, or raw sources is fully GFV-compliant before registration.
- **`skills/dev-browser/`** — Playwright-based browser automation skill for headless testing, scraping, and UI validation. Includes screen capture, form fill, and navigation capabilities.

### Changed
- **`README.md`** — Added getfreshventures.com URL to header and footer. Clarified this is a GFV product powered by the Growth by Design (GxD) model. Replaced client-specific core integrations with kit-native systems (Linear, HubSpot, Slack, Google Ads, GA4, QuickBooks).
- **`AGENT-GUIDE.md`** — Fixed 4 stale skill name references that pointed to non-existent skill directories.
- **Installer parity** — Both `bootstrap.sh` and `bootstrap.ps1` now register all 75 skills (18 Beginner + 28 Intermediate + 29 Advanced) with identical tier assignments.

### Fixed — 6-Pass Integrity Audit (41 files, 853 insertions)
- **Pass 1 (14 files):** Purged all `PIL`, `Proactive Intelligence`, `pil-server` references from skill author tags and content.
- **Pass 2 (14 files):** Removed `Supabase` backend references, `gfv_memory.db`, `pil_morning_digest.py`, and `entity_embeddings` table names.
- **Pass 3 (2 files):** Removed `ccflare` hardcoded examples and depersonalized `Diraj` name references in `import-skill`.
- **Pass 4 (6 files):** Purged `ServiceTitan`, `CAAI`, `Utah`, `Iowa`, `Des Moines` geography, and client contact name `Greg` from examples.
- **Pass 5 (12 files):** Purged all `Field Service Platform` aliases (the ServiceTitan rename). Added GFV website URL branding.
- **Pass 6 (1 file):** Removed final `PIL` reference in `tools/gfv-brain-search.py` docstring and `aprio` client example query.

### Files Modified
- README.md, AGENT-GUIDE.md, SKILL-AUTHORING-STANDARD.md, CHANGELOG.md
- bootstrap.sh, bootstrap.ps1
- tools/gfv-brain-search.py
- skills/import-skill/SKILL.md, skills/dev-browser/SKILL.md (new)
- skills/eeat-content-pod/SKILL.md, skills/agent-protocol/SKILL.md
- skills/competitive-intel/SKILL.md, skills/ceo-advisor/SKILL.md
- skills/cro-advisor/SKILL.md, skills/coo-advisor/SKILL.md
- skills/voice-model/SKILL.md, skills/copy-master/SKILL.md
- skills/context-engine/SKILL.md, skills/chief-of-staff/SKILL.md
- skills/strategic-decision/SKILL.md, skills/automation-recommender/SKILL.md
- skills/decision-logger/SKILL.md, skills/project-release/SKILL.md
- skills/scenario-war-room/SKILL.md, skills/larry-loop/SKILL.md
- skills/board-deck-builder/SKILL.md, skills/night_shift.md
- 41 files total across 6 audit passes


## 2026-04-16 11:16 PM PT — v1.32.2 — Unbiased Orchestration & Tool Bug Fixes

### Why it matters
This release permanently decouples the kit from legacy proprietary ecosystem dependencies, ensuring true cross-platform neutrality. It patches a catastrophic hallucination logic break mapped across 70+ skills causing memory searches to fail, removes forced Anthropic telemetry binaries from macOS boot sequences, and integrates the new scalable E-E-A-T Content Pod orchestration factory for multi-agent execution.

### Added
- **`skills/eeat-content-pod/`** — Registered new 4-agent orchestration pod into the registry and execution environments.

### Changed
- **`SKILLS-REGISTRY.md` / `bootstrap` scripts** — Scoped the new E-E-A-T capability to the Advanced Tier install targets.

### Fixed
- **`skills/` Manifests** — Programmatic sweep of 70+ files patched the system-wide legacy reference from the non-existent `ceo-brain-search.py` string to the correct `gfv-brain-search.py` physical asset path.
- **`bootstrap.sh`** — Severed forced macOS background installations for `ccflare` and `claude-mem` to adhere strictly to IDE agnosticism flags.
- **`tools/gfv-dream.py`** — Hardened the runtime against relying on personal unreleased Python pipelines, processing native transcript parsing securely via standard I/O pipes.

### Files Modified
- CHANGELOG.md, README.md, SKILLS-REGISTRY.md
- bootstrap.sh, bootstrap.ps1
- tools/gfv-dream.py
- 72 manifest files across the `skills/` directory

## 2026-04-16 10:35 PM PT — v1.32.1 — UX Hardening & Agnostic Compliance

### Why it matters
This patch permanently resolves severe UX friction points and hardcoded agnostic breaks introduced during recent architecture decoupling efforts. It ensures Windows boot sequences are on full feature-parity with macOS, eliminates hallucinated installer file paths for non-guided cloning, and structurally secures the Sherpa Educator feature from getting accidentally overwritten by other skills.

### Changed
- **`bootstrap.sh`** — Eliminated a ghost directory pathing bug where the final step told users to open the non-existent `GTM-Enablement-Kit` folder instead of dynamically referencing the actual cloned repository's name.
- **`bootstrap.ps1`** — Brought Windows fully inline with macOS by injecting the `ide_expertise` selector prompt into the boot sequence, guaranteeing the Dual-Axis Sherpa UX successfully binds for Windows CEOs.
- **`AGENT.md` / Bootstraps** — Scratched proprietary `claude-mem` library references from the core rule set in favor of decoupled generic local memory requirements, and updated `.cursorrules` generation to natively instruct the hook boot sequence, eliminating boot-time errors in non-Anthropic IDEs.
- **`skills/onboard/SKILL.md`** — Sandboxed the JSON read/write flow so that `/onboard` parses and merges into `profile.json` natively instead of overwriting the document and destroying execution settings (like `ide_expertise`).

### Files Modified
- CHANGELOG.md
- bootstrap.sh, bootstrap.ps1
- AGENT.md
- skills/onboard/SKILL.md

## 2026-04-16 4:52 PM PT — v1.32.0 — Agnostic Architecture Decoupling & Educator Persona

### Why it matters
This release fundamentally severs the final dependencies tying the CEO Enablement Kit to proprietary Proactive Intelligence Layer (PIL) structures and specific IDE configurations (like `.claude`), ensuring zero-friction out-of-the-box operation on any CEO's machine. Additionally, it implements a revolutionary UI/UX profiling system that actively teaches non-technical executives how to command an IDE interface via the "Sherpa Protocol," bridging the gap between advanced GTM operations and entry-level coding fluency.

### Added
- **`AGENT.md`** — Injected the "Educator Persona / Sherpa UX" ruleset, dynamically narrating mechanical AI operations (like executing background scripts) in plain English to educate beginners.
- **`ceo-brain/profile.json`** — Deployed dual-axis configuration capability by defining `ide_expertise` as a discrete, independent metric from the operational autonomy tier.

### Changed
- **`bootstrap.sh`** — Introduced a secondary CLI prompt querying IDE Expertise (`Beginner/Intermediate/Advanced`) to cleanly route the UX educational logic entirely independent of their GTM operational tier.
- **`skills/`** — Over 70 skills were scrubbed and refactored via Python AST replacements. Replaced all legacy hardcoded references to `gfv-brain` with the IDE-agnostic `~/ceo-brain` runtime fallback, establishing absolute localization.
- **`skills/onboard/SKILL.md`** — Rewired the initial Interface Orientation logic to trigger conditionally via the new `ide_expertise` integer, streamlining the onboarding for fully-technical founders.
- **`tools/` & `hooks/`** — Bypassed `.claude` configuration pollution. All telemetry and background data stores were forcibly repathed to synchronous `$GFV_CEO_BRAIN/.core/` targets, solidifying cross-IDE compatibility (Cursor/Windsurf).

### Fixed
- **`skills/`** — Swapped broken `linear-mcp-server` protocol dependencies inside the `project-release`, `coo-advisor`, `ceo-advisor`, and `board-deck-builder` skills in favor of flawless Python REST implementations.
- **`bootstrap.ps1` & Documentation** — Stripped lingering explicit absolute pathing mapping back to native `$HOME` instances.

### Files Modified
- CHANGELOG.md, README.md, bootstrap.ps1, AGENT.md
- bootstrap.sh
- tools/gfv-telemetry.py, tools/gfv-dream.py, tools/ccflare.py, tools/gfv-brain-search.py, tools/gfv-audit.py
- hooks/session-start.py, hooks/session-stop.py, hooks/pre-send-review.py
- 72 target elements in the `skills/` directory (e.g., project-release, onboard)


## 2026-04-16 3:06 PM PT — v1.31.1 — GxD Rebranding Finalization

### Why it matters
This patch completes the full structural alignment of the kit around the **Growth by Design (GxD)** architectural doctrine. We executed a total eradication of the localized "CEO Enablement Kit" nomenclature across all executable paths, terminal UI prompts, and physical dotfiles—solidifying this repository as the definitive **GetFresh GTM Enablement Kit**.

### Fixed
- **Clone Architecture & Onboarding Paths:** Repathed the primary structural installation directories inside `bootstrap.sh`, `bootstrap.ps1`, and the core documentation from `CEO-Enablement-Kit` to `GTM-Enablement-Kit` to ensure zero fragmentation between the brand philosophy and the physical system pathways.
- **Python Hook Syntax Errors:** Resolved a critical execution fault missing an `except` block inside the `session-stop.py` lifecycle hook, preventing catastrophic CLI crashes when memory saving fails during IDE termination. 

### Files Modified
- `README.md`, `GETTING-STARTED.md`, `CHANGELOG.md`, `LICENSE`
- `bootstrap.sh`, `bootstrap.ps1`
- `AGENT.md`, `AGENT-GUIDE.md`
- `hooks/pre-send-review.py`, `hooks/session-start.py`, `hooks/session-stop.py`
- `tools/gfv-ralph.sh`
- `SKILLS-REGISTRY.md`, `SKILL-AUTHORING-STANDARD.md`
- `skills/onboard/SKILL.md`, `skills/project-release/SKILL.md`

## 2026-04-15 10:14 PM PT — v1.31.0 — Zero-Configuration Onboarding & Auto-Installers

### Why it matters
The previous onboarding funnels assumed an engineering baseline—requiring SSH keys, Node.js installations, and command-line familiarity. This alienated our core demographic of non-technical executives. In v1.31.0, we have overhauled the pipeline to deliver a literal "Zero-Click" onboarding experience. The bootstrap script itself now acts as a silent package-manager, automatically downloading and compiling Cursor or Claude Code, resolving dependencies (like NVM/Node 20), and dynamically creating visible project structures so an executive goes from a fresh laptop to a live AI Chief of Staff in under 60 seconds.

### Added
- **AI Agent Auto-Installers:** Injected native `curl`/`unzip` hooks and `nvm`/`node.js` dependency resolution chains into `bootstrap.sh`. The kit now seamlessly downloads MacOS Cursor Universal binaries or globally installs `@anthropic-ai/claude-code` completely under the hood, depending on the executive's preference.

### Changed
- **Visual Clone Pathing:** Relocated the foundational clone target from the hidden `~/.gfv_growth_by_design` directory to a highly visible `~/Documents/GTM-Enablement-Kit` path.
- **HTTPS Git Routing:** Eliminated the SSH `git@github.com` clone requisite that previously returned `Permission Denied` exceptions for business users, pivoting to unrestricted HTTPS routing.
- **Documentation Restructure:** Overhauled `GETTING-STARTED.md` and `README.md` to omit CLI engineering instructions and instead utilize explicit, UI-driven navigation (e.g. `File > Open Folder`) to natively activate dotfile workspaces inside Cursor.

## 2026-04-15 06:10 PM PT — v1.30.0 — Hyper Capability & Swarm Execution

### Why it matters
This release fundamentally evolves the AI assistant into a proactive, parallel-execution operating system. By removing dependency on external remote intelligence layers, the kit now ships with a 100% offline edge-native Swarm dispatch tool and an embedded Full-Text Search (FTS) SQLite memory cache. These features deliver immense computing scale to the executive without locking their primary terminal or risking data leaks.

### Added
- **Native Local Brain Search**: Built `tools/gfv-brain-search.py`, leveraging Python's built-in SQLite3 FTS5, to instantly index and query historical CEO memory across `~/ceo-brain/` entirely offline. Hooked into `session-stop.py` for automated re-indexing on session close.
- **Background Swarm Dispatcher**: Introduced `tools/gfv-spawn.py` allowing executives to offload massive extraction, web-scraping, and audit tasks into detached sub-processes so the primary terminal remains instantly responsive.
- **Native Git Brain Rollbacks**: `session-stop.py` now wraps local state snapshots in native `git commit` history to establish an immortal rollback net against AI-induced data corruption.
- **Secrets Marshalling**: `tools/gfv-auth.py` gateway enforces credential extraction from 1Password/ENV before execution prevents pipeline breaks mid-flight.
- **Execution Telemetry**: `tools/gfv-telemetry.py` tracks background ROI, usage durations, and success payloads across the local machine.
- **Pytest Governance**: Established strict assertions validating cross-OS locks and auth gateways ensuring absolute parity on major structure checks.
- **Standardized Footers**: Ran recursive scripts replacing all legacy Beginner-tier hardcoded blocks across 18 Advanced templated skills with universal dynamic upgrade paths.

### Stats
6 files changed, +1020/-110 lines.

---

## 2026-04-15 11:35 AM PT — v1.29.0 — DevOps Hardening & CI/CD Governance

### Why it matters
This release transforms the GetFresh GTM Enablement Kit from a localized script toolkit into a scalable, enterprise-grade deployment. By isolating dependencies into self-managed Virtual Environments and standardizing cross-platform OS locking, operational crashes have been virtually eliminated. Additionally, this release implements programmatic governance via GitHub Actions CI and Over-The-Air (OTA) architecture.

### Added
- **Dependency Isolation (venv)**: `bootstrap.sh` and `bootstrap.ps1` now programmatically generate a localized `venv` environment and resolve dependencies against `requirements.txt`, preventing OS PATH/versioning conflicts.
- **GitHub Actions CI/CD Pipeline**: `.github/workflows/validate-skills.yml` was integrated to algorithmically enforce the `SKILL-AUTHORING-STANDARD.md` across the entire repository. This enforces that high-risk skills submitted by developers or AI agents strictly maintain human-loop circuit breakers.
- **OTA Updates Payload**: Added an async GitHub remote tag sweep to the `session-start.py` hook, pushing a proactive upgrade alert to executives who fall behind the main branch.

### Changed
- **Cross-Platform OS Locks**: Eradicated the UNIX-exclusive `fcntl` import from `task_manager.py`, `session-stop.py`, and `gfv-memento.py`. File concurrency is now managed via `portalocker` securing identical parallel resilience for Windows users.
- **Python Standardization**: Ported `gfv-audit.sh`, `gfv-cost-estimator.sh`, and `gfv-dream.sh` completely into native Python format, drastically improving cross-OS stability and execution predictability. Deleted legacy bash scripts.

### Stats
17 files changed, +365/-249 lines.

---

## 2026-04-15 11:15 AM PT — v1.28.0 — Enterprise Hardening (Circuit Breakers & Concurrency)

### Why it matters
The GTM Enablement Kit is now fully enterprise-hardened. This release introduces Human-in-the-Loop circuit breakers to prevent autonomous agents from running high-risk tasks without approval, explicitly implements OS-level file locking to prevent data corruption during multi-agent DAG parallel executions, and automatically provisions IDE-native context rules across Mac and Windows. 

### Added
- **Human-in-the-Loop Circuit Breakers**: `task_manager.py` dynamically intercepts tasks requiring executive approval. Modified `deal-review` and `hubspot-architect` to test this standard via `requires_human_approval: true` frontmatter tags.
- **Verification Gates**: Standardized the `create-skill` template to mandate programmatic self-verification before any agent marks a task complete.
- **IDE Native Integration**: `bootstrap.sh` and `bootstrap.ps1` now automatically generate `.cursorrules` and `.windsurfrules` files to unify the terminal and IDE experience.

### Changed
- **Cross-Platform OS Locks**: Replaced unsafe basic text appends with `fcntl` OS-level file locking blocks in `task_manager.py`, `session-stop.py`, and `gfv-memento.py`. Supports massive swarm parallelism without corruption.
- **Environment Constant Centralization**: Purged all hardcoded string paths (e.g. `~/ceo-brain`) from the hook architecture, replacing them with portable `os.environ` endpoints (`GFV_CEO_BRAIN` and `GFV_GTM_BRAIN`).
- **UTF-8 Encoding Parity**: Swept all python hooks (`session-stop.py`, `gfv-dedupe.py`, `gfv-memento.py`) ensuring `encoding="utf-8"` is explicitly utilized to prevent string mutation crashes on Windows variants.
- **Bash Failsafes**: Bound all global bash utilities (`gfv-audit.sh`, `gfv-cost-estimator.sh`, `gfv-generalist.sh`, `lint-agent.sh`) with strict `set -e` traps.

### Stats
14 files changed, +120/-50 lines.

---

## 2026-04-15 10:28 AM PT — v1.27.0 — Tip Chains + Upgrade Path

### Why it matters
Every skill now guides CEOs to their next logical step, and beginners get proactive nudges to upgrade when they're ready.

### Added
- **Tip chains for ALL 72 skills**: Each skill's "After This Skill" section suggests 2-3 logical next skills with descriptions
- **Upgrade path (3 layers)**:
  - session-start.py: Proactive "Ready for more?" nudge for established beginners
  - 18 beginner skills: "Ready for More?" section with upgrade instructions
  - GETTING-STARTED.md: "Signs You're Ready" table + "What Each Level Unlocks" catalog

### Stats
66 files changed, 468 insertions(+)

---

## 2026-04-15 10:22 AM PT — v1.26.0 — Complete CEO UX Overhaul

### Why it matters
First release focused entirely on CEO ease-of-use. Resolves all 5 UX findings from Phase 11 audit.

### Added
- **short_description**: 72/72 skills now have <60 char descriptions for slash-menu display
- **Quick Start**: 72/72 skills now have "Just say any of these:" with 2-3 natural-language prompts
- **Troubleshooting**: 28 intermediate skills now have Problem/Fix tables
- **--quick flag**: `./bootstrap.sh --quick` for zero-interaction setup (Tier 2 defaults)

### Renamed (CEO clarity)
- `aeo-optimizer` → `ai-search-optimizer`
- `create-prd` → `product-spec`

### Stats
75 files changed, 751 insertions(+), 30 deletions(-)

---

## 2026-04-15 10:15 AM PT — v1.25.0 — CEO UX: Quick Start Prompts

### Added
- **Quick Start** sections added to all 18 beginner-tier skills
- Each skill now tells CEOs exactly what to type: "Just say any of these:"

### Stats
18 files changed, 125 insertions(+)

---

## 2026-04-15 10:06 AM PT — v1.24.0 — Runtime Verification Pass

### Why it matters
First audit pass to actually EXECUTE every hook, tool, and script. Found a critical Python 3.9 crash in task_manager.py that 5 static passes missed.

### Fixed
- **task_manager.py**: Python 3.10+ union type syntax crashed on macOS default Python 3.9
- **12 phantom skill references**: Skills referencing external GFV tools not in this repo
- **lint-claude-md.sh**: grep "invalid character range" regex error

### Also Fixed (full audit)
- **Version strings**: Synced README + GETTING-STARTED to v1.24.0
- **onboard skill**: Added missing "After This Skill" proactive tip chain (last of 18 beginner skills)
- **gfv-generalist.sh**: Fixed shebang from #!/bin/bash to #!/usr/bin/env bash

### Verified Working
session-start.py, session-stop.py, pre-send-review.py, generate_audio.py, ccflare.py, task_manager.py (all 3 modes: linear/dag/debate), lint-agent.sh, lint-claude-md.sh, gfv-cost-estimator.sh, gfv-memento.py

### Files Modified
12 files, ~30 net changes

---

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
The following upgrades were applied to the shared `.agents/skills` directory used by the operational GFV workspace. They are referenced here for release tracking but do not ship as part of the GTM Enablement Kit repo:
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
- **Final Rebranding:** Deeply updated all project identifiers (README, scripts, hooks, documentation) to formally adopt "GetFresh GTM Enablement Kit for AI", aligning with the "Growth by Design" (GxD) GTM model.
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
The original `~/brain` directory natively combined both personal executive data (voice models, delegation matrices, meeting prep) and organizational capability data (pipeline revenue, ad campaigns) into a single node. In `v1.12.0`, the monolith has been refactored into the "Dual-Brain System." The GTM Enablement Kit now strictly isolates the active GTM state (`~/gtm-brain`) from the CEO's personal configuration identity (`~/ceo-brain`). This allows portfolio CEOs running multiple concurrent organizations to operate cleanly without capability cross-pollination. 

### Added
- **Dual-Brain Boot Sequence**: `bootstrap.sh` now independently maps and protects `~/ceo-brain` vs `~/gtm-brain` during the executive installation.
- **Context Multiplexer**: The `session-start.py` Claude hook now scans and binds the state of both data models concurrently to compose the `context` without colliding entity mappings.
- **Governance Refactoring**: `AGENT.md` Rule 0 and Rule 3 strictly mandate all skills to execute writes based on classification (Corporate signals write to GTM; Identity signals write to CEO).

### Deprecated
- `~/brain/` is entirely dismantled and deprecated out of all 49 skills, system prompts, hooks, and documentation templates.

## 2026-04-12 2:10 PM CT — v1.11.0 — White-Glove Intake & Entity Deduplication

### Why it matters
This release elevates the GTM Enablement Kit from a developer scaffold to an enterprise-grade "White-Glove" executive experience. It eliminates the manual text configuration prompts and implements a zero-touch agentic boot process that immediately runs a 4-phase ecosystem, delegation, and voice calibration wizard. Additionally, it integrates ML-based record linkage (Dedupe) to eliminate fragmented CRM entity data across the GFV ontology, and solidifies 3 new prompt-engineering constraints to prevent agent overfitting and boilerplate scripting.

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
