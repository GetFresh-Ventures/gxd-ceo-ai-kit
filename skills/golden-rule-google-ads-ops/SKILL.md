---
name: golden-rule-google-ads-ops
description: Operational playbook for making changes in Google Ads UI for Golden Rule accounts. Covers account navigation, campaign-level negative keywords, ad group creation, keyword addition, RSA creation, bid adjustments, ad extensions, enhanced conversions, and conversion action setup. Use this when automating Google Ads changes via browser.
---

# Golden Rule Google Ads Operations Skill

## Account Structure

```
Golden Rule PHCE (Manager Account, CID: 673-422-5461)
└── DSM-PPC (448-550-2333) ← ALL campaigns live here
    ├── DSM-Plumbing-Search (21057619182) — Iowa
    ├── DSM-HVAC-Service (21057659454) — Iowa
    ├── DSM-Plumbing-Pmax (21247624524) — Iowa
    ├── DSM-Electrical-PMAX (21257970934) — Iowa
    ├── DSM-HVAC-PMax (21633422052) — Iowa
    ├── Utah-HVAC-Search (22100120349) — Utah ✅ Active
    ├── Utah-Plumbing-Search — Utah ✅ Active
    └── Utah-WH-Search — Utah ✅ Active
```

> **CRITICAL:** Utah and Des Moines campaigns share the same Google Ads account (DSM-PPC, 448-550-2333). Always filter by campaign name prefix `Utah-` before making changes. NEVER modify `DSM-*` campaigns when doing Utah work.

## Account IDs Reference

| Entity | ID |
|--------|-----|
| Manager Account (Golden Rule PHCE) | 673-422-5461 |
| DSM-PPC sub-account | 448-550-2333 |
| GA4 Property | 319584840 |
| GTM Container | GTM-K7JHHJD (v92) |
| Utah phone number | (801) 901-8553 |
| Iowa phone number | (515) 393-4526 |
| LSA Utah | 189-035-6117 |
| LSA Des Moines | 274-787-7158 |

---

## Login & Navigation

1. Navigate to `https://ads.google.com`
2. You'll land in the Golden Rule PHCE manager account (673-422-5461)
3. The sub-account DSM-PPC (448-550-2333) contains all campaigns
4. Click into DSM-PPC from the account list, or use the breadcrumb at top left

---

## Enhanced Conversions Setup (April 2026)

> [!IMPORTANT]
> Enhanced conversions are required for accurate conversion tracking from landing pages. This was a major focus in April 2026.

### What Enhanced Conversions Do
- Match website conversion events to Google accounts using hashed first-party data (email, phone, name, address)
- Improve conversion measurement accuracy by 5-15%
- Required for offline conversion imports

### Setup Steps (via Google Ads UI)

1. Navigate to **Goals → Conversions → Settings** (customer-level)
2. Under "Enhanced conversions" → Click **Turn on**
3. Select implementation method: **Google Tag Manager** (GTM-K7JHHJD)
4. Google will validate the tag is present
5. Accept the customer data terms
6. Allow 1-3 days for Google to verify data is flowing

### Conversion Actions (DSM-PPC)

Navigate: **Goals → Conversions → Summary**

| Action Name | Category | Source | Status |
|-------------|----------|--------|--------|
| Phone calls | Phone call conversions | Google Ads | ✅ Active |
| Website conversions | Default | GA4 import | ⚠️ Check |
| form_submission | Submit lead form | GA4 import | ⚠️ Needs GA4 Editor |
| phone_call_click | Contact | GA4 import | ⚠️ Needs GA4 Editor |

### Creating a New Conversion Action

1. Navigate: **Goals → Conversions → Summary → New conversion action**
2. Select **Website** or **Import**
3. For GA4 imports: Select **Google Analytics 4 properties** → choose events
4. Set conversion window (30 days recommended)
5. Set attribution model: **Data-driven** (default)
6. Save

### Diagnostics

Navigate: **Goals → Conversions → Diagnostics**
- Check for "No recent conversions" warnings
- Verify tag firing status
- Look for "Enhanced conversions" diagnostic card

---

