# Step 22: Define the Minimum Viable Business Product (MVBP)

## The offer
**What's included:** SMS call-out broadcast to a qualified backup-worker list, first-accept-wins
claiming, manager dashboard — the Step 7 Must-have set, delivered for one pilot franchise group
(prospect #1, Alex Torres / Copperline Burgers, or whichever Step 9 prospect converts first) at
their real locations, using a manually-built roster (CSV import, hand-verified by Maria rather
than a self-serve flow) rather than a fully polished onboarding experience.
**What's explicitly excluded (and why that's OK for now):** auto-escalation ladder, labor-cost
reporting, cross-location opt-in toggle — all Should/Could items from Step 7, deferred until the
Must-have core is proven with a real paying customer.

## Price
$149/location/month (or $129/location/month if 11+ locations), from Step 16 (`qc-016-price`) — no
founding-customer discount to zero. If Alex Torres's group (18 units, Step 9) is the first
customer, that's the volume tier: $129 × 18 = $2,322/month.

## Delivery process
**Automated today:** the SMS broadcast and first-accept-wins claiming logic itself (this is the
actual product, assumed built for the MVBP).
**Manual/concierge today:** roster import and qualification tagging (Maria hand-builds this from
a CSV export rather than a self-serve upload flow); onboarding walkthrough delivered personally by
Maria, not a self-serve tutorial; any edge case where nobody accepts a broadcast is escalated to
Maria directly rather than a support team, at least for the first pilot.
**Automation trigger for each manual piece:** roster import gets a self-serve flow once 3+ paying
customers have onboarded manually (validates the mapping logic first); support handoff to a real
support process once volume exceeds what Maria can personally handle (no specific number set yet
— flagged as an open question for Step 24).

## Sales motion (simplified from Step 18)
Awareness → first conversation → champion buy-in → (franchisor check if applicable) → pricing
conversation → signed. For the MVBP specifically, Maria offers a **paid pilot at a subset of
locations** (addressing `ka-013-pilot-needed`) before asking for a full-group commitment, rather
than skipping straight to a full-group contract.

## What this MVBP is designed to prove
1. **ka-008-target-unproven** — does real time-to-cover land meaningfully below the 45-minute
   baseline?
2. **ka-006-onboarding-adoption** — does the pilot GM actually use it during a real call-out,
   rather than reverting to the paper list?
3. **ka-onboarding-cross-location-pool** — do backup workers actually accept being on a shared
   list (testable even within a single pilot group's own locations, before testing across
   different franchise owners)?

## Definition of success
**3 real call-outs covered via ShiftCover, at the stated price (no discount), within the first
30 days of the pilot, with the pilot GM reporting the process felt faster than the old call
list** — a concrete, falsifiable bar, not "the pilot went well."

## Open assumptions
```json
{ "id": "ka-022-delivery", "statement": "Assumes manual onboarding (no self-serve roster import) is acceptable to the pilot buyer at full price for the first customer — not yet tested, since no pilot has run.", "step_ref": "22_define_the_mvbp", "confidence": "low", "test_plan": "Directly observable outcome of the first MVBP sales attempt itself.", "test_result": null }
```
