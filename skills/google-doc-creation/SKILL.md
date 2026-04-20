---
name: google-doc-creation
description: Create professional, executive-ready Google Docs with branded styling. Use this whenever the user asks to create a Google Doc, report, strategy document, or any document in Google Drive. ALL agents must use this skill — never create raw/unstyled docs.
---

# Google Doc Creation — Professional Documents

## When to Use This Skill

Use this skill **any time** a Google Doc needs to be created, including:
- Strategy reports, audit reports, growth plans
- Client-facing documents (proposals, analyses, recommendations)
- Internal reports (status updates, retrospectives)
- Any document requested to be placed in Google Drive

**NEVER create a plain, unstyled Google Doc.** Every doc must have professional styling applied automatically.

## The Script

**Location:** `~/Documents/Code/gfv-brain/scripts/create_google_doc.py`

### Quick Usage

```python
# From Python
import sys
sys.path.insert(0, os.path.expanduser("~/Documents/Code/gfv-brain/scripts"))
from create_google_doc import create_formatted_doc

url = create_formatted_doc(
    markdown_content,
    title="My Professional Document",
    folder_id="GOOGLE_DRIVE_FOLDER_ID"
)
```

```bash
# From CLI
python3 ~/Documents/Code/gfv-brain/scripts/create_google_doc.py \
    --input content.md \
    --title "My Document" \
    --folder FOLDER_ID
```

### Auth

- **Preferred:** Service Account at `~/.config/gfv/gfv_service_account.json` with domain-wide delegation (impersonates `diraj@getfreshventures.com`)
- **Fallback:** `gws` CLI for content insertion, SA for styling pass

### What It Does Automatically

The script handles two phases:

1. **Content Insertion** — Parses markdown → inserts headings, paragraphs, tables, lists, horizontal rules via Docs API `batchUpdate`
2. **Professional Styling Pass** — Reads the doc back and applies all visual design rules (see below)

## ⚠️ HARD DESIGN RULES — NEVER SKIP

Every Google Doc created by any agent MUST comply with ALL of these rules. They are enforced automatically by `create_google_doc.py`.

### Typography

| Element | Size | Weight | Color |
|---------|------|--------|-------|
| H1 (Title/Part headers) | 20pt | Bold | Navy `#1B2A4A` |
| H2 (Section headers) | 16pt | Bold | Navy `#1B2A4A` |
| H3 (Sub-section headers) | 13pt | Bold | Dark Navy `#141F38` |
| Body text | 11pt | Regular | Black |
| Table header text | 10pt | Bold | White `#FFFFFF` |

### Typography Rules

- All headings use `keepWithNext: true` so they never orphan at page bottoms
- H1 has **28pt above, 8pt below** spacing (major section break)
- H2 has **22pt above, 4pt below** spacing (sub-section break)
- H3 has **16pt above, 2pt below** spacing (snaps tightly to tables/lists below)
- Normal body paragraphs MUST use **115% line spacing** and **8pt spaceBelow** to ensure clear readability and cadence between blocks.

### Table Design — MANDATORY

| Element | Style |
|---------|-------|
| **Table Layout**| Always spans 100% of page working width (468pt). Remaining slack is distributed to columns. |
| **Header row background** | Navy `#1B2A4A` |
| **Header row text** | White, Bold, 10pt. Center Appears `alignment: CENTER`. |
| **Odd body rows** | White background (default) |
| **Even body rows** | Light Gray `#F5F5F5` |
| **Cell padding** | Header: 4pt top/bottom, 6pt left/right. Body: 3pt top/bottom, 6pt left/right |
| **Cell alignment**| Smart routing based on type: Values (Numbers/$, %) align `END`, statuses/booleans (✅/❌, short enums) align `CENTER`, standard text aligns `START`. |
| **Column widths** | Smart two-tier: numeric/short columns get compact widths (45–75pt), text columns absorb remaining page width proportionally |

### Post-Table Spacing — MANDATORY

Every table MUST have **14pt `spaceAbove`** applied to the first paragraph element after it. This creates visual breathing room between the table bottom border and the next content. The script handles this automatically in the `apply_professional_styling` pass (section 2b).

### Pre-Table Empty Paragraph Squashing — MANDATORY

Google Docs API inserts a mandatory empty `\n` paragraph before every table. These ghost paragraphs create visible dead space between headings and their tables. The styling pass automatically detects all empty paragraphs immediately preceding a table and squashes them:
- `spaceAbove: 0pt`, `spaceBelow: 0pt`, `lineSpacing: 0`
- Font size reduced to `1pt`

This ensures H3 subheadings snap flush to table borders with no visible gap.

### Column Width Auto-Fit Algorithm