## GCLID Attribution Pipeline

### How GCLID Works
```
Google Ads Click → ?gclid=xxx appended to URL
    ↓
Landing Page loads → GTM Conversion Linker captures GCLID
    ↓
Conversion event fires → GCLID associated with conversion
    ↓
Google Ads shows conversion in campaign/ad group/keyword reports
```

### Key Components
1. **GTM Conversion Linker** — Tag in GTM-K7JHHJD that captures `gclid` from URL params and stores in `_gcl_aw` cookie
2. **Auto-tagging** — Must be ON in account settings (Settings → Account settings → Auto-tagging)
3. **Final URLs** — Must include `?loc=UT` for Utah pages: `goldenrulephc.com/utah-water-heater-repair-ppc/?loc=UT`

### Verify Auto-Tagging
1. Navigate: **Admin → Account settings**
2. Confirm "Tag your URL when people click your ad" is **ON**
3. If OFF, turn it on — this is required for GCLID capture

---

## Offline Conversion Import

For matching phone calls (ServiceTitan) back to ad clicks:

1. Navigate: **Goals → Conversions → Uploads**
2. Upload format: CSV with `gclid`, `conversion_name`, `conversion_time`, `conversion_value`
3. Schedule: Can be automated via Google Ads API (requires API token)

> [!WARNING]
> As of April 2026, we do NOT have Dynamic Number Insertion (DNI) on the Utah landing pages. Phone calls to (801) 901-8553 cannot be automatically matched to GCLID. This is tracked in GFV-304.

---

## Common Operations

### Add Campaign-Level Negative Keywords

1. Click the target campaign name (e.g., "Utah-Plumbing-Search")
2. Left sidebar → "Audiences, keywords, and content" → "Keywords"
3. Click "Negative keywords" tab (next to "Keywords" tab)
4. Click the blue "+" button
5. Select "Add negative keywords"
6. Ensure "Campaign" is selected (not "Ad group")
7. Type or paste keywords (one per line)
8. Click "Save"

### Create a New Ad Group

1. Navigate to the target campaign
2. Left sidebar → "Ad groups" (or click "Ad groups" in the main content area)
3. Click the blue "+" button → "Standard ad group"
4. Name the ad group (e.g., "Canary - HVAC Replacement")
5. Add keywords in the keyword section
6. Set bid strategy (default to campaign-level)
7. Save

### Add Keywords to Existing Ad Group

1. Navigate to the campaign → ad group
2. Left sidebar → "Keywords" → "Search keywords" tab
3. Click blue "+" button → "Add keywords"
4. Type keywords with match type notation:
   - `[keyword]` = Exact match
   - `"keyword"` = Phrase match
   - `keyword` = Broad match
5. Save

### Create RSA (Responsive Search Ad)

1. Navigate to target ad group
2. Click "Ads" in left sidebar or content area
3. Click blue "+" → "Responsive search ad"
4. Add headlines (minimum 3, target 10-12):
   - **PIN H1** to primary keyword-matched headline
   - **PIN H2** to phone number or strongest value prop
5. Add descriptions (minimum 2)
6. Set final URL to the landing page
7. Add display path (e.g., `/plumbing` `/repair`)
8. Save

### Deploy Ad Extensions (Assets)

1. Navigate to campaign level (or account level for shared extensions)
2. Left sidebar → "Assets" → "Assets" 
3. Click blue "+" button
4. Select extension type:
   - **Sitelinks:** 4 minimum per campaign
   - **Callouts:** 4-6 text callouts (e.g., "24/7 Emergency Service")
   - **Call:** Phone number with call reporting enabled
   - **Structured snippets:** Type = "Services", values = service names
5. Save

### Apply Bid Adjustments

1. Navigate to the target campaign
2. Left sidebar → "Keywords" → "Search keywords"
3. Find the keyword to adjust
4. Click the bid column → enter new bid (or use percentage adjustment)
5. Save

---

## Utah Canary Campaign Strategy

### What Canary Campaigns Are
Canary campaigns are low-budget test campaigns ($2-10/day) with high-intent, symptom-based keywords designed to validate demand before scaling.

