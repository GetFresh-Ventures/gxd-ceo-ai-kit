---
name: golden-rule-weekly-report
description: "Generate a professional weekly progress report for the Golden Rule PHC team. Follows the established template from the April 6, 2026 progress report — narrative-driven, Before/After TLDR, date-by-date timeline, category deep-dives with tables, full funnel walkthrough, action plan by owner, and phase status. Each week picks up from the previous week's action plan and shows planned vs actual. Use when asked for a Golden Rule weekly report, status update, progress report, or before the Thursday call."
metadata:
  version: 2.0.0
  category: client-reporting
  origin: Golden Rule Apr 6 + Apr 13 reports, memory #242/#244
  triggers:
    - golden rule weekly report
    - golden rule progress report
    - golden rule status update
    - update for mark
    - prepare for thursday call
    - golden rule team update
---

# Golden Rule Weekly Report Skill

Generate a comprehensive, executive-ready weekly progress report for the Golden Rule PHC team — Mark Paup (CEO), Greg Romans (Marketing), Derrick Dickey (Technology), and Arvin (Technical Implementation).

## When to Activate

- Before the Thursday weekly call with Golden Rule
- When Diraj asks for a "Golden Rule weekly report" or "update for Mark"
- End of week sync / recap
- Any time the team needs a written record of what changed

## Quick-Start Workflow

Every week, follow these 5 steps:

```
1. READ previous week's report from the Report Registry (below)
2. PULL this week's completed Linear issues from the Golden Rule project
3. PULL live data from Google Ads, GA4, ServiceTitan MCPs (skip HubSpot — not needed for Golden Rule)
4. GENERATE the report markdown using the template below
5. CREATE Google Doc via create_google_doc.py + apply table styling fix
```

### Step 1: Read Previous Report

```python
# Always read the previous week's report first.
# The action plan from last week becomes this week's "Planned vs Actual" section.
PREV_DOC_ID = "<get from Report Registry below>"
```

### Step 2: Pull Linear Issues

```python
# Use Linear MCP to get completed issues for this week
# Filter: project = "Golden Rule", state = "Done", updatedAt >= last_monday
```

### Step 3: Pull Live Data

```python
# Google Ads MCP: campaign performance, spend, CPA, conversions
# GA4 MCP: landing page sessions, form fills, conversion rates
# ServiceTitan MCP: jobs booked, revenue, attribution
# SEMrush MCP: competitive position changes
# DO NOT use HubSpot — not connected for Golden Rule
```

### Step 4: Generate Report Markdown

Use the template below. The key structural requirement: **each week picks up from the previous week's action plan**. The TLDR shows last week vs this week. The body shows what was planned and what actually got done.

### Step 5: Create Google Doc

**Use the `google-doc-creation` skill.** The canonical entry point is `create_formatted_doc()` which handles content insertion + professional styling in one call.

```python
# Reference: google-doc-creation skill
# Script: ~/Documents/Code/gfv-brain/scripts/create_google_doc.py
# Auth: Service Account at ~/.config/gfv/gfv_service_account.json

import os, sys
sys.path.insert(0, os.path.expanduser("~/Documents/Code/gfv-brain/scripts"))
from create_google_doc import create_formatted_doc

# ALL reports go in the same folder:
REPORTS_FOLDER_ID = "1aStvfmROoTZwn5WH0F2M28O3bJhUc2zW"  # Golden Rule → Demand Engine → 04-2026
# When month changes, find/create the new month folder under:
# Golden Rule PHC External → Demand Engine → MM-YYYY

url = create_formatted_doc(
    md_content,
    title=f"Golden Rule Utah — Google Ads Progress Report — {date_string}",
    folder_id=REPORTS_FOLDER_ID,
)
print(f"Report: {url}")
```

## Audience & Tone

