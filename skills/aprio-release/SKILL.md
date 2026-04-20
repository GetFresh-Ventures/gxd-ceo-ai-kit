---
name: aprio-release
description: Push a versioned release for the Aprio GTM Dashboard — updates GitHub (README, CHANGELOG, tag), creates GitHub Release, and posts a Linear project update. Hard gates enforce no skipped steps.
---

# Aprio Dashboard Release Workflow

// turbo-all

## Prerequisites
- Repo: `/Users/dirajgoel/Documents/Code/aprio-dashboard`
- Branch: `master` (NOT `main`)
- Linear Project ID: `600a9682-c809-4b33-807c-d435eada6ec9` (Aprio GTM Dashboard)
- Linear API Key: Use the `linear-api-access` skill (Python direct GraphQL, NOT MCP)
- GitHub CLI: `/opt/homebrew/bin/gh`

## Version Format
`vMAJOR.MINOR.PATCH` — Example: `v1.4.0`
- **MAJOR**: Full rebuild, breaking architecture change
- **MINOR**: New features, new content categories, significant SEO deployments
- **PATCH**: Bug fixes, content updates, styling changes, schema tweaks

---

## STEP 1: Determine Version (GATE: must decide before proceeding)

Check the last version:
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && git describe --tags --abbrev=0 && git log $(git describe --tags --abbrev=0)..HEAD --oneline
```

Decide the new version number based on what changed since the last tag. State it explicitly before continuing.

**GATE: Do NOT proceed until version number is confirmed.**

---

## STEP 2: Pre-Flight Checks (GATE: all must pass)

```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && echo "=== GIT STATUS ===" && git status --short && echo "=== UNCOMMITTED ===" && git diff --stat
```

**GATE: The following must ALL be true before proceeding:**
- [ ] Version number decided (Step 1)
- [ ] No unexpected uncommitted changes (or they are intentional for this release)

---

## STEP 3: Update CHANGELOG.md (GATE: must include version entry)

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
- Include a Linear Issues section when issues were closed

**GATE: CHANGELOG.md must have the new version entry before proceeding.**

---

## STEP 4: Update README.md

Update the following in README.md:
- `**Version**:` badge must show new version number
- `### What's New in vX.Y.Z` section must exist with release highlights
- Any architecture changes, new directories, or new data sources must be documented

**GATE: README.md must reference the new version before proceeding.**

---

## STEP 5: Git Commit + Tag

Stage, commit, and tag:
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && git add -A && git status
```

Then commit and tag (replace VERSION and TITLE):
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && git commit -m "vX.Y.Z: Release Title" && git tag vX.Y.Z
```

**GATE: Commit and tag must exist before proceeding. Verify:**
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && git log -1 --oneline && git describe --tags --exact-match HEAD
```

---

## STEP 6: Push and Create GitHub Release

Push the code and tags to origin:
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && git push origin master --tags
```

Then create a formal GitHub Release. Extract the EXACT release notes from CHANGELOG.md (do NOT use a placeholder "See CHANGELOG.md" string — copy the actual content):

```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && /opt/homebrew/bin/gh release create vX.Y.Z --title "vX.Y.Z — Release Title" --notes "ACTUAL CHANGELOG MARKDOWN CONTENT HERE"
```

**GATE: Push and GitHub Release must succeed. Verify:**
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && /opt/homebrew/bin/gh release list --limit 3
```

---

## STEP 6.5: Update GitHub About Section

```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && /opt/homebrew/bin/gh repo view --json description,homepageUrl,repositoryTopics --jq '{description: .description, homepage: .homepageUrl, topics: [.repositoryTopics[].name]}'
```

Then update as needed:
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && /opt/homebrew/bin/gh repo edit \
  --description "Executive GTM dashboard & SEO engine for Aprio Board Portal — 40+ pages deployed, FAQ schema, competitive intelligence, GA4 pipeline" \
  --homepage "https://aprioboardportal.com" \
  --add-topic "aprio" --add-topic "seo" --add-topic "react" --add-topic "vite" --add-topic "vercel" --add-topic "wordpress" --add-topic "ga4" --add-topic "board-portal"
```

---

## STEP 7: Create Linear Project Update

Use the `linear-api-access` skill (Python direct GraphQL) to post a project update:

```python
import json, urllib.request, subprocess

api_key = "lin_api_Zi3MnxJwACVYELvQV2QitS0NPk1TBknapaQZ4eGA"
try:
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

project_id = "600a9682-c809-4b33-807c-d435eada6ec9"
update_body = """## vX.Y.Z — Release Title (Date)

Summary of what changed.

**Key Changes:**
- Change 1
- Change 2

**Files Modified:**
- file1.ext
- file2.ext

**Git:** [commit hash](https://github.com/GetFresh-Ventures/aprio-dashboard/commit/HASH)
**Release:** [vX.Y.Z](https://github.com/GetFresh-Ventures/aprio-dashboard/releases/tag/vX.Y.Z)"""

mutation = '''
mutation($i: ProjectUpdateCreateInput!) {
  projectUpdateCreate(input: $i) { success projectUpdate { id } }
}
'''
res = run_linear_query(mutation, {"i": {"projectId": project_id, "body": update_body, "health": "onTrack"}})
print("Linear update:", "OK" if res.get("data", {}).get("projectUpdateCreate", {}).get("success") else "FAIL")
```

Health values: `onTrack`, `atRisk`, `offTrack`

**GATE: Linear update must be created. Output must show "OK".**

---

## STEP 8: Post-Release Verification

Final verification checklist:
```bash
cd /Users/dirajgoel/Documents/Code/aprio-dashboard && echo "=== LAST COMMIT ===" && git log -1 --format="%H %s (%ai)" && echo "=== TAG ===" && git describe --tags --exact-match HEAD && echo "=== REMOTE SYNC ===" && git status -sb
```

**ALL gates must pass:**
- [ ] CHANGELOG.md has new version entry with CDT timestamp
- [ ] README.md references new version in badge and What's New
- [ ] Git commit message follows format `vX.Y.Z: Title`
- [ ] Git tag matches version
- [ ] Pushed to origin/master with tags
- [ ] GitHub Release created with actual changelog content (not placeholder)
- [ ] GitHub About section updated
- [ ] Linear project update created with release link
- [ ] No uncommitted changes remain

---

## Quick Reference

### Key Differences from Golden Rule Release
| Property | Golden Rule | Aprio |
|----------|------------|-------|
| Repo | `golden-rule-dashboard` | `aprio-dashboard` |
| Branch | `main` | `master` |
| Linear Project ID | `a6f05311-...` | `600a9682-...` |
| Hosting | Cloudflare Pages | Vercel |
| Deploy step | `npx wrangler pages deploy` | Auto-deploy on push (Vercel) |
| Linear method | Node.js via `op` | Python direct GraphQL |

### Commit Message Examples
```
v1.4.0: SEO Infrastructure Finalization & Programmatic Content Engine
v1.3.2: Eject from button tag to div to prevent component library bleed
v1.5.0: Canadian Geo-Targeting & Hreflang Deployment
v2.0.0: Elementor Migration & Dashboard Rebuild
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
