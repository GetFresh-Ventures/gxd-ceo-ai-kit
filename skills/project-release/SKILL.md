---
name: project-release
description: Governed release workflow for CEO enablement projects. Bumps semantic version, updates CHANGELOG and README, tags git, pushes to remote, and optionally syncs release notes to Linear.
---

# `project-release`

This skill provides a structured release process for AI-powered executives managing their own codebase and infrastructure. It ensures every release is documented, cleanly versioned, and broadcasted to tracking systems.

## Prerequisites
- A git repository initialized with a `README.md` and `CHANGELOG.md`.
- Ensure there are no uncommitted changes or dirty working states prior to running this release.
- GitHub CLI (`gh`) installed and authenticated for publishing formal releases.
- (Optional) Linear Project ID + Linear API Key for project board synchronization.

## Phase 1: Determine Version Details
1. Review the git history since the last tag. If a tag exists, run `git log $(git describe --tags --abbrev=0)..HEAD --oneline` to see what changed.
2. Determine the new Semantic Version:
   - **MAJOR (`v2.0.0`)**: Breaking framework changes or massive structural refactors.
   - **MINOR (`v1.2.0`)**: New skills, workflows, or significant system additions.
   - **PATCH (`v1.1.1`)**: Small fixes, prompt tweaks, or documentation updates.
3. Formulate a short, punchy release title (e.g., `Awesome Claude Edition`).
4. **Pause here** if running interactively. Ensure the CEO confirms the version bump and title before proceeding to writes.

## Phase 2: Documentation Upgrades

### 1. Update `CHANGELOG.md`
Inject a new version header at the top of the `CHANGELOG.md` (right below the main `# Changelog` headers) tracking exactly this format:

```markdown
## YYYY-MM-DD h:mm A CT — vX.Y.Z — Release Title

### Added
- [Feature 1 detail]

### Changed
- [Modification detail]

### Fixed
- [Fix detail]
```
*Note: Timestamp must always be converted to Central Time (CT).*

### 2. Update `README.md`
- Locate the version identifier at the top (e.g., `**Version**: vX.Y.Z`) and increment it.
- Locate or create the `"What's New in vX.Y.Z"` section to highlight the critical changes being pushed in this release.

## Phase 3: Git Tagging and Push
Execute the following to commit the version into history:

1. Stage the files:
   `git add README.md CHANGELOG.md`
2. Commit:
   `git commit -m "vX.Y.Z: Release Title"`
3. Tag the release:
   `git tag -a "vX.Y.Z" -m "vX.Y.Z: Release Title"`
4. Push to remote:
   `git push origin main --tags --force-with-lease`

## Phase 4: GitHub Release Publish
After the tag is pushed to origin, you must formally publish the release to the GitHub UI using the GitHub CLI (`gh`).
1. Extract the exact bulleted body of the new release from `CHANGELOG.md` into a temporary file (e.g. `/tmp/vX.Y.Z_release_notes.md`).
2. Run the GitHub CLI release creator:
   `/opt/homebrew/bin/gh release create vX.Y.Z --title "vX.Y.Z: Release Title" -F /tmp/vX.Y.Z_release_notes.md`

## Phase 5: Linear Sync (If Applicable)
If the active environment is tied to a Linear Project:
1. Extract the new `CHANGELOG.md` entry.
2. Formulate a markdown payload summarizing the release, including a direct link to the `git commit` hash on GitHub.
3. Use the `mcp_linear-mcp-server_save_status_update` tool (or a graphql bash script) to publish the payload as a Project Update to the designated Linear Project. Set health to `onTrack`.

## Verification & Execution Gates
- **GATE**: Ensure `CHANGELOG.md` and `README.md` are correctly formatted before committing.
- **GATE**: Verify `git push` succeeded and did not reject the tag.
- **GATE**: Verify `gh release create` successfully returning the GitHub URL for the release.
- **GATE**: Ensure Linear sync returned a `success` response.