| Person | Role | What They Care About |
|--------|------|---------------------|
| **Mark Paup** | CEO | ROI, CPA trends, phase progress, blockers to revenue |
| **Greg Romans** | Marketing Manager | Action items, call attribution, campaign performance |
| **Derrick Dickey** | Technology & Data | ServiceTitan integration, tracking, API access |
| **Arvin** | Technical Implementation | Landing pages, dashboard connectors, automation |
| **Diraj** | Strategy & Execution | Overall velocity, competitive position, phase gates |

**Tone:** Direct, story-driven, no jargon. Every change is framed as **what changed + why it matters**. Numbers over opinions. Bold the key stats.

## Data Sources

Pull from (in priority order) — **never from memory alone:**
1. **Previous week's report** — the action plan becomes this week's "planned vs actual"
2. **Linear** — Golden Rule project issues completed this week, status changes, milestones
3. **Google Ads MCP** — campaign performance, spend, CPA, conversions
4. **GA4 MCP** — website traffic, conversion rates, landing page performance
5. **ServiceTitan MCP** — jobs booked, revenue, call attribution
6. **SEMrush MCP** — competitive intelligence, keyword positions
7. **PIL / Memory** — relationship context, prior decisions

**DO NOT** use HubSpot for Golden Rule reports.

## Report Template

The report follows the established template from the Apr 6 report. The format is narrative-driven with McKinsey-style action titles. **Each week picks up from the previous week's action plan.**