Column widths use a **two-tier compact/text distribution** to prevent numeric columns from hogging space:
1. Classify each column: if alignment is `END` (numbers/$) or `CENTER` (status/emoji), it is "compact"
2. Compact columns get a tight width: `max(45, min(75, max_char_len * 7 + 12))` pt
3. Remaining page width (511pt total) is distributed proportionally among text columns by max character length
4. Normalize all widths to sum to exactly 511pt; remainder goes to first text column
5. Minimum column width: 40pt absolute floor

### Table Font Sizing — STRICT 10pt

All table text (headers and body) MUST be **10pt regardless of column count**. Never shrink fonts to fit wide tables — the smart column width algorithm handles space distribution instead.

### Callout / Blocker Text

Lines containing critical alerting keywords are automatically styled as a high-visibility block.
Keywords include:
- "WordPress access is the critical-path blocker"
- "WordPress access is the single gating dependency"
- "CRITICAL"
- "⚠️"

**Styling Rules applied:**
- Entire paragraph background shading is light red (`#FAF0F0`)
- Text elements matching callout are **bold dark red** (`#CC1919`)
- Solid 3pt dark red left border (`borderLeft`) to pop out from standard paragraphs.
- Paddings `spaceAbove: 12pt` and `spaceBelow: 12pt`.

### Horizontal Rules

- Rendered as a paragraph with `borderBottom` (solid, 1pt, gray `#B3B3B3`)
- 6pt padding below the border
- Do NOT use on the title paragraph — only between major sections

### Title / Cover Page — MANDATORY

Every professional report MUST include a branded title page. Pass `cover_page` dict to `create_formatted_doc()`.

**Layout (top → bottom, all centered, NO blank lines):**

| Element | Style |
|---------|-------|
| **Main title** | 36pt, bold, Navy `#1B2A4A`, centered, **200pt `spaceAbove`** (pushes ~40% down page) |
| **Subtitle** | 24pt, regular, Gray `#666666`, centered, 30pt below |
| **Domain** | 13pt, italic, Navy, centered, 1.5pt navy `borderBottom` divider, 8pt padding |
| **Prepared by** | 12pt, Gray, centered, 24pt above |
| **Date** | 12pt, Gray, centered, 30pt below |
| **CONFIDENTIAL** | 9pt, Light Gray `#999999`, centered, 20pt above |
| **Page break** | Separates title page from body content |

> [!IMPORTANT]
> **NEVER use blank `\n` lines for vertical spacing.** They inherit the default 11pt paragraph height and will push content to page 2. Always use `spaceAbove`/`spaceBelow` on paragraph styles. The 200pt `spaceAbove` on the title paragraph is the canonical way to push content down the page.

**Usage:**

```python
url = create_formatted_doc(
    markdown_content,
    title="Client — Report Title",
    folder_id="DRIVE_FOLDER_ID",
    cover_page={
        "title": "SEO Growth Strategy",
        "subtitle": "Aprio Board Portal",
        "domain": "aprioboardportal.com",
        "prepared_by": "GetFresh Ventures",
        "date": "April 2026",
        "confidential": True,
    }
)
```

## Writing Content for the Doc

### Markdown Format

Write content as standard markdown. The parser supports:
- `# H1`, `## H2`, `### H3` headings
- `**bold**`, `*italic*`, `***bold italic***`
- Bullet lists (`- item`)
- Numbered lists (`1. item`)
- Pipe tables (`| col1 | col2 |`)
- Horizontal rules (`---`)

### Table Cell Content Rules

- Keep table cell text **concise** — long text causes wrapping and poor readability
- For short values (grades, scores, dates), use minimal text
- For descriptions, keep to ~40 characters max per cell

### Title Rules

- The H1 title should be a single line — keep it under 50 characters
- If a title would wrap at 20pt, shorten it or break into title + subtitle
- Use an em dash (—) as separator in compound titles: "Client — Report Type"

## Shared Drive Locations

| Client | Drive ID | Notes |
|--------|----------|-------|
| Aprio | `0AGZeuLXeKiBzUk9PVA` | Aprio shared drive |
| GFV Internal | `1SxiQMO8MwgHEeQ9KgpNruoDK-axbks6F` | gfv_brain folder |

## Common Workflow

```python
import os, sys
sys.path.insert(0, os.path.expanduser("~/Documents/Code/gfv-brain/scripts"))

# 1. Write the markdown content
md_content = """
# Aprio Board Portal — SEO Growth Strategy

Domain: aprioboardportal.com · Date: April 10, 2026

---

## Executive Summary

The key findings are...

| Pillar | Grade | Score | Key Finding |
|--------|-------|-------|-------------|
| Content | B+ | 82/100 | Good depth |
| Keywords | C | 55/100 | 57% uncovered |

---

## Next Steps

- Fix performance issues
- Create competitor pages
"""

# 2. Create the doc (styling applied automatically)
from create_google_doc import create_formatted_doc
url = create_formatted_doc(
    md_content,
    title="Aprio Board Portal — SEO Growth Strategy",
    folder_id="0AGZeuLXeKiBzUk9PVA"
)
print(f"Doc ready: {url}")
```

