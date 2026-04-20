---
name: perplexity-invoice-pull
description: Pull Perplexity AI invoices/receipts, cross-reference with QuickBooks, and generate spend reports for finance handoff.
---

# Perplexity Invoice Pull & Spend Reconciliation

## Key Facts (Verified 2026-04-08)

| Item | Value |
|---|---|
| Stripe Customer ID | `cus_QIYDeiItShZEcZ` |
| Business Name | GetFresh Ventures |
| Payment Method | Visa ****7354 (Exp 11/2029) |
| QB Vendor | Perplexity AI (ID: 756) |
| CC Account | TD Business Travel Visa 0242 |
| Portal Session API | `bps_*` via `stripe.perplexity.ai` |
| Invoice History | **DISABLED** by Perplexity in Stripe portal config |

## ⚠️ Critical: Perplexity Disables Invoice Downloads

Perplexity has set `invoice_history.enabled = false` in their Stripe Customer Portal configuration. This means:
- The `/invoices` route in the portal returns "page not found"
- There is no way to download formal PDF invoices from the portal
- The Stripe API requires Perplexity's merchant API key (we don't have it)
- Email receipts are notification-only (no invoice PDFs attached)

## Data Sources (Priority Order)

### 1. QuickBooks (Primary - Most Complete)
```bash
# Query all Perplexity charges
python3 ~/Documents/Code/gfv-brain/scripts/quickbooks_supabase_ingest.py
# Vendor ID: 756, Account: TD Business Travel Visa 0242
```
- Contains ALL CC charges with dates, amounts (CAD), and merchant names
- Includes team expense reports (Brendan, Tessa)
- This is the authoritative source for spend tracking

### 2. Gmail (Supplementary - Receipts)
```python
# Search for Perplexity billing emails
IMAP search: FROM "perplexity" SUBJECT "purchase" OR "payment" OR "upgraded" OR "canceled"
# Account: diraj@getfreshventures.com (GFV_GMAIL_APP_PASSWORD in Keychain)
```
- "Thank you for your purchase" emails (API credit purchases)
- "You've been upgraded" emails (plan changes)
- "Payment unsuccessful" emails (failed charges)
- These do NOT contain PDF invoices or Stripe invoice URLs

### 3. Stripe Customer Portal (Limited - No Invoices)
```
# To get a portal session URL:
# 1. User logs into perplexity.ai
# 2. Goes to Settings → Billing
# 3. Clicks "Manage Subscription"
# 4. Copies the stripe.perplexity.ai/p/session/... URL
```
- Shows payment methods and billing address only
- Invoice history feature is disabled by Perplexity
- Session URLs expire in ~24 hours
- Can be loaded in MCP Chrome (Stripe doesn't use Cloudflare)

## Workflow: Monthly Reconciliation

### Step 1: Pull QuickBooks Data
```bash
python3 -c "
from quickbooks_supabase_ingest import qb_query
# Get all Perplexity purchases for current month
result = qb_query(\"SELECT * FROM Purchase WHERE EntityRef = '756' AND TxnDate >= '2026-03-01'\")
"
```

### Step 2: Pull Email Receipts
```python
import imaplib, email
# Connect to IMAP, search FROM "perplexity", save HTML bodies as receipts
```

### Step 3: Generate Report
- Monthly spend summary (from QuickBooks)
- Individual charge detail (date, amount CAD, merchant entity)
- Team expense report items
- Save to `gfv-brain/daily/perplexity-invoices/`

### Step 4: Finance Handoff
- Package report + CSV + HTML receipts
- Draft email to tessa@getfreshventures.com
- Get Diraj's "send it" approval before sending

## Output Files

| File | Purpose |
|---|---|
| `perplexity_billing_report.txt` | Human-readable full report |
| `perplexity_charges.csv` | Machine-readable charge history |
| `perplexity_spend_tracker.json` | JSON data for programmatic use |
| `receipt_*.html` | HTML email receipts as backups |

## Cloudflare / Bot Detection Notes

- **perplexity.ai** uses Cloudflare Turnstile — blocks CDP/WebDriver browsers
- **stripe.perplexity.ai** does NOT use Cloudflare — can be automated via MCP Chrome
- Chrome cookie decryption (macOS 127+) uses App-Bound Encryption — cannot extract cookies externally
- For perplexity.ai access: use user's default Chrome profile (not headless/automation)

## Invoice Recovery (Updated 2026-04-08)

### What Worked: Contacting Perplexity Support
- Sent support ticket requesting invoice history for `cus_QIYDeiItShZEcZ`
- **Sam from Perplexity Support responded same day** with:
  - 9 Stripe invoice PDFs (invoices 0024–0032, ~$22–$28 CAD each)
  - 9 matching credit note PDFs (cancellation refunds)
  - Stripe receipt HTML pages for recent invoices
  - Forwarded to billing team for **full history June 2024 → April 2026**

### Files Downloaded
- **Local**: `/tmp/perplexity_invoices_named/`
- **Naming**: `Perplexity-Invoice-8778FD48-XXXX.pdf` and `Perplexity-CreditNote-8778FD48-XXXX.pdf`
- **Need to upload**: GFV Shared Drive → `Tech Subscriptions/Perplexity AI/`
- **Blocked on**: Google Drive API access (OAuth client deleted, SA lacks shared drive perms)

### Still Pending
- **Full invoice history** (June 2024 → April 2026) from Perplexity billing team
- Check email periodically: `FROM "perplexity" SUBJECT "invoice"` via IMAP
- Subscription **cancelled April 4, 2026** per Tessa

### For Future Invoice Requests
Email `support@perplexity.ai` with:
- Stripe Customer ID: `cus_QIYDeiItShZEcZ`
- Business name: GetFresh Ventures
- Specific date range needed
- They respond within hours


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
