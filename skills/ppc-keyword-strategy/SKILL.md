---
name: ppc-keyword-strategy
description: Repeatable methodology for auditing and restructuring PPC keyword lists for home services campaigns. Covers keyword design, negative keyword lists, ad copy pairing, and landing page alignment.
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

**Output** — Save results to `~/Documents/Code/gfv-brain/` or PIL via Supabase. Never send external messages (email, Slack, WhatsApp) without the Executive's explicit "send it" approval.

**Active Clients**:
- **GetFresh Ventures** — Venture studio: getfreshventures.com

---




# PPC Keyword Strategy — Home Services

**Use this skill when:** Building or restructuring Search campaigns for a home services company (HVAC, Plumbing, Water Heater, Electrical, Roofing, etc.). This methodology was developed and validated on the Acme Corp Utah market restructure (April 2026) and can be applied to any metro area.


---

## The Framework: Keyword Design Principles

### 1. Intent Hierarchy

Not all keywords are equal. Organize them by **buyer intent**, from highest to lowest:

| Tier | Intent Level | Example Keywords | Expected CPC | Conversion Likelihood |
|---|---|---|---|---|
| **Tier 1** | Emergency / Symptom | "furnace not working", "no hot water", "pipe burst" | $3–8 | Very High — caller has a problem NOW |
| **Tier 2** | Brand + Service | "Rheem water heater repair", "Carrier AC repair" | $3–10 | High — knows their equipment brand |
| **Tier 3** | Service + Location | "plumber salt lake city", "hvac repair sandy utah" | $5–15 | High — local intent confirmed |
| **Tier 4** | Generic Service | "water heater repair", "ac repair" | $15–35 | Medium — could be research |
| **Tier 5** | Research / DIY | "how to fix water heater", "ac parts near me" | $8–20 | Low — likely not buying |

**Rule: Build from Tier 1 down, not Tier 4 up.** Most campaigns start with expensive generic Tier 4 keywords. Start with cheap, high-intent Tier 1–2 instead.

### 2. Keyword Categories (per Service Line)

For each service line (HVAC, Plumbing, Water Heater, etc.), build keywords across these 5 categories:

#### a) Symptom Keywords
What the customer *experiences*. These are the highest-intent searches because the person has a problem right now.

```
[symptom] + [optional location]
```

**HVAC examples:**
- furnace blowing cold air
- AC not cooling
- thermostat not working
- furnace won't turn on
- AC making noise

**Water Heater examples:**
- no hot water
- water heater leaking
- pilot light out
- rusty hot water
- water heater flooding

**Plumbing examples:**
- burst pipe
- clogged drain
- sewer backup
- toilet overflowing
- faucet leaking

#### b) Brand + Service Keywords
The customer *knows what equipment they have*. Lower competition because it's more specific.

```
[brand name] + [service type] + [optional "repair"/"service"]
```

**HVAC brands:** Goodman, Carrier, Trane, Lennox, York, Rheem, Daikin
**Water Heater brands:** Rheem, AO Smith, Bradford White, Navien, Rinnai
**Plumbing brands:** Less brand-specific — focus on service type instead

**Examples:**
- Goodman furnace repair
- Carrier AC service
- Rheem water heater leaking
- AO Smith pilot light out
- Bradford White repair near me

#### c) Service + City Keywords
Geographic specificity signals local intent.

```
[service type] + [city name] [state abbreviation]
```

**Pick cities from data:** Pull all-time geo performance and rank by conversion volume. Add city keywords for the top 5–10 converting areas.

**Examples:**
- plumber west jordan utah
- hvac repair sandy ut
- water heater repair ogden
- emergency plumber orem utah
- furnace repair clearfield

#### d) Emergency / Urgency Keywords
Captures after-hours and panic searches.

```
[urgency modifier] + [service type] + [optional location]
```

**Urgency modifiers:** emergency, 24/7, 24 hour, same day, urgent, after hours, late night

**Examples:**
- emergency plumber salt lake city
- 24/7 hvac repair
- same day water heater replacement
- after hours plumber utah

