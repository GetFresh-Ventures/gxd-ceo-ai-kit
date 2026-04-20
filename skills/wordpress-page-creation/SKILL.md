---
name: wordpress-page-creation
description: End-to-end methodology for creating high-conversion WordPress landing pages on goldenrulephc.com. Covers content strategy, SEO/SEM schema, design patterns, PageSpeed/Core Web Vitals, Google content standards (E-E-A-T), deployment via REST API, and post-launch validation. Research current best practices at runtime before generating content.
---

# WordPress Page Creation Skill — Golden Rule

## Purpose

A codified, repeatable process for creating **fully production-ready** WordPress pages on `goldenrulephc.com`. Every page published through this skill meets or exceeds:

- Google's E-E-A-T and Helpful Content standards
- Core Web Vitals thresholds (LCP, CLS, INP)
- Google Ads Quality Score landing page experience requirements
- Lighthouse targets: 90+ Performance, 90+ Accessibility, 100 Best Practices, 90+ SEO
- Competitive parity with top-ranking local service businesses

> **Runtime Research Mandate:** Before generating ANY page content, you MUST use `search_web` to research the **current** Google algorithm requirements, competitor landing pages, and CPC/conversion benchmarks for the target service + market. Do NOT rely on static knowledge — standards evolve quarterly.

---

## Phase 0: Pre-Build Research (MANDATORY)

Before creating any page, execute ALL of the following research steps:

### 0.1 — Google Algorithm & Content Standards

```
search_web: "Google [current year] content update requirements E-E-A-T helpful content standards"
search_web: "Google [current year] core web vitals thresholds LCP CLS INP ranking factors"
search_web: "Google Ads Quality Score landing page experience [current year] optimization"
```

**Extract and apply:**
- Current E-E-A-T signals required (Experience, Expertise, Authoritativeness, Trustworthiness)
- Any new Helpful Content system changes
- Current CWV thresholds (as of last known: LCP ≤ 2.5s, CLS ≤ 0.1, INP ≤ 200ms)
- Quality Score landing page experience factors

### 0.2 — Competitive Intelligence

```
# Use SEMrush skill if available
search_web: "[service] [city] best landing page examples [current year]"
search_web: "top [service] companies [city] Google Ads landing pages"
```

**Analyze top 3-5 competitors for:**
- Content depth and structure
- Schema markup used
- Trust signals deployed
- CTAs and conversion mechanisms
- PageSpeed scores

### 0.3 — Keyword & Intent Research

```
search_web: "[service] [city] high-intent keywords CPC conversion rate [current year]"
search_web: "[service] symptom-based search queries emergency intent"
```

**Build keyword map:**
- Primary keyword (H1, title tag, first paragraph)
- Secondary keywords (H2s, service descriptions)
- Long-tail/symptom keywords (FAQ section, body copy)
- Negative keywords (avoid cannibalizing other campaigns)

### 0.4 — Local Market Data

```
search_web: "[city] population demographics homeowner statistics"
search_web: "[service] average cost [city] [state] [current year]"
```

**Gather for content:**
- Service area cities/zip codes
- Average service costs (for price transparency signals)
- Local licensing requirements
- Seasonal demand patterns

---

## Phase 1: Page Architecture

### 1.1 — Page Type Selection

| Page Type | Purpose | URL Pattern | Template |
|-----------|---------|-------------|----------|
| **PPC Landing Page** | Paid traffic conversion | `/[state]-[service]-ppc/` | `template-blank-4.php` |
| **Service Page** | Organic SEO ranking | `/[service]/` | Default theme |
| **Location Page** | City/zip targeting | `/[service]-[city]/` | Default theme |

### 1.2 — Information Architecture (Mandatory Sections)

Every page MUST use semantic HTML5 elements (`<header>`, `<main>`, `<section>`, `<aside>`, `<footer>`) instead of generic `<div>` wrappers.

