---
name: gsc-indexing-automation
description: >
  Autonomously submit URLs for Google indexing via the Search Console UI using Chrome DevTools Protocol.
  Bypasses the Indexing API (which requires GCP project-level enablement and Verified Owner permissions)
  by driving the live GSC browser session directly through CDP websocket commands.
  Use when: new pages deployed and need rapid indexing, Indexing API is blocked/disabled, bulk URL submissions.
  Skip when: Indexing API is working and SA has Verified Owner, URLs already indexed, no Chrome session available.
---

# GSC Indexing Automation (via Chrome DevTools Protocol)

## Overview

This skill automates the "Request Indexing" flow in Google Search Console by controlling an authenticated Chrome session via the Chrome DevTools Protocol (CDP) over websockets on `ws://127.0.0.1:9222`. It replaces manual URL-by-URL copy-paste into the GSC UI and works around the common blockers (GCP API not enabled, service account not a Verified Owner) that prevent the Google Indexing API from working.

## When to Trigger
- New pages deployed to any property and need Google crawl prioritization
- Google Indexing API returns 403 (API disabled, SA not verified owner)
- Bulk URL submissions needed (3+ URLs)
- User says "submit to GSC", "request indexing", "get these indexed"

## When to Skip
- The Google Indexing API (`indexing.googleapis.com`) is working for the target property
- The service account has Verified Owner permissions in GSC
- URLs are already showing "URL is on Google" in GSC
- No Chrome session is running with `--remote-debugging-port=9222`

## Prerequisites

1. **Chrome must be running with remote debugging enabled:**
   ```bash
   /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222
   ```

2. **User must be logged into Google Search Console** in a Chrome tab with the target property active.

3. **Python dependencies:**
   - `websocket-client` (`pip install websocket-client`)
   - `requests` (stdlib-adjacent)

## Core Protocol

### Step 1: Connect to Chrome

```python
import requests, websocket, json, time

# Find the GSC tab
pages = requests.get('http://127.0.0.1:9222/json').json()
gsc = next((p for p in pages 
    if 'search.google.com/search-console' in p.get('url','') 
    and p.get('type') == 'page'), None)

# Connect via websocket (suppress_origin=True is CRITICAL to avoid 403)
ws = websocket.WebSocket()
ws.settimeout(120)
ws.connect(gsc['webSocketDebuggerUrl'], suppress_origin=True)
```

> **CRITICAL**: You MUST pass `suppress_origin=True` to `ws.connect()`. Without it, Chrome rejects the websocket handshake with a 403 Forbidden because the origin doesn't match `--remote-allow-origins`.

### Step 2: Navigate to GSC Overview

```python
# Helper functions
mc = [0]
def cdp(method, params=None):
    mc[0] += 1
    ws.send(json.dumps({"id": mc[0], "method": method, **({"params": params} if params else {})}))
    while True:
        r = json.loads(ws.recv())
        if r.get("id") == mc[0]: return r

def ev(expr):
    return cdp("Runtime.evaluate", {
        "expression": expr, "returnByValue": True
    }).get('result',{}).get('result',{}).get('value','')

def mouse_click(x, y):
    cdp("Input.dispatchMouseEvent", {"type": "mousePressed", "x": x, "y": y, "button": "left", "clickCount": 1})
    time.sleep(0.05)
    cdp("Input.dispatchMouseEvent", {"type": "mouseReleased", "x": x, "y": y, "button": "left", "clickCount": 1})

cdp("Page.enable")

# Navigate — resource_id must be URL-encoded
resource_id = "https%3A%2F%2Faprioboardportal.com%2F"  # CHANGE THIS per property
cdp("Page.navigate", {"url": f"https://search.google.com/search-console?resource_id={resource_id}"})
time.sleep(7)
```

### Step 3: Find the Search Icon Position

GSC's "Inspect any URL" search bar is a **collapsed search icon** in the Google header bar. It's a `<form role="search">` element, typically around `44x48` pixels.

```python
search_pos = ev("""
    (function() {
        var form = document.querySelector('form[role="search"]');
        if (!form) return '{}';
        var rect = form.getBoundingClientRect();
        return JSON.stringify({
            x: Math.round(rect.x + rect.width/2),
            y: Math.round(rect.y + rect.height/2)
        });
    })()
""")
pos = json.loads(search_pos)
SEARCH_X, SEARCH_Y = pos['x'], pos['y']  # Typically ~(413, 32)
```

### Step 4: For Each URL — Open Overlay → Type → Submit → Click Request Indexing

