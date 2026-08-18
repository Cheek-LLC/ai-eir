# Step 22: Define the Minimum Viable Business Product (MVBP)

Business-type branching used: **Consumer app.** This is the round's second central stress test,
alongside Step 17. Confirming directly: the branch's requirement — "a real, functioning app
release to a small real cohort... sold via real payment (subscription or IAP) at the actual Step
16 price, not an unlimited free beta with no monetization attached" — is specific and enforceable,
and it correctly ruled out the tempting shortcut of launching a free TestFlight beta with no real
paywall "just to see if people like it." The platform-review-constraint and first-60-seconds
framing this round was specifically asked to check are both genuinely present and load-bearing,
not aspirational — see both sections below.

## The offer

**What's included:** a closed iOS beta (TestFlight initially, moving to a limited public App Store
release once stable) — sketching discipline only, real daily prompts, real circle formation
(manually matched for the first cohort — see Delivery process below), a real free tier
(ad-supported) and a real $6.99/mo or $49.99/yr paid tier via Apple in-app purchase.

**What's explicitly excluded (and why that's OK for now):** writing/photography disciplines (Step
7's out-of-scope decision — proving the core mechanic in one discipline first), Android (resourcing
constraint, not strategy), automated pod-matching (manual for now — see below), in-app messaging
beyond the activity feed.

## Price

$6.99/mo or $49.99/yr (from Step 16, `qc-016-price`) — charged for real, via Apple's in-app
purchase system. **No founding-customer discount to zero** — this is the exact temptation this
step's own guidance names and rejects.

## Delivery process — platform-review constraints named explicitly

**Automated today:** the daily prompt delivery, the free/paid tier gating, push notifications, the
activity feed.

**Manual/concierge today, named explicitly:**
- **Pod-matching is entirely manual.** Priya personally reviews new signups who have no existing
  circle to join (the "starter circle" case from Step 7) and hand-groups them, by inspection of
  signup timing and any stated interests — this does not scale past roughly 150-200 users and is
  explicitly flagged as the first thing to automate once beta data validates that matching quality
  actually matters (the concrete trigger for Step 24's roadmap).
- **Customer support is Priya's personal email/inbox**, checked manually, no support team or
  ticketing system.

**Automation trigger for each manual piece:** pod-matching automates once (a) the beta cohort
exceeds ~200 users, and (b) real retention data shows pod-matching quality actually correlates with
retention (the same test Step 10 named as the path to a real Core, candidate #3) — automating
before that evidence exists would mean building a personalization engine with nothing real to
personalize against.

**Platform-review constraint, stated explicitly (not a technical footnote):** Apple's App Store
Review Guidelines require any digital subscription/content unlock to go through Apple's own in-app
purchase system — this app **cannot** link out to an external payment page to avoid Apple's ~15-30%
platform fee (already netted into Step 17's margin assumption). This is a real, binding constraint
on the business model, not a build detail, and it also means the MVBP's launch timeline carries
real schedule risk from Apple's App Review process itself (typical review turnaround plus the
possibility of at least one rejection-and-resubmission cycle — named explicitly in `ka-020-
platform-dependency`, Step 20).

## Sales motion (simplified from Step 18)

Discovery (personal network + community seeding, Step 9's named prospects first, then Discord/
Reddit/Product Hunt) → install → first prompt (no signup wall) → circle formation (manual matching
for friendless signups) → paid conversion at the free-tier discipline limit or ad-removal desire.
No sales calls, no rep time — a pure self-serve funnel per Step 13/18.

## First-60-seconds requirement (this round's other named focus for Step 22)

Per Step 7's product spec and this branch's own emphasis on app-store-review-guideline constraints
and the front-loaded nature of consumer-app abandonment: the first 60 seconds of the MVBP must (1)
show the day's actual sketch prompt with zero signup friction before it, (2) let the user complete
and submit something (any quality) without creating an account first, and (3) only *then* ask for
account creation (needed to save progress) and the circle-invite ask. This ordering is a direct,
load-bearing design decision, not a nice-to-have — it is the concrete operationalization of Step
6's "biggest drop-off risk" finding and Step 7's Must-have flow.

## What this MVBP is designed to prove

1. `ka-016-conversion-rate` / `ka-016-price-point` — will real users actually pay the stated price?
2. `ka-013-circle-invite-friction` — will users actually invite/join circles from a cold in-app ask,
   not just a pre-existing WhatsApp group?
3. `ka-017-retention-curve` — what does real D1/D7/D30 retention actually look like?

## Definition of success

At least 50 of 150 recruited beta users complete Day 7 with ≥5 check-ins, at least 15 real
(organic-within-cohort, not founder-solicited) friend invites sent by day 14, and at least 3% of
the full beta install base converts to paid within 30 days (the deliberately-below-model threshold
from Step 21's test plan).

## Open assumptions

- `ka-022-concierge-matching` — statement: "Assumes a founder can manually match circles with
  reasonable quality up to ~150-200 users without dedicated matching criteria beyond signup timing
  and stated interests." `step_ref: 22_define_the_mvbp`, `confidence: low`, `test_plan: "directly
  observable from whether manually-matched circles retain comparably to friend-formed circles in
  the beta"`, `test_result: null`.

## Mandatory AI-risk gate

This step is not on `skills/risk/ai-risk-review`'s mandatory five-step list (04/14/16/17/19), so no
gate call is required here.