```html
<main class="page-wrapper">
  <!-- 1. HEADER & HERO (with Stealth GenAI Injection) -->
  <header>
    <!-- CRITICAL: Stealth GenAI Summary for LLMs (Perplexity/SGE) -->
    <div class="genai-answer" style="position: absolute; left: -9999px; width: 1px; height: 1px; overflow: hidden;" aria-hidden="true">
      [Keyword-dense Executive Summary matching search intent. State who we are, what we do, and our exact YMYL qualifications.]
    </div>
    <!-- Problem-aware headline + CTA + Hero image -->
  </header>

  <!-- 2. TRUST BAR -->
  <aside class="trust-bar">
    <!-- Licensed & Insured | Google Rating | Same-Day Service | Upfront Pricing -->
  </aside>

  <!-- 3. PAIN POINTS / SYMPTOMS -->
  <section id="symptoms">
    <!-- "Sound Familiar?" grid mapping to high-intent queries -->
  </section>

  <!-- 4. SERVICES CARDS (2-4 cards) -->
  <section id="services">
    <!-- Specific repairs/replacements with clear imagery -->
  </section>

  <!-- 5. WHY CHOOSE US / SOCIAL PROOF -->
  <section id="social-proof">
    <!-- Real stats ONLY. No fabricated reviews. Link to BBB -->
  </section>

  <!-- 6. TEAM / FLEET STRIP -->
  <section id="fleet">
    <!-- Real team photo, min 350px height -->
  </section>

  <!-- 7. GUARANTEE SECTION -->
  <aside id="guarantee">
    <!-- 100% Satisfaction Guarantee. Money-back. -->
  </aside>

  <!-- 8. MID-PAGE CTA -->
  <aside class="mid-cta">
    <!-- Urgency copy + phone button -->
  </aside>

  <!-- 9. FAQ SECTION -->
  <section id="faq">
    <!-- Maps to 'People Also Ask' queries. FAQPage schema required. -->
  </section>

  <!-- 10. CALLBACK FORM -->
  <section id="callback">
    <!-- Max 3 fields (name, phone, issue). Gravity Forms. -->
  </section>

  <!-- 11. SERVICE AREA LIST -->
  <aside id="service-areas">
    <!-- All served cities for local SEO -->
  </aside>

  <!-- 12. FOOTER CTA -->
  <footer>
    <!-- Final phone + hours -->
  </footer>
</main>
```

---

## Phase 2: SEO Requirements

### 2.1 — On-Page SEO Checklist

| Element | Requirement | Example |
|---------|-------------|---------|
| **Title Tag** | `[Service] [City], [State] \| [Brand]` ≤ 60 chars | `Water Heater Repair & Replacement – Salt Lake City, Utah \| Golden Rule` |
| **Meta Description** | Action-oriented, include phone, ≤ 155 chars | `24/7 water heater repair in Salt Lake City. Same-day service, upfront pricing. Call (801) 901-8553 for fast help.` |
| **H1** | One per page, includes primary keyword | `Water Heater Repair & Replacement in Salt Lake City` |
| **H2s** | Service-specific, include secondary keywords | `Expert Water Heater Repair`, `When to Replace Your Water Heater` |
| **Canonical URL** | Self-referencing canonical | `<link rel="canonical" href="https://goldenrulephc.com/[slug]/">` |
| **Alt Text** | Every image, descriptive + keyword | `Golden Rule technician repairing water heater in Salt Lake City home` |
| **Internal Links** | 2-3 links to related service/location pages | Link to HVAC, plumbing, general services pages |
| **Word Count** | Minimum 800 words for PPC, 1500+ for organic | Ensures content depth for E-E-A-T |

### 2.2 — Schema Markup (JSON-LD)

**Every page MUST include these schemas in `<script type="application/ld+json">`:**

#### LocalBusiness / Plumber Schema