### Current Canary Structure (April 2026)
```
Utah-HVAC-Search
├── Canary - HVAC Replacement (furnace/AC replacement keywords)
├── Canary - HVAC Emergency (emergency heating/cooling repair)
└── (expand based on search term report insights)

Utah-Plumbing-Search
├── Canary - Emergency Plumbing (burst pipe, leak, etc.)
├── Canary - Water Softener
└── (expand based on performance)

Utah-WH-Search
├── Water Heater Repair (primary)
├── Water Heater Replacement
└── Tankless Water Heater
```

### Keyword Design Principles
1. **Symptom-based intent:** "[problem] + [service]" — e.g., "furnace not working", "pipe burst"
2. **Replacement intent:** "[system] replacement" — e.g., "ac unit replacement salt lake city"
3. **Exact match first:** Start with `[exact match]` to control spend
4. **Geo-modified:** Include city/state in keywords where natural
5. **Night/weekend wedges:** +20-30% bid adjustment during 6pm-6am and weekends (emergency intent)

### Pending: Greg Romans Financing Question
Before creating financing-related ad copy or keywords, confirm with Greg Romans:
- Does Utah location offer financing?
- Which financing partner? (GreenSky, Service Finance, etc.)
- What terms can be advertised? (0% APR, 60 months, etc.)

---

## Verification After Changes

Always verify changes after making them:

1. **Change History:** Left sidebar → "Change history" → filter by user → verify only intended campaigns were modified
2. **Negative Keywords Tab:** Filter by campaign name to see all negatives
3. **Campaign Filter:** When viewing keywords/negatives across campaigns, use the campaign filter to isolate Utah campaigns
4. **Ad Preview:** Use "Ad Preview and Diagnosis" tool to check Utah geo + keyword targeting

---

## Known Gotchas

### Ad Group Creation: Auto-Populated Keywords
When creating a new ad group, Google Ads auto-populates "Products or services" tags based on existing ad groups. These generate **junk broad match keywords**.

**Fix:** Before entering keywords in the textarea:
1. Remove ALL auto-suggested tags by clicking the X on each tag
2. Clear the keywords textarea with Cmd+A → Delete
3. THEN paste your exact/phrase match keywords
4. After saving, verify no broad match junk was added — if so, select and Remove them

### Ad Group Name Field
Use **Cmd+A** to select all, then type the new name to replace. Do NOT try to backspace character by character.

### Enhanced Conversions Verification Delay
After enabling enhanced conversions, Google needs 1-3 days to verify data flow. The diagnostics page may show warnings during this period — this is normal.

### Google Ads API Token
To use the Google Ads API for programmatic changes (offline conversion import, automated reporting), you need an API developer token. Apply at: **Tools & Settings → Setup → API Center** or `https://ads.google.com/aw/apicenter?ocid=...`

---

## Guardrails

- **UTAH ONLY:** Never modify DSM-* campaigns for Utah work
- **Match types matter:** Use exact `[kw]` for high-intent, phrase `"kw"` for discovery
- **Pin RSA headlines:** Always pin H1 and H2 — Google's auto-combination creates bad pairings
- **Manual CPC first:** Don't use Smart Bidding until we have 15+ conversions
- **Budget caps:** Canary budgets are intentionally low ($2-10/day) — don't increase without explicit approval
- **Dayparting:** Utah campaigns run 5am-10pm MT — check ad schedule before launch
- **Night/weekend bidding:** Apply +20-30% bid adjustments for after-hours (emergency intent)

## Campaign Landing Pages

| Campaign | Landing Page |
|----------|-------------|
| Utah-Plumbing-Search | `goldenrulephc.com/location-utah-urgent-repair-plumbing-ppc/?loc=UT` |
| Utah-HVAC-Search | `goldenrulephc.com/hvac-replacement-salt-lake-city/?loc=UT` (Replacement) / `goldenrulephc.com/heating-cooling/?loc=UT` (Generic repair) |
| Utah-WH-Search | `goldenrulephc.com/utah-water-heater-repair-ppc/?loc=UT` |


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
