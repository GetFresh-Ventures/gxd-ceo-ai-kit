---
name: gfv-website-release
description: Push a versioned release for the GetFresh Ventures website — updates GitHub (README, CHANGELOG, tag), creates GitHub Release, deploys to Vercel via push, and posts a Linear project update. Hard gates enforce no skipped steps.
---

# GFV Website Release Workflow

// turbo-all

## Prerequisites
- Repo: `/Users/dirajgoel/Documents/Code/getfresh-ventures-website`
- Branch: `main`
- Remote: `https://github.com/dpgvan/getfresh-ventures-website.git`
- Linear Project ID: `0d033c84-1217-4c52-bfa8-7200de84ee37` (GFV Website Migration & SEO Hardening)
- Linear API Key: Use the `linear-api-access` skill (Python direct GraphQL)
- GitHub CLI: `/opt/homebrew/bin/gh`
- Production URL: https://www.getfreshventures.com
- Hosting: Vercel (auto-deploys on push to `main`)
- Stack: Next.js (App Router), Tailwind CSS, Supabase

## Version Format
`vMAJOR.MINOR.PATCH` — Example: `v1.0.0`
- **MAJOR**: Full rebuild, framework migration, breaking architecture change
- **MINOR**: New features, new pages, significant SEO/content deployments
- **PATCH**: Bug fixes, content updates, styling changes, schema tweaks

---

## STEP 1: Determine Version (GATE: must decide before proceeding)

Check the last version:
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && git describe --tags --abbrev=0 2>/dev/null || echo "No tags yet — this is the first release" && echo "---" && git log --oneline -10
```

Decide the new version number based on what changed since the last tag. State it explicitly before continuing.

**GATE: Do NOT proceed until version number is confirmed.**

---

## STEP 2: Pre-Flight Checks (GATE: all must pass)

```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && echo "=== GIT STATUS ===" && git status --short | head -30 && echo "=== BRANCH ===" && git branch --show-current && echo "=== BUILD TEST ===" && npm run build 2>&1 | tail -10
```

**GATE: The following must ALL be true before proceeding:**
- [ ] Version number decided (Step 1)
- [ ] On `main` branch (or changes merged to main)
- [ ] Build succeeds (`npm run build`)
- [ ] No unexpected uncommitted changes (or they are intentional for this release)

---

## STEP 3: Update or Create CHANGELOG.md (GATE: must include version entry)

If CHANGELOG.md doesn't exist, create it with header `# Changelog`.

Add a new entry at the TOP of the changelog (after the `# Changelog` header), following this exact format:

```
## YYYY-MM-DD H:MM AM/PM CDT — vX.Y.Z — Release Title

### Added
- Item 1
- Item 2

### Changed
- Item 1

### Fixed
- Item 1

### Linear Issues
- GFV-XXX (Title) — Done ✅
```

Rules:
- Time must be in **Central Time (CDT)**
- Use sections: Added, Changed, Fixed, Removed (only include non-empty sections)
- Each item must be a concrete change, not vague
- Reference Linear issue IDs (GFV-XXX) where applicable

**GATE: CHANGELOG.md must have the new version entry before proceeding.**

---

## STEP 4: Update README.md

Update the following in README.md:
- `**Version**:` badge must show new version number
- `### What's New in vX.Y.Z` section must exist with release highlights
- Technology stack section should reflect current stack (Next.js, not Vite)

**GATE: README.md must reference the new version before proceeding.**

---

## STEP 5: Git Commit + Tag

Stage, commit, and tag:
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && git add -A && git status
```

Then commit and tag (replace VERSION and TITLE):
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && git commit -m "vX.Y.Z: Release Title" && git tag vX.Y.Z
```

**GATE: Commit and tag must exist before proceeding. Verify:**
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && git log -1 --oneline && git describe --tags --exact-match HEAD
```

---

## STEP 6: Push and Create GitHub Release

Push the code and tags to origin:
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && git push origin main --tags
```

> **NOTE:** Vercel will auto-deploy on push to `main`. Monitor the deployment at https://vercel.com.

Then create a formal GitHub Release. Extract the EXACT release notes from CHANGELOG.md (do NOT use a placeholder "See CHANGELOG.md" string — copy the actual content):

```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && /opt/homebrew/bin/gh release create vX.Y.Z --title "vX.Y.Z — Release Title" --notes "ACTUAL CHANGELOG MARKDOWN CONTENT HERE"
```

**GATE: Push and GitHub Release must succeed. Verify:**
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && /opt/homebrew/bin/gh release list --limit 3
```

---

## STEP 6.5: Update GitHub About Section

```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && /opt/homebrew/bin/gh repo view --json description,homepageUrl,repositoryTopics --jq '{description: .description, homepage: .homepageUrl, topics: [.repositoryTopics[].name]}'
```

Then update as needed:
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && /opt/homebrew/bin/gh repo edit \
  --description "GetFresh Ventures — AI GTM engineering for growth-stage CEOs. Next.js, Supabase, Vercel. Growth by Design methodology." \
  --homepage "https://www.getfreshventures.com" \
  --add-topic "nextjs" --add-topic "react" --add-topic "vercel" --add-topic "supabase" --add-topic "gtm" --add-topic "ai" --add-topic "tailwindcss" --add-topic "seo"
```