```markdown
# Golden Rule Utah — Weekly Progress Report

[Date] | [Phase Tag: e.g., "Phase 2: Canary — Week 3"]
Prepared by: Diraj Goel, GetFresh Ventures

---

## TLDR — Strategic Overview

**Target Objective:** [Remind the reader what the ultimate goal is, e.g., Transitioning to Phase 3 Conversion Optimization with a 100% clean attribution pipeline]
**Current Phase:** [What phase we are in, e.g., Phase 2: Canary]
**Phase Progress:** [What part of the phase we are in, e.g., Final Week of Infrastructure Testing]

**Last Week:** [Explain the state of the account and the challenges faced narratively. Do not just list tasks. E.g., We analyzed the legacy agency's setup, identifying critical flaws including generic broad match keywords bleeding budget, zero negative keywords, phantom conversion signals corrupting Smart Bidding, and a lack of dedicated landing pages. The focus was triaging the immediate damage.]

**This Week:** [Narrative explanation of what was accomplished this week and how it explicitly aligns with the target objective. E.g., We rebuilt the core infrastructure. We decoupled traffic from the generic homepage by deploying 7 dedicated utility landing pages, configured precise semantic and E-E-A-T schemas, hardened the attribution layer with hidden GCLID forms, and established a true baseline against TruePros and Valley Plumbing to ensure an accurate accounting of revenue.]

**Next 2-3 Weeks:** [What is planned next and why. E.g., We will gather 14+ days of clean conversion data to hit the required statistical significance. Once the pipeline proves it correctly maps $0 invoices back to the campaign, we will enter Phase 3 (Conversion Optimization), transitioning away from Canary limits and deploying targeted Bid Multipliers to dominate high-intent Utah symptom variants.]

**What's in this report:** [One sentence listing what's explicitly detailed down below.]

---

---

## Executive Summary — [Headline Stat]

[2-3 paragraphs. Lead with the most important number. Frame what the week's focus was. Explain WHY the work matters.]

---

## Last Week's Plan vs What We Actually Did

[NEW SECTION — required every week starting Week 3. Pull the action plan from the previous report and show status.]

| Owner | Planned Action | Status | What Actually Happened |
|-------|---------------|--------|----------------------|
| Greg | Export call tracking numbers | ✅ Done | Delivered Apr 10, mapped all 15 numbers |
| Greg | Establish call QA cadence | ⚠️ Partial | Started but needs consistent weekly rhythm |
| Derrick | Fix invoice-to-job linkage | ❌ Not started | Blocked on ServiceTitan config |
| ... | ... | ... | ... |

**Completion rate:** [X] of [Y] planned actions completed ([Z]%).

---

## Rebuild Timeline — [N] Changes in [N] Days

**[Date] —** [Narrative paragraph covering all changes that day. Bold the dates. 2-3 sentences max per date.]

**[Date] —** [Next day's changes...]

---

## [Category Name] — [Headline Stat]

[Use focused tables with a Verdict column for campaign/keyword data:]

| [Col1] | [Col2] | [Col3] | Verdict |
|--------|--------|--------|---------|
| ... | ... | ... | ✅ / ⚠️ / ❌ + one-line assessment |

[Repeat for each category: Campaign Performance, Landing Pages, Attribution Pipeline, Competitive Intelligence, etc.]

---

## The Full Funnel — Every Step from Ad Impression to Revenue

[Include only if funnel-level changes were made this week.]

### Step 1: Ad Impression → Click
**What's supposed to happen:** [One sentence]
**What we fixed this week:** [Specific changes]
**Current state:** ✅/⚠️/❌ [One-line status]

### Step 2: Click → Landing Page
[Same format...]

### Step 3: Landing Page → Phone Call / Form
[Same format...]

### Step 4: Phone Call → Booking
[Same format...]

### Step 5: Booking → Completed Job
[Same format...]

### Step 6: Completed Job → Google Ads Revenue
[Same format...]

---

## Phase [N] Action Plan — Checklist by Owner

[This becomes next week's "Planned vs Actual" section.]

### Greg Romans — Marketing Manager ([N] Actions)
1. **[Action title]** — [Date] — [Why this matters]

### Derrick Dickey — Technology & Data ([N] Actions)
1. **[Action title]** — [Date] — [Why this matters]

### Arvin — Technical Implementation ([N] Actions)
1. **[Action title]** — [Date] — [Why this matters]

### Mark Paup — CEO ([N] Actions)
1. **[Action title]** — [Date] — [Why this matters]

### Diraj — Strategy & Execution ([N] Actions)
1. **[Action title]** — [Date] — [Why this matters]

---

## Phase [N] Status — Where We Stand Today

**What's live:**
- [Bullet list]

**What we're waiting on:**
- [Bullet list with Linear issue IDs]

**Phase [N] completion:** ~[X]%. Gate for Phase [N+1]: [criteria]. Estimated start: [date].

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
- **Column 2 (action/title column):** Bold in all tables
- **Spacing:** 12pt after each table before next section
- **Verdict column:** Use ✅ ⚠️ ❌ 🧪 emoji indicators for quick scanning

### Action Plan Items
- **Number + bold title** on one line
- **Due date** — immediately after title
- **Impact explanation** — dash-separated on same line
- Indent sub-items 36pt under parent labels

### General Rules
- GFV logo at top of document (use Drive-hosted logo if available)
- "GetFresh Ventures · Confidential" footer on every page
- No line break between a label and its first child
- Line break between table and next section header
- Bold lead-ins on all bullet points
- CPA framed as beating industry benchmarks, not pleasing Mark
- "The previous agency" — never use agency code names (no "C4", "MediaSpark" etc.)
- Phase status is NOT complete until sustained data proves the thesis

## Report Filing System

**ALL reports are filed in one place with a consistent naming convention:**

```
Google Drive: Golden Rule PHC External → Demand Engine → MM-YYYY/
Naming: "Golden Rule Utah — Google Ads Progress Report — [Month Day, Year]"
```

| Month | Folder ID |
|-------|-----------|
| 04-2026 | `1aStvfmROoTZwn5WH0F2M28O3bJhUc2zW` |

When the month changes, create a new `MM-YYYY` folder under `Demand Engine` and update this table.

## Report Registry

Every report ever created, in chronological order. **Always read the most recent report before generating the next one.**

| Week | Date | Doc ID | Doc Title | Status |
|------|------|--------|-----------|--------|
| 1 | April 6, 2026 | `13uStZpqkFluVWZzmjw0TezqNZg2Kv3wtrVuZrwpDKiE` | Golden Rule Utah — Google Ads Progress Report — April 6, 2026 | Sent |
| 2 | April 13, 2026 | `178tGqqEyQSzg8otMymkt0lMW5h-eGKSAndIQXoM0YlI` | Golden Rule Utah — Google Ads Progress Report — April 13, 2026 | Pending review |

**Old drafts deleted:** v1–v4 drafts for Week 2 have been trashed from Drive.

## Distribution

| Channel | Recipients | Format |
|---------|-----------|--------|
| Google Docs | All team members | Primary — shared in reports folder |
| Email | Mark, Derrick, Greg | PDF attachment (NOT Drive link) |
| CC | Tessa, Arvin | Email CC |
| BCC | Tallulah | Email BCC |

**DO NOT send email without Diraj's explicit "send it" approval.**

## User Preferences (from Apr 6 + Apr 13 reviews)

1. **Bold column 2** (title/action column) in all tables
2. **Indent sub-items** 36pt under parent labels
3. **Line break** between table and next section header
4. **No line break** between label and its first child
5. CPA framed as **beating industry benchmarks**, not "a CPA Mark would be happy with"
6. Phase completion is **NOT done** until sustained trend data is visible
7. Use **"the previous agency"** — never use code names like "C4" or "MediaSpark"
8. Wants **integrated data view**, not exports for attribution
9. "Everything We've Changed" needs **story-driven context** explaining WHY
10. **Table text:** 10pt body, 10pt headers — NOT default large Google Docs table font
11. **DO NOT generate PDF** until Diraj explicitly says to
12. **DO NOT send** until Diraj reviews the Google Doc first
13. **Each week picks up from the previous week** — show planned vs actual
14. **All reports filed in the same folder** with consistent naming
15. **No HubSpot** — not connected for Golden Rule

## Quality Gate

Before delivering:
- [ ] Previous week's report read — action plan extracted for planned vs actual
- [ ] All changes verified from Linear (not memory)
- [ ] Strategic TLDR uses the Before/After Table mapping 'what changed and what it gives us'
- [ ] Every table has navy headers, zebra striping, strict **10pt font** regardless of column count to prevent micro-fonts.
- [ ] List/Table titles must be H3 tags (`### Header`) rather than standalone bold strings to ensure they map strictly with a 2pt bottom margin, snapping tightly to the visual element below.
- [ ] Tables use the **full page width (511pt)** with smart two-tier distribution: numeric/short columns (Spend, Clicks, Conv., CPA) get compact widths (45–75pt), text columns (Campaign, Verdict) absorb the remaining width proportionally. Never equal-distribute.
- [ ] Pre-table ghost paragraphs are squashed (0pt spacing, 1pt font) so headings snap flush to table borders with no visible gap.
- [ ] Tables have Verdict column with emoji status indicators
- [ ] Action items have owners, dates, and impact explanations
- [ ] Phase status is honest — not inflated
- [ ] Full funnel uses "What's supposed to happen / What we fixed / Current state" format
- [ ] Previous report referenced for week-over-week comparison
- [ ] Planned vs Actual section included (starting Week 3)
- [ ] Google Doc styled with `apply_professional_styling()`
- [ ] **CRITICAL: You MUST write a python script to pull the live Google Doc content and verify the fonts (ensure they aren't defaulted to Aerial), formatting, and layout BEFORE finalizing and sharing it with Diraj.**
- [ ] Saved in correct Golden Rule Drive folder
- [ ] Report Registry updated in this SKILL.md

## Related Skills

- `gfv-report-builder` — Visual slide decks via Gemini (for presentations, not weekly text reports)
- `golden-rule-google-ads` — Pull live campaign data for the report
- `golden-rule-ga4` — Pull analytics data for LP performance
- `servicetitan-api` — Pull job/revenue data for attribution section
- `golden-rule-semrush` — Pull competitive intelligence data


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
