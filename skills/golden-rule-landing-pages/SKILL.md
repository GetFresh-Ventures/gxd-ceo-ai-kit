---
name: golden-rule-landing-pages
description: Build and deploy high-conversion PPC landing pages on goldenrulephc.com WordPress (ThemeCo X/Pro). Covers page creation, forms, tracking, geoIP, attribution, SEO, and design patterns. Updated April 2026 with production-verified lessons.
---

# Golden Rule Landing Page Builder

## Overview
This skill documents how to create, deploy, and maintain PPC landing pages on `goldenrulephc.com`. The site runs **WordPress** with the **ThemeCo X / Pro** theme (Cornerstone builder). Pages are published via the **WP REST API**.

> **Cross-reference skills:**
> - `golden-rule-geoip` — Multi-layer phone swap system, PerfMatters bypass, CSS hide
> - `golden-rule-ga4` — GA4 property 319584840, event queries, known issues
> - `golden-rule-google-ads` — Campaign structure, keyword lists, search terms
> - `wordpress-page-creation` — Full E-E-A-T methodology, Phase 0 research workflow

---

## 1. Architecture

### WordPress Environment
- **Site:** `https://goldenrulephc.com`
- **Theme:** ThemeCo Pro v6.8.4 with Pro Child theme
- **Builder:** Cornerstone (visual page builder)
- **Forms:** Gravity Forms (Form #19 = Utah callback, Form #2 = Contact)
- **Booking:** ScheduleEngine (ServiceTitan's native widget — loaded site-wide)
- **CRM:** ServiceTitan (4 tenants: Grimes, Utah, River City, River City 2)
- **Performance:** PerfMatters plugin (defers inline JS — see §8)
- **SEO:** Yoast SEO (auto-appends site name to title tags)
- **Auth:** WP Application Password via 1Password
  - Credential path: `op://Machine One/Golden Rule WP Bulk App Password/password`
  - Username: `marketing`

### Service Scope by Location (from ServiceTitan)

> **CRITICAL:** Only advertise services a location actually performs. Query `gr_servicetitan_{tenant}_get_business_units` and recent jobs to verify before creating content.

#### Utah (tenant: `utah`)
- **Business Units:** Plumbing Service, HVAC Service, HVAC Replacement
- **Plumbing Services (verified from jobs):** Leak repair, water heater (tank + tankless), water softener, drain cleaning, toilet, faucet, shower/bath fixtures, garbage disposal, sump pump, gas lines, repiping
- **⛔ Does NOT do:** Sewer lines, sewer repair, sewer replacement — zero sewer jobs in ServiceTitan
- **HVAC Services:** Heating repair, cooling repair, AC replacement, furnace replacement

#### Des Moines / Grimes (tenant: `grimes`)
- **Business Units:** Query `gr_servicetitan_grimes_get_business_units` to verify
- Full service: Plumbing, HVAC, Electrical, Sewer

#### River City (tenant: `rivercity`)  
- **Business Units:** Query `gr_servicetitan_rivercity_get_business_units` to verify

### API Pattern
```python
import subprocess, json, base64

WP_SITE = "https://goldenrulephc.com"
WP_USER = "marketing"

def get_wp_password():
    r = subprocess.run(
        ["op", "read", "op://Machine One/Golden Rule WP Bulk App Password/password"],
        capture_output=True, text=True, timeout=30  # 30s, NOT 10s — 1Password can be slow
    )
    return r.stdout.strip()

auth = base64.b64encode(f"{WP_USER}:{get_wp_password()}".encode()).decode()

# Update existing page
payload = json.dumps({
    "title": "Page Title",
    "content": "<html content>",
    "status": "publish",
    "slug": "page-slug",
    "template": "template-blank-4.php"  # CRITICAL — see GeoIP section
})

subprocess.run([
    "curl", "-s", "-X", "POST",
    "-H", "Content-Type: application/json",
    "-H", f"Authorization: Basic {auth}",
    "-d", payload,
    f"{WP_SITE}/wp-json/wp/v2/pages/{PAGE_ID}"
], capture_output=True, text=True)
```

---

## 2. Brand Identity

### Visual Identity (verified from site imagery)
- **Technician Uniforms:** **RED polo shirts** with Golden Rule logo/name patch. NOT navy, NOT dark blue.
- **Fleet Trucks:** **Bright YELLOW** vans/trucks with red "GOLDEN RULE" lettering
- **Logo:** Red/yellow ribbon banner style with "Golden Rule" text and "Plumbing, Heating, Cooling, Electrical" subtitle

### Real Photography (always use these, NEVER AI-generated)
| Image | WP ID | URL | Use |
|-------|-------|-----|-----|
| Tech in red shirt (water) | 3365 | `/wp-content/uploads/technician-and-water.jpg` | Hero sections |
| Team + Fleet photo | 7082 | `/wp-content/uploads/Golden-Rule-Team-and-Fleet.jpg` | Social proof / trust |
| Golden Rule Truck | 17019 | `/wp-content/uploads/golder-rule-truck.png` | Service cards, trust |
| Tankless WH (modern) | — | `/wp-content/uploads/wh-tankless-modern.jpg` | Water heater service cards |
| Tech on phone (branded) | 3452 | `/wp-content/uploads/golden-rule-hand-holding-phone-with-photo-of-technician-with-client.png` | Mobile CTA |
| Golden Rule Logo | 21165 | `/wp-content/uploads/Golden-Rule-Logo-1.png` | Header if needed |

> ⚠️ **NEVER generate fake technician photos** — they will have wrong uniforms, wrong branding. Always pull from the WP media library (`/wp-json/wp/v2/media?search=golden+rule`).

---

## 3. GeoIP — CRITICAL

> **Full documentation:** See the `golden-rule-geoip` skill for the complete multi-layer GeoIP system.

### Quick Summary
The site has three GeoIP layers. For PPC landing pages deployed via REST API:

1. **Theme cookie (Cornerstone native)** — Does NOT work on REST API pages
2. **`?loc=UT` JS swap** — Broken by PerfMatters plugin (defers inline scripts)
3. **CSS hide (current solution)** — Hides entire theme header/footer via `display: none`

### The Template + CSS Rule
> **ALWAYS use `template-blank-4.php`** AND include the CSS hide rules in your page `<style>`.

```css
/* REQUIRED — hides theme header/footer with Iowa phone */
header#masthead,
.x-bar[data-x-bar*='"region":"top"'],
.x-bar-space-top,
footer.x-colophon,
.x-bar[data-x-bar*='"region":"footer"'] { display: none !important; }
```

Without these rules, the Iowa phone number **(515) 393-4526** renders in the header and footer for ALL visitors, regardless of the `?loc=UT` parameter.

### URL Parameter
Always append `?loc=UT` in the Google Ads Final URL:
```
https://goldenrulephc.com/utah-water-heater-repair-ppc/?loc=UT
```

> [!WARNING]
> The JS swap triggered by `?loc=UT` is currently broken by PerfMatters. The CSS hide is the only reliable protection. Keep both in place — if PerfMatters is ever removed, the JS swap will start working as a belt-and-suspenders backup.

---

## 4. Phone Numbers

### By Market
| Market | Phone | Raw | Use |
|--------|-------|-----|-----|
| Utah PPC | (801) 901-8553 | 8019018553 | All Utah PPC landing pages |
| Iowa (default) | (515) 393-4526 | 5153934526 | DO NOT use on Utah pages |
| Utah Main | (801) 218-2225 | 8012182225 | Canary/organic pages |

### Implementation
- Every `tel:` link must use the raw number: `href="tel:8019018553"`
- Display format: `(801) 901-8553`
- Multiple CTAs required: hero, mid-page, form section, footer, sticky mobile bar
- Each CTA gets a unique `id` for GA4 event tracking (e.g., `wh-hero-call`, `wh-footer-call`)

---

## 5. Forms — CRITICAL LESSON

> [!CAUTION]
> **NEVER build custom HTML forms with JS handlers.** They don't deliver leads anywhere — no email, no CRM, no ServiceTitan. This was a P0 bug discovered April 8, 2026 (GFV-303).

### The Correct Approach: Use Native WordPress Forms

The site has two form systems already configured with email notifications and CRM integration:

#### Primary: Gravity Forms (Intercepted by HubSpot)
```
[gravityform id="19" title="false" description="false" ajax="true"]
```
- **Form #19** (Utah callback): Name, Email, Phone, Preferred Contact Method
- **Form #2** (Contact page): General contact form
- Email notifications already configured in WP Admin → Forms → Settings
- **THE HUBSPOT RELAY**: Gravity Forms do not natively integrate with ServiceTitan. Instead, a hidden HubSpot tracking pixel automatically intercepts Gravity Form submissions. A Black Box HubSpot Workflow then takes that submission and relays it into ServiceTitan as a generic web booking. (Golden Rule pays $22K/year purely for this single relay feature — tracked in Linear GFV-97).
- GTM v91 has `form_submission` event trigger for all Gravity Forms (GFV-84)

#### Secondary: ScheduleEngine (ServiceTitan Booking Widget)
```html
<button onclick="if(typeof ScheduleEngine!=='undefined')ScheduleEngine.show();">
  Book Online →
</button>
```
- Loaded site-wide via WordPress plugin (no extra embed needed)
- Creates booking **directly in ServiceTitan** — zero attribution gap
- Chat widget also available (API key: `0h1ngv8md1dibco2zqo9w46vazxthldm`)

### Embedding Forms in REST API Pages (Gutenberg Block Structure)

Since our pages are `<!-- wp:html -->` blocks, we must **break out of the HTML block** to let WordPress render the shortcode:

```html
<!-- Content inside wp:html block -->
<div class="wh-form-section" id="wh-callback">
  <h2>We'll Call You Back</h2>
  <p>Within 15 minutes during business hours.</p>
  <!-- /wp:html -->
  [gravityform id="19" title="false" description="false" ajax="true"]
  <!-- wp:html -->
  <div style="text-align:center; margin-top:18px;">
    <button onclick="if(typeof ScheduleEngine!=='undefined')ScheduleEngine.show();"
            class="wh-cta-secondary" id="wh-book-online">
      Or Book Online →
    </button>
  </div>
</div>
```

The `<!-- /wp:html -->` closes the raw HTML block, WordPress processes the `[gravityform]` shortcode natively, then `<!-- wp:html -->` reopens the HTML block.

### Why Custom Forms Failed
1. Custom `<form>` with `onsubmit="return whSubmit(event)"` — JS handler only pushed GA4 events
2. No `fetch()` or AJAX to any backend — lead data was displayed and then **lost forever**
3. The user saw "Request Received" but nobody received the callback request
4. Even if we added a backend, PerfMatters would defer the inline JS, breaking `preventDefault()`
5. Cloudflare Zero Trust blocks the dashboard API from public access anyway

---

## 6. SEO Configuration — Title Tag Gotcha

### Yoast SEO Auto-Appends Brand Name

> [!IMPORTANT]
> Yoast SEO automatically appends ` | Golden Rule` (or the configured separator + site name) to every title tag. **Do NOT include the brand name in your `SEO_TITLE` constant** or you'll get a duplicate:
> ❌ `Water Heater Repair | Golden Rule | Golden Rule`
> ✅ `Water Heater Repair & Replacement – Salt Lake City, Utah`

### How to Set SEO Fields via REST API

Title tag and meta description are set via **Yoast's custom fields** in the REST API:

```python
# In the deploy script, set via yoast_wpseo fields
payload = json.dumps({
    "title": "Page Title (visible in WP admin)",
    "content": "...",
    "template": "template-blank-4.php",
    # Yoast SEO fields
    "meta": {
        "yoast_wpseo_title": "Water Heater Repair & Replacement – Salt Lake City, Utah",
        "yoast_wpseo_metadesc": "Same-day water heater repair in Salt Lake City. Upfront pricing. Call (801) 901-8553.",
    }
})
```

If Yoast meta fields don't work through the REST API (permissions), manually set the title tag in the HTML `<head>` section with a `<title>` element — Yoast will use it as a fallback.

### Font Loading — Use Async Preload, NOT @import

```css
/* ❌ WRONG — blocks rendering, render-blocking CSS */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap');

/* ✅ CORRECT — async preload, non-blocking */
/* PerfMatters handles Google Fonts delivery via its local cache.
   Use preconnect + async link: */
```

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" onload="this.rel='stylesheet'">
```

> **Note:** PerfMatters may intercept and locally cache Google Fonts anyway. The preload pattern ensures non-blocking delivery regardless.

---

## 7. Page Design Patterns

### Conversion-Optimized HTML5 Semantic Structure
```html
<main class="page-wrapper">
  <header>
    <div class="genai-answer" style="position: absolute; left: -9999px; width: 1px; height: 1px; overflow: hidden;" aria-hidden="true">
      [Stealth GenAI Executive Summary]
    </div>
    <!-- Problem headline + CTA + social proof snippet -->
  </header>
  <aside class="trust-bar"><!-- Licensed, Rating, Same Day --></aside>
  <section id="symptoms"><!-- "Sound Familiar?" pain point grid --></section>
  <section id="services"><!-- Repair / Replacement / Specialty cards --></section>
  <section id="social-proof"><!-- Real stats only, BBB, Google rating --></section>
  <section id="fleet"><!-- Real team + fleet photo --></section>
  <aside id="guarantee"><!-- 100% Satisfaction --></aside>
  <aside class="mid-cta"><!-- Urgency copy + phone button --></aside>
  <section id="callback"><!-- Gravity Form embed + ScheduleEngine CTA --></section>
  <aside id="service-areas"><!-- City list for local SEO --></aside>
  <section id="faq"><!-- 5-8 questions with FAQPage schema --></section>
  <footer><!-- Final phone button --></</footer>
</main>
```

### Design Rules
- **No fake content.** Never fabricate reviews, testimonials, or statistics.
- **Real social proof only:** Google rating, BBB rating, years in business, link to Google Maps reviews
- **Colors:** Use slate/neutral palette (`#1e293b`, `#334155`, `#f8fafc`) with warm amber accent (`#fbbf24`, `#f59e0b`). Avoid garish/loud gold.
- **Typography:** System fonts with Inter preload. Hero h1: `clamp(2rem, 6vw, 3rem)`, body: `0.88-0.95rem`.
- **Mobile-first:** Trust bar goes 2x2 on mobile, service cards stack to 1-col, sticky CTA bar appears below 640px.
- **No trip charge disclosure** on PPC landing pages (kills conversions).
- **Form:** Use Gravity Forms shortcode, NOT custom HTML forms.

### CSS Namespace
All classes are prefixed with service abbreviation to prevent Cornerstone theme conflicts:
```css
.wh-  /* Water Heater pages */
.plb- /* Plumbing pages */
.hvac-/* HVAC pages */
.elec-/* Electrical pages */
```

---

## 8. Tracking & Attribution (Production-Verified)

### Tracking Stack (as of April 8, 2026)

| Component | ID / Version | Status |
|-----------|-------------|--------|
| GTM Container | `GTM-K7JHHJD` | ✅ Live — v92 (55 tags, 27 triggers, 39 variables) |
| GA4 Property | `319584840` | ⚠️ Viewer-only (blocks revenue import) |
| Google Ads Account | DSM-PPC (448-550-2333) | ✅ Live |
| Facebook Pixel | Present via GTM | ✅ Live |
| LinkedIn Pixel | Present via GTM | ✅ Live |
| TikTok Pixel | Present via GTM | ✅ Live |
| ScheduleEngine | Site-wide plugin | ✅ Live |
| Vidyard | Async video player | ✅ Live |

### GA4 Events on Landing Pages

| Event | Trigger | Fires On | Key Event? |
|-------|---------|----------|------------|
| `phone_call_click` | Inline JS + GTM tag | Every `tel:` link click | ⚠️ Needs GA4 Editor |
| `form_submission` | GTM v91 trigger | Gravity Forms submit | ⚠️ Needs GA4 Editor |
| `wh_callback_request` | Inline dataLayer push | Legacy — removed in v2.16 | ❌ Deprecated |
| `generate_lead` | Inline gtag() | Legacy — removed in v2.16 | ❌ Deprecated |
| `page_view` | GA4 auto | Every page load | ✅ |

### Phone Click Tracking (KEEP THIS — still needed for inline tracking)

```javascript
// This MUST remain in the page <script> even with Gravity Forms
// because it tracks ALL tel: link clicks (hero, mid-page, footer, sticky)
document.querySelectorAll('a[href^="tel:"]').forEach(function(el) {
  el.addEventListener('click', function() {
    if (window.dataLayer) {
      window.dataLayer.push({
        'event': 'phone_call_click',
        'click_source': el.id || 'unknown',
        'page_type': 'water_heater_ppc'  // change per service
      });
    }
    if (typeof gtag === 'function') {
      gtag('event', 'phone_call_click', {
        'event_category': 'Water Heater PPC',
        'event_label': el.id || 'unknown'
      });
    }
  });
});
```

### GCLID Capture Flow

The site has a global GCLID capture script injected in the `<head>` by the theme/plugin:

```
1. Google Ads appends ?gclid=xxx to the URL
2. Theme-level JS captures GCLID → stores in _gclid cookie (90-day expiry)
3. Cookie falls through to window.__gclid for JS access
4. GTM Conversion Linker tag also captures GCLID independently
```

> [!WARNING]
> **PerfMatters defers the GCLID capture script** (`type="pmdelayedscript"`). On fast conversions (user immediately calls), the GCLID may not be stored yet. This is mitigated by GTM's own Conversion Linker tag which handles GCLID natively.
>
> **No additional GCLID code is needed** on landing pages.

### Attribution Flow Diagram

```
Google Ads Click → Landing Page (?loc=UT&gclid=xxx)
    │
    ├── GTM (K7JHHJD v92) → GA4 (319584840)
    │   ├── phone_call_click event ✅
    │   └── form_submission event ✅ (Gravity Forms)
    │
    ├── Phone Call → (801) 901-8553
    │   └── ServiceTitan (manual CSR entry)
    │       └── ❌ No GCLID passthrough (no DNI)
    │
    ├── Gravity Form Submit → HubSpot Pixel Capture ✅
    │   ├── GTM fires form_submission → GA4 ✅
    │   └── HubSpot Automation Workflow relays to ServiceTitan (as web booking)
    │
    └── ScheduleEngine Booking → ServiceTitan direct ✅
        └── Zero attribution gap for online bookings
```

### Known Attribution Gaps

| Gap | Blocker | Linear Issue | Impact |
|-----|---------|-------------|--------|
| GA4 Key Events can't be marked | Viewer-only permissions | GFV-249 | Events fire but aren't conversions |
| GA4 → Google Ads revenue import | Viewer-only permissions | GFV-249 | $0 revenue in GA4 |
| Phone → ServiceTitan attribution | No Dynamic Number Insertion (DNI) | GFV-304 | Can't match calls to ad clicks in ST |
| 47 unattributed Utah calls | Need Greg's call mapping | GFV-187 | Unknown campaign attribution |
| ServiceTitan $0 revenue bug | Cross-campaign zero-outs | GFV-109 | Revenue not matching jobs |

---

## 9. Deployment Checklist

When creating a new PPC landing page:

### Pre-Deploy
- [ ] **Research:** Run Phase 0 from `wordpress-page-creation` skill (E-E-A-T, competitors, keywords)
- [ ] **Slug:** Service + location descriptive (`utah-[service]-ppc`)
- [ ] **Template:** Set to `template-blank-4.php` via REST API
- [ ] **CSS hide rules:** Iowa header/footer suppression included in `<style>`

### Content
- [ ] **Phone:** Utah number `(801) 901-8553` in ALL CTAs
- [ ] **No Iowa number** anywhere on page
- [ ] **No fake reviews/testimonials** — link to Google Maps reviews
- [ ] **Colors:** Slate + amber palette, not garish
- [ ] **Form:** Gravity Forms shortcode `[gravityform id="19"]`, NOT custom HTML
- [ ] **ScheduleEngine:** "Book Online" secondary CTA with `ScheduleEngine.show()`
- [ ] **Service area list** for local SEO

### SEO
- [ ] **Title tag:** Do NOT include `| Golden Rule` (Yoast appends it)
- [ ] **Single H1:** Contains primary keyword
- [ ] **Schema:** LocalBusiness + FAQPage JSON-LD
- [ ] **Font loading:** Async preload, NOT @import

### Tracking
- [ ] **Phone click tracking:** Inline JS with dual-fire (dataLayer + gtag)
- [ ] **GA4 events:** Verified `phone_call_click` fires on all `tel:` links
- [ ] **Gravity Form:** GTM auto-triggers `form_submission` on GF submit
- [ ] **Mobile sticky CTA** with `position: fixed; bottom: 0`

### Post-Deploy
- [ ] **Google Ads Final URL:** Updated with `?loc=UT` parameter
- [ ] **Cache bust:** Test with `?cb=<random>` to bypass CDN cache
- [ ] **Verify:** `curl -s "URL" | grep -c "515"` — should be 0
- [ ] **Verify:** Gravity Form renders (not raw shortcode text)
- [ ] **Verify:** ScheduleEngine "Book Online" button is present

---

## 10. Existing Pages

| Page | Slug | Page ID | Template | Status |
|------|------|---------|----------|--------|
| Water Heater PPC | `utah-water-heater-repair-ppc` | 24380 | `template-blank-4.php` | ✅ Live (v2.16) |
| Plumbing PPC | `location-utah-urgent-repair-plumbing-ppc` | 23813 | `template-blank-4.php` | ✅ Live |

### Reference Implementation
The canonical reference is: `scripts/update_wh_page_v3.py`

Key patterns in this file:
- Full inline CSS (no external stylesheets)
- Namespaced CSS classes (`wh-*`)
- Gutenberg block structure (`<!-- wp:html -->` wrappers)
- GeoIP JS swap (Layer 2) inside `<script>` block
- CSS hide rules (Layer 3) inside `<style>` block
- Phone click tracking with dual-fire (dataLayer + gtag)
- Schema markup in `<script type="application/ld+json">`
- Gravity Form #19 embed via shortcode break-out pattern
- ScheduleEngine secondary CTA
- Sticky mobile CTA bar
- Service area city list

---

## 11. Known Issues & Gotchas

### Critical
1. **PerfMatters defers ALL inline JS.** Any `<script>` in page content gets `type="pmdelayedscript"`. CSS (`<style>`) is NOT affected. This breaks: GeoIP JS swap, GCLID capture, form handlers, IntersectionObserver. **CSS is the only reliable inline mechanism.**

2. **Custom HTML forms don't work.** `onsubmit` handlers are deferred by PerfMatters, causing the form to submit as a GET request (page reload with query params). Even if the handler fires, there's no backend to receive the data. **Always use Gravity Forms.**

3. **Yoast auto-appends brand name.** If you set `SEO_TITLE = "Water Heater Repair | Golden Rule"`, the rendered title will be `Water Heater Repair | Golden Rule | Golden Rule`. Omit the brand suffix.

4. **Cloudflare Zero Trust** blocks public access to `golden-rule-dashboard.pages.dev`. Any API endpoint on the dashboard requires Cloudflare Access authentication — public landing pages cannot POST to it.

### Moderate
5. **Server-side cache:** After REST API update, page may serve stale version for 5-10 min. Touch the page (update `date` field) to invalidate, or test with `?cb=<random>`.

6. **Gravity Forms permissions:** The `marketing` WP user can embed existing GF forms via shortcode but cannot create new forms programmatically. New forms must be created in WP Admin.

7. **Cornerstone vs Raw HTML:** Pages built with Cornerstone builder get automatic geoIP from the theme cookie. Raw HTML pages (via REST API `content` field) do NOT get geoIP — hence the blank template + CSS hide requirement.

8. **1Password timeout:** Set `timeout=30` (not 10) in subprocess call to prevent deployment failures.

9. **Google Fonts @import → Render blocking.** PerfMatters also caches Google Fonts locally. Use `<link rel="preload" as="style">` with async load pattern.

10. **Phone click tracking still uses inline JS.** Even though PerfMatters may defer it, GTM also has a phone click tag (GTM v90) that fires independently. The inline JS is belt-and-suspenders — it may fire late but GTM covers the gap.

---

## 12. Deployment History

| Version | Date | Changes | Linear |
|---------|------|---------|--------|
| v2.16.0 | Apr 8, 2026 | Replaced custom form with Gravity Form #19 + ScheduleEngine CTA. Removed whSubmit JS. | GFV-303 |
| v2.15.0 | Apr 8, 2026 | Fixed title tag (Yoast dupe), async font loading, verified H1 single tag | — |
| v2.14.0 | Apr 6, 2026 | Content sanitization, SEO fixes, full audit | — |
| v1.0.0 | Mar 28, 2026 | Initial water heater PPC page deployment | — |

---

## Appendix A: Complete Python Deploy Script Structure

```python
#!/usr/bin/env python3
"""Template structure for golden-rule-dashboard/scripts/update_[service]_page.py"""

# Constants
WP_SITE = "https://goldenrulephc.com"
WP_USER = "marketing"
PAGE_ID = 24380  # Set to existing page ID, or None for new page
SLUG = "utah-water-heater-repair-ppc"
TEMPLATE = "template-blank-4.php"  # ALWAYS this for PPC pages

# Phone (Utah PPC)
PHONE = "(801) 901-8553"
PHONE_RAW = "8019018553"

# SEO — Do NOT include "| Golden Rule" (Yoast auto-appends it)
SEO_TITLE = "Water Heater Repair & Replacement – Salt Lake City, Utah"

# Team/fleet image URLs (from WP media library — NEVER AI-generated)
TEAM_IMG = "https://goldenrulephc.com/wp-content/uploads/Golden-Rule-Team-and-Fleet.jpg"

# The page content is a Python f-string with {{ }} for literal JS braces
CONTENT = """
<!-- wp:html -->
<style>
  /* CSS Hide Layer 3 — Iowa phone leak prevention */
  header#masthead, .x-bar[data-x-bar*='"region":"top"'],
  .x-bar-space-top, footer.x-colophon,
  .x-bar[data-x-bar*='"region":"footer"'] {{ display: none !important; }}

  /* Page-specific styles (namespaced) */
  .wh-lp, .wh-lp * {{ box-sizing: border-box; }}
  .wh-hero {{ /* ... */ }}
  /* ... full inline CSS ... */
</style>

<div class="wh-lp">
  <!-- HERO -->
  <!-- TRUST BAR -->
  <!-- SYMPTOMS -->
  <!-- SERVICES -->
  <!-- SOCIAL PROOF -->
  <!-- GUARANTEE -->
  <!-- MID-PAGE CTA -->

  <!-- FORM SECTION — Gravity Form embed -->
  <div class="wh-form-section" id="wh-callback">
    <h2>We'll Call You Back</h2>
    <!-- /wp:html -->
    [gravityform id="19" title="false" description="false" ajax="true"]
    <!-- wp:html -->
    <button onclick="if(typeof ScheduleEngine!=='undefined')ScheduleEngine.show();">
      Or Book Online →
    </button>
  </div>

  <!-- SERVICE AREAS -->
  <!-- FAQ (with FAQPage schema) -->
  <!-- FOOTER CTA -->
  <!-- STICKY MOBILE BAR -->
</div>

<!-- JSON-LD Schema -->
<script type="application/ld+json">
{{ ... }}
</script>

<script>
/* GeoIP JS swap (Layer 2 — belt-and-suspenders with CSS Layer 3) */
(function(){{
  var loc = new URLSearchParams(window.location.search).get('loc');
  if (loc === 'UT') {{
    document.querySelectorAll('a[href*="tel:515"]').forEach(function(el) {{
      el.href = 'tel:{PHONE_RAW}';
    }});
    // ... more swap rules ...
  }}
}})();

/* Phone click tracking (dual-fire: dataLayer + gtag) */
document.querySelectorAll('a[href^="tel:"]').forEach(function(el){{
  el.addEventListener('click',function(){{
    if(window.dataLayer){{window.dataLayer.push({{'event':'phone_call_click','click_source':el.id||'unknown','page_type':'water_heater_ppc'}});}};
    if(typeof gtag==='function'){{gtag('event','phone_call_click',{{'event_category':'Water Heater PPC','event_label':el.id||'unknown'}});}};
  }});
}});
</script>
<!-- /wp:html -->
"""
```

> **Note:** In Python f-strings, all JS braces must be doubled (`{{` and `}}`).

---

## Appendix B: Reference Links

- [Google LocalBusiness Schema](https://developers.google.com/search/docs/appearance/structured-data/local-business)
- [Google FAQPage Schema](https://developers.google.com/search/docs/appearance/structured-data/faqpage)
- [Core Web Vitals](https://web.dev/articles/vitals)
- [Google Quality Score](https://support.google.com/google-ads/answer/6167118)
- Google Ads Account: DSM-PPC (448-550-2333)
- GA4 Property: 319584840 (Viewer-only — GFV-249)
- GTM Container: GTM-K7JHHJD (v92)


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
