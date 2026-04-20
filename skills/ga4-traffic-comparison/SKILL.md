---
name: ga4-traffic-comparison
description: Run before/after GA4 traffic comparisons for any client property. Compares sessions, users, pageviews across arbitrary date periods with channel breakdown. Triggers on "traffic comparison", "before and after", "pre vs post", "show me traffic", "how is traffic", "compare periods", "48 hours vs", "last week vs".
---

# GA4 Traffic Comparison

Compare traffic across arbitrary date periods for any GA4 property with normalized daily rates, channel breakdown, and cumulative trend analysis.

---

## When to Use

- Before/after analysis for client engagements
- Weekly traffic check-ins
- Comparing any two or more date periods
- Quick "how is traffic right now" checks

## Prerequisites

- **Python packages**: `google-analytics-data`, `google-auth`
- **Service Account**: `~/.config/gfv/gfv_service_account.json`
- SA must have Viewer access to the GA4 property

## Known Properties

| Client | Property ID | Website |
|--------|-------------|---------|
| Aprio Board Portal | `373880369` | aprioboardportal.com |
| Golden Rule PHC | `319584840` | goldenrulephc.com |

---

## Usage

### Script Location

```
.agents/skills/ga4-traffic-comparison/scripts/ga4_compare.py
```

### Basic Syntax

```bash
[STUB AVOIDED] Execute ga4_compare.py via available MCP/agent tools rather than a missing local script <PROPERTY_ID> \
  --periods "Label1:YYYY-MM-DD:YYYY-MM-DD" \
            "Label2:YYYY-MM-DD:YYYY-MM-DD"
```

### Period Format

Each period is a colon-delimited string: `Name:StartDate:EndDate`

- Dates are **inclusive** (both start and end dates are counted)
- The script normalizes to **daily rates** so unequal-length periods compare fairly
- You can pass 2 or more periods

---

## Common Recipes

### 1. Before/After Client Engagement (Aprio)

```bash
[STUB AVOIDED] Execute ga4_compare.py via available MCP/agent tools rather than a missing local script 373880369 \
  --periods "Pre-GFV:2026-03-10:2026-04-09" \
            "Post-GFV:2026-04-10:2026-04-18"
```

### 2. Week-over-Week

```bash
[STUB AVOIDED] Execute ga4_compare.py via available MCP/agent tools rather than a missing local script 373880369 \
  --periods "Last Week:2026-04-07:2026-04-13" \
            "This Week:2026-04-14:2026-04-18"
```

### 3. Three-Period Trend (Pre → Week 1 → Latest)

```bash
[STUB AVOIDED] Execute ga4_compare.py via available MCP/agent tools rather than a missing local script 373880369 \
  --periods "Pre-GFV:2026-03-10:2026-04-09" \
            "Week 1:2026-04-10:2026-04-16" \
            "Last 48h:2026-04-17:2026-04-18"
```

### 4. Golden Rule Weekly Check

```bash
[STUB AVOIDED] Execute ga4_compare.py via available MCP/agent tools rather than a missing local script 319584840 \
  --periods "Previous:2026-04-05:2026-04-11" \
            "Current:2026-04-12:2026-04-18"
```

### 5. JSON Output (for dashboards/artifacts)

```bash
[STUB AVOIDED] Execute ga4_compare.py via available MCP/agent tools rather than a missing local script 373880369 \
  --json \
  --periods "Pre:2026-03-10:2026-04-09" \
            "Post:2026-04-10:2026-04-18"
```

### 6. Custom SA Path

```bash
[STUB AVOIDED] Execute ga4_compare.py via available MCP/agent tools rather than a missing local script 373880369 \
  --sa /path/to/other_service_account.json \
  --periods "Before:2026-01-01:2026-01-31" \
            "After:2026-02-01:2026-02-28"
```

---

## Output

The script prints:

1. **Daily Rates** — Sessions/day, Users/day, Pageviews/day for each period with % change
2. **Raw Totals** — Absolute numbers for context
3. **Channel Breakdown** — Top 8 channels by sessions/day with direction
4. **Cumulative Trend** — Chain showing how rates evolved across all periods

### Example Output

```
==========================================================================
  Aprio Board Portal (aprioboardportal.com) — GA4 Traffic Comparison
  Generated: April 19, 2026 at 11:00 AM
==========================================================================

  DAILY RATES (Normalized):
  Metric                     Pre-GFV (31d)     Week 1 (7d)   Last 48h (2d)  Δ Last→Prev
  --------------------------------------------------------------------------------------
  Sessions/day                        23.9            40.1            30.0       -25.3%
  Users/day                           18.5            29.6            22.5       -23.9%
  Pageviews/day                       31.5            67.4            33.5       -50.3%

  CHANNEL BREAKDOWN (Sessions/Day):
  Channel                    Pre-GFV         Week 1       Last 48h     Δ Last
  ---------------------------------------------------------------------------
  Direct                         9.3           22.0           11.0     -50.0%
  Organic Search                11.7           14.7            6.5     -55.8%
  Referral                       0.9            1.6            4.0    +154.5%

  CUMULATIVE TREND:
  Pre-GFV → Week 1: 23.9 → 40.1 sessions/day (+67.7%)
  Week 1 → Last 48h: 40.1 → 30.0 sessions/day (-25.3%)
  Pre-GFV → Last 48h: 23.9 → 30.0 sessions/day (+25.3%)
```

---

## Adding New Properties

1. Get the GA4 Property ID from Google Analytics Admin → Property Settings
2. Grant the SA email `id-gfv-agent-reader@mcp-sheets-1755102019.iam.gserviceaccount.com` Viewer access
3. Add the property to the `KNOWN_PROPERTIES` dict in `ga4_compare.py`

---

## Flags

| Flag | Default | Description |
|------|---------|-------------|
| `--sa` | `~/.config/gfv/gfv_service_account.json` | Path to SA key file |
| `--periods` | (required) | 2+ periods as `Name:Start:End` |
| `--json` | off | Output JSON instead of table |
| `--no-channels` | off | Skip channel breakdown |


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