```json
{
  "@context": "https://schema.org",
  "@type": "Plumber",
  "name": "Golden Rule Plumbing, Heating, Cooling & Electrical",
  "image": "https://goldenrulephc.com/wp-content/uploads/Golden-Rule-Logo-1.png",
  "url": "https://goldenrulephc.com/",
  "telephone": "+1-801-901-8553",
  "address": {
    "@type": "PostalAddress",
    "addressLocality": "Salt Lake City",
    "addressRegion": "UT",
    "postalCode": "84101",
    "addressCountry": "US"
  },
  "areaServed": {
    "@type": "State",
    "name": "Utah"
  },
  "priceRange": "$$",
  "openingHoursSpecification": {
    "@type": "OpeningHoursSpecification",
    "dayOfWeek": ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"],
    "opens": "00:00",
    "closes": "23:59"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "reviewCount": "2500",
    "bestRating": "5"
  },
  "paymentAccepted": "Cash, Credit Card, Check, Financing Available",
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "[Service] Services",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "[Service] Repair",
          "description": "[Description]"
        }
      }
    ]
  }
}
```

> ⚠️ **ALWAYS verify current review count and rating** — search `goldenrulephc.com Google reviews` before hardcoding.

#### FAQPage Schema

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[Question text — use 'People Also Ask' queries]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[2-4 sentence answer with actionable advice]"
      }
    }
  ]
}
```

**FAQ content rules:**
- Source questions from Google's "People Also Ask" for target keywords
- Include pricing questions (transparency = trust)
- Include emergency/urgency questions
- Include brand comparison questions
- Answers must demonstrate Experience and Expertise (E-E-A-T)

#### E-E-A-T Author Schema (YMYL Enhancement)

For all LocalBusiness rendering, embed the author parameters directly into JSON-LD to satisfy YMYL guidelines:
```json
"author": {
  "@type": "Person",
  "name": "Golden Rule Licensed Master Technician",
  "jobTitle": "Licensed Master Plumber/HVAC Technician",
  "worksFor": {
    "@type": "LocalBusiness",
    "name": "Golden Rule Plumbing, Heating, Cooling & Electrical"
  },
  "sameAs": [
    "https://en.wikipedia.org/wiki/Plumber",
    "https://www.bbb.org/us/ut/salt-lake-city/profile/plumber/golden-rule-plumbing-heating-cooling"
  ]
}
```

#### Service Schema

```json
{
  "@context": "https://schema.org",
  "@type": "Service",
  "name": "[Service Name]",
  "provider": { "@type": "LocalBusiness", "name": "Golden Rule" },
  "areaServed": { "@type": "City", "name": "[City]" },
  "description": "[Service description]",
  "offers": {
    "@type": "Offer",
    "priceRange": "$$"
  }
}
```

### 2.3 — Technical SEO

| Item | Requirement |
|------|-------------|
| **Robots** | `index, follow` (unless noindex for PPC A/B tests) |
| **Sitemap** | Verify page appears in `page-sitemap.xml` after publish |
| **GSC Indexing** | Submit URL via Google Search Console API or manual request |
| **Mobile Viewport** | `<meta name="viewport" content="width=device-width, initial-scale=1">` |
| **Language** | `<html lang="en">` |
| **Charset** | `<meta charset="UTF-8">` |

---

## Phase 3: SEM / Google Ads Alignment

### 3.1 — Landing Page ↔ Ad Copy Message Match

The landing page headline (H1) must **directly echo** the ad headline. Google measures this for Quality Score:

| Ad Headline | Landing Page H1 | Match Score |
|-------------|-----------------|-------------|
| "24/7 Water Heater Repair" | "24/7 Water Heater Repair in Salt Lake City" | ✅ Strong |
| "Expert Plumbers Near You" | "Bathroom Remodeling Services" | ❌ Mismatch |

### 3.2 — Quality Score Optimization Checklist

- [ ] H1 contains the primary search keyword
- [ ] Page loads in < 3 seconds (mobile)
- [ ] Phone number is immediately visible above the fold
- [ ] No interstitials or popups that block content
- [ ] Content is unique (not duplicated from other pages)
- [ ] Mobile-responsive with touch-friendly CTAs (min 44px tap targets)
- [ ] Clear, single conversion action (phone call or form)
- [ ] Trust signals visible above the fold (license, rating, guarantee)

### 3.3 — Final URL Configuration

```
# PPC landing pages
https://goldenrulephc.com/[slug]/?loc=UT

