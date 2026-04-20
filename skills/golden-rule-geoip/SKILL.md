---
name: golden-rule-geoip
description: Complete reference for Golden Rule's multi-market phone/content swap system. Covers Cornerstone theme geo-cookie, PPC URL param workaround, PerfMatters bypass, and CSS-based header/footer isolation for market-specific landing pages.
---

# Golden Rule GeoIP — Multi-Market Content Swap

## Overview
Golden Rule operates in three markets with different phone numbers and service areas. The site uses a layered system to show the correct content per visitor. This skill documents every layer, how they interact, and the critical gotchas discovered through reverse engineering.

---

## 1. Market Phone Numbers

| Market | Phone (Display) | Phone (Raw) | Tracking Context |
|--------|----------------|-------------|------------------|
| **Iowa (Des Moines)** | (515) 393-4526 | 5153934526 | HQ default — shows site-wide unless overridden |
| **Utah (Salt Lake City)** PPC | (801) 901-8553 | 8019018553 | PPC tracking number for Utah ads |
| **Utah Main** | (801) 218-2225 | 8012182225 | Organic/canary Utah traffic |

> [!CAUTION]
> Iowa (515) is the **hardcoded default** in the Cornerstone theme global bars. Every page on the site renders (515) in the header and footer unless explicitly overridden.

---

## 2. The Three GeoIP Layers

### Layer 1: Theme Cookie (Cornerstone Native)
- **What:** The ThemeCo X/Pro theme uses a **cookie-based geolocation** system
- **How:** On first visit, Cornerstone checks the visitor's geo and sets a cookie. Subsequent visits use the cookie to swap content blocks.
- **Scope:** Only works on pages built **inside Cornerstone Builder** (visual builder elements). Does NOT affect raw HTML injected via WP REST API `content` field.
- **Elements affected:** Cornerstone-native header bars, footer bars, content sections built in the visual builder
- **Limitation:** REST API pages bypass Cornerstone rendering entirely — the cookie geo system never fires on raw HTML content

### Layer 2: URL Parameter (`?loc=UT`) — Client-Side JS
- **What:** Our custom inline JS reads `?loc=UT` from the URL and swaps Iowa → Utah content via DOM manipulation
- **How:** On page load, the script:
  1. Reads `URLSearchParams` for `loc` parameter
  2. If `loc === 'UT'`:
     - Swaps all `a[href*="tel:515"]` → `tel:8019018553`
     - Replaces text in `.x-anchor-text-primary` elements containing "515"
     - Replaces "Serving Des Moines..." text → "Serving the Salt Lake City Metro Area"
- **Scope:** Targets the global Cornerstone header/footer elements rendered by the theme
- **Trigger:** Only fires when `?loc=UT` is in the URL (i.e., traffic from Google Ads with that Final URL)

```javascript
/* ── GEOIP FIX: Swap Iowa 515 → Utah 801 on ?loc=UT pages ── */
(function(){
  var loc = new URLSearchParams(window.location.search).get('loc');
  if (loc === 'UT') {
    document.querySelectorAll('a[href*="tel:515"]').forEach(function(el) {
      el.href = 'tel:8019018553';
    });
    document.querySelectorAll('.x-anchor-text-primary').forEach(function(el) {
      if (el.textContent.indexOf('515') > -1) {
        el.textContent = '(801) 901-8553';
      }
    });
    document.querySelectorAll('.x-text, .x-text-headline').forEach(function(el) {
      if (el.textContent.indexOf('515') > -1 && el.textContent.indexOf('393') > -1) {
        el.textContent = el.textContent
          .replace(/\(515\)\s*393-4526/g, '(801) 901-8553')
          .replace(/515-393-4526/g, '(801) 901-8553');
      }
    });
    document.querySelectorAll('.x-text, .x-text-headline, .x-text-content-text').forEach(function(el) {
      if (el.textContent.indexOf('Des Moines') > -1) {
        el.innerHTML = el.innerHTML.replace(/Serving.*?Metro Areas?/gi, 'Serving the Salt Lake City Metro Area');
      }
    });
  }
})();
```

### Layer 3: CSS Hide (PerfMatters Bypass) — CURRENT SOLUTION
- **What:** CSS `display: none !important` on all Cornerstone theme header/footer bars
- **How:** Inline `<style>` rules in the page content that target Cornerstone's data attributes
- **Why:** PerfMatters breaks Layer 2 (see Section 3), making CSS the only reliable option
- **Scope:** Hides the entire theme header and footer, leaving only the page's own HTML content visible

```css
/* ── HIDE CORNERSTONE THEME HEADER/FOOTER (Iowa 515 phone leak fix) ── */
header#masthead,
.x-bar[data-x-bar*='"region":"top"'],
.x-bar-space-top,
footer.x-colophon,
.x-bar[data-x-bar*='"region":"footer"'] { display: none !important; }
```

