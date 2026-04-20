---
name: aprio-weekly-report
description: "Generate a professional weekly progress report for the Aprio Board Portal SEO/Content engagement. Covers content deployment (US + Canada geo-targeted pages), SEO infrastructure (structured data, hreflang, backlink disavow), competitive positioning vs BoardEffect/Boardable/OnBoard/Diligent, and pipeline status. Each week picks up from the previous week's action plan. Use when asked for an Aprio report, status update, progress report, or update for Ian/Eugene."
metadata:
  version: 1.0.0
  category: client-reporting
  origin: Golden Rule weekly report skill adapted for Aprio engagement
  triggers:
    - aprio weekly report
    - aprio progress report
    - aprio status update
    - update for ian
    - update for eugene
    - aprio team update
---

# Aprio Weekly Report Skill

Generate a comprehensive, executive-ready weekly progress report for the Aprio Board Portal team — Ian McPhail (CEO), Eugene Gurevich (CTO), and the GFV team.

## When to Activate

- When Diraj asks for an "Aprio report" or "update for Ian"
- End of week recap / sync prep
- Before strategy calls with the Aprio team
- Monthly SEO review cadence

## ⛔ HARD RULE: Do No Harm to Existing Organic Traffic

Organic search is Aprio's primary traffic source. This rule applies to ALL Aprio work — not just reports.

1. **NEVER modify title tags, H1 tags, URL slugs, or content structure on pages that existed BEFORE GFV engagement** (WP ID < 13076) without first reviewing GSC performance data and getting Diraj's explicit approval.
2. **Only additive changes on existing pages** — meta descriptions, OG tags, schema, internal links = safe. Title/heading/content changes = NOT safe without data review.
3. **Pages WE created (WP ID ≥ 13076) are safe to modify** — zero existing organic history.
4. **When in doubt, check GSC first** — if a page has >100 impressions/month, do not touch titles/headings.
5. **Log every change** — maintain a changelog so traffic impact can be traced.
6. **Frame all work as additive** — reports should emphasize what was ADDED, not what was modified on existing pages.

## ⛔ HARD REQUIREMENTS: Pre-Publish Checklist

Every report MUST pass ALL of the following checks before being pushed to the Google Doc. If any item is missing, the report is NOT complete. Do NOT push a partial report.

### Document Structure
- [ ] **Title/Cover Page**: Must use `update_formatted_doc()` with `cover_page=` parameter. Title page includes: title, subtitle, domain, prepared_by, date (with week number), and confidential flag. A report without a title page is REJECTED.
- [ ] **Overwrite existing doc**: Always use `EXISTING_DOC_ID` to update in-place. NEVER create a new document. The canonical doc ID is in the Report Registry below.
- [ ] **Footer**: "GetFresh Ventures · Confidential" footer with page numbers.

### Content Depth (Non-Negotiable)
- [ ] **Section 1 — Executive Context & Baseline State**: Deep narrative on the state BEFORE our work. Must include the 12-month organic traffic trend table, explain what the numbers mean, WHY gaps exist, and why the "Do No Harm" doctrine is critical. This is NOT a bullet list — it's a consulting-grade narrative.
- [ ] **Section 2 — Week N Execution & Strategy Rationale**: Two parts: (a) what we tactically executed, and (b) the deep "WHY" behind each strategic decision. Explain the mechanics: why these pages, why additive, why competitor hubs, why hreflang pairing. Every deployment gets a full manifest table.
- [ ] **Section 3 — Expected Outcomes & Impact**: What the business should expect. Leading vs lagging indicators, indexing velocity, competitive moat implications. Specific timelines.
- [ ] **Section 4 — Forward Plan**: What we need to tackle next, how we plan to address every identified gap (gap-to-strategy mapping table), blockers on the Aprio team, and a planned vs actual execution trace table.
- [ ] **Section 5 — Technical Appendix**: Content deployment counts, Linear issue status, technical SEO component checklist.
- [ ] **Competitive Intelligence**: Competitor table with DR and exploitation strategy.
- [ ] **Backlog & Next Actions**: Blocked items (with owner), planned next steps with dates.
- [ ] **Engagement Status**: Summary metrics — content velocity, total pages, geo coverage, Do No Harm compliance.

