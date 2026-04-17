---
name: dev-browser
description: "Browser automation with sandboxed Playwright scripts. Use when users need to navigate websites, fill forms, take screenshots, extract web data, test web apps, scrape pages, or automate multi-step browser workflows. Trigger phrases: 'go to [url]', 'click on', 'fill out the form', 'take a screenshot', 'scrape [site]', 'test the website', 'log into', or any browser interaction request."
short_description: "Sandboxed browser automation via Playwright CLI"
metadata:
  version: 1.0.0
  category: technical-builder
  tier: advanced
  requires_human_approval: false
  triggers:
    - go to a website
    - take a screenshot
    - fill out a form
    - scrape a page
    - test the website
    - automate the browser
    - log into
    - browser automation
---

# Dev Browser

You are a browser automation specialist. Your tool is `dev-browser` — a CLI that runs sandboxed JavaScript scripts against a real Chromium browser via Playwright. Scripts execute in a QuickJS WASM sandbox with zero host access, making them safe to auto-approve.

## When to Use

- User needs to navigate to a URL, fill forms, click buttons, or extract data
- Screenshot capture of a live web page for audit, QA, or reporting
- Web scraping where the target requires JavaScript rendering
- Testing a deployed web app's UI flow end-to-end
- Logging into an authenticated session and performing actions
- Any multi-step browser workflow that exceeds what `curl` can do

## Context-First Check

Before running any browser automation:
1. Confirm `dev-browser` is installed: `which dev-browser || npm list -g dev-browser`
2. If not installed, run: `npm install -g dev-browser && dev-browser install`
3. For connecting to an existing Chrome session, ensure Chrome was launched with `--remote-debugging-port=9222`

## Core Workflows

### Mode 1: Headless Automation (Default)

Use this for scraping, screenshots, and non-interactive tasks. Launches a fresh Chromium.

```bash
dev-browser --headless <<'EOF'
const page = await browser.getPage("main");
await page.goto("https://example.com", { waitUntil: "domcontentloaded" });
console.log(await page.title());
EOF
```

### Mode 2: Connect to Running Chrome

Use this to interact with an already-authenticated browser session (logged-in dashboards, CRMs, etc).

```bash
# First: ensure Chrome is running with remote debugging
# chrome --remote-debugging-port=9222

dev-browser --connect <<'EOF'
const tabs = await browser.listPages();
console.log(JSON.stringify(tabs, null, 2));
EOF
```

### Mode 3: Multi-Step Persistent Sessions

Named pages persist across script invocations. Navigate once, interact many times.

```bash
# Step 1: Navigate and authenticate
dev-browser --headless <<'EOF'
const page = await browser.getPage("session");
await page.goto("https://app.example.com/login", { waitUntil: "networkidle" });
await page.fill('[name="email"]', 'user@example.com');
await page.fill('[name="password"]', 'secure-password');
await page.click('button[type="submit"]');
await page.waitForURL("**/dashboard**");
console.log("Logged in:", await page.title());
EOF

# Step 2: Interact with the same session
dev-browser --headless <<'EOF'
const page = await browser.getPage("session");
console.log("Still on:", await page.url());
// Do more work on the authenticated page...
EOF
```

## Script API Reference

Scripts run in a sandboxed QuickJS runtime (not Node.js). Available globals:

| API | Description | Returns |
|-----|-------------|---------|
| `browser.getPage(name)` | Get or create a named persistent page, or connect to tab by targetId | Page |
| `browser.newPage()` | Create anonymous page (cleaned up after script) | Page |
| `browser.listPages()` | List all browser tabs | `[{id, url, title, name}]` |
| `browser.closePage(name)` | Close a named page | void |
| `saveScreenshot(buf, name)` | Save screenshot buffer to `~/.dev-browser/tmp/` | file path |
| `writeFile(name, data)` | Write file to sandbox temp dir | file path |
| `readFile(name)` | Read file from sandbox temp dir | content |

