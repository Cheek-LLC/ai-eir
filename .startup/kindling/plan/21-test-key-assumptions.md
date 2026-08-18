# Step 21: Test Key Assumptions

Business-type branching used: **Consumer app.** This branch's central instruction — "for retention
or engagement assumptions specifically, there is no substitute for real usage data... a retention
assumption should usually be marked deferred" — was followed exactly for `ka-017-retention-curve`
below, rather than closing it on a survey or a plausible-sounding test design.

## Test plans and outcomes (leap-of-faith shortlist, from Step 20)

### ka-016-conversion-rate — 4% payer-conversion assumption
- Test method: state the real $6.99/$49.99 price live in the MVBP beta's paywall (Step 22) and
  observe actual conversion — a real-money test, not a survey, per this branch's own instruction
  that "a survey asking 'would you use this daily' does not validate a retention assumption" and
  the equivalent logic applies to a payment assumption.
- Success metric / threshold: at least 3% of beta installs convert to paid within 30 days (set
  below the 4% model assumption deliberately, so even a "below-model" real result still counts as
  meaningful signal rather than requiring the model to be exactly right to learn anything).
- Cost / timeline: no incremental cost beyond running the beta itself; resolves within 30 days of
  beta launch.
- **Outcome: Deferred until the MVBP beta has run for 30 days.** No real signal exists yet.

### ka-017-retention-curve — the entire assumed D1/D7/D30/D90 curve
- Test method: **no substitute exists for real cohort data**, per this branch's own explicit
  instruction — a survey, an intent question, or a founder guess refined further would not
  validate this.
- Success metric / threshold: real D1/D7/D30 retention measured from the actual beta cohort,
  compared against the assumed curve; no pass/fail bar, just replacement of the assumption with
  data.
- Cost / timeline: requires the beta to run at least 30 days post-launch (90 for the D90 point).
- **Outcome: Deferred until 30-90 days of real beta cohort data exists.** This is the correct,
  honest disposition per this step's own instruction not to let a plausible test *design* substitute
  for a test *result*.

### ka-013-circle-invite-friction — cold in-app circle-invite acceptance
- Test method: instrument the actual invite-send and invite-accept events in the MVBP beta;
  compare against the pilot's pre-existing-relationship baseline explicitly, since this is the one
  assumption most likely to differ from the pilot precisely because the pilot never tested a cold
  invite.
- Success metric / threshold: at least 35% of first-prompt completers form/join a circle within 7
  days (matching the funnel assumption in Step 18).
- Cost / timeline: resolves within the first 1-2 weeks of beta launch — faster than the retention
  or conversion tests.
- **Outcome: Deferred until beta launch**, but flagged as resolvable fastest of the shortlist —
  recommend the orchestrator/founder treat this as an early go/no-go checkpoint before the longer
  retention/conversion tests even finish.

### ka-008-selfselection — is the 3x streak-length delta causal or self-selected?
- Test method: within the beta cohort, compare streak length for users who join a circle vs. users
  who complete the first prompt but decline to join one — this at least controls for "chose this
  app," even though it can't fully separate every source of self-selection, per this file's own
  honest caveat.
- Success metric / threshold: circle-joiners show a directionally similar (not necessarily
  identical) multiplier over non-joiners within the same cohort.
- Cost / timeline: same beta window as the other tests, no added cost.
- **Outcome: Deferred until beta launch.**