---

## STEP 7: Verify Vercel Deployment

After pushing, check that Vercel deployed successfully:

```bash
curl -s -o /dev/null -w "%{http_code}" https://www.getfreshventures.com
```

Also spot-check key pages:
```bash
for page in "" "/thesis" "/platform" "/insights" "/team" "/contact"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" "https://www.getfreshventures.com${page}")
  echo "${page:-/}: $code"
done
```

**GATE: All pages must return 200.**

---

## STEP 8: Create Linear Project Update

Use Python direct GraphQL to post a project update:

```python
import json, urllib.request

api_key = "lin_api_Zi3MnxJwACVYELvQV2QitS0NPk1TBknapaQZ4eGA"
try:
    import subprocess
    r = subprocess.run(["security", "find-generic-password", "-w", "-s", "LINEAR_API_KEY"], capture_output=True, text=True)
    if r.stdout.strip():
        api_key = r.stdout.strip()
except Exception:
    pass

def run_linear_query(query, variables=None):
    data = {"query": query}
    if variables:
        data["variables"] = variables
    req = urllib.request.Request(
        "https://api.linear.app/graphql",
        data=json.dumps(data).encode('utf-8'),
        headers={"Content-Type": "application/json", "Authorization": api_key}
    )
    return json.loads(urllib.request.urlopen(req).read().decode('utf-8'))

project_id = "0d033c84-1217-4c52-bfa8-7200de84ee37"
update_body = """## vX.Y.Z — Release Title (Date)

Summary of what changed.

**Key Changes:**
- Change 1
- Change 2

**Production:** https://www.getfreshventures.com
**Git:** [commit hash](https://github.com/dpgvan/getfresh-ventures-website/commit/HASH)
**Release:** [vX.Y.Z](https://github.com/dpgvan/getfresh-ventures-website/releases/tag/vX.Y.Z)"""

mutation = '''
mutation($i: ProjectUpdateCreateInput!) {
  projectUpdateCreate(input: $i) { success projectUpdate { id } }
}
'''
res = run_linear_query(mutation, {"i": {"projectId": project_id, "body": update_body, "health": "onTrack"}})
print("Linear update:", "OK" if res.get("data", {}).get("projectUpdateCreate", {}).get("success") else "FAIL")
```

**GATE: Linear update must be created. Output must show "OK".**

---

## STEP 9: Post-Release Verification

Final verification checklist:
```bash
cd /Users/dirajgoel/Documents/Code/getfresh-ventures-website && echo "=== LAST COMMIT ===" && git log -1 --format="%H %s (%ai)" && echo "=== TAG ===" && git describe --tags --exact-match HEAD && echo "=== REMOTE SYNC ===" && git status -sb
```

**ALL gates must pass:**
- [ ] CHANGELOG.md has new version entry with CDT timestamp
- [ ] README.md references new version in badge and What's New
- [ ] Git commit message follows format `vX.Y.Z: Title`
- [ ] Git tag matches version
- [ ] Pushed to origin/main with tags
- [ ] GitHub Release created with actual changelog content (not placeholder)
- [ ] GitHub About section updated (description, topics, homepage)
- [ ] Vercel auto-deployed successfully (200 on all key pages)
- [ ] Linear project update created with release link
- [ ] No uncommitted changes remain

---

## Quick Reference

### Key Differences from Other Releases
| Property | Golden Rule | Aprio | GFV Website |
|----------|------------|-------|-------------|
| Repo | `golden-rule-dashboard` | `aprio-dashboard` | `getfresh-ventures-website` |
| Branch | `main` | `master` | `main` |
| Linear Project ID | `a6f05311-...` | `600a9682-...` | `0d033c84-...` |
| Hosting | Cloudflare Pages | Vercel (auto) | Vercel (auto) |
| Deploy step | `npx wrangler pages deploy` | Push triggers deploy | Push triggers deploy |
| Stack | Vanilla JS | Vite + React | Next.js (App Router) |
| Build | N/A | `npm run build` | `npm run build` |

### Commit Message Examples
```
v1.0.0: Next.js Migration & SEO Infrastructure
v1.1.0: Growth Diagnostic Tool & CTA Realignment
v1.0.1: Fix blog carousel loading & meta descriptions
v2.0.0: Full Conversion Engineering Overhaul
```

### Linear Health Status
- `onTrack` — Default for routine releases
- `atRisk` — When blockers exist or timeline is slipping
- `offTrack` — When critical systems are broken

### Time Conversion
- PDT → CDT: add 2 hours (e.g., 3:00 PM PDT = 5:00 PM CDT)
- UTC → CDT: subtract 5 hours (e.g., 22:00 UTC = 5:00 PM CDT)


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