Pages are full **Playwright Page objects** with the complete API: `goto`, `click`, `fill`, `locator`, `evaluate`, `screenshot`, `waitForURL`, `waitForSelector`, and everything else documented at [Playwright Page API](https://playwright.dev/docs/api/class-page).

Additional method: `page.snapshotForAI({ track?, depth?, timeout? })` returns `{ full, incremental? }` for AI-friendly page snapshots.

## Common Recipes

### Screenshot a page
```bash
dev-browser --headless <<'EOF'
const page = await browser.getPage("main");
await page.goto("https://example.com", { waitUntil: "networkidle" });
const buf = await page.screenshot({ fullPage: true });
const path = await saveScreenshot(buf, "example-screenshot");
console.log("Saved:", path);
EOF
```

### Extract structured data
```bash
dev-browser --headless <<'EOF'
const page = await browser.getPage("main");
await page.goto("https://example.com/products", { waitUntil: "domcontentloaded" });
const products = await page.evaluate(() => {
  return Array.from(document.querySelectorAll('.product')).map(el => ({
    name: el.querySelector('h2')?.textContent?.trim(),
    price: el.querySelector('.price')?.textContent?.trim(),
  }));
});
console.log(JSON.stringify(products, null, 2));
EOF
```

### Fill and submit a form
```bash
dev-browser --headless <<'EOF'
const page = await browser.getPage("main");
await page.goto("https://example.com/contact", { waitUntil: "domcontentloaded" });
await page.fill('#name', 'John Doe');
await page.fill('#email', 'john@example.com');
await page.fill('#message', 'Hello from dev-browser');
await page.click('button[type="submit"]');
await page.waitForSelector('.success-message');
console.log("Form submitted successfully");
EOF
```

### AI-friendly page snapshot
```bash
dev-browser --headless <<'EOF'
const page = await browser.getPage("main");
await page.goto("https://example.com", { waitUntil: "domcontentloaded" });
const snapshot = await page.snapshotForAI({ depth: 3 });
console.log(snapshot.full);
EOF
```

## Installation in Bootstrap

The kit installer handles `dev-browser` setup automatically for Advanced tier users. The installer:
1. Checks for Node.js and npm
2. Runs `npm install -g dev-browser`
3. Runs `dev-browser install` to download Chromium
4. Optionally adds `Bash(dev-browser *)` to Claude Code's allow list

### Manual Installation
```bash
npm install -g dev-browser
dev-browser install    # downloads Playwright + Chromium
```

### Windows (PowerShell)
```powershell
npm install -g dev-browser
dev-browser install
```

## Agent Permission Setup

To auto-approve `dev-browser` commands without permission prompts, add to your IDE settings:

**Claude Code** (per-project `.claude/settings.json` or global `~/.claude/settings.json`):
```json
{
  "permissions": {
    "allow": [
      "Bash(dev-browser *)",
      "Bash(npx dev-browser *)"
    ]
  }
}
```

Scripts are safe to auto-approve because they run in a sandboxed QuickJS WASM environment with zero host filesystem or network access.

## Performance Benchmarks

| Method | Time | Cost | Turns | Success |
|--------|------|------|-------|---------|
| **Dev Browser** | 3m 53s | $0.88 | 29 | 100% |
| Playwright MCP | 4m 31s | $1.45 | 51 | 100% |
| Playwright Skill | 8m 07s | $1.45 | 38 | 67% |
| Claude Chrome Extension | 12m 54s | $2.81 | 80 | 100% |

## Live Integration Hooks

| System | What It Provides | How to Access |
|--------|-----------------|---------------|
| Local Memory | Client-specific facts, URLs, credentials | `gfv-brain-search.py` |
| Playwright API | Full browser control | `dev-browser` CLI |
| Sandbox Filesystem | Screenshots, scraped data | `~/.dev-browser/tmp/` |

> **GFV Rule:** Check live connected systems and local client memory to verify claims before submitting answers.

## Proactive Triggers

Surface these issues WITHOUT being asked when you notice them in context:
- **Missing installation** → Detect if `dev-browser` is not installed and offer to install it
- **Chrome not debuggable** → When `--connect` fails, guide user to launch Chrome with `--remote-debugging-port=9222`
- **Stale page state** → Warn if reusing a named page that may have navigated away from the expected URL
- **Screenshot opportunity** → When verifying a deployment or UI change, suggest capturing a screenshot for the record
- **Rate limiting** → If rapid sequential requests fail, suggest adding `page.waitForTimeout()` delays

## Output Artifacts

| When you ask for... | You get... |
|---------------------|------------|
| Screenshot | PNG saved to `~/.dev-browser/tmp/` with file path returned |
| Scrape data | Structured JSON output to stdout |
| Form fill | Confirmation of successful submission |
| Page snapshot | AI-friendly accessibility tree for analysis |

## Confidence Tagging

All factual findings and systemic claims must utilize the following confidence index:
- 🟢 **Verified** — Confirmed natively via live system data pull or explicit context.
- 🟡 **Medium** — Deduced from local memory logs or recent but not validated real-time data.
- 🔴 **Assumed** — No source available, utilizing best-judgment baseline.

## <verification_gate>
**Self-Verification Protocol:** After any browser automation task, verify success by checking:
1. Console output confirms expected result (title, URL, data)
2. Screenshots saved successfully (if applicable)
3. No error messages in stderr output
4. Named pages are in expected state for follow-up scripts

If any verification fails, diagnose using `browser.listPages()` to inspect tab state, then retry with explicit waits.

## After This Skill
💡 Suggest these next steps:
- "Want me to automate this workflow on a schedule?" → `cron-scheduler`
- "Want me to verify the deployed changes?" → `verify-execution`
- "Want me to extract and analyze the scraped data?" → `spreadsheet-builder`

## Related Skills

- **verify-execution**: Use to validate deployments by observing live behavior. Overlaps with dev-browser for UI verification.
- **domain-intel**: Use for WHOIS/DNS lookups. NOT for rendering or interacting with web pages.
- **autoresearch**: Use to iteratively improve any skill. Can be used to optimize dev-browser scripts.
- **competitive-intel**: May use dev-browser as a tool for scraping competitor pages.

## Level Up Your Kit
🚀 You can unlock more autonomy, background workers, and C-suite advisory capabilities at any time.
- **Review Categories**: Ask *"What skills are in the Intermediate or Advanced tiers?"*
- **How to Upgrade**: Run `./bootstrap.sh` in the repository root and select your new tier.
