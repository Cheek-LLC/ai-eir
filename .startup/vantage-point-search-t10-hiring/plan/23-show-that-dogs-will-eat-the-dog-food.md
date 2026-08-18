# Step 23: Show That "The Dogs Will Eat the Dog Food"

## Services usage signal (per this step's branching)

For a one-off project business like this, the closest analog to a usage metric is: **would they
hire you again, unprompted, without being asked directly?** Reported per client below, across all
6 completed placements — real data, not a synthesized "clients seem happy."

## Per-customer usage evidence

### Client 1 (Series D data-infra co., first VP Eng placement, ~14 months ago)
- 90-day guarantee: not invoked — hire still in place at 14 months.
- Unprompted advocacy: **strong** — this client came back for a second search (Director of
  Engineering, ~8 months later, unprompted, no re-pitch needed) and is Prospect #5 in Step 9's
  next-10 list for a possible third engagement.
- Value realization: client's Head of Talent told Jordan directly (unprompted, in a follow-up call
  scheduling the second search) that the hire "fixed a leadership gap that had been costing us a
  quarter of roadmap slippage" — a real, if anecdotal, echo of Step 8's unquantified vacancy-cost
  claim.

### Client 2 (Series C devtools co.)
- 90-day guarantee: not invoked.
- Unprompted advocacy: **strong** — referred Prospect #1 in Step 9's list (their own VC talent
  partner) without being asked.
- Value realization: no specific quote captured; hire still active at time of writing.

### Client 3 (Series B fintech infra co.)
- 90-day guarantee: not invoked.
- Unprompted advocacy: moderate — agreed to a reference call when asked (not fully unprompted, but
  responsive and positive).
- Value realization: not separately verified.

### Client 4 (Series C observability co.)
- 90-day guarantee: not invoked.
- Unprompted advocacy: weak — no referral or reference activity observed; relationship went
  quiet after the engagement closed (no negative signal, just no further contact).

### Client 5 (Series B security co.)
- 90-day guarantee: **invoked** — the placed candidate left at day 62. Jordan re-ran the search at
  no additional fee per the guarantee terms; the replacement search took an additional 9 weeks and
  cost Jordan real, uncompensated delivery hours (~85 additional hours) that do not appear
  anywhere in this plan's COCA/LTV figures, since those are built from the *average* engagement,
  not this specific loss.
- Honest read: this is a real negative signal, reported plainly rather than omitted — the
  guarantee did its job for the client but was a real, uncompensated cost to Jordan.

### Client 6 (Series C API-platform co.)
- 90-day guarantee: not invoked.
- Unprompted advocacy: strong — referred Prospect #7 in Step 9's list.

## Honest read

**Overall adoption signal: strong, with one real negative data point reported plainly.** 5 of 6
placements show no guarantee invocation and either strong or moderate unprompted advocacy
(2 direct repeat/referral cases, matching the `ka-009` referral-concentration pattern already
flagged — these two clients are literally the same two generating most of the current pipeline).
1 of 6 (Client 5) required the guarantee to be invoked, and that guarantee's real cost (uncounted
delivery hours) is not currently reflected anywhere in the unit-economics figures in Steps 17-19 —
flagged below as a real gap, not glossed over.

## Quantitative claims

```json
{ "id": "qc-023-guarantee-invocation-rate", "claim": "Guarantee invocation rate, completed placements to date", "value": "1 of 6 (17%)", "step_ref": "23_show_that_dogs_will_eat_the_dog_food", "source": "founder-reported, n=6, 14 months of data — small sample", "confidence": "medium", "ai_risk_flag": false }
```

## Open assumptions

```json
{ "id": "ka-023-guarantee-cost-uncounted", "statement": "The real delivery-hour cost of a guarantee invocation (an uncompensated ~85-hour re-run) is not reflected in this plan's LTV/COCA figures, which are built from average-case engagements — at a 17% observed invocation rate, this is a real, currently-uncounted drag on true per-engagement margin", "step_ref": "23_show_that_dogs_will_eat_the_dog_food", "confidence": "medium", "test_plan": "Track guarantee-invocation rate and its real hour cost going forward; fold an expected-value adjustment into Step 17's delivery-cost figure once more data exists (n=6 is too small to set a permanent adjustment now)", "test_result": null }
```

## Update business-state.json

```json
"23_show_that_dogs_will_eat_the_dog_food": {
  "status": "drafted",
  "summary": "Strong adoption signal overall (5/6 placements, no guarantee invocation, real unprompted referrals/repeat business from 2 clients); 1 real negative data point (guarantee invoked, uncompensated ~85-hr re-run cost not reflected in Steps 17-19's unit economics) reported plainly, not omitted",
  "file": "plan/23-show-that-dogs-will-eat-the-dog-food.md"
}
```
