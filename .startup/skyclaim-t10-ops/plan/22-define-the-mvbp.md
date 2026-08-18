# Step 22: Define the Minimum Viable Business Product (MVBP)

Per this step's marketplace guidance: "decide explicitly which side gets sourced first and why
that side is the harder liquidity problem." **Supply is sourced first** — per Step 4/9's findings,
supply (pilots) is the binding constraint and the thinner, less-proven side, while demand (Ray,
Denise, the Oklahoma contact) is already warm and waiting. Pushing demand harder before real
supply exists would just reproduce Step 6's flagged "empty availability map" failure mode on
day one.

## The offer
What's included: a real, insurance-claim-ready aerial roof inspection, booked through SkyClaim
(not called in to Derek directly), delivered within a stated window, at the real $175/property
price from Step 16. What's explicitly excluded: no live in-app availability map yet (Derek
manually tracks which of the 4-6 committed pilots are free); no automated payment split (first
transactions are invoiced and paid via direct transfer, split manually by Derek). This is
acceptable for now because it tests the two things that actually matter — will a real pilot
accept and complete a marketplace-routed job, and will a real contractor's carrier accept the
resulting report — without needing to build automation for a supply pool that doesn't exist at
scale yet.

## Price
$175/property (from Step 16, `qc-016-price`), with the 18% take rate applied manually on the
first transactions (real number, not a "founding customer" discount).

## Delivery process
Automated today: nothing. Manual/concierge today: Derek personally matches each incoming demand-
side job request to one of the 4-6 committed pilots by text/phone, tracks who's available, and
manually reconciles payment. Automation trigger for each manual piece: job-matching automates once
there are more concurrent open jobs than Derek can track by hand (a real, observable threshold,
not a calendar date); payment-split automation triggers once transaction volume exceeds what
manual reconciliation can sustain without errors.

## Sales motion (simplified from Step 18)
Demand: reach out to Ray Delgado and Denise Ruiz first (the two closest, most-committed existing
clients) and explicitly frame this as "book through the new system instead of calling me" for
their next real job — not a hypothetical pitch, a real live-fire test. Supply: confirm with
Marcus Webb and Jake Fennimore (the two most-engaged supply-side contacts) that they're ready to
accept a real dispatched job on short notice.

## What this MVBP is designed to prove
1. **ka-012-carrier-veto-unconfirmed** — the first real report delivered through this MVBP is
   explicitly the artifact Ray will test with his carrier contact.
2. **ka-onboarding-pilot-pool-tolerance** — whether Marcus or Jake will actually accept a job
   routed to them by SkyClaim rather than coming from Derek personally is tested the moment the
   first real dispatch happens.
3. **ka-002-existing-clients-marketplace-adoption** — whether Ray/Denise will actually route a
   real job through the new flow instead of just calling Derek is tested directly.

## Definition of success
3 real, paid transactions completed end-to-end (demand posts → supply accepts → report delivered
→ payment settled) within 6 weeks, with at least 1 report actually submitted to a real insurance
carrier and not rejected on format grounds.

## Open assumptions
- `ka-022-manual-matching-scale`: "Assumes manual phone/text matching is workable for the first
  handful of transactions — not yet tested at even 2 simultaneous open jobs." `step_ref`:
  `22_define_the_mvbp`, `confidence`: `low`, `test_plan`: "Directly observable outcome of the
  first MVBP sales attempts themselves," `test_result`: `null`.

## Update business-state.json
`22_define_the_mvbp`: `status: "drafted"`, summary states the MVBP offer, $175 price, supply-
sourced-first rationale, and the 3-transactions-in-6-weeks success bar.
