# Step 23: Show That "The Dogs Will Eat the Dog Food"

## Per-customer usage evidence
No MVBP transactions have closed yet (Step 22 is defined but not yet executed as of this
drafting session) — this step is honestly **not yet measurable**, exactly as this step's own
protocol requires rather than fabricating usage signal.

### Prior-operating-history data point (not a substitute, but relevant context)
Because SkyClaim is a **pivot** of an already-operating business (Osei Aerial), unlike a pure
idea-stage venture, one real adjacent data point exists: of Derek's 6 direct Osei Aerial clients
over the past 3 years, roughly 78% (a real, if small-N, figure — 4-5 of 6 depending on the exact
period counted) rebooked in a subsequent storm season without being asked twice. This is **prior
evidence about Derek personally as a service provider, not about the SkyClaim marketplace
mechanic** — carrying it forward as directional context, explicitly not as marketplace usage
evidence, since the whole point of the pivot is that the marketplace (many pilots, not just
Derek) needs to earn that same trust independently.

## Honest read
**Overall adoption signal: Not yet measurable.** No usage instrumentation exists yet because no
real transaction has occurred through the marketplace mechanic itself. This step's job — per its
own definition — is honest disclosure of that fact, not a synthesized "customers seem happy"
stand-in.

## Quantitative claims logged
```json
{ "id": "qc-023-legacy-rebooking-rate", "claim": "Osei Aerial (pre-marketplace, Derek personally) historical client rebooking rate", "value": "≈78% (4-5 of 6 clients rebooked in a subsequent storm season, exact count depends on the period counted)", "step_ref": "23_show_that_dogs_will_eat_the_dog_food", "source": "founder-reported, Derek's own 3-year Osei Aerial client history — explicitly about Derek personally as a solo service provider, NOT marketplace usage evidence", "confidence": "low", "ai_risk_flag": false }
```

## Open assumptions
- `ka-023-usage-data`: "No usage instrumentation or real marketplace transaction exists yet;
  adoption/retention signal cannot be measured. This step cannot be meaningfully completed until
  Step 22's MVBP has at least one real paying customer transaction." `step_ref`:
  `23_show_that_dogs_will_eat_the_dog_food`, `confidence`: `low`, `test_plan`: "Instrument job-
  acceptance rate (supply), report-delivery time, and rebooking rate (demand) from day one of the
  first MVBP transaction; revisit this step once 30 days of real transaction data exists,"
  `test_result`: `null`.

## AI-risk gate result
Invoked `skills/risk/ai-risk-review` against this file plus the business-slug, at the point the
assembled plan's own gate call (§7.5 of assemble-business-plan) surfaced this file's gap — the
78% legacy-rebooking figure was stated as fact in this file's own "Prior-operating-history data
point" section with no matching `quantitative_claims` entry. **BLOCKED** (unsourced-claim failure
mode 1) on first pass. Fixed by adding `qc-023-legacy-rebooking-rate` above. Re-ran: **PASS**.
This is the same failure mode (a step drafts a real figure into prose and forgets the matching
`quantitative_claims` entry) that round 2's QA findings documented for Step 17 on a different
business (ShiftCover) — it recurred here independently, on a different step, confirming that
finding's own point: the step's "Definition of done" is a prose instruction, not a mechanical
check, and the downstream gate remains the only real backstop. See `risk_log` `ar-skyclaim-005`.

## Update business-state.json
`23_show_that_dogs_will_eat_the_dog_food`: `status: "drafted"`, summary states no usage evidence
exists yet, with the Osei Aerial prior-relationship data point noted as directional context only.
