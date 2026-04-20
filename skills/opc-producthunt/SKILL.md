---
name: producthunt
description: Search and retrieve content from Product Hunt. Get posts, topics, users, and collections via the GraphQL API. Use when user mentions Product Hunt, PH, or product launches.
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


# ProductHunt Skill

Get posts, topics, users, and collections from Product Hunt via the official GraphQL API.

## Prerequisites

Set access token in `~/.zshrc`:
```bash
export PRODUCTHUNT_ACCESS_TOKEN="your_developer_token"
```

Get your token from: https://www.producthunt.com/v2/oauth/applications

**Quick Check**:
```bash
cd <skill_directory>
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script --limit 3
```

## Commands

All commands run from the skill directory.

### Posts
```bash
[STUB AVOIDED] Execute get_post.py via available MCP/agent tools rather than a missing local script chatgpt                    # Get post by slug
[STUB AVOIDED] Execute get_post.py via available MCP/agent tools rather than a missing local script 12345                      # Get post by ID
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script --limit 20                # Today's featured posts
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script --topic ai --limit 10     # Posts in topic
[STUB AVOIDED] Execute get_posts.py via available MCP/agent tools rather than a missing local script --after 2026-01-01        # Posts after date
[STUB AVOIDED] Execute get_post_comments.py via available MCP/agent tools rather than a missing local script POST_ID --limit 20
```

### Topics
```bash
[STUB AVOIDED] Execute get_topic.py via available MCP/agent tools rather than a missing local script artificial-intelligence  # Get topic by slug
[STUB AVOIDED] Execute get_topics.py via available MCP/agent tools rather than a missing local script --query "AI" --limit 20 # Search topics
[STUB AVOIDED] Execute get_topics.py via available MCP/agent tools rather than a missing local script --limit 50              # Popular topics
```

### Users
```bash
[STUB AVOIDED] Execute get_user.py via available MCP/agent tools rather than a missing local script rrhoover                  # Get user by username
[STUB AVOIDED] Execute get_user_posts.py via available MCP/agent tools rather than a missing local script rrhoover --limit 20 # User's posts
```

### Collections
```bash
[STUB AVOIDED] Execute get_collection.py via available MCP/agent tools rather than a missing local script SLUG_OR_ID          # Get collection
[STUB AVOIDED] Execute get_collections.py via available MCP/agent tools rather than a missing local script --featured --limit 20
```

## API Info
- **Endpoint**: https://api.producthunt.com/v2/api/graphql
- **Type**: GraphQL
- **Rate Limits**: 6250 complexity points / 15 min
- **Docs**: https://api.producthunt.com/v2/docs


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