### Links & Data Quality
- [ ] **All URLs are clickable absolute links**: Every deployed page URL in tables must use markdown link syntax `[text](https://full-url)` so they render as clickable hyperlinks in Google Docs. Slug-only references are NOT acceptable.
- [ ] **No fabricated data**: If a data source is unavailable, mark it "pending access" — never estimate or guess.
- [ ] **All data verified from source**: Deal status, traffic numbers, and rankings must be pulled from live systems (GSC, GA4, HubSpot, Linear), not from memory.

### Report Continuity
- [ ] **Picks up from previous report**: The action plan from the prior week becomes this week's "Planned vs Actual" section. Read the previous report FIRST.
- [ ] **Cumulative, not incremental**: The report should contain ALL context — baseline, strategy, deployments — not just the delta from last week.

## Quick-Start Workflow

Every report, follow these 5 steps:

```
1. READ previous report from the Report Registry (below)
2. PULL this week's completed Linear issues (filter: title contains "Aprio")
3. PULL live data from GSC, GA4, WordPress inventory, SEMrush
4. GENERATE the report markdown using the template below
5. CREATE Google Doc via create_google_doc.py
```

### Step 1: Read Previous Report

```python
# Always read the previous week's report first.
# The action plan from last week becomes this week's "Planned vs Actual" section.
PREV_DOC_ID = "<get from Report Registry below>"
```

### Step 2: Pull Linear Issues

```python
# Use Linear API to get issues with "Aprio" in title
# Filter: state = "Done" or "In Progress", updatedAt >= last report date
import json, urllib.request
api_key = "lin_api_Zi3MnxJwACVYELvQV2QitS0NPk1TBknapaQZ4eGA"
# Query: issues(filter: { title: { containsIgnoreCase: "Aprio" } })
```

### Step 3: Pull Live Data

```python
# Google Search Console: impressions, clicks, position for deployed pages
# GA4: landing page sessions, organic traffic, conversion events (if GA4 access granted)
# WordPress REST API: page inventory, publish dates, content structure
# SEMrush MCP: domain authority, keyword positions, competitive intelligence
# HubSpot: pipeline deals, contacts (when API token available — GFV-356)
# DO NOT fabricate data — mark "pending access" if source unavailable
```

### Step 4: Generate Report Markdown

Use the template below. Structure: **each report picks up from the previous report's action plan**. Show what was planned vs what was delivered.

### Step 5: Create Google Doc

**Use the `google-doc-creation` skill.** The canonical entry point is `create_formatted_doc()`.

```python
import os, sys
sys.path.insert(0, os.path.expanduser("~/Documents/Code/gfv-brain/scripts"))
from create_google_doc import create_formatted_doc, update_formatted_doc

# ALL reports go in the Aprio folder:
REPORTS_FOLDER_ID = "1YDY5NzVrpIui58xBzTT4jrcFBITv2TWu"
# Google Drive: GetFresh Ventures → Clients → Aprio → Reports → MM-YYYY/

EXISTING_DOC_ID = "1aM7GuFZGa7uEMCTcYExksgWwlOHJJKuFIlOZbQFAy00" # Update this to overwrite an existing doc, or set to None

cover_page_data = {
    "title": "SEO & Content Progress Report",
    "subtitle": "Aprio Board Portal",
    "domain": "aprioboardportal.com",
    "prepared_by": "GetFresh Ventures",
    "date": f"{date_string} — Week {week_number}",
    "confidential": True,
}

if EXISTING_DOC_ID:
    url = update_formatted_doc(
        markdown_content=md_content,
        doc_id=EXISTING_DOC_ID,
        cover_page=cover_page_data
    )
    print(f"Report OVERWRITTEN at: {url}")
else:
    url = create_formatted_doc(
        markdown_content=md_content,
        title=f"Aprio Board Portal — SEO Progress Report — {date_string}",
        folder_id=REPORTS_FOLDER_ID,
        cover_page=cover_page_data
    )
    print(f"Report CREATED at: {url}")
```

## Audience & Tone