## For Shared Drives (Important)

When placing docs in Shared Drives, you may need the SA direct approach instead of `gws`:

```python
from google.oauth2 import service_account
from googleapiclient.discovery import build

SA_KEY = os.path.expanduser("~/.config/gfv/gfv_service_account.json")
creds = service_account.Credentials.from_service_account_file(
    SA_KEY,
    scopes=["https://www.googleapis.com/auth/drive", "https://www.googleapis.com/auth/documents"],
    subject="diraj@getfreshventures.com"
)
drive = build("drive", "v3", credentials=creds, cache_discovery=False)
docs_svc = build("docs", "v1", credentials=creds, cache_discovery=False)

# Create doc in shared drive
doc_file = drive.files().create(
    body={
        "name": "Document Title",
        "mimeType": "application/vnd.google-apps.document",
        "parents": [DRIVE_ID]
    },
    supportsAllDrives=True,
    fields="id,name,webViewLink"
).execute()

# Then parse + insert content using create_google_doc functions
from create_google_doc import parse_markdown, build_requests, apply_professional_styling
elements = parse_markdown(md_content)
reqs = build_requests(elements)

# Send style defaults + content in one batch each
docs_svc.documents().batchUpdate(documentId=doc_file["id"], body={"requests": reqs}).execute()

# Apply professional styling
apply_professional_styling(doc_file["id"], docs_svc)
```

## Known Limitations

1. **No chunk splitting** — All batchUpdate requests must be sent in a single call. Splitting corrupts tables due to reverse-order cell inserts with forward index tracking.
2. **No `updateNamedStyle`** — Despite docs showing it, `updateNamedStyle` is NOT a valid batchUpdate request type in the Docs API v1. All heading styling (color, size, spacing) is applied per-element via `updateTextStyle` + `updateParagraphStyle` in the post-insertion styling pass.
3. **Images** — Not supported. Use the `gfv-report-builder` skill for image-based reports.
4. **Links** — Inline markdown links are not yet parsed. Add links manually after creation.
5. **Nested lists** — Only single-level bullets/numbers supported.
6. **Page breaks** — Google Docs auto-paginates. Tables may split across pages. Use `keepWithNext` on headings to prevent orphans.

> [!CAUTION]
> ## Critical: UTF-16 Surrogate Pair Indexing
> Google Docs uses **UTF-16 code unit** indexing, NOT Python codepoint indexing. Supplementary plane characters (emoji like 🔴, ✅, 🏢 — anything U+10000+) are **2 UTF-16 code units** but Python `len()` counts them as 1. Every such emoji drifts the cursor by 1, causing subsequent content to land **inside** table cells.
>
> The `_utf16_len()` helper in `create_google_doc.py` handles this. **Never use Python `len()` for Google Docs index arithmetic.**
>
> Formula: `sum(2 if ord(ch) > 0xFFFF else 1 for ch in text)`

## Post-Creation Validation — MANDATORY

After every doc creation, the agent MUST visually validate the output. Open the doc URL in the browser and verify:

| Check | What to Look For |
|-------|------------------|
| **Title page fits one page** | All elements (title, subtitle, domain, attribution, date, CONFIDENTIAL) are visible on page 1 with no overflow to page 2 |
| **Page break is clean** | Content body starts on the page after the title page |
| **Headings are navy** | H1, H2, H3 should all be Navy `#1B2A4A`, not black |
| **Table headers are navy** | First row of each table should have navy background with white bold text |
| **Table columns are readable** | Auto-fitted column widths, no crushed/garbled cells |
| **Alternating row shading** | Even rows should have `#F5F5F5` background |
| **Red callouts** | Lines containing ❌, ⚠️, BLOCKED, etc. should be bold red |
| **No orphan headings** | Headings should not appear alone at the bottom of a page |

If ANY check fails, fix the issue before returning the URL to the user.

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| Title page splits across 2 pages | Blank lines used for spacing | Remove blank lines, use `spaceAbove: 200pt` on title paragraph |
| Content absorbed into table cells | UTF-16 surrogate pair drift (emoji) | Use `_utf16_len()` not `len()` for all index math |
| Tables after first one garbled | Chunk splitting | Never chunk — send all requests in one batch |
| Table overflows page margins | Fixed minimum widths too large | Use sqrt-scale proportional widths with iterative clamping |
| No styling applied | SA auth missing | Ensure `~/.config/gfv/gfv_service_account.json` exists |
| "index out of range" error | Doc doesn't start at index 1 | Create a blank doc first, don't reuse existing |

### Content Rules (Avoid These in Markdown)

- **No ASCII art bar charts** — Replace with proper markdown tables
- **Keep cell text < 50 chars** — Long text wraps poorly in narrow columns
- **Use emoji sparingly in tables** — Each supplementary plane emoji costs 2 index units


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