---

## 3. The PerfMatters Problem (Critical Discovery — April 8, 2026)

### What Happens
The site runs **PerfMatters** (a WordPress performance plugin). PerfMatters processes ALL inline `<script>` tags and converts them:

**Before (in WP content):**
```html
<script>
/* ── GEOIP FIX ── */
(function(){ ... })();
</script>
```

**After (PerfMatters rewrites to):**
```html
<script type="pmdelayedscript" data-cfasync="false" data-no-optimize="1" data-no-defer="1" data-no-minify="1" data-rocketlazyloadscript="1">
/* ── GEOIP FIX ── */
(function(){ ... })();
</script>
```

### Why It Breaks
- `type="pmdelayedscript"` tells the browser this is **NOT JavaScript** — the browser ignores it entirely
- PerfMatters then lazily injects and executes it via its own loader mechanism
- By the time PerfMatters tries to execute it (or if its loader encounters errors), the GeoIP swap either:
  - Runs **too late** (user already saw the Iowa number, possibly clicked it)
  - **Never runs** (PerfMatters' `replaceChild` throws a SyntaxError)
- Console errors observed:
  - `Uncaught SyntaxError: Failed to execute 'replaceChild' on 'Node'`
  - `Uncaught TypeError: Cannot read properties of null (reading 'addEventListener')`

### Why `data-no-defer` Doesn't Help
The `data-no-optimize`, `data-no-defer`, and `data-no-minify` attributes are PerfMatters hints, but they need to be in the **original source HTML** before PerfMatters processes it. Since our content is injected via WP REST API into the `post_content` field, PerfMatters processes it during the page render pipeline before these attributes are respected.

### The Fix: CSS (Layer 3)
CSS rules in `<style>` tags are **never deferred** by PerfMatters. They execute synchronously as part of the CSSOM construction. This makes CSS the only reliable mechanism for hiding theme elements on REST API pages where PerfMatters is active.

---

## 4. Architecture Diagram

```
Google Ads Click → goldenrulephc.com/page/?loc=UT
                            │
                            ▼
              ┌─────────── WordPress ───────────┐
              │                                  │
              │  Cornerstone Theme renders:      │
              │  ┌─────────────────────────────┐ │
              │  │ HEADER (e21064)             │ │
              │  │ Iowa (515) 393-4526 ← HARD- │ │
              │  │ CODED in global bar element  │ │
              │  └──────────┬──────────────────┘ │
              │             │ display:none (CSS) │
              │  ┌──────────▼──────────────────┐ │
              │  │ PAGE CONTENT (post_content)  │ │
              │  │ Utah (801) 901-8553          │ │
              │  │ All CTAs, forms, schema      │ │
              │  │ ┌──────────────────────────┐ │ │
              │  │ │ <style> CSS hide rules   │ │ │ ← Fires immediately
              │  │ └──────────────────────────┘ │ │
              │  │ ┌──────────────────────────┐ │ │
              │  │ │ <script> GeoIP swap JS   │ │ │ ← Broken by PerfMatters
              │  │ │ type="pmdelayedscript"   │ │ │
              │  │ └──────────────────────────┘ │ │
              │  └──────────┬──────────────────┘ │
              │             │ display:none (CSS) │
              │  ┌──────────▼──────────────────┐ │
              │  │ FOOTER (e21088)             │ │
              │  │ Iowa (515) + Des Moines     │ │
              │  │ address — HIDDEN            │ │
              │  └─────────────────────────────┘ │
              └──────────────────────────────────┘
```

---

## 5. Cornerstone Element IDs

| Element | Post ID | CSS Prefix | Contains |
|---------|---------|------------|----------|
| **Global Header** | 21064 | `e21064-*` | Logo, nav, phone button, hamburger |
| **Global Footer** | 21088 | `e21088-*` | Phone, schedule button, address, hours |

### Key Selectors
```css
/* Header top bars (all 3 — topbar, main bar, mobile bar) */
.x-bar[data-x-bar*='"region":"top"']

/* Footer bars (3 — main footer, separator, info bar) */
.x-bar[data-x-bar*='"region":"footer"']

/* Header spacer element */
.x-bar-space-top

/* Semantic elements */
header#masthead
footer.x-colophon
```

### Phone Button Selectors (for JS targeting if PerfMatters is bypassed)
```css
/* Header phone (desktop) */
.x-anchor.e21064-e11 .x-anchor-text-primary    /* "(515) 393-4526" */

/* Header phone (mobile) */
.x-anchor.e21064-e76 .x-anchor-text-primary    /* "(515) 393-4526" */

/* Off-canvas phone */
.x-anchor.e21064-e83 .x-anchor-text-primary    /* "(515) 393-4526" */

/* Footer phone */
.x-anchor.e21088-e10 .x-anchor-text-primary    /* "(515) 393-4526" */

/* Footer "Call our team" link */
a.x-text.e21088-e6[href="tel:515-393-4526"]
```

---

## 6. Decision Tree: Building a New Market-Specific Page

```
Q: Is this page built in Cornerstone Builder?
├── YES → Theme GeoIP cookie handles header/footer swap automatically
│         └── No additional work needed for phone swap
└── NO (REST API / raw HTML page)
    │
    Q: Does the site run PerfMatters (or WP Rocket delay JS)?
    ├── YES → Use CSS Layer 3: Hide theme header/footer entirely
    │         └── Build your own header/footer in page content
    │         └── Include all CTAs with correct market phone
    └── NO → Use JS Layer 2: URL param swap
              └── Still build own CTAs, but JS will fix theme elements
```

---

## 7. Testing Checklist

After deploying a market-specific page:

- [ ] **curl test:** `curl -s "URL" | grep -c "515"` — should be 0 for Utah pages
- [ ] **Browser test:** Load with `?loc=UT` param, check:
  - [ ] No (515) number visible anywhere on page
  - [ ] All `a[href^="tel:"]` links go to correct market number
  - [ ] Form submission fires correct GA4 events
  - [ ] Sticky mobile CTA shows correct number
- [ ] **Console check:** No JS errors related to GeoIP swap
- [ ] **Footer check:** No Iowa address visible ("904 NE Main Street, Grimes, IA")
- [ ] **"Des Moines" check:** No Iowa market text visible in any bar

### Automated Test Script
```bash
#!/bin/bash
URL="https://goldenrulephc.com/utah-water-heater-repair-ppc/?loc=UT&v=$(date +%s)"
echo "Testing: $URL"

# Count Iowa phone occurrences
IOWA=$(curl -s "$URL" | grep -c "515-393-4526\|(515) 393-4526")
echo "Iowa (515) occurrences in source: $IOWA"

# Count Utah phone occurrences  
UTAH=$(curl -s "$URL" | grep -c "801.*901.*8553")
echo "Utah (801) occurrences in source: $UTAH"

# Check CSS hide rule present
HIDE=$(curl -s "$URL" | grep -c "display: none !important")
echo "CSS hide rules: $HIDE"

# Check PerfMatters interference
PM=$(curl -s "$URL" | grep -c 'type="pmdelayedscript"')
echo "PerfMatters-deferred scripts: $PM"

if [ "$HIDE" -gt 0 ]; then
  echo "✅ CSS hide active — Iowa header/footer hidden"
else
  echo "❌ CSS hide MISSING — Iowa number may be visible"
fi
```

---

## 8. Historical Context

### Discovery Timeline
- **Mar 27, 2026:** GeoIP deployed on site (GFV-189), verified "working" from manual IP check
- **Apr 1, 2026:** GFV-2 (Iowa content on Utah pages) closed as "not a bug — GeoIP working as designed"
- **Apr 8, 2026:** PerfMatters interference discovered — inline JS swap was never executing on cached pages
- **Apr 8, 2026:** CSS-based fix deployed as Layer 3, verified 0 Iowa numbers visible

### Linear Issues
| Issue | Title | Outcome |
|-------|-------|---------|
| GFV-2 | Iowa content on Utah pages | Closed as geo-IP working. **Later found to be partially broken due to PerfMatters.** |
| GFV-189 | Verify GeoIP site fixes from Utah device | Marked done — but JS swap was broken by PerfMatters |
| GFV-265 | Conversion Optimization | CSS fix deployed as part of this work |

### Key Lesson
> **Cookie-based GeoIP only works on Cornerstone-native content.** REST API pages must use their own swap mechanism. And any JS-based swap is vulnerable to performance plugins deferring/breaking inline scripts. **CSS is the only truly reliable layer for hiding theme elements.**

---

## 9. Future Considerations

### If PerfMatters is Removed or Reconfigured
- The JS swap (Layer 2) would start working again
- CSS hide (Layer 3) would still work and is harmless
- Both layers can coexist safely

### Adding a New Market (e.g., Omaha)
1. Create `?loc=NE` URL param swap in page JS
2. Add CSS hide rules (same pattern)
3. Build page content with Omaha phone number
4. Google Ads Final URL: `page-slug/?loc=NE`

### Server-Side Approach (Best Long-Term)
Instead of client-side JS, the ideal solution would be:
- WordPress `functions.php` or a mu-plugin that reads `$_GET['loc']` 
- Outputs market-specific `<style>` or swaps phone numbers at render time
- This bypasses PerfMatters entirely since it's PHP, not JS
- Requires theme file access (Greg or developer task)


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
