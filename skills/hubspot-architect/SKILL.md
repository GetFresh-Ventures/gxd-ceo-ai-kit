---
name: hubspot-architect
description: "Build HubSpot CRM integrations, data pipelines, and sync workflows. Use when the user needs to set up HubSpot, create custom properties, build deal pipelines, or sync data between HubSpot and other systems."
short_description: "Build HubSpot CRM integrations and pipelines"
requires_human_approval: true
---

# HubSpot Architect

Build production-grade HubSpot integrations. Never guess at API structures — always verify against the SDK and API docs.


## Quick Start
Just say any of these:
- "Set up my HubSpot deal pipeline"
- "Build a workflow that auto-assigns leads"
- "Design my CRM data model"


## When to Use

- "Set up HubSpot for [client]"
- "Sync [system] data to HubSpot"
- "Create a deal pipeline in HubSpot"
- "Build a HubSpot integration"
- Any CRM data architecture work

## Prerequisites

### SDK Setup (on-demand)
```bash
pip install hubspot-api-client
```

### Authentication
```python
from hubspot import HubSpot

# Private App Token (recommended)
client = HubSpot(access_token="YOUR_PAT")

# Or from environment
import os
client = HubSpot(access_token=os.environ["HUBSPOT_PAT"])
```

**Where tokens live:** macOS Keychain or environment variable `HUBSPOT_PAT`. Never hardcode.

## Common Patterns

### 1. Contact CRUD

```python
from hubspot.crm.contacts import SimplePublicObjectInputForCreate

# Create
contact = client.crm.contacts.basic_api.create(
    SimplePublicObjectInputForCreate(
        properties={
            "email": "ceo@example.com",
            "firstname": "Jane",
            "lastname": "Doe",
            "company": "Acme Corp"
        }
    )
)

# Search
from hubspot.crm.contacts import PublicObjectSearchRequest
search = client.crm.contacts.search_api.do_search(
    PublicObjectSearchRequest(
        filter_groups=[{
            "filters": [{
                "propertyName": "email",
                "operator": "EQ",
                "value": "ceo@example.com"
            }]
        }],
        properties=["email", "firstname", "lastname", "company"]
    )
)

# Update
from hubspot.crm.contacts import SimplePublicObjectInput
client.crm.contacts.basic_api.update(
    contact_id="12345",
    simple_public_object_input=SimplePublicObjectInput(
        properties={"lifecyclestage": "customer"}
    )
)
```

### 2. Deal Pipeline Setup

```python
# Create a pipeline
pipeline = client.crm.pipelines.pipelines_api.create(
    object_type="deals",
    pipeline_input={
        "label": "Sales Pipeline",
        "displayOrder": 0,
        "stages": [
            {"label": "Discovery",      "displayOrder": 0, "metadata": {"probability": "0.1"}},
            {"label": "Proposal",       "displayOrder": 1, "metadata": {"probability": "0.3"}},
            {"label": "Negotiation",    "displayOrder": 2, "metadata": {"probability": "0.6"}},
            {"label": "Closed Won",     "displayOrder": 3, "metadata": {"probability": "1.0"}},
            {"label": "Closed Lost",    "displayOrder": 4, "metadata": {"probability": "0.0"}},
        ]
    }
)
```

### 3. UPSERT Sync Pattern

The right way to sync external data into HubSpot — don't create duplicates:

```python
def upsert_contact(client, email, properties):
    """Search by email first, create or update accordingly."""
    from hubspot.crm.contacts import PublicObjectSearchRequest

    # Search
    results = client.crm.contacts.search_api.do_search(
        PublicObjectSearchRequest(
            filter_groups=[{
                "filters": [{
                    "propertyName": "email",
                    "operator": "EQ",
                    "value": email
                }]
            }]
        )
    )

    if results.total > 0:
        # Update existing
        contact_id = results.results[0].id
        client.crm.contacts.basic_api.update(
            contact_id=contact_id,
            simple_public_object_input={"properties": properties}
        )
        return contact_id, "updated"
    else:
        # Create new
        props = {**properties, "email": email}
        result = client.crm.contacts.basic_api.create(
            simple_public_object_input={"properties": props}
        )
        return result.id, "created"
```

### 4. Batch Operations

```python
# Batch create (up to 100 at a time)
from hubspot.crm.contacts import BatchInputSimplePublicObjectInputForCreate

batch = BatchInputSimplePublicObjectInputForCreate(
    inputs=[
        {"properties": {"email": "a@example.com", "firstname": "A"}},
        {"properties": {"email": "b@example.com", "firstname": "B"}},
    ]
)
client.crm.contacts.batch_api.create(batch)
```

## Architecture Rules

1. **Always UPSERT, never blind INSERT** — duplicates corrupt the CRM
2. **Rate limits:** 100 requests/10 seconds for private apps. Use batch endpoints.
3. **Property validation:** Check that custom properties exist before writing to them
4. **Association types:** Use the correct `associationTypeId` (3 = contact-to-company, 5 = deal-to-contact)
5. **Pagination:** All list endpoints return max 100 results. Always check `paging.next` for more

## Error Handling

| Error | Cause | Fix |
|-------|-------|-----|
| 401 | Bad or expired token | Refresh PAT in HubSpot settings |
| 409 | Duplicate detected | Use UPSERT pattern above |
| 429 | Rate limited | Wait 10 seconds, retry |
| 400 with "PROPERTY_DOESNT_EXIST" | Custom property missing | Create it first via Properties API |

## Integration

- Used by `/cro-advisor` for pipeline analysis
- Used by `/pipeline-pulse` for deal tracking
- Used by `/chief-of-staff` for CRM health monitoring
- Credentials stored in macOS Keychain or env vars — never in code

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Workflows not triggering | Check enrollment criteria — 'and' vs 'or' logic is the #1 mistake |
| Data quality issues | Set required fields on deal stage transitions to enforce data entry |



## After This Skill
💡 Suggest these next:
- "Try `pipeline-pulse` — Active pipeline management and deal tracking"
- "Try `deal-review` — Pipeline review — flag stale deals, find gaps"
- "Try `outreach-sequence` — Design multi-touch outreach campaigns"
