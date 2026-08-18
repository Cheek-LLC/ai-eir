# Step 7: High-Level Product Specification

Business-type branching used: **Consumer app.** Asked about target platform, app-store review
constraints, and — the load-bearing question for this business type — what the first 60 seconds of
onboarding must accomplish.

## Traceability

| FLCUC stage | Required capability | Priority |
|---|---|---|
| Onboarding/first use | Show today's sketch prompt immediately, no signup wall first | Must |
| Onboarding/first use | Let the user complete and submit the first prompt (photo capture) before any account creation | Must |
| Ongoing use | Circle formation/invite flow, presented right after first prompt completion | Must |
| Ongoing use | Daily prompt delivery + push notification nudge if a circle member hasn't checked in by evening | Must |
| Ongoing use | Streak tracking + 2 streak-freeze tokens/month for paid tier | Should |
| Ongoing use | Circle activity feed (see other members' check-ins) | Must |
| Renewal/expansion | Paid-tier upsell at the free-tier single-discipline limit | Must |
| Support/service | In-app feedback/contact (manual, founder-monitored) | Should |
| (unvalidated — Step 20/21 candidate) | Automated pod-matching for users with no existing friends to invite | Won't (this version) |

## Prioritized capability list

### Must have
- Prompt-before-signup first-use flow (single discipline: sketching, at launch)
- Photo-based daily check-in
- Manual circle creation/invite (share a join code or link to real contacts)
- Circle activity feed
- Push-notification nudge for at-risk streaks
- Apple in-app purchase for the paid tier (App Store requirement — see below)
- Ad SDK integration for the free tier

### Should have
- Streak-freeze tokens
- Basic in-app support contact

### Could have
- Multi-discipline support beyond sketching at launch (writing, photography) — deferred to see if
  the core mechanic works at all before adding scope
- Automated (non-manual) matching for users without existing friends to invite

### Won't have (this version)
- Algorithmic pod-matching/recommendation engine (Step 22's MVBP does this manually by hand)
- In-app messaging beyond the activity feed
- Any web app — iOS only at launch
- Android — deferred until iOS proves the mechanic (a real resourcing constraint, not a strategy
  choice; see Step 24)

## Core user flow ("moment of value")

Install → app opens directly to today's sketch prompt (no login screen first) → user sketches
something (any quality, no bar) → takes a photo, submits → *then*, immediately after that first
submission, is invited to text/share an invite link to 2-3 real friends to form a circle, framed as
"who do you want to see this?" rather than a generic contacts-import ask. If she has no one to
invite yet, she's shown a small existing "starter circle" of other new solo users (a manual,
founder-curated group at MVBP scale — flagged as unscalable and explicitly named as such in Step
22) rather than being left circle-less.

## Explicit out-of-scope items

No algorithmic matching, no Android, no web, no in-app messaging, no multi-discipline content
beyond sketching until the core mechanic (circle formation + retention differential) is actually
observed in real usage.

## Assumptions flagged

- `ka-007-starter-circle` — statement: "The manually-curated 'starter circle' for friendless new
  users is untested — assumes strangers grouped by a founder will produce a similar accountability
  effect to a real-friend circle, which the pilot never actually tested (the pilot cohort was
  entirely pre-existing friends)." `step_ref: 07_high_level_product_specification`, `confidence:
  low`, `test_plan: "test with the Next 10 Customers (Step 9) and the MVBP beta cohort specifically
  for stranger-grouped circles, not just friend-grouped ones"`, `test_result: null`.

## Mandatory AI-risk gate

This step is not on `skills/risk/ai-risk-review`'s mandatory five-step list (04/14/16/17/19), so no
gate call is required here — noted for completeness, not skipped by oversight.
