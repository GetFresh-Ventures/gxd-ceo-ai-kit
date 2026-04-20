---
name: offline-conversion-upload
description: Pull GCLID leads from Supabase, match to ServiceTitan completed jobs, generate CSV, and upload to Google Ads via browser. Repeatable weekly process until API token (GFV-335) is approved.
---

# Offline Conversion Upload — Manual Pipeline

## When to Use

Run this skill **weekly** (or on-demand) to feed offline conversion data to Google Ads Smart Bidding. This replaces the broken API pipeline until GFV-335 (Google Ads API Basic Access) is approved.

**Trigger phrases:** "run offline conversion upload", "upload conversions", "feed smart bidding", "manual conversion import"

## Prerequisites

- GCLID capture tag deployed in GTM (GFV-345 ✅ Done)
- `gclid_leads` table in Supabase has data (check first)
- ServiceTitan MCP connector accessible
- Google Ads DSM-PPC account accessible in browser

## Pipeline Steps

### Step 1: Generate the Upload CSV

Run the generation script. It pulls from Supabase + ServiceTitan, matches by phone/email, and outputs a CSV.

```bash
cd ~/Documents/Code/gfv-brain && [STUB AVOIDED] Execute generate_conversion_csv.py via available MCP/agent tools rather than a missing local script --days 7
```

This produces: `~/Documents/Code/gfv-brain/data/offline_conversions/upload_YYYY-MM-DD.csv`

If the script reports 0 GCLID leads, the capture tag hasn't collected enough data yet. Wait for more PPC form submissions.

### Step 2: Google Ads Auto-Sync Configuration

The Vercel pipeline (`api/cron-offline-conversions.js`) automates step 1 in the background by batching matched conversions directly into the Google Sheet: `GFV_Ads_Offline_Conversions_Auto`.

To consume this data, Google Ads must run a scheduled pull:

1. Open **Google Ads** → Goals → **Conversions** → **Uploads** → **Schedules**
2. Click **"+"** to create a new Schedule
3. Source: **Google Sheets**
4. Link this specific Google Sheet: `https://docs.google.com/spreadsheets/d/1vyEMaD1Pyoxyz9OfNQQV7WGYM9IG3iLgVdYdUFVM_I4/edit`
5. Frequency: **Every 24 Hours**
6. Click **"Save & Preview"** to ensure Google Ads connects properly.

### Step 3: Verify Autonomous Synchronization

Since everything is running server-side:
1. Google Ads will silently process the sheet every 24 hours.
2. If match formats are incorrect, the Google Ads UI will note a failure in the Schedules tab.
3. Once successful, data flows securely to Smart Bidding.

### Step 4: Record in Linear

Update GFV-340 with upload results:
- Number of conversions uploaded
- Total revenue value
- Any match failures
- Date range covered

## CSV Format (Google Ads Required)

```csv
Parameters:TimeZone=America/Denver
Google Click ID,Conversion Name,Conversion Time,Conversion Value,Currency Code
CjwKCAjw...,ServiceTitan Booked Job (Call Extension),2026-04-05 14:30:00,4500.00,USD
```

**Important notes:**
- First line MUST be the timezone parameter
- `Conversion Name` must EXACTLY match the conversion action name in Google Ads
- `Conversion Time` must be AFTER the click time (Google validates this)
- GCLIDs expire after 90 days — older clicks cannot be imported

## Troubleshooting

| Issue | Fix |
|-------|-----|
| 0 GCLID leads | GCLID capture tag just deployed. Wait 24-48h for data. |
| 0 matches | Phone/email format mismatch. Check normalization. |
| Upload rejected | Check timezone format in CSV header. Must be IANA timezone. |
| "Conversion action not found" | Conversion name must exactly match. Check Google Ads > Conversions. |
| GCLID too old | GCLIDs expire after 90 days. Cannot import historical data beyond that. |

## Automation Path

**ACTIVE**: The Vercel cron architecture fully automates this pipeline.
1. ServiceTitan payloads execute nightly.
2. Vercel probabilistically matches missing GCLIDs.
3. Vercel acts as a `diraj@getfreshventures.com` Service Account, generating native JS JWT tokens.
4. Extracted metrics append to Google Sheets. 
5. Google Ads Scheduled Uploads sweeps the sheet.

*The pending Google Ads Developer Token (GFV-335) is no longer a blocker.*


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
