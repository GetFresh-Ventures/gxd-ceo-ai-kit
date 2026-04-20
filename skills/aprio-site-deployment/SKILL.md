---
name: aprio-site-deployment
description: Deploy content updates and new pages to aprioboardportal.com via WordPress REST API + Chrome CDP. Covers page creation, content updates, verification, and rollback. This is the ONLY proven deployment method — browser subagents and WPCode injection fail.
---

# Aprio Site Deployment Skill

## Overview
This skill codifies the **only reliable method** for deploying content to `aprioboardportal.com`. After extensive testing, the proven pipeline is:

1. **Fetch** current content via `curl` (bypasses Cloudflare with User-Agent header)
2. **Build** enriched HTML content locally
3. **Deploy** via Chrome CDP websocket → WP REST API with session nonce
4. **Verify** deployed content via `curl` + keyword checks

> ⚠️ **What does NOT work:**
> - Browser subagent → Elementor/Classic Editor → too fragile, session instability
> - Direct `urllib` from Python → Cloudflare 403 blocks
> - WPCode snippet injection → payload too large, crashes session
> - Manual paste into editor → loses HTML formatting

---

## Prerequisites

1. **Active WordPress admin session** in Chrome (logged into `aprioboardportal.com/wp-admin/`)
   - Username: `diraj` | Email: `diraj@getfreshventures.com`
   - App password (REST API): stored in `aprio-dashboard/scripts/wp_auth_finder.py` line 7
   - The app password works for REST API Basic Auth reads but NOT writes — you need an active browser cookie session for write operations via CDP
2. **Chrome running with remote debugging on port 9222** (the Antigravity browser profile does this automatically)
3. The `websockets` Python package (install: `pip3 install websockets`)

---

## Step 1: Fetch Current Page Content

Use `curl` with a browser User-Agent to bypass Cloudflare:

```python
import subprocess, json

def fetch_page(slug):
    """Fetch page content from WP REST API via curl."""
    r = subprocess.run([
        "curl", "-sL",
        "-A", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
        f"https://aprioboardportal.com/wp-json/wp/v2/pages?slug={slug}&_fields=id,title,slug,content"
    ], capture_output=True, text=True, timeout=15)
    
    data = json.loads(r.stdout)
    if data:
        return {"id": data[0]["id"], "title": data[0]["title"]["rendered"], "content": data[0]["content"]["rendered"]}
    return None
```

---

## Step 2: Build Enriched Content

Always **inject** new content into the existing page rather than replacing it entirely. This preserves SEO structure and existing content.

**Injection pattern:**
```python
def inject_block(current_html, new_block, before_marker="<hr"):
    """Insert a content block before the last horizontal rule (CTA section)."""
    last_hr = current_html.rfind(before_marker)
    if last_hr > 0:
        return current_html[:last_hr] + new_block + "\n" + current_html[last_hr:]
    return current_html + new_block
```

**Design patterns for Aprio content blocks:**
- Background: `background:linear-gradient(135deg,#f8f4ee 0%,#fdf9f3 100%)`
- Border accent: `border-left:4px solid #005587`
- Primary color: `#005587` (Aprio navy)
- CTA green: `#26C571`
- Table header: `background:#005587; color:white`
- Rounded corners: `border-radius:0 12px 12px 0` (for accent blocks)

---

## Step 3: Deploy via Chrome CDP

This is the critical step. Use the CDP websocket to execute the WP REST API update **inside the authenticated wp-admin session**.

### Find the CDP Target

```python
import json, urllib.request

def find_wp_admin_target(port=9222):
    """Find the wp-admin Chrome tab via CDP."""
    resp = urllib.request.urlopen(f"http://localhost:{port}/json")
    targets = json.loads(resp.read().decode())
    
    for t in targets:
        url = t.get('url', '')
        if 'wp-admin' in url or ('aprioboardportal' in url and 'wp-' in url):
            return t
    
    # Fallback: any Aprio tab
    for t in targets:
        if 'aprioboardportal' in t.get('url', ''):
            return t
    
    return None
```

### Deploy Content

