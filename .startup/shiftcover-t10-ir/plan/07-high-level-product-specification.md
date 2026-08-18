# Step 7: High-Level Product Specification

## Traceability
| FLCUC stage | Required capability | Priority |
|---|---|---|
| Onboarding/first use | Roster import from 7shifts/HotSchedules (CSV at minimum) | Must |
| Onboarding/first use | Qualification/role tagging per worker (e.g., "drive-thru certified") | Must |
| Ongoing use | SMS broadcast to qualified backup pool on call-out trigger | Must |
| Ongoing use | First-accept-wins claiming (one-tap SMS reply) | Must |
| Ongoing use | Manager dashboard showing broadcast status/outcome | Must |
| Support/service | In-app fallback guidance if nobody accepts within N minutes | Should |
| Ongoing use | Auto-escalation ladder (broaden qualification/radius if no accept) | Should |
| Renewal/expansion | Basic labor-cost-impact report for Director of Ops (time-to-cover trend) | Should |
| Search/discovery, Decision & purchase | Multi-location account/contract structure (one Director-of-Ops-level account, many location admins) | Must |
| Ongoing use | Cross-location backup pool opt-in toggle per worker | Could |
| Ongoing use | Two-way worker availability status (proactive, not just reactive to a broadcast) | Could |
| (speculative, no FLCUC touchpoint) | Predictive no-show risk scoring | Won't (this version) |

## Prioritized capability list
### Must have
- Roster import (CSV, from 7shifts/HotSchedules exports)
- Worker qualification/role tagging
- SMS call-out broadcast to qualified backup pool
- First-accept-wins claiming via SMS reply
- Manager dashboard (broadcast status/outcome)
- Multi-location account structure (Director of Ops account, per-location admin/GM access)

### Should have
- Auto-escalation ladder if no accept within N minutes
- In-app fallback guidance for an unfilled broadcast
- Basic time-to-cover reporting for the Director of Ops

### Could have
- Worker-controlled cross-location opt-in toggle
- Proactive two-way availability status

### Won't have (this version)
- Native API integrations with 7shifts/HotSchedules (CSV import only for v1 — API integration
  requires partnership/dev work not scoped for the MVBP)
- Full base-schedule replacement (7shifts/HotSchedules remain the system of record for the regular
  schedule)
- Payroll integration
- Predictive no-show risk scoring — flagged as untraceable to any FLCUC touchpoint and not
  validated as a Persona need; explicitly kept out rather than added because it sounds impressive.

## Core user flow ("moment of value")
Jordan gets a call-out text at 6:45am. She opens ShiftCover, taps "Broadcast" for that shift/role.
Qualified backup workers (already tagged as drive-thru certified, already opted into this
location's or the group's shared pool) get an SMS immediately. The first one to reply "YES" is
auto-assigned and Jordan gets a confirmation notification with their name and ETA. The entire
loop, if it works, should take single-digit minutes from trigger to a named person confirmed —
this specific number (target: 8 minutes) is stated as an unproven target, not a measured result
(see Step 8).

## Explicit out-of-scope items
No scheduling replacement, no payroll, no predictive analytics, no live API integrations in v1.
This is a deliberately narrow tool that does one thing (call-out coverage) well rather than a
broader ops platform — a scope boundary Maria stated explicitly and the product spec honors.

## Assumptions flagged
```json
{ "id": "ka-007-csv-only", "statement": "Assumes CSV import (no live API) is an acceptable onboarding friction point for Directors of Operations at this beachhead size — not yet tested with a real buyer.", "step_ref": "07_high_level_product_specification", "confidence": "low", "test_plan": "Test the actual CSV import flow with the Next 10 Customers (Step 9) during early sales conversations; if it's a stated blocker, API integration may need to move up in priority.", "test_result": null }
```