| Person | Role | What They Care About |
|--------|------|---------------------|
| **Ian McPhail** | CEO | Revenue impact, competitive positioning, market expansion (Canada), pipeline growth |
| **Eugene Gurevich** | CTO | Technical SEO, site performance, integrations, infrastructure changes |
| **Diraj** | Strategy & Execution | Content velocity, SEO rankings, competitive moat, engagement ROI |

**Tone:** Professional, data-driven, strategic. Every change is framed as **what we did + the competitive advantage it creates**. Aprio is a challenger brand against Diligent/BoardEffect — every report should reinforce how GFV is closing the SEO gap.

## Data Sources

Pull from (in priority order) — **never from memory alone:**
1. **Previous report** — action plan becomes this week's "planned vs actual"
2. **Linear** — Aprio issues completed, status changes
3. **WordPress REST API** — page inventory, content structure, publish dates
4. **Google Search Console** — impressions, clicks, position for deployed pages
5. **GA4** — organic traffic, landing page performance (when access available)
6. **SEMrush MCP** — domain authority, keyword rankings, competitive intelligence
7. **PIL / Memory** — relationship context, prior decisions

## Content Inventory

### WordPress Pages We Manage (as of April 2026)

**US Landing Pages (9):**
| Slug | WP ID | Topic |
|------|-------|-------|
| `landing-board-directors` | 13140 | SEC Cybersecurity for Directors |
| `landing-board-managers` | 13141 | AI Governance for Boards |
| `landing-board-materials-distribution` | 13145 | HIPAA Healthcare Board Portal |
| `landing-board-meeting-minutes` | 13146 | Board Meeting Minutes Legal |
| `landing-board-portal-efficiency` | 13144 | Credit Union NCUA Compliance |
| `landing-board-security` | 13147 | SEC Cyber Incident Response |
| `landing-corporate-secretaries` | 13142 | Corporate Secretary Toolkit |
| `landing-evaluating-board-portal-software` | 13148 | Software Evaluation Checklist |
| `landing-it-security` | 13143 | Zero-Trust Board Portal Security |

**Canadian Landing Pages (9):**
| Slug | WP ID | Regulatory Framework |
|------|-------|---------------------|
| `landing-board-directors-canada` | 13171 | CSA NI 51-102, CBCA s.122, BCE |
| `landing-board-managers-canada` | 13172 | AIDA (Bill C-27), OSFI AI/ML |
| `landing-board-materials-distribution-canada` | 13169 | PIPEDA + provincial health acts |
| `landing-board-meeting-minutes-canada` | 13174 | CNCA s.21, CBCA s.20/s.123 |
| `landing-board-portal-efficiency-canada` | 13170 | FSRA, BCFSA, CUDGC, AMF |
| `landing-board-security-canada` | 13168 | CSA Staff Notice 51-347, OSFI B-13 |
| `landing-corporate-secretaries-canada` | 13173 | CSA SN 51-358, SEDAR+, CBCA s.120 |
| `landing-evaluating-board-portal-software-canada` | 13176 | Canadian compliance checklist |
| `landing-it-security-canada` | 13175 | CCCS, CLOUD Act, data sovereignty |

**TOFU Blog Articles (3 US + 3 Canada):**
| US Slug | CA Slug | Search Vol |
|---------|---------|-----------|
| `news/quorum-for-board-meeting` (blog) | `quorum-board-meeting-canada` (page) | 49.5K |
| `roberts-rules-of-order-quick-reference` | `roberts-rules-of-order-canada` | 22.2K |
| `how-to-write-a-mission-statement` | `how-to-write-a-mission-statement-canada` | 14.8K |

**High-Intent Landing Pages (3):**
| Slug | WP ID | Purpose |
|------|-------|---------|
| `landing-free-trial` | 13076 | Free trial conversion page |
| `landing-roi-calculator` | 13120 | ROI calculator lead gen |
| `landing-compliance` | 13113 | Compliance overview |

