---
name: google-calendar-api
description: >
  Access Google Calendar API for event management — list, create, update, delete events.
  Uses Service Account domain-wide delegation via gfv_service_account.json.
  Use when: scheduling meetings, checking availability, creating calendar events.
  Skip when: just looking at meeting history (use fathom-api for transcripts).
---

# Google Calendar API

> [!IMPORTANT]
> **GFV-Adapted Skill** — This skill runs within the GetFresh Ventures infrastructure.

### GFV Infrastructure Integration

**Credentials**: Service Account with domain-wide delegation
```bash
# SA file location
~/.config/gfv/gfv_service_account.json

# No Keychain needed — SA file is the credential
```

---

## Overview

Manages Google Calendar events for `executive@company.com` using Service Account delegation. Handles listing upcoming events, creating new meetings, and managing availability.

## Authentication

```python
from google.oauth2 import service_account
from googleapiclient.discovery import build

SA_FILE = os.path.expanduser('~/.config/gfv/gfv_service_account.json')

credentials = service_account.Credentials.from_service_account_file(
    SA_FILE,
    scopes=['https://www.googleapis.com/auth/calendar']
).with_subject('executive@company.com')

service = build('calendar', 'v3', credentials=credentials)
```

## Core Operations

### List Upcoming Events

```python
from datetime import datetime, timezone

now = datetime.now(timezone.utc).isoformat()
events = service.events().list(
    calendarId='primary',
    timeMin=now,
    maxResults=10,
    singleEvents=True,
    orderBy='startTime'
).execute()

for event in events.get('items', []):
    start = event['start'].get('dateTime', event['start'].get('date'))
    print(f"{start} — {event['summary']}")
```

### Create Event

```python
event = {
    'summary': 'Acme Corp Weekly Sync',
    'description': 'Weekly progress review with Greg and Derrick',
    'start': {
        'dateTime': '2026-04-24T14:00:00-06:00',
        'timeZone': 'America/Denver',
    },
    'end': {
        'dateTime': '2026-04-24T15:00:00-06:00',
        'timeZone': 'America/Denver',
    },
    'attendees': [
    ],
    'conferenceData': {
        'createRequest': {'requestId': 'unique-id-here'}
    },
}

created = service.events().insert(
    calendarId='primary',
    body=event,
    conferenceDataVersion=1,  # Creates Google Meet link
    sendUpdates='all'
).execute()
print(f"Created: {created['htmlLink']}")
```

### Update Event

```python
event = service.events().get(
    calendarId='primary',
    eventId='event_id_here'
).execute()

event['summary'] = 'Updated: Acme Corp Weekly Sync'
updated = service.events().update(
    calendarId='primary',
    eventId=event['id'],
    body=event,
    sendUpdates='all'
).execute()
```

### Delete Event

```python
service.events().delete(
    calendarId='primary',
    eventId='event_id_here',
    sendUpdates='all'
).execute()
```

### Check Availability (Free/Busy)

```python
body = {
    'timeMin': '2026-04-24T00:00:00-06:00',
    'timeMax': '2026-04-24T23:59:59-06:00',
    'items': [{'id': 'executive@company.com'}]
}
freebusy = service.freebusy().query(body=body).execute()
busy_times = freebusy['calendars']['executive@company.com']['busy']
```

## Time Zones

| Client | Zone | IANA |
|---|---|---|
| Acme Corp (Utah) | Mountain | `America/Denver` |
| Acme Corp (Iowa) | Central | `America/Chicago` |
| Globex Corp (National) | Eastern | `America/New_York` |
| the Executive | Pacific | `America/Los_Angeles` |

## Anti-Patterns
- ❌ Creating events without the Executive's approval
- ❌ Sending calendar invites to external clients without review
- ❌ Using personal OAuth when SA delegation works
- ❌ Ignoring time zone differences between clients

## Related Skills
- **google-workspace-access**: Master credential reference
- **fathom-api**: Meeting transcripts after the event
- **gfv-email-drafting**: Follow-up emails after meetings
- **hubspot-api**: Log meetings as engagements in CRM

## References
- **API Docs**: https://developers.google.com/calendar/api
- **SA File**: `~/.config/gfv/gfv_service_account.json`


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