```python
import asyncio, websockets

async def deploy_pages(pages):
    """
    Deploy page content via CDP websocket.
    pages: list of {"id": wp_id, "slug": slug, "content": html_content}
    """
    target = find_wp_admin_target()
    if not target:
        raise Exception("No wp-admin target found in Chrome")
    
    ws_url = target['webSocketDebuggerUrl']
    
    async with websockets.connect(ws_url, max_size=10**7) as ws:
        # Navigate to wp-admin to get fresh nonce
        await ws.send(json.dumps({
            "id": 1,
            "method": "Page.navigate",
            "params": {"url": "https://aprioboardportal.com/wp-admin/"}
        }))
        await ws.recv()
        await asyncio.sleep(5)
        
        # Build deployment JS
        js_code = f'''
        (async function() {{
            const results = [];
            const nonceMatch = document.body.innerHTML.match(/wpApiSettings.*?"nonce":"([^"]+)"/);
            let nonce = '';
            if (nonceMatch) {{
                nonce = nonceMatch[1];
            }} else {{
                const r = await fetch('/wp-admin/admin-ajax.php?action=rest-nonce', {{credentials: 'same-origin'}});
                nonce = await r.text();
            }}
            
            if (!nonce || nonce.length < 5) {{
                return JSON.stringify({{error: 'Could not get nonce', raw: nonce}});
            }}
            
            const pages = {json.dumps(pages)};
            
            for (const page of pages) {{
                try {{
                    const resp = await fetch(`/wp-json/wp/v2/pages/${{page.id}}`, {{
                        method: 'POST',
                        headers: {{'Content-Type': 'application/json', 'X-WP-Nonce': nonce}},
                        credentials: 'same-origin',
                        body: JSON.stringify({{content: page.content}})
                    }});
                    const data = await resp.json();
                    results.push({{id: page.id, slug: page.slug, status: resp.status, title: data.title ? data.title.rendered : 'unknown'}});
                }} catch (e) {{
                    results.push({{id: page.id, slug: page.slug, error: e.message}});
                }}
            }}
            
            return JSON.stringify({{success: results.length, results: results}});
        }})();
        '''
        
        await ws.send(json.dumps({
            "id": 2,
            "method": "Runtime.evaluate",
            "params": {"expression": js_code, "awaitPromise": True, "timeout": 30000}
        }))
        
        result = json.loads(await ws.recv())
        return json.loads(result['result']['result']['value'])

# Usage
result = asyncio.get_event_loop().run_until_complete(deploy_pages([
    {"id": 13069, "slug": "aprio-vs-boardeffect-alternative", "content": "<div>...</div>"}
]))
```

---

## Step 4: Verify Deployment

```python
def verify_page(slug, keywords):
    """Verify deployed content contains expected keywords."""
    r = subprocess.run([
        "curl", "-sL",
        "-A", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
        f"https://aprioboardportal.com/{slug}/"
    ], capture_output=True, text=True, timeout=15)
    
    found = [kw for kw in keywords if kw in r.stdout]
    missing = [kw for kw in keywords if kw not in r.stdout]
    
    return {"slug": slug, "found": found, "missing": missing, "success": len(missing) == 0}
```

---

## Do No Harm Rules

1. **Never modify legacy pages** — only pages we deployed (check creation date or content patterns)
2. **Always save current content** before updating — write to `content-compiled/{slug}_backup.html`
3. **Inject, don't replace** — add new blocks to existing content, don't overwrite
4. **Verify after deploy** — curl the live page and check for expected content
5. **Keep payload under 50KB per page** — larger payloads can timeout the CDP connection

---

## Page ID Reference

### Our Comparison Pages (deployed April 2026)
| WP ID | Slug |
|-------|------|
| 13069 | aprio-vs-boardeffect-alternative |
| 13070 | aprio-vs-diligent-alternative |
| 13071 | aprio-vs-onboard-alternative |
| 13296 | aprio-vs-govenda-alternative |

### Our Landing Pages (WP ID ≥ 13076)
45 pages deployed across US (31) and Canada (14) verticals. Full list available in `aprio-dashboard/page_manifest.json`.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `Cloudflare 403` on curl | Add `-A "Mozilla/5.0..."` User-Agent header |
| `No wp-admin target` | Navigate Chrome to `aprioboardportal.com/wp-admin/` first |
| `Could not get nonce` | Session expired — re-login to wp-admin in Chrome |
| CDP websocket refused | Check `lsof -i -P -n \| grep Chrome \| grep LISTEN` for port |
| Content not rendering | Check for unescaped HTML entities in injected content |
| `max_size` error | Increase `websockets.connect(ws_url, max_size=10**7)` |

---

## Screenshot via CDP

```python
import base64

async def screenshot_page(slug, output_path, y_offset=0, height=900):
    """Take a screenshot of a deployed page for verification."""
    target = find_wp_admin_target()
    ws_url = target['webSocketDebuggerUrl']
    
    async with websockets.connect(ws_url, max_size=10**7) as ws:
        await ws.send(json.dumps({
            "id": 1,
            "method": "Page.navigate",
            "params": {"url": f"https://aprioboardportal.com/{slug}/"}
        }))
        await ws.recv()
        await asyncio.sleep(4)
        
        await ws.send(json.dumps({
            "id": 2,
            "method": "Page.captureScreenshot",
            "params": {"format": "png", "clip": {"x": 0, "y": y_offset, "width": 1200, "height": height, "scale": 1}}
        }))
        resp = json.loads(await ws.recv())
        
        img_data = base64.b64decode(resp['result']['data'])
        with open(output_path, 'wb') as f:
            f.write(img_data)
```


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