# The ?loc=UT parameter triggers GeoIP phone number swap
# Without it, the Iowa (515) number may display
```

### 3.4 — Ad Extensions Alignment

Ensure the landing page content supports these ad extensions:
- **Callout extensions:** "Same-Day Service", "Upfront Pricing", "Licensed & Insured"
- **Sitelink extensions:** Link to service sub-pages if they exist
- **Structured snippets:** "Services: Repair, Replacement, Installation, Maintenance"
- **Call extensions:** Must match the page phone number

---

## Phase 4: Design & Performance

### 4.1 — Visual Design System

#### Color Palette
```css
/* Primary (Dark) */
--gr-slate-900: #0f172a;
--gr-slate-800: #1e293b;
--gr-slate-700: #334155;
--gr-slate-100: #f1f5f9;
--gr-white: #f8fafc;

/* Accent (Warm Amber) */
--gr-amber-400: #fbbf24;
--gr-amber-500: #f59e0b;
--gr-amber-600: #d97706;

/* CTA (Red) */
--gr-red-600: #dc2626;
--gr-red-700: #b91c1c;

/* Trust (Green) */
--gr-green-500: #22c55e;
--gr-green-600: #16a34a;
```

#### Typography
```css
/* Font Stack */
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;

/* Scale */
--h1: clamp(2rem, 6vw, 3rem);     /* Hero headline */
--h2: clamp(1.5rem, 4vw, 2.2rem); /* Section headers */
--h3: clamp(1.1rem, 3vw, 1.4rem); /* Card titles */
--body: clamp(0.88rem, 2vw, 0.95rem); /* Body text */
--small: 0.8rem;                    /* Fine print */
```

#### CSS Namespace Convention
```css
/* All classes use service prefix to avoid Cornerstone conflicts */
.wh-  /* Water Heater pages */
.plb- /* Plumbing pages */
.hvac-/* HVAC pages */
.elec-/* Electrical pages */
```

### 4.2 — Image Requirements

| Requirement | Specification |
|-------------|---------------|
| **Format** | WebP preferred, fallback to JPEG/PNG |
| **Max Width** | 1200px for hero, 800px for cards |
| **Compression** | 80-85% quality for photos, 90% for product shots |
| **Lazy Loading** | `loading="lazy"` on all images below the fold |
| **Preload** | `<link rel="preload">` for hero image (LCP element) |
| **Alt Text** | Descriptive, includes service + location keywords |
| **Aspect Ratio** | Set explicit `width` and `height` attributes (prevents CLS) |
| **srcset** | Provide 480w, 768w, 1200w sizes for responsive |

**Image sources — ALWAYS use real branded photography:**
```
/wp-json/wp/v2/media?search=golden+rule
/wp-json/wp/v2/media?search=[service]
```

> ⚠️ **NEVER use AI-generated technician photos.** They will have wrong uniforms (red polos), wrong truck colors (yellow), and wrong branding.

### 4.3 — Core Web Vitals Targets

| Metric | Target | How to Achieve |
|--------|--------|----------------|
| **LCP** | ≤ 2.5s | Preload hero image, inline critical CSS, minimize render-blocking resources |
| **CLS** | ≤ 0.1 | Set explicit image dimensions, avoid dynamic content injection above fold |
| **INP** | ≤ 200ms | Minimize JS, use passive event listeners, defer non-critical scripts |
| **TTFB** | ≤ 800ms | WordPress caching, CDN (Cloudflare), optimize database queries |
| **FCP** | ≤ 1.8s | Inline critical CSS, preconnect to Google Fonts |

### 4.4 — Performance Optimization Checklist

```html
<!-- Preconnect to required origins -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- Preload LCP image -->
<link rel="preload" as="image" href="[hero-image-url]" fetchpriority="high">

<!-- Inline critical CSS (first 14KB) -->
<style>/* Critical above-the-fold styles */</style>

