# Step 6: Full Life Cycle Use Case

## Persona
Jordan Vasquez, GM, 14-unit QSR franchise group (Step 5).

## Stage-by-stage map
| Stage | Who's involved | What happens | Persona's state of mind | Product's role/touchpoint | Drop-off risk |
|---|---|---|---|---|---|
| Trigger | Employee who's calling out, Jordan | Employee texts/calls Jordan directly that they can't make their shift, usually within 1-2 hours of shift start | Immediate stress, especially if it's a peak period | None yet — trigger happens outside the product today | Employee doesn't notify far enough in advance for any tool to help |
| Search/discovery | Jordan (as end user), Director of Ops (as buyer) | Jordan doesn't search for a product mid-crisis — she just works the call list. Discovery of ShiftCover itself happens earlier, via the Director of Ops hearing about it through franchise-association peer network | Jordan: no time to search. Director of Ops: passively open to hearing about ops tools from peers | Marketing/positioning reaches the Director of Ops, not Jordan, at this stage | If positioning is aimed at GMs instead of Directors of Ops, discovery never happens — buyer and user are different people (Step 12) |
| Evaluation | Director of Ops, sometimes a second GM as a pilot tester | Director of Ops compares ShiftCover to the status quo (manual call list) and to doing nothing; may ask 1-2 GMs to informally try it | Director of Ops is skeptical of "one more tool" GMs will ignore | Trial/demo shows the SMS broadcast flow concretely | If the demo doesn't address "will my GMs actually use this," evaluation stalls |
| Decision & purchase | Director of Ops (signs), Jordan (has no say) | Director of Ops signs a contract covering all locations in the group | Director of Ops weighing labor-cost ROI against a new recurring line-item | Sales-assisted contract, priced per location (Step 16) | Long procurement cycle if positioned as an "enterprise" sale rather than a fast operational fix |
| Onboarding/first use | Jordan, other GMs in the group, Director of Ops | Roster imported (from 7shifts/HotSchedules export), backup-worker qualifications tagged, GMs get a 10-minute walkthrough | Jordan is wary of "corporate's new mandated tool" based on past experience | Import/setup flow, first-use walkthrough | If setup burden falls on Jordan personally with no support, she deprioritizes it under shift pressure |
| Ongoing use | Jordan, backup workers | Jordan triggers a broadcast when a call-out happens; qualified backups get an SMS; first to accept is assigned | Jordan's stress at the trigger moment is the same — the product's job is to compress what happens next | Core broadcast + first-accept-wins flow | If backup workers don't respond fast enough, Jordan falls back to the old call list anyway |
| Support/service | Jordan, ShiftCover support | Jordan hits an edge case (e.g., nobody accepts) and needs a fast answer, not a ticket queue | Frustration compounds if support is slow during an active crisis | In-app fallback guidance + human support channel | Slow support during a live crisis destroys trust immediately |
| Renewal/expansion/disposal | Director of Ops | Contract renews annually or monthly; expansion = adding newly opened locations to the group's plan | Director of Ops renews based on whether GMs actually stopped complaining about coverage, not a formal ROI report (most groups this size don't run one) | Usage data available to Director of Ops as a renewal-time proof point | If GMs quietly reverted to the call list mid-contract, renewal is at risk and the Director of Ops may not know until renewal time |

## Narrative walkthrough
The life cycle has a structural split baked in from the very first stage: the person who
experiences the pain (Jordan) is never the person who discovers, evaluates, or buys the product
(the Director of Ops) — she only meets it at onboarding. This means the product has two
first-value moments to win, not one: the Director of Ops's evaluation-stage confidence that GMs
will actually use it, and Jordan's actual first live use during a real call-out. A product that
nails procurement but loses Jordan at onboarding will show as "purchased but unused" at renewal —
exactly the failure mode Step 23 is designed to catch later.

## Biggest drop-off risk
**Onboarding/first use.** Jordan has been burned before by corporate-mandated tools she was never
consulted on. If the roster import and qualification-tagging setup is not close to effortless, or
if her first real call-out during the trial period isn't covered faster than her existing 45-75
minute baseline, she reverts to the laminated call list — and the Director of Ops won't
necessarily find out until renewal.

## Assumptions flagged
```json
{ "id": "ka-006-onboarding-adoption", "statement": "Assumes GMs like Jordan will actually adopt the tool during onboarding rather than defaulting back to the paper call list under shift pressure — not yet observed, since no pilot has run.", "step_ref": "06_full_life_cycle_use_case", "confidence": "low", "test_plan": "Track first-30-days actual broadcast usage per GM during the MVBP pilot (Step 22/23), not just contract signature.", "test_result": null }
```