**Infrastructure:**
- **hreflang snippet:** WPCode ID 13177 — pairs all 12 US/CA page sets with `en-us`, `en-ca`, `x-default`
- **Structured data:** SoftwareApplication, FAQ, Product schema deployed globally
- **Competitor comparisons:** BoardEffect, Boardable, OnBoard pages refreshed
- **Best Board Portal 2026:** Hub page linking all comparisons

## Competitive Landscape

| Competitor | Domain | DR | Key Weakness to Exploit |
|-----------|--------|-----|------------------------|
| **Diligent** | diligent.com | 70+ | Enterprise-only positioning; Aprio wins on mid-market value |
| **BoardEffect** | boardeffect.com | 50+ | Stale content; we already outrank on some terms |
| **Boardable** | boardable.com | 40+ | Weak Canadian presence; Aprio is bilingual |
| **OnBoard** | onboardmeetings.com | 45+ | Limited regulatory content; our depth wins |
| **BoardPro** | boardpro.com | 30+ | Geographic focus (ANZ); weak in North America |

## Report Template

```markdown
# Aprio Board Portal — SEO & Content Progress Report

[Date] | [Engagement Phase]
Prepared by: Diraj Goel, GetFresh Ventures

---

## 1. Executive Context & Baseline State

### Strategic Objective
Define the ultimate goal (e.g., Establishing Aprio as the definitive authority for Board Portal software in North America against Diligent and BoardEffect).

### The Baseline State (Before Our Work)
Provide a deep narrative on the state of organic traffic and content health prior to execution. 
*Explain the 12-Month Organic Traffic Trend (insert the table here).*
*Detail what the numbers mean: Are we converting? Are we ranking for high-intent terms or just low-value informational terms?*

### The Core Gaps & Challenges
Detail *why* the gaps exist.
- What was missing from the content architecture? (e.g., lack of comparison hubs).
- What technical debt was dragging performance down? (e.g., stale blog posts, 404 leakage).
- Why is the "Do No Harm" doctrine critical here?

---

## 2. Week [N] Execution & Strategy Rationale

### What We Executed This Week
Provide a comprehensive list of tactical deliverables (e.g., deployed 27 pages, applied Schema, staged hreflang).

### The "Why" Behind the Strategy
Deeply explain the mechanics behind the execution.
- *Why did we deploy these specific pages?* 
- *Why did we take an additive approach instead of modifying historical high-traffic pages?*
- *Why are comparison pages (e.g., "Alternative to Diligent") critical for capturing high-intent switching traffic?*

---

## 3. Expected Outcomes & Impact
Explain what the business should expect to see as a result of this week's work.
- *How long will indexing take?*
- *What leading indicators will signal success (e.g., GSC Impressions vs GA4 Conversions)?*
- *How does this close the competitive moat?*

---

## 4. Next Phase Execution (The Forward Plan)

### What We Need To Tackle Next
Detail the immediate next steps from the action plan.
- *What is blocking us? (e.g., WP Admin access, GA4 Service Account).*
- *How will we resolve these blockers?*
- *What is the exact execution timeline for the next 7 days?*

### Planned vs Actual (Execution Trace)
*Insert the tabular trace of last week's planned items vs their current status.*

---

## 5. Technical Appendix & Metrics

*Include the raw metric tables here (Content Deployment Counts, Technical SEO Status checkboxes, Backlog/Linear ID tables).*
----|
| Structured data (SoftwareApplication) | ✅ | Deployed globally |
| FAQ schema | ✅ | On comparison + hub pages |
| hreflang tags | ✅ | [N] pairs via WPCode |
| Breadcrumb schema | ⏳ | GFV-383 backlog |
| Security headers | ⏳ | GFV-367, needs Cloudflare |

### Search Performance (from GSC)

[Include only if GSC data available]

| Page/Query | Impressions | Clicks | CTR | Position |
|------------|-------------|--------|-----|----------|
| [query] | [N] | [N] | [N]% | [N] |

---

## Competitive Intelligence

[Pull from SEMrush when available]

### Keyword Gaps Closed

| Keyword | Volume | Aprio Position | Competitor | Their Position |
|---------|--------|---------------|-----------|----------------|
| [kw] | [N] | [N] | [comp] | [N] |

---

## Backlog & Next Actions

### Active (In Progress)

| ID | Title | Owner | Priority |
|----|-------|-------|----------|
| [GFV-xxx] | [title] | [name] | [P1/P2/P3] |

### Blocked (Waiting on Aprio Team)

| ID | Title | Blocker | Impact |
|----|-------|---------|--------|
| GFV-356 | HubSpot API token | Eugene | Pipeline visibility |
| GFV-357 | GA4 service account | Eugene | Traffic analytics |
| GFV-355 | Cloudflare access | Eugene | Security headers, PageSpeed |

### Planned Next

1. **[Action]** — [Date] — [Why it matters]

---

## Engagement Status

**Content velocity:** [N] pages/week avg
**Total pages managed:** [N]
**Geo coverage:** US + Canada with hreflang
**Competitive moat:** [Summary of positioning advantage]

---

*GetFresh Ventures · Confidential*
```

