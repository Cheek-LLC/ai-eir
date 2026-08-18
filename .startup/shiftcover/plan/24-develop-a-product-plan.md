# Step 24: Product Plan

## Near-term roadmap (next 1-2 quarters)
| Item | Justification (Step 22 trigger / Step 23 evidence / spec gap) | Priority |
|---|---|---|
| Ship the Step 7 Must-have set for one real pilot (SMS broadcast, first-accept-wins, manager dashboard, CSV roster import) | Step 22's MVBP requires this to exist before anything else on this list matters | 1 (blocking everything downstream) |
| Test `ka-onboarding-cross-location-pool` directly with 10 backup-worker conversations | Zero-cost, zero-product-dependency test flagged as not-yet-done in Step 21 — should happen in parallel with the item above, not after it | 1 (parallel) |
| Billing infrastructure for per-location subscription | Flagged as a real build dependency in Step 15 that was never in Step 7's spec — must exist before the MVBP can actually charge the stated price | 2 |
| Auto-escalation ladder (Should-have, Step 7) | Deferred from MVBP per Step 22; revisit once Step 23 shows real broadcasts going unaccepted often enough to justify it | 3 (evidence-gated, not yet triggered) |
| Self-serve roster import | Step 22's stated automation trigger: "once 3+ paying customers have onboarded manually" — not yet hit | Gated, not yet triggered |

## Follow-on market readiness (Step 14 bowling pins)
Pin 2 (casual-dining chains) trigger condition: 15-20% penetration of the Step 9 pipeline **and**
resolution of the tipped-staff incentive question via 3+ real casual-dining GM conversations.
Current distance to trigger: **far** — zero of the Step 9 pipeline has converted to a signed
customer yet, and zero casual-dining conversations have happened.

## Sequencing rationale
Everything is gated behind the MVBP shipping and the cross-location-pool question being tested,
because both Step 21 and this step's own evidence chain show the plan currently has no real usage
data anywhere — building anything beyond the Must-have set before that exists (per Step 22) would
be building ahead of validation, which Step 22's own definition explicitly warns against.

## Resourcing reality check
This roadmap assumes Maria either builds the MVBP herself or brings on a technical co-founder/
contractor — no engineering resourcing plan exists yet in any prior step. This is a real gap
flagged here rather than assumed away: none of Steps 1-23 established who actually builds the
product.

```json
{ "id": "ka-024-no-eng-resourcing", "statement": "No step in this plan (1-23) established who actually builds the MVBP — Maria's background is operations, not engineering, and no technical co-founder or contractor has been identified.", "step_ref": "24_develop_a_product_plan", "confidence": "low", "test_plan": "Founder needs to resolve this before the Step 22 MVBP timeline is credible — either learn to build a minimal version, bring on a technical co-founder, or hire a contractor.", "test_result": null }
```

## Handoff briefs
### To GTM
Positioning should center on the Director-of-Ops-facing pitch (Step 6's discovery/evaluation
stages), using Jordan's story (Step 5) as the proof point, not a generic "shift management
software" pitch. Do not launch broad marketing — the near-term motion is entirely the Step 9
warm-network pipeline; GTM work should focus on supporting those specific conversations (a demo
script, a one-page ROI summary using Step 8's numbers with their caveats intact), not a public
launch.

### To Ops/Scaling
Not yet applicable — `business-state.json.stage` has not reached `operating`, and per Step 23,
there is no usage data yet for ops/scaling to work from. This section is a placeholder
acknowledging the handoff point exists, not a real brief, since nothing downstream is ready to
receive one.

## Open assumptions
(see `ka-024-no-eng-resourcing` above)
