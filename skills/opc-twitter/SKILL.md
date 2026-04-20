---
name: twitter
description: Search and retrieve content from Twitter/X. Get user info, tweets, replies, followers, communities, spaces, and trends via twitterapi.io. Use when user mentions Twitter, X, or tweets.
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


# Twitter/X Skill

Get user profiles, tweets, replies, followers/following, communities, spaces, and trends from Twitter/X via twitterapi.io.

## Prerequisites

Set API key in `~/.zshrc`:
```bash
export TWITTERAPI_API_KEY="your_api_key"
```

**Quick Check**:
```bash
cd <skill_directory>
[STUB AVOIDED] Execute get_user_info.py via available MCP/agent tools rather than a missing local script elonmusk
```

## Commands

All commands run from the skill directory.

### User Endpoints
```bash
[STUB AVOIDED] Execute get_user_info.py via available MCP/agent tools rather than a missing local script USERNAME
[STUB AVOIDED] Execute get_user_about.py via available MCP/agent tools rather than a missing local script USERNAME
[STUB AVOIDED] Execute batch_get_users.py via available MCP/agent tools rather than a missing local script USER_ID1,USER_ID2
[STUB AVOIDED] Execute get_user_tweets.py via available MCP/agent tools rather than a missing local script USERNAME --limit 20
[STUB AVOIDED] Execute get_user_mentions.py via available MCP/agent tools rather than a missing local script USERNAME --limit 20
[STUB AVOIDED] Execute get_followers.py via available MCP/agent tools rather than a missing local script USERNAME --limit 100
[STUB AVOIDED] Execute get_following.py via available MCP/agent tools rather than a missing local script USERNAME --limit 100
[STUB AVOIDED] Execute get_verified_followers.py via available MCP/agent tools rather than a missing local script USERNAME --limit 20
[STUB AVOIDED] Execute check_relationship.py via available MCP/agent tools rather than a missing local script USER1 USER2
[STUB AVOIDED] Execute search_users.py via available MCP/agent tools rather than a missing local script "query" --limit 20
```

### Tweet Endpoints
```bash
[STUB AVOIDED] Execute get_tweet.py via available MCP/agent tools rather than a missing local script TWEET_ID [TWEET_ID2...]
[STUB AVOIDED] Execute search_tweets.py via available MCP/agent tools rather than a missing local script "query" --type Latest --limit 20
[STUB AVOIDED] Execute get_tweet_replies.py via available MCP/agent tools rather than a missing local script TWEET_ID --limit 20
[STUB AVOIDED] Execute get_tweet_quotes.py via available MCP/agent tools rather than a missing local script TWEET_ID --limit 20
[STUB AVOIDED] Execute get_tweet_retweeters.py via available MCP/agent tools rather than a missing local script TWEET_ID --limit 50
[STUB AVOIDED] Execute get_tweet_thread.py via available MCP/agent tools rather than a missing local script TWEET_ID
[STUB AVOIDED] Execute get_article.py via available MCP/agent tools rather than a missing local script TWEET_ID
```

### List Endpoints
```bash
[STUB AVOIDED] Execute get_list_followers.py via available MCP/agent tools rather than a missing local script LIST_ID --limit 20
[STUB AVOIDED] Execute get_list_members.py via available MCP/agent tools rather than a missing local script LIST_ID --limit 20
```

### Community Endpoints
```bash
[STUB AVOIDED] Execute get_community.py via available MCP/agent tools rather than a missing local script COMMUNITY_ID
[STUB AVOIDED] Execute get_community_members.py via available MCP/agent tools rather than a missing local script COMMUNITY_ID --limit 20
[STUB AVOIDED] Execute get_community_moderators.py via available MCP/agent tools rather than a missing local script COMMUNITY_ID
[STUB AVOIDED] Execute get_community_tweets.py via available MCP/agent tools rather than a missing local script COMMUNITY_ID --limit 20
[STUB AVOIDED] Execute search_community_tweets.py via available MCP/agent tools rather than a missing local script "query" --limit 20
```

### Other Endpoints
```bash
[STUB AVOIDED] Execute get_space.py via available MCP/agent tools rather than a missing local script SPACE_ID
[STUB AVOIDED] Execute get_trends.py via available MCP/agent tools rather than a missing local script --woeid 1  # Worldwide
```

## Search Query Syntax

```bash
# Basic search
[STUB AVOIDED] Execute search_tweets.py via available MCP/agent tools rather than a missing local script "AI agent"

# From specific user
[STUB AVOIDED] Execute search_tweets.py via available MCP/agent tools rather than a missing local script "from:elonmusk"

# Date range
[STUB AVOIDED] Execute search_tweets.py via available MCP/agent tools rather than a missing local script "AI since:2024-01-01 until:2024-12-31"

# Exclude retweets
[STUB AVOIDED] Execute search_tweets.py via available MCP/agent tools rather than a missing local script "AI -filter:retweets"

# With media
[STUB AVOIDED] Execute search_tweets.py via available MCP/agent tools rather than a missing local script "AI filter:media"

# Minimum engagement
[STUB AVOIDED] Execute search_tweets.py via available MCP/agent tools rather than a missing local script "AI min_faves:1000"
```

## API: twitterapi.io
- Base URL: https://api.twitterapi.io/twitter
- Auth: X-API-Key header
- Pricing: ~$0.15-0.18/1k requests
- Docs: https://docs.twitterapi.io/


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
