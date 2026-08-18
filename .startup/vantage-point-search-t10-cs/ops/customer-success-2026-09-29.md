# Customer Success Playbook — Vantage Point Search — 2026-09-29

Produced by `skills/ops/customer-success-playbook`, delegated from
`agents/ops/customer-success-lead.md`. This is the **first** run of this skill for this business —
no prior `ops/customer-success-*.md` snapshot exists to carry tiers/thresholds forward from, so
this run establishes the model from scratch, dated to align with the most recent real check-in
(2026-09-29) so it reads against the same period as that check-in's other ops files.

## Business type & motion used

`business_basics.business_type`: `services` (project-based retained search, not a retainer — see
Step 15). Onboarding definition applied (Part 2, services/project-based branch): **"onboarded"
converges with "delivered" for a one-off engagement — kickoff completed, plus the first agreed
deliverable (per Step 7's spec, the candidate-slate delivery) accepted by the client without
dispute. The renewal-decision-point clause is explicitly not applied — this business has no
recurring/retainer engagements.** Pricing framework on file: yes,
`plan/16-set-your-pricing-framework.md` — single flat-rate structure (30% of first-year base
salary), no tiers, no add-ons.

## Which accounts exist to score, and why that number is small

Per `business-state.json` and `ops/2026-09-29-retention-metrics.md`, this business has 8 signed
engagements / 6 distinct clients over 14 months, but **6 of those engagements are already
completed and closed** (delivered, guarantee window either passed or resolved) — they are not
currently "active accounts" in the sense this skill scores (no ongoing relationship being managed
for health/expansion this period). Exactly **one account is currently active**: engagement #5
(Step 9's repeat client, Series D data-infra co., signed 2026-08-20, candidate-slate delivered
2026-09-22). That is the only row in this period's health snapshot.

The 6 *completed* engagements are not scored here (they are historical, not current), but they are
the real substrate used below to set thresholds — this is exactly the "known-good/known-bad
accounts" comparison Part 1 Step 2 asks for, and `plan/23-show-that-dogs-will-eat-the-dog-food.md`
already contains it, per-client, in detail.

## Health-scoring model

Threshold-setting path used is **mixed, per signal** — not a single global choice. Part 1 Step 2's
instruction operates "for every trackable signal," and applying it signal-by-signal here means two
different paths actually apply to different rows below, which is worth stating explicitly rather
than collapsing into one answer.

| Signal | Trackable? | Known-good reading | Known-bad reading | Threshold set (yellow / red) | Weight |
|---|---|---|---|---|---|
| Delivery-milestone pace (services adaptation of "usage frequency & depth" — progress against Step 7's ~30-day slate-delivery target) | Yes (real milestone dates exist) | n/a — Step 23 records advocacy/outcome per historical client but not milestone-pace-vs-target per client, so no real comparison exists for *this specific signal* | n/a, same reason | **PROVISIONAL — founder judgment, insufficient comparable volume for this signal specifically:** Yellow if slate delivery lands >20% past the ~30-day Step 7 target with no client communication about the delay; Red if a milestone is missed outright with no communication. (Engagement #5's actual slate delivery was ~33 days, a ~10% slip already assessed by the 2026-09-29 retro as "small, noted, not material" — below the yellow line.) | Equal |
| Support-ticket sentiment & volume | **No** — no formal support inbox/helpdesk exists for this business; not tracked in any form | — | — | — (excluded from blended score) | — |
| NPS / CSAT | **Not collected** | — | — | — | — (excluded) |
| Payment / installment timeliness | Yes in principle (3-installment structure: signing / slate-delivery / start date) — but no late-payment case exists anywhere in this business's 14-month, 8-engagement record to compare against | n/a — no known-bad example exists on record | n/a | **PROVISIONAL — founder judgment, zero known-bad examples to compare against:** Yellow if an installment is >2 weeks late past its trigger event; Red if unpaid >30 days or the client disputes an invoice | Equal |
| Relationship/engagement signal (post-milestone responsiveness; unprompted advocacy/referral vs. going quiet) | **Yes — real known-good/known-bad comparison exists** | Clients 1, 2, 6 (`plan/23-...`): unprompted referral or repeat re-engagement, responsive to outreach | Client 4 (`plan/23-...`): no referral/reference activity; "went quiet after the engagement closed... no further contact." Client 5 (`plan/23-...`, harder case): 90-day guarantee invoked (candidate departed day 62) — a **hard risk indicator**, not just a soft relationship signal | **REAL-DATA THRESHOLD:** Yellow = no response to a routine post-milestone check-in, or no advocacy/referral activity within ~4-6 weeks of a milestone (Client 4's observed pattern). Red (hard override, regardless of blended score) = guarantee invocation, an explicit dispute, or comparably hard negative event (Client 5's observed pattern) | Equal, **and** this signal's Red case is the hard-indicator override per Part 1's rule — overrides the blended score outright |

Weighting: equal across the two trackable-and-in-model signals used for this period's blended
score (delivery-milestone pace, relationship/engagement) — payment/installment timeliness is
trackable in principle but has no live event to score this period (no installment is currently due
or overdue for engagement #5), so it doesn't move this period's tier either way. No founder-stated
reason to weight any signal more heavily than another was given, so equal weighting is used per
the skill's default.

## Account health snapshot

| Account | Onboarded? (Part 2 bar) | Signals past threshold | Hard risk indicator? | Tier | Notes |
|---|---|---|---|---|---|
| Engagement #5 (Series D data-infra co., 3rd engagement with this client) | Yes — kickoff completed 2026-08-20, first deliverable (candidate slate) accepted without dispute 2026-09-22 | None | No | **Green** | Milestone pace within provisional threshold (~10% slip, not material per the 2026-09-29 retro). No relationship-signal concern — this is the same client behind two of Step 23's strongest known-good advocacy cases (Client 1), now on a 3rd engagement. |

## Onboarding status this period

1 of 1 current-cohort accounts onboarded within the applicable window (100%). No accounts past the
window without hitting the bar — engagement #5 is the only current-cohort account and it already
cleared the bar.

## Expansion-ready accounts

**None this period.** Engagement #5 is Green (the necessary first condition), but shows no
concrete expansion trigger yet per Part 3's services definition ("client requesting scope beyond
the current engagement" — no such request is on record; there is no retainer-hours ceiling to max
out under this business's flat project-fee model). It is worth naming explicitly that this
client's relationship *itself* is a strong repeat-business pattern (this is already their 3rd
signed engagement) — but that is evidence the historical motion works, not a live in-engagement
expansion signal to act on this period; conflating "a client who repeats" with "an account
currently showing an expansion trigger" would overstate what's actually observed right now.

**Pricing-framework cross-reference, checked even though no trigger fired:** `plan/16-...` has a
single flat-rate structure (30% of first-year base) with no tiers or add-ons at all. If an
expansion trigger did fire for this or a future account (e.g., a request to run a second role
search concurrently, or interest in the Step 14 Pin-2 Product-search offering), there is currently
**no existing tier/add-on that names that** — Step 16 prices one search at a time, not a bundle or
concurrent-search rate. Flagging this now as a real, checked gap rather than waiting until an
account actually asks, since Part 3 explicitly directs naming a missing-tier gap rather than
inventing one on the spot.

## Save plays in progress or opened this period

None — no yellow/red accounts exist this period (the only current account is Green).

## Escalation to retention-and-churn-analysis

None of Part 4's escalation triggers fired this period: no yellow/red accounts exist to show a
repeated root-cause pattern, the red-tier count is 0 (not "a second red account in a period" for a
small-base founder), and no save play was attempted (none was needed). Stated explicitly: **no
escalation recommended this period.**

## Trend vs. prior period

N/A — first `customer-success-*.md` snapshot for this business. No prior tier distribution or
onboarding % exists to compare against.

## Self-correcting check: health model vs. real outcomes (per `agents/ops/customer-success-lead.md`'s "Optimization" section)

Attempted as instructed, run alongside this snapshot since a `retention-and-churn-analysis` pass
also exists for this same period (`ops/2026-09-29-retention-metrics.md`). Result: **there is
nothing to meaningfully check yet, and that is reported honestly rather than forced.**

- This is the first `ops/customer-success-*.md` snapshot this business has ever produced — there is
  no *prior* snapshot's predictions to compare against real outcomes that "had time to play out."
  A false-positive/false-negative rate requires a prediction made in the past checked against a
  later real result; there is no past prediction to check yet.
- The only candidate for a retroactive check is `plan/23-...`'s historical per-client record
  (Clients 1-6) — but that record is exactly what this run's own thresholds were just derived
  *from* (see the health-scoring model above). Scoring those same 6 historical clients against a
  model built from their own outcomes would not be a real out-of-sample check — it would trivially
  "pass" by construction (Client 5 would score Red because Client 5 is literally why the Red
  threshold is defined the way it is). Reporting this distinction explicitly rather than padding
  the finding with a self-confirming exercise dressed up as a calibration check.
- Net result: **false-positive/false-negative rate cannot be computed this period — not "0%," not
  skipped silently, but explicitly insufficient data**, for a structural reason (first run, zero
  completed engagements since this model existed to test against), not a volume problem that will
  resolve with more of the same kind of data. It resolves once engagement #5 (or a future account)
  reaches a real outcome (delivered cleanly, or a guarantee invocation) that this model scored
  *before* that outcome was known.
- No recalibration trigger fires from this (there is no rate to compare against a materiality bar).
  No miscalticion `risk_log` entry is warranted this period for the same reason.
- **Gap worth naming for the skill itself, not just this business:** `agents/ops/customer-success-lead.md`'s
  Optimization section instructs *how* to compute the false-positive/false-negative rates once
  prior predictions exist, but has no explicit instruction for the first-run case (zero prior
  snapshots) the way Part 1 Step 2 of `customer-success-playbook/SKILL.md` explicitly names the
  provisional-threshold fallback for low account volume. This run handled it by stating the
  insufficiency plainly, matching the spirit of the rest of this plugin's "insufficient data" style
  seen throughout this business's other ops files — but that's an inference from house style, not
  an instruction the agent file actually gives. See the QA findings doc for the specific
  recommendation.

## Recommended next run

Re-run `customer-success-playbook` at or before the next check-in (2026-10-13). By then, engagement
#5 should have a real placement/start-date outcome or a clearer read on timeline — the first
genuine out-of-sample data point for both this snapshot's Green-tier prediction and the self-
correction check above.