## Design System (Google Docs Styling)

### Typography
- **H1 Title:** 20pt Source Sans Pro, Navy (#1B2B4E)
- **H2 Section Headers:** 14pt Source Sans Pro, Navy (#1B2B4E)
- **H3 Subheaders:** 12pt Source Sans Pro, Navy (#1B2B4E)
- **Body text:** 11pt Source Sans Pro, Charcoal (#333333)
- **Metadata line:** 10pt Source Sans Pro, Gray

### Tables
- **Header row:** Navy background (#1B2B4E), white text, bold
- **Body rows:** Alternating white / light gray (#F8F8F8) zebra striping
- **Cell font:** 10pt Source Sans Pro
- **Column 2 (title column):** Bold in all tables
- **Spacing:** 12pt after each table before next section
- **Status column:** Use ✅ ⚠️ ❌ ⏳ emoji indicators

### General Rules
- GFV logo at top of document
- "GetFresh Ventures · Confidential" footer with page numbers (e.g., "Page 1 of X")
- No line break between a label and its first child
- Bold lead-ins on all bullet points
- Frame everything as competitive advantage vs Diligent/BoardEffect
- Phase completion is NOT done until search ranking data confirms

## Report Filing System

```
Google Drive: GetFresh Ventures → Clients → Aprio → Reports → MM-YYYY/
Naming: "Aprio Board Portal — SEO Progress Report — [Month Day, Year]"
```

| Month | Folder ID |
|-------|-----------|
| 04-2026 | `<to be created on first report>` |

## Report Registry

Every report ever created, in chronological order. **Always read the most recent report before generating the next one.**

| # | Date | Doc ID | Doc Title | Status |
|---|------|--------|-----------|--------|
| 1 | April 15, 2026 | `1aM7GuFZGa7uEMCTcYExksgWwlOHJJKuFIlOZbQFAy00` | Aprio Board Portal — Week 1 SEO Progress Report — April 15, 2026 | Current |

## Distribution

| Channel | Recipients | Format |
|---------|-----------|--------|
| Google Docs | Diraj (internal review) | Primary — Google Doc |
| Email | Ian McPhail, Eugene Gurevich | PDF attachment after Diraj approval |

**DO NOT send email without Diraj's explicit "send it" approval.**

## Quality Gate

Before delivering:
- [ ] Previous report read — action plan extracted for planned vs actual
- [ ] All changes verified from Linear (not memory)
- [ ] Content inventory table is current with latest WP IDs
- [ ] Competitive framing present — every section ties back to beating BoardEffect/Diligent
- [ ] Tables have navy headers, zebra striping, 10pt font
- [ ] Emoji status indicators in all status columns
- [ ] Action items have owners and impact explanations
- [ ] Blocked items clearly call out what Aprio team needs to unblock
- [ ] Google Doc styled with `create_formatted_doc()`
- [ ] Saved in correct Aprio Drive folder
- [ ] Report Registry updated in this SKILL.md

## Related Skills

- `gfv-report-builder` — Visual slide decks via Gemini
- `google-doc-creation` — Google Doc creation and styling
- `aprio-seo-page-deployment` — WordPress page deployment methodology
- `golden-rule-semrush` — SEMrush queries (adapt for Aprio domain)
- `hubspot-api` — HubSpot pipeline data (when token available)


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