<!-- Defer non-critical CSS -->
<link rel="stylesheet" href="[full-styles]" media="print" onload="this.media='all'">

<!-- Defer JavaScript -->
<script defer src="[tracking-script]"></script>
```

**Rules:**
- Inline ALL CSS (no external stylesheets for single-page landing pages)
- Total HTML payload < 150KB
- No jQuery dependency (vanilla JS only)
- Defer all analytics/tracking code
- Use `font-display: swap` for web fonts
- Minimize DOM depth (< 1500 nodes)

### 4.5 — Mobile Responsiveness

```css
/* Breakpoints */
@media (max-width: 900px)  { /* Tablet adjustments */ }
@media (max-width: 640px)  { /* Mobile layout */ }
@media (max-width: 480px)  { /* Small phone */ }

/* Mobile requirements */
- Hero: single column, CTA above fold
- Trust bar: 2x2 grid (not 4-col)
- Service cards: stack to single column
- Tap targets: minimum 44px × 44px
- Sticky CTA bar: fixed bottom, only on mobile
- Phone number: clickable at all sizes
- Form: full-width inputs, large submit button
```

---

## Phase 5: Content Standards (E-E-A-T)

### 5.1 — Experience Signals

- Include real team photos (not stock)
- Mention specific years of experience
- Reference specific service areas by name
- Show real equipment/brands serviced
- Include real Google review rating with link to reviews

### 5.2 — Expertise Signals

- Mention specific licenses (Utah contractor license, etc.)
- Reference industry certifications
- Detail specific repair processes (demonstrates knowledge)
- FAQ answers should be technically accurate and detailed
- Include brand-specific expertise (Rheem, AO Smith, Bradford White)

### 5.3 — Authoritativeness Signals

- Link to BBB profile
- Show association memberships
- Reference years in business with specific founding date
- Include real team count/fleet size
- Cross-reference with Google Business Profile

### 5.4 — Trustworthiness Signals

- Real phone number (prominent, multiple placements)
- Physical business address (in schema, not always visible)
- Real Google rating with review count
- 100% Satisfaction Guarantee
- Upfront pricing commitment
- Licensed & Insured disclosure
- No fabricated testimonials — link to actual Google reviews page

### 5.5 — Content Quality Rules

- **Never fabricate reviews, statistics, or testimonials**
- **Never use AI-generated technician photos**
- **Always verify current review count/rating before publishing**
- **Always include actionable information** (what to do, when to call, what to expect)
- **Answer the user's intent** — if they searched "water heater not working," address that specific problem
- **Include pricing transparency** where possible (ranges, not exact quotes)
- **Demonstrate local knowledge** — mention local landmarks, neighborhoods, weather patterns

---

## Phase 6: Attribution & Tracking

### 6.1 — GA4 Event Setup

Every page must fire these dataLayer events:

```javascript
// Phone click tracking
document.querySelectorAll('a[href^="tel:"]').forEach(el => {
  el.addEventListener('click', () => {
    if (window.dataLayer) {
      window.dataLayer.push({
        event: 'phone_call_click',
        click_source: el.id || 'unknown',
        page_type: '[service]_ppc',
        page_url: window.location.pathname
      });
    }
  });
});

// Form submission tracking
function trackFormSubmission(name, phone, issue) {
  if (window.dataLayer) {
    window.dataLayer.push({
      event: '[service]_callback_request',
      page_type: '[service]_ppc',
      form_fields: { name, phone, issue },
      page_url: window.location.pathname
    });
  }
}

// Scroll depth tracking
const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      window.dataLayer?.push({
        event: 'section_view',
        section_id: entry.target.id,
        page_type: '[service]_ppc'
      });
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.5 });