### ka-016-price-point — untested $6.99/$49.99 price
- Test method: same as `ka-016-conversion-rate` above — the live beta paywall is the real test
  for both together (they're resolved by the same evidence).
- **Outcome: Folded into ka-016-conversion-rate's test** — same instrument, same timeline, no
  separate test needed.

### ka-020-founder-bandwidth — solo founder running this alongside a full-time job
- Test method: not a data test — a resourcing decision. Ask directly: is Priya prepared to commit
  a specific weekly hour budget (the 80-hour pre-launch estimate implies ~10 hrs/week) for at least
  the 8-week pre-launch window plus the 30-90 day beta window, and what happens if her day job
  intensifies during that window?
- Success metric / threshold: an explicit, stated hour commitment and a stated fallback if it
  slips (e.g., extend the timeline rather than silently under-deliver on community seeding).
- Cost / timeline: resolvable immediately, in conversation — no data needed.
- **Outcome: Accepted — Priya confirmed a 10 hrs/week commitment through the beta window and named
  a fallback (extend timeline, don't cut community-seeding scope) if her day job intensifies.**
  Logged as validated-by-founder-commitment, not by external data, which is an honest and
  appropriate disposition for this specific kind of assumption.

## Full-inventory disposition (non-shortlisted items)

| ID | Statement | Disposition |
|---|---|---|
| ka-001-segment-breadth | Segments 2-13 unvalidated | Accepted — low impact/uncertainty for the beachhead decision itself; relevant again only when pin 2/3 are pursued (Step 14's own trigger conditions already gate that) |
| ka-002-segment2-reach | Circle mechanic assumed to transfer to writing | Deferred until pin 2 is pursued, per Step 14's stated trigger |
| ka-003-friends-and-family-sample | Pilot data from founder's network only | Folded into `ka-013-circle-invite-friction`'s beta test — the beta cohort is explicitly recruited beyond the founder's network (Step 9), which is the same evidence that resolves this |
| ka-004-tam-count | Unsourced 13M/15% TAM inputs | Deferred until a real published benchmark is found or waitlist signups from cold community-seeding give a directional check |
| ka-004-arpu-method | No step guidance for freemium TAM; improvised | Accepted as a plugin-level gap, not a business-level risk — flagged for `docs/QA-FINDINGS-ROUND5.md`, not something the founder can resolve herself |
| qc-004-tam-realistic | Realistic TAM unsourced | Same disposition as ka-004-tam-count — linked to it |
| ka-007-starter-circle | Stranger-grouped starter circle untested | Deferred until the beta cohort actually produces friendless new users who need one |
| ka-009-shortfall | 8 of 10 next-customers reached | Accepted — low impact; the remaining 2 outreach attempts are already in motion outside this document |
| ka-010-core-not-found | No durable Core yet | Accepted — this is an honest structural finding for an idea_only-stage business, not something a test resolves; revisit once beta data exists to check candidate #3 (pod-matching data) per Step 10's own test plan |
| ka-011-competitor-verification | Competitor positions unverified | Accepted — low impact; recommend a spot-check before this chart is shown to any outside party, not a dedicated test |
| ka-014-pin2-arpu-vs-tam | ARPU-expansion vs. new-TAM split unmeasured | Deferred until pin 2 is pursued |
| ka-015-model-fit | Subscription vs. one-time-IAP unresolved | Folded into `ka-016-conversion-rate`'s test — the beta's real subscription-paywall performance is the evidence needed to decide whether IAP is worth testing as an alternative later |
| ka-017-payer-lifetime | ~10-month payer lifetime placeholder | Deferred until a real paying cohort exists |
| ka-017-margin | 75% margin unbenchmarked | Deferred until a real hosting/CDN cost quote is obtained — resolvable pre-launch, recommend doing this before Step 22 finalizes its technical scope |
| ka-018-discovery-conversion | Discovery/install/first-prompt rates unmeasured | Folded into the same beta-instrumentation effort as the other funnel tests above |
| ka-018-conversion-inconsistency | Step 16 vs. Step 18 conversion-rate disagreement | Deferred until real beta funnel data resolves which chain of assumptions was closer to right |
| ka-019-founder-rate | $50/hr placeholder unsourced | Deferred — resolvable pre-launch by researching a real freelance community-manager/content-creator rate comp, recommend doing this before treating COCA as more than directional |
| ka-019-install-estimate | 800-install launch estimate | Deferred until the beta actually launches and the real install count is known |
| ka-020-platform-dependency | App Store policy/fee/review risk unaddressed until this sweep | Accepted as a named, standing risk — not testable in advance; recommend Step 22 explicitly budget schedule slack for at least one Apple App Review rejection-and-resubmission cycle |

## Unresolved risk carried forward

The two highest-impact, still-`test_result: null` items are `ka-016-conversion-rate` and
`ka-017-retention-curve` — both correctly deferred rather than closed prematurely, both resolvable
only by the MVBP beta actually running, and both drive the LTV:COCA ratio (Step 19) directly. A
founder or reviewer reading this plan should treat the entire Step 17/19 unit-economics picture as
provisional pending these two specifically, not as a settled result.
