---
name: reddit
description: Search and retrieve content from Reddit. Get posts, comments, subreddit info, and user profiles via the public JSON API. Use when user mentions Reddit, a subreddit, or r/ links.
---


> [!IMPORTANT]
> **GFV-Adapted Skill** — This skill runs within the GetFresh Ventures infrastructure. Follow these conventions.

### GFV Infrastructure Integration

**Credentials** — Never use `.env` files. All secrets live in macOS Keychain:
```bash
security find-generic-password -s "<service>" -a "<account>" -w
```
Check `~/Documents/Code/gfv-brain/scripts/pil_config.py` for service mappings.

**Data Sources** — Before querying external APIs, check PIL first:
- `search_pil` / `smart_search` / `vector_search` MCP tools (491K+ embeddings, 81K entities)
- Supabase tables: `entity_embeddings`, `ont_entities`, `ont_facts`
- Local SQLite: WhatsApp (59K msgs), Slack (2.5K msgs), `gfv_memory.db`

**Output** — Save results to `~/Documents/Code/gfv-brain/` or PIL via Supabase. Never send external messages (email, Slack, WhatsApp) without Diraj's explicit "send it" approval.

**Active Clients**:
- **Golden Rule PHC** — HVAC/plumbing/roofing: goldenrulephc.com, rivercityac.com, cornerstoneroofingexteriors.com
- **Aprio Board Portal** — SaaS governance: aprioboardportal.com
- **GetFresh Ventures** — Venture studio: getfreshventures.com

---


# Reddit Skill

Get posts, comments, subreddit info, and user profiles from Reddit via the public JSON API.

## Prerequisites

**No API key required!** Reddit's public JSON API works without authentication.

**Quick Check**:
```bash
cd <skill_directory>
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script python --limit 3
```

## Commands

All commands run from the skill directory.

### Subreddit Posts
```bash
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script python --limit 20           # Hot posts (default)
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script python --sort new --limit 20
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script python --sort top --time week
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script python --sort top --time all --limit 10
```

### Search Posts
```bash
[STUB AVOIDED] Execute search_posts.py via available MCP/agent tools rather than a missing local script "AI agent" --limit 20
[STUB AVOIDED] Execute search_posts.py via available MCP/agent tools rather than a missing local script "MCP server" --subreddit ClaudeAI --limit 10
[STUB AVOIDED] Execute search_posts.py via available MCP/agent tools rather than a missing local script "async python" --sort top --time year
```

### Subreddit Info
```bash
[STUB AVOIDED] Execute get_subreddit.py via available MCP/agent tools rather than a missing local script python
[STUB AVOIDED] Execute get_subreddit.py via available MCP/agent tools rather than a missing local script ClaudeAI
```

### Post & Comments
```bash
[STUB AVOIDED] Execute get_post.py via available MCP/agent tools rather than a missing local script abc123                       # Get post by ID
[STUB AVOIDED] Execute get_post.py via available MCP/agent tools rather than a missing local script abc123 --comments 50         # With more comments
```

### User Profile
```bash
[STUB AVOIDED] Execute get_user.py via available MCP/agent tools rather than a missing local script spez
[STUB AVOIDED] Execute get_user.py via available MCP/agent tools rather than a missing local script spez --posts 10              # Include recent posts
```

## Sort Options

| Sort | Description | Time Options |
|------|-------------|--------------|
| `hot` | Trending posts (default) | - |
| `new` | Latest posts | - |
| `top` | Highest voted | hour, day, week, month, year, all |
| `rising` | Gaining traction | - |
| `controversial` | Mixed votes | hour, day, week, month, year, all |

## API Info
- **Method**: Public JSON API (no auth needed)
- **Trick**: Append `.json` to any Reddit URL
- **Rate Limit**: 100 requests/minute
- **Docs**: https://www.reddit.com/dev/api


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