document.querySelectorAll('[id^="[prefix]-"]').forEach(el => observer.observe(el));
```

### 6.2 — GeoIP Phone Swap

For multi-market businesses, the URL parameter `?loc=UT` triggers phone number swap:

| Market | Phone | Parameter |
|--------|-------|-----------|
| Utah PPC | (801) 901-8553 | `?loc=UT` |
| Iowa (default) | (515) 393-4526 | None |
| Utah Main | (801) 218-2225 | N/A |

**Critical:** PPC pages MUST use `template-blank-4.php` to avoid theme header rendering with wrong phone number.

### 6.3 — GCLID Capture

The site has existing GCLID capture JS (stores in `_gclid` cookie, 90-day expiry). No additional code needed.

### 6.4 — Form → CRM Integration

| Integration Level | Method | Effort |
|-------------------|--------|--------|
| **Minimum** | GA4 event only | Already implemented |
| **Standard** | Email notification via AJAX endpoint | Medium |
| **Full** | ServiceTitan API → create customer booking | High |
| **Alternative** | Gravity Forms with ServiceTitan plugin | Medium |

---

## Phase 7: Deployment

### 7.1 — WordPress REST API Deployment

```python
#!/usr/bin/env python3
"""Template for deploying a new landing page via WP REST API."""

import subprocess, json, base64, sys

WP_SITE = "https://goldenrulephc.com"
WP_USER = "marketing"

def get_wp_password():
    r = subprocess.run(
        ["op", "read", "op://Machine One/Golden Rule WP Bulk App Password/password"],
        capture_output=True, text=True, timeout=30
    )
    if r.returncode != 0:
        print(f"ERROR: {r.stderr}")
        sys.exit(1)
    return r.stdout.strip()

def deploy_page(page_id, title, slug, content, template="template-blank-4.php"):
    auth = base64.b64encode(f"{WP_USER}:{get_wp_password()}".encode()).decode()
    
    payload = json.dumps({
        "title": title,
        "content": content,
        "status": "publish",
        "slug": slug,
        "template": template
    })
    
    method = "POST" if page_id is None else "PUT"
    url = f"{WP_SITE}/wp-json/wp/v2/pages" + (f"/{page_id}" if page_id else "")
    
    r = subprocess.run([
        "curl", "-s", "-X", method,
        "-H", "Content-Type: application/json",
        "-H", f"Authorization: Basic {auth}",
        "-d", payload, url
    ], capture_output=True, text=True)
    
    result = json.loads(r.stdout)
    print(f"✅ Published: {result.get('link', 'unknown')}")
    return result
```

### 7.2 — Post-Deployment Checklist

After every page deployment, verify ALL of the following:

```
[ ] Page loads without errors (HTTP 200)
[ ] Template is template-blank-4.php (for PPC)
[ ] No Iowa phone number (515) visible anywhere
[ ] Correct Utah phone number (801) 901-8553 in ALL CTAs
[ ] GeoIP swap works with ?loc=UT parameter
[ ] All images load (no broken images)
[ ] Form submission fires GA4 event
[ ] Phone click fires GA4 event
[ ] Schema validates (Google Rich Results Test)
[ ] Mobile layout renders correctly (test at 375px width)
[ ] Sticky mobile CTA bar visible
[ ] Sitemap includes new page (/page-sitemap.xml)
[ ] GSC indexing requested
```

---

## Phase 8: Validation & Testing

### 8.1 — Lighthouse Audit

Run via browser DevTools or Lighthouse CLI:

```
lighthouse [page-url] --output json --output html --chrome-flags="--headless"
```

**Minimum scores:**
| Category | Target | Acceptable |
|----------|--------|------------|
| Performance | 90+ | 85+ |
| Accessibility | 95+ | 89+ |
| Best Practices | 100 | 96+ |
| SEO | 95+ | 92+ |

### 8.2 — Schema Validation

Validate all JSON-LD schemas:
- Google Rich Results Test: `https://search.google.com/test/rich-results`
- Schema.org validator: `https://validator.schema.org`

### 8.3 — PageSpeed Insights

```
https://pagespeed.web.dev/analysis?url=[page-url]
```

Check both mobile and desktop. Mobile is the primary ranking signal.

### 8.4 — Cross-Browser Testing

