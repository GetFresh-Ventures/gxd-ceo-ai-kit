---
name: aprio-seo-page-deployment
description: >
  End-to-end methodology for building, styling, deploying, and validating Aprio SEO regulatory landing pages via the WordPress REST API.
  Use when: creating new Aprio SEO landing pages, migrating blog posts to landing pages, or fixing design elements across Aprio content.
  Skip when: performing generic code changes not related to Aprio WordPress content.
---

# Aprio SEO Page Deployment

## Overview
This skill codifies the standard operating procedure for deploying high-intent, regulatory-driven landing pages to the Aprio WordPress site (`aprioboardportal.com`). It ensures that all new pages share the exact same design language, correct CTA button styling (matching the Aprio Elementor theme), responsive table formatting, and deployment validation checklist.

## When to Trigger
- Creating new regulatory/SEO landing pages for Aprio.
- Updating existing Aprio WordPress pages programmatically.
- Fixing CTA buttons, tables, or design elements across Aprio content files.
- The user asks to "deploy Aprio pages" or "build a new Aprio landing page."

## When to Skip
- Modifying non-Aprio WordPress sites.
- Backend infrastructure tasks un-related to content publishing.

## Core Protocol

### 1. Preparation & Content Formatting
All Aprio landing pages must be formatted with consistent HTML structures before deployment.
- **CTA Buttons:** Ensure CTA buttons use the Aprio Elementor-compatible styling or exact inline equivalents. 
  - *Primary Button (`#26C571` Green):* `<a href="[URL]" style="display: inline-block; background-color: #26C571; color: #ffffff; padding: 12px 22px; text-decoration: none; border-radius: 3px; border: 3px solid #26C571; font-weight: 800; font-size: 18px; font-family: 'Open Sans', sans-serif; text-transform: uppercase;">Primary CTA</a>`
  - *Secondary Button (Transparent/Outline):* `<a href="[URL]" style="display: inline-block; background-color: transparent; color: #005587; padding: 12px 22px; text-decoration: none; border-radius: 3px; border: 3px solid #005587; font-weight: 800; font-size: 18px; font-family: 'Open Sans', sans-serif; text-transform: uppercase;">Secondary CTA</a>`
- **Tables:** Comparison tables must be fully responsive and styled cleanly.
  - Wrap tables in `<div style="overflow-x: auto;">`
  - Table header background: `#f5f5f5` or `#005587` with white text.
  - Use `border-collapse: collapse; width: 100%;` on the `<table>` element.
- **Lists:** Unordered lists should have sufficient line-height (`1.6`) and margin.

### 2. Deployment via WordPress REST API
Aprio restricts standard REST API Application Passwords for `POST` (create/update) requests. You must use cookie-based authentication with a REST Nonce.
- **Script Location:** Navigate to `/Users/dirajgoel/Documents/Code/aprio-dashboard/scripts/`.
- **Deploy Script:** Use the `deploy_v2_fixed.py` (or equivalent) Python script.
- **Credentials:** The script pulls from the keychain/1Password for `diraj` Aprio login, fetches auth cookies, retrieves a nonce, and then programmatically pushes `.html` and `.jsonld` schema payloads to the `/wp-json/wp/v2/pages` endpoint.

### 3. Validation Checklist
After successful deployment (HTTP 200), **you must perform a visual audit:**
1. Navigate to the live page URL using the chrome-devtools-mcp.
2. Take a full-page screenshot.
3. Validate typography, spacing, and bullet points.
4. Verify the primary and secondary CTA buttons are bold, uppercase, correctly colored (Green/White or Blue-Outline), and visible.
5. Verify tables do not overflow or break the mobile viewport.

### 4. Post-Deployment Steps
- Submit the new URLs to Google Search Console for priority indexing.
- Update the global Footer Navigation WPCode snippet in WordPress so orphan pages do not 404.
- Track status on the Linear board.

## GFV Integration
- Integrates with the `deploy_v2_fixed.py` Python script.
- Aligned with the 2026 GFV Regulatory/Intent SEO strategy for Aprio.

## ⛔ HARD RULE: Do No Harm to Existing Organic Traffic

Organic search is Aprio's primary traffic source. Every change must be evaluated against this gate:

1. **NEVER modify title tags, H1 tags, URL slugs, or content on pages that existed BEFORE GFV engagement** without first reviewing that page's GSC performance data (impressions, clicks, position) and getting Diraj's explicit approval.
2. **Only additive changes on existing pages** — adding meta descriptions, OG tags, schema markup, or internal links is safe. Changing titles, headings, or content structure is NOT safe without data review.
3. **Pages WE created are safe to modify** — they have zero existing organic history.
4. **When in doubt, check GSC first** — if a page has >100 impressions/month, treat it as "existing with traffic" and apply rule #1.
5. **Log every change** — maintain a changelog of what was modified, when, and the GSC baseline at time of change so any traffic impact can be traced.

### How to Identify "Existing" vs "Our" Pages
- **Our pages:** Any page with WP ID ≥ 13076 (first page we created was `landing-free-trial` on April 13, 2026)
- **Existing pages:** Any page with WP ID < 13076 — these were created by Aprio before our engagement

## Anti-Patterns
- **⛔ DO NOT** change title tags or H1s on existing Aprio pages without GSC data review and explicit approval.
- **DO NOT** use generic inline CTA styles with basic `#1a8c8c` teal. Always use the Aprio global design tokens (`#26C571` accent, `#005587` primary, Open Sans, Uppercase, 800 weight).
- **DO NOT** attempt to deploy via Basic Auth (Application Passwords). It will fail with a 401 error on `POST` requests. Use the cookie/nonce script.
- **DO NOT** deploy without visually auditing the CTA buttons in the browser.

## References
- **Target Audience:** Aprio Board Portal prospects.
- **GFV Standard:** GTM Content Deployment.


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