```python
for url in urls:
    # 4a. Click the search icon to open the Material overlay
    mouse_click(SEARCH_X, SEARCH_Y)
    time.sleep(1.5)

    # 4b. Clear existing text (Cmd+A → Backspace)
    cdp("Input.dispatchKeyEvent", {"type": "rawKeyDown", "key": "a", "code": "KeyA",
        "windowsVirtualKeyCode": 65, "modifiers": 2})  # modifiers=2 = Cmd on Mac
    cdp("Input.dispatchKeyEvent", {"type": "keyUp", "key": "a", "code": "KeyA", "modifiers": 2})
    time.sleep(0.1)
    cdp("Input.dispatchKeyEvent", {"type": "rawKeyDown", "key": "Backspace", "code": "Backspace",
        "windowsVirtualKeyCode": 8})
    cdp("Input.dispatchKeyEvent", {"type": "keyUp", "key": "Backspace", "code": "Backspace"})
    time.sleep(0.3)

    # 4c. Insert URL using Input.insertText (IME-level, bypasses Angular)
    cdp("Input.insertText", {"text": url})
    time.sleep(0.5)

    # 4d. Press Enter to submit
    cdp("Input.dispatchKeyEvent", {"type": "rawKeyDown", "key": "Enter", "code": "Enter",
        "windowsVirtualKeyCode": 13, "nativeVirtualKeyCode": 13})
    cdp("Input.dispatchKeyEvent", {"type": "keyUp", "key": "Enter", "code": "Enter",
        "windowsVirtualKeyCode": 13})
    time.sleep(5)

    # 4e. Wait for inspection results (poll for "request indexing" text)
    for attempt in range(40):
        time.sleep(3)
        raw = ev("""..check for 'request indexing' in body.innerText...""")
        # Break when found

    # 4f. Find and click "Request Indexing" by coordinates
    ri_coords = ev("""
        (function() {
            var allEls = document.querySelectorAll('*');
            for (var el of allEls) {
                var text = (el.textContent || '').trim();
                if (text.toLowerCase() === 'request indexing' && el.children.length === 0) {
                    var rect = el.getBoundingClientRect();
                    if (rect.width > 0) return JSON.stringify({
                        x: Math.round(rect.x + rect.width/2),
                        y: Math.round(rect.y + rect.height/2), found: true
                    });
                }
            }
            return JSON.stringify({found: false});
        })()
    """)
    ri = json.loads(ri_coords)
    mouse_click(ri['x'], ri['y'])

    # 4g. Wait for "Indexing requested" confirmation (up to ~3 min)
    for attempt in range(60):
        time.sleep(3)
        modal = ev("""..check body for 'indexing requested' vs 'testing if live'...""")
        if modal == 'SUCCESS':
            # Click "Got it" to dismiss
            break

    # 4h. Navigate back to overview for next URL
    cdp("Page.navigate", {"url": f"https://search.google.com/search-console?resource_id={resource_id}"})
    time.sleep(7)
```

## Critical Technical Details

### Why `Input.insertText` Instead of `dispatchKeyEvent`

GSC is an Angular application. Character-by-character `dispatchKeyEvent` with `text` property does NOT trigger Angular's change detection. The keystrokes go to the browser but the Angular model never updates, so the input stays empty. `Input.insertText` operates at the IME (input method editor) level and correctly triggers the framework bindings.

### Why Mouse Clicks at Coordinates

GSC's Material Design components intercept click events at specific layers. `element.click()` via JS often doesn't trigger the Material ripple handlers or dialog openers. CDP `Input.dispatchMouseEvent` at the actual pixel coordinates simulates a real user click that passes through all event layers.

### The Search Overlay Pattern

The "Inspect any URL" search bar is NOT a normal visible input. It's a **collapsed `<form role="search">`** (typically 44x48px) in the Google header bar. The actual `<input>` elements have `0x0` dimensions until you click the form. Clicking the form icon expands a search overlay where the input becomes visible and focusable.

### Common Pitfalls

| Problem | Cause | Fix |
|---------|-------|-----|
| 403 on websocket connect | Missing `suppress_origin=True` | Add `suppress_origin=True` to `ws.connect()` |
| `wpApiSettings is not defined` | Wrong page context (not wp-admin) | Navigate to `/wp-admin/` first |
| Input value stays empty after typing | Angular ignoring `dispatchKeyEvent` | Use `Input.insertText` instead |
| Search overlay doesn't open | Clicking wrong element/coordinates | Click `form[role="search"]` center coords |
| 404 on inspection deep-link | Wrong `resource_id` format | Use URL-encoded full property URL, not `sc-domain:` |
| "Request Indexing" click does nothing | Clicking non-leaf text node | Find element with `children.length === 0` |

## GFV Integration

- **Linear**: Post comment on relevant issue when indexing completes (use `linear-api-access` skill, NOT MCP)
- **PIL**: Log indexing events to memory for tracking crawl status
- **Three-System Sync**: Update HubSpot deal notes if indexing relates to a client deliverable

## Complete Reference Script

The battle-tested, production-verified script is at `/tmp/gsc_final.py`. Copy it as a starting point and modify the `resource_id` and `urls` list for each property.

## Anti-Patterns

- ❌ **DO NOT** try the Google Indexing API first every time — check if it's enabled before wasting time
- ❌ **DO NOT** use `element.click()` via JS eval — use CDP `Input.dispatchMouseEvent` with coordinates
- ❌ **DO NOT** type character-by-character with `dispatchKeyEvent` — use `Input.insertText`
- ❌ **DO NOT** use `sc-domain:` in the `resource_id` — use the full URL-encoded property URL
- ❌ **DO NOT** navigate directly to `/search-console/inspect?id=...` — it 404s; use the search overlay
- ❌ **DO NOT** use the Linear MCP server — it hangs; use direct GraphQL via `linear-api-access` skill

## References

- **Source Pattern**: GFV session `ec7f31bd` — 9 iterations to crack the GSC Angular overlay
- **Chrome DevTools Protocol**: https://chromedevtools.github.io/devtools-protocol/
- **CDP Input Domain**: https://chromedevtools.github.io/devtools-protocol/tot/Input/
- **GFV Standard**: Draft Review Before Send (indexing is autonomous, no draft needed)


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