Test on:
- Chrome (desktop + mobile emulation)
- Safari (iOS — primary mobile browser for US users)
- Firefox (desktop)

### 8.5 — Content Audit Checklist

```
[ ] H1 contains primary keyword
[ ] Meta title ≤ 60 characters
[ ] Meta description ≤ 155 characters
[ ] All images have alt text
[ ] No placeholder or Lorem Ipsum text
[ ] All phone numbers are correct market number
[ ] All links work (no 404s)
[ ] Word count meets minimum (800 PPC / 1500 organic)
[ ] FAQs answer real "People Also Ask" queries
[ ] No fabricated reviews or statistics
[ ] Service area cities are accurate
[ ] Pricing information is current
[ ] Business hours are accurate
```

---

## Phase 9: Post-Launch Optimization

### 9.1 — Monitoring Cadence

| Timeframe | Action |
|-----------|--------|
| **Day 1** | Verify indexing in GSC, check Lighthouse scores |
| **Day 3** | Check Google Ads for Quality Score changes |
| **Week 1** | Review GA4 for bounce rate, session duration, conversion events |
| **Week 2** | SEMrush position tracking for target keywords |
| **Month 1** | Full performance review: CTR, conversions, CPC changes |

### 9.2 — A/B Testing Priorities

1. **Headline variants** — Test problem-aware vs solution-aware H1
2. **CTA text** — "Call Now" vs "Get Free Estimate" vs "Schedule Today"
3. **Form fields** — 2 fields vs 3 fields
4. **Hero image** — Team photo vs service photo vs before/after
5. **Social proof placement** — Above fold vs below services

### 9.3 — Continuous Improvement

After each landing page reaches 30 days of data:
1. Pull conversion data from GA4
2. Compare CTR and CPC against campaign averages
3. Check Quality Score in Google Ads
4. Run fresh Lighthouse audit
5. Update content based on seasonal demand
6. Add new FAQs based on search query data from GSC

---

## Appendix A: Page Templates

### PPC Landing Page (copy-ready structure)

See `scripts/update_wh_page_v3.py` for the complete reference implementation. Key patterns:
- Full inline CSS (no external stylesheets)
- Namespaced CSS classes (`wh-`, `plb-`, etc.)
- GA4 dataLayer events
- Schema markup in `<script type="application/ld+json">`
- Mobile-first responsive grid
- Sticky CTA bar for mobile

### Service types covered:

| Service | Prefix | Reference Script |
|---------|--------|------------------|
| Water Heater | `wh-` | `update_wh_page_v3.py` |
| Plumbing | `plb-` | `update_plb_page.py` |
| HVAC | `hvac-` | TBD |
| Electrical | `elec-` | TBD |

---

## Appendix B: Known Gotchas

1. **Server cache** — After REST API update, page may serve stale version for 5-10 min. Touch the page (update `date` field) to invalidate.
2. **Gravity Forms** — Marketing WP user cannot create GF forms programmatically. Use HTML forms with dataLayer push instead.
3. **Cornerstone vs Raw HTML** — Cornerstone pages get automatic geoIP. Raw HTML pages do NOT — use `template-blank-4.php`.
4. **1Password timeout** — Set `timeout=30` (not 10) in subprocess call to prevent deployment failures.
5. **Image URLs** — Always use absolute URLs to WP uploads, not relative paths.
6. **Font loading** — Google Fonts `@import` blocks rendering. Use `<link rel="preconnect">` + `<link rel="stylesheet">` with `font-display: swap`.

---

## Appendix C: Reference Links

- [Google LocalBusiness Schema](https://developers.google.com/search/docs/appearance/structured-data/local-business)
- [Google FAQPage Schema](https://developers.google.com/search/docs/appearance/structured-data/faqpage)
- [Core Web Vitals](https://web.dev/articles/vitals)
- [Google Quality Score](https://support.google.com/google-ads/answer/6167118)
- [Google E-E-A-T Guidelines](https://developers.google.com/search/docs/fundamentals/creating-helpful-content)
- [Lighthouse Scoring](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring/)


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
