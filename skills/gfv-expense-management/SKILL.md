---
name: gfv-expense-management
description: Manage, organize, and analyze GFV tech subscription expenses across iCloud, Google Shared Drive, and QuickBooks. Covers invoice collection, folder organization, spend reconciliation, and cost optimization.
---

# GFV Expense Management Skill

## Overview

This skill covers the end-to-end management of GFV's tech subscription and vendor expenses, including:
- Invoice/receipt collection and organization
- Shared drive folder structure maintenance
- QuickBooks cross-referencing
- Monthly spend analysis and cost optimization

## File Locations

### Primary Expense Storage (Google Shared Drive)
```
_gfv_gtm_team/
  05 - Strategy/
    Revenue Planning/
      GFV x EightX: Strategic Planning Q4 2024/
        Expenses/
          Tech Subscriptions/     ← 62+ vendor folders, 979+ PDFs
          Vendors/                ← Non-tech vendors (CMC, WeWork, etc.)
          Bank Transactions/      ← TD Visa statements + CSV exports
          Tax Receipts/           ← CRA-related receipts
          Marketing/              ← Ad spend receipts
          Meals/                  ← Business meal receipts
          Archived/               ← Old/superseded files
```

Full path: `~/Library/CloudStorage/GoogleDrive-diraj@getfreshventures.com/Shared drives/_gfv_gtm_team/05 - Strategy/Revenue Planning/GFV x EightX: Strategic Planning Q4 2024/Expenses/`

### Local Working Copy (iCloud)
```
~/Library/Mobile Documents/com~apple~CloudDocs/Downloads - iCloud/
  _ORGANIZED/Personal/expenses/
    {VendorName}/                 ← Organized by vendor
```

### QuickBooks Data
- **Vendor ID reference:** Query via `gfv-brain/scripts/quickbooks_supabase_ingest.py`
- **Realm ID:** Check `.env` in `gfv-brain/`
- **Access token:** Needs periodic refresh
- **TD Business Travel Visa 0242** — primary CC for subscriptions

### Spend Tracker (Local)
- `~/Documents/Code/gfv-brain/daily/perplexity_spend_tracker.json`
- `~/Documents/Code/gfv-brain/daily/perplexity-invoices/` — extracted invoices

## Folder Naming Convention

### Vendor Folder Names
Use the canonical vendor name, title case:
- ✅ `Anthropic`, `HubSpot`, `LinkedIn`, `Manus AI`, `XAI`
- ❌ `anthropic (1)`, `hubspot`, `LinkedIn Premium Company`, `xai_grok`

### File Naming Convention
Format: `{Vendor}_{Type}_{YYYY-MM-DD}.pdf`

Examples:
- `Anthropic_Invoice_2026-03-07.pdf`
- `HubSpot_Invoice_2025-11-30.pdf`  
- `Manus_Receipt_2025-08-02.pdf`
- `TD_Visa_Statement_2025-04-07.pdf`

When the original filename is descriptive enough (e.g., `LNKD_INVOICE_101113654149.pdf`), keep it. Only rename generic files like `Receipt-2090-1136-8749.pdf`.

## Monthly Expense Review Process

### Step 1: Collect New Invoices
```bash
# Check for new PDFs in iCloud expenses folder
find ~/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads\ -\ iCloud/_ORGANIZED/Personal/expenses -name "*.pdf" -newer /tmp/last_review_marker
```

### Step 2: Sync to Shared Drive
```python
# Use the sync script pattern from this skill
# For each vendor folder in local, copy new files to GDrive
# Skip files that already exist on GDrive
```

### Step 3: Extract Amounts from New PDFs
```python
import fitz, re
doc = fitz.open("invoice.pdf")
text = doc[0].get_text()
amounts = re.findall(r'(?:Total|Amount Due|Amount Paid)[:\s]*\$?([\d,]+\.?\d*)', text, re.I)
```

### Step 4: Cross-Reference with QuickBooks
```python
# Refresh QB token first
from quickbooks_supabase_ingest import qb_query
result = qb_query("SELECT * FROM Purchase WHERE TxnDate >= '2026-01-01' ORDERBY TxnDate DESC MAXRESULTS 200", access_token, realm_id)
```

### Step 5: Generate Spend Report
Output a ranked vendor spend summary with:
- Total spend per vendor
- Monthly trend (increasing/stable/decreasing)
- Optimization opportunities
- Missing invoices flagged

## Known Issues

### Image-Based PDFs (Need OCR)
These vendors produce PDFs that PyMuPDF can't extract text from:
- PandaDoc
- SEMrush  
- Bright Data
- Zoom
- Evernote

Use `pytesseract` or similar OCR for these.

### Perplexity Invoice Access
Perplexity has `invoice_history.enabled: false` in their Stripe Customer Portal config. Invoices must be requested from support@perplexity.ai. See the `perplexity-invoice-pull` skill for details.

### QuickBooks Token Refresh
QB access tokens expire frequently. Before any QB query:
1. Check if `QB_ACCESS_TOKEN` is set in `gfv-brain/.env`
2. If expired, run: `[STUB AVOIDED] Execute quickbooks_supabase_ingest.py via available MCP/agent tools rather than a missing local script --refresh-only`

## Key Vendor IDs (QuickBooks)

| Vendor | QB Vendor ID |
|--------|-------------|
| Perplexity AI | 756 |
| (others TBD — refresh QB to populate) |

## Cost Optimization Checklist

When reviewing expenses, check for:

1. **Duplicate tools** — Are we paying for 2+ tools that do the same thing?
2. **Unused seats** — Is everyone on the plan actually using it?
3. **Annual vs. monthly** — Would annual billing save 10-20%?
4. **Plan tiering** — Are we on a higher tier than needed?
5. **AI tool overlap** — Claude, Cursor, Perplexity, OpenAI, XAI, Manus — do we need all?
6. **Trial leftovers** — Tools we tried and forgot to cancel?

## IMPORTANT RULES

1. **NEVER delete files without reviewing contents first** — move to `_REVIEW/` folder
2. **Always sync local → shared drive** after collecting new invoices
3. **Keep original filenames** if they're descriptive; only rename generic ones
4. **Flag gaps** — if a vendor has charges in QB but no invoices, flag it
5. **Check Trash before declaring files lost** — Google Drive moves to `.Trash/`


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