#### e) Pre-Season / Preventive Keywords
Lower CPC, builds Quality Score before demand surges. Use 4–6 weeks before the relevant season.

```
[preventive service] + [optional location]
```

**HVAC — add in March/April for summer:**
- AC tune up
- AC maintenance salt lake city
- air conditioning check up

**HVAC — add in September/October for winter:**
- furnace tune up
- heating system maintenance
- furnace inspection

---

## Step-by-Step Audit Workflow

### Phase 1: Pull Current State (30 minutes)

```bash
# 1. Get campaign stats (last 30 days)
gr_google_ads_ppc_get_campaign_stats {"start_date":"<30d ago>","end_date":"<today>"}

# 2. Get keyword performance (last 30 days)
gr_google_ads_ppc_get_keyword_performance {"start_date":"<30d ago>","end_date":"<today>"}

# 3. Get search terms (last 21 days — what users ACTUALLY searched)
gr_google_ads_ppc_get_search_terms {"start_date":"<21d ago>","end_date":"<today>"}

# 4. Get geo performance (all-time for coverage validation)
gr_google_ads_ppc_get_geographic_performance {"start_date":"2024-01-01","end_date":"<today>"}
```

### Phase 2: Diagnose Problems (15 minutes)

Build a diagnostic table for each campaign:

| Metric | Healthy | Warning | Critical |
|---|---|---|---|
| CTR | >4% | 2–4% | <2% |
| CPC | <$10 | $10–20 | >$20 |
| CPA | <$75 | $75–150 | >$150 or ∞ |
| Conversion Rate | >8% | 4–8% | <4% |
| Keywords per campaign | 15–30 | 8–14 | <8 |
| Ads per ad group | 3+ | 2 | 1 |

Check for these common problems:
- [ ] **Expensive generic keywords** — Tier 4 keywords with CPC >$20 and no conversions
- [ ] **Missing Tier 1–2 keywords** — No symptom or brand keywords
- [ ] **No city keywords** — Missing top-converting geo areas
- [ ] **Competitor bleed** — Search terms showing competitor names
- [ ] **DIY/research bleed** — Search terms like "how to", "parts", "home depot"
- [ ] **Landing page mismatch** — Ad points to wrong page or homepage
- [ ] **Too few ads** — Only 1 ad per ad group (need 3+)
- [ ] **No emergency messaging** — No "24/7" in headlines despite after-hours bidding

### Phase 3: Build Keyword List (30 minutes)

For each service line, create keywords from all 5 categories above. Target 12–20 keywords per campaign:

| Category | Target Count | Priority |
|---|---|---|
| Symptom keywords | 3–5 | P0 — add first |
| Brand + Service | 3–5 | P0 — add first |
| Service + City | 3–5 | P1 — add for top converting cities |
| Emergency / Urgency | 2–3 | P1 — especially if running after-hours bids |
| Pre-Season / Preventive | 2–3 | P2 — seasonal, add 4-6 weeks before demand |

**Match types:** Use **Phrase Match** (`"keyword"`) for all new keywords. Avoid Broad Match (wastes budget) and Exact Match (too restrictive for new keywords).

### Phase 4: Build Negative Keyword List (15 minutes)

Create a **shared** negative keyword list applied across all campaigns in the account:

#### Competitor Names (always block)
Pull from search term report — any competitor name that triggered your ad. Common pattern:
```
[competitor name]
[competitor name] [city]
[competitor name] utah
```

#### DIY / Research Terms (always block)
```
how to
parts
home depot
lowes
diy
training
salary
jobs
hiring
wholesale
used
youtube
reddit
```

#### Non-Emergency Intent (block for emergency campaigns)
```
cost
price
reviews
ratings
comparison
best
cheapest
```

### Phase 5: Align Ads + Landing Pages (20 minutes)

For each ad group, verify:

| Check | Rule | Fix If Wrong |
|---|---|---|
| Final URL matches service | WH ads → WH page, not plumbing page | Update final URL |
| Display URL is specific | Not just `example.com` — use `example.com/plumbing/emergency` | Update display URL path |
| At least 1 headline has "24/7" | Required if running after-hours bids | Add headline variant |
| 3+ ad variants per ad group | Google needs variants to optimize | Create 2+ more ads |
| Dynamic location insertion | Use `{LOCATION(City):Near Me}` in at least 1 headline | Add to headline |
| Landing page has form + phone | Must have conversion mechanism | Build or redirect to correct page |

### Phase 6: Deploy + Monitor (ongoing)

**Day 1-3:** Keywords enter "learning" status in Google Ads. Don't touch them.

**Day 5-7:** Pull first performance data:
```bash
gr_google_ads_ppc_get_keyword_performance {"start_date":"<5d ago>","end_date":"<today>"}
```

**Day 14:** First optimization pass:
- Pause keywords with 100+ impressions and 0 clicks (bad relevance)
- Lower bids on keywords with CPC > $25 and no conversions
- Increase bids on keywords with conversions and CPC < $10
- Check search term report for new negative keyword candidates

**Day 30:** Full review — compare CPA before vs. after restructure.

---

## Proven Keyword Lists (Acme Corp — Utah)

These are the exact keyword lists deployed in the April 2026 Utah restructure. Use as templates for other markets — swap city names.

### HVAC (14 keywords)
```
"Goodman furnace repair"
"Carrier AC repair"
"Trane furnace service"
"Lennox AC repair"
"furnace blowing cold air"
"AC not cooling"
"thermostat not working"
"hvac repair west jordan"
"furnace repair sandy utah"
"AC tune up"
"AC maintenance salt lake city"
"emergency hvac repair"
"furnace not turning on"
"central air repair near me"
```

### Water Heater (15 keywords)
```
"Rheem water heater repair"
"AO Smith water heater leaking"
"Bradford White repair"
"Rheem water heater leaking"
"AO Smith pilot light out"
"no hot water"
"water heater flooding"
"rusty hot water"
"water heater repair ogden"
"water heater repair west jordan"
"tankless water heater repair"
"water heater replacement salt lake city"
"emergency water heater repair"
"hot water heater not working"
"water heater pilot light out"
```

### Plumbing (13 keywords)
```
"emergency plumber"
"24/7 plumber"
"burst pipe repair"
"drain cleaning"
"clogged drain"
"sewer line repair"
"leak detection"
"plumber west jordan"
"plumber sandy utah"
"plumber orem utah"
"emergency plumber salt lake city"
"toilet repair near me"
"garbage disposal repair"
```

### Negative Keywords (27 — shared list)
```
Competitors: apex clean air, trust plumbing, absolute comfort, jackson family plumbing,
black diamond, american plumbing, mountain west plumbing, peterson plumbing,
beehive heating and air, yes air conditioning, jones heating, any hour services,
my buddy the plumber, whipple service, action plumbing, expert plumbing, manana plumbing

DIY/Research: home depot, lowes, how to, parts, diy, salary, training,
wholesale, used, youtube
```

---

## Performance Benchmarks (Utah — April 2026)

After restructure, these are the target ranges. Use to evaluate whether a new market restructure is working:

| Metric | Target | Warning | Action |
|---|---|---|---|
| Blended CPC | $5–12 | $12–20 | Review keywords for Tier 4 dominance |
| CTR | >3% | 2–3% | Improve ad relevance / headlines |
| CPA | <$80 | $80–120 | Check landing page conversion rate |
| Form Conversion Rate | >8% | 5–8% | Simplify form, add urgency messaging |
| Weekend CPC Discount | >30% | 15–30% | Verify bid schedule configuration |
| Keywords per Campaign | 15–25 | 8–14 | Add more Tier 1–2 keywords |

---

## When to Apply This Skill

- **New market launch** — Before spending any budget, build keyword list from Tier 1 down
- **Monthly audit** — Pull search terms, check for competitor/DIY bleed, add new negatives
- **Seasonal transition** — Add pre-season keywords 4–6 weeks before demand change
- **Poor performance** — If CPA > $120 or CTR < 2%, run full Phase 1–5 audit
- **Campaign expansion** — Adding new service lines (Electrical, Roofing, etc.) — follow same category framework


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
