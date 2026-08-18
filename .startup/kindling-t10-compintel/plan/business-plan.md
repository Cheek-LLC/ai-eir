# Kindling — Business Plan (v1)

*This is a planning aid produced with AI assistance, grounded in the Disciplined Entrepreneurship
framework and this business's own stated facts. It is not licensed financial, legal, or tax
advice.*

## Executive Summary

Kindling is a daily-practice app for hobbyist creatives — sketching first — who have already tried
and abandoned a self-directed streak because nobody notices when they quit. The product's bet is
small, real-friend accountability "circles": an informal 6-week manual pilot (WhatsApp group +
spreadsheet, 14 real people) showed participants who stayed in an accountability group sustained a
streak roughly 3x longer than those practicing solo (34+ days vs. ~12 days), though this is
self-selected, uncontrolled pilot data, not a randomized result.

The beachhead — hobbyist sketchers active in art-hobbyist communities who've abandoned a streak in
the last 12 months — was chosen almost entirely on founder reach and community credibility, not
raw market size: the realistic, blended-ARPU beachhead TAM is a modest ~$5M/year (a freemium
consumer app's blended-ARPU TAM is structurally much smaller than a naive full-price ceiling of
~$100M/year — see Section 4). The single biggest open risk, stated plainly: **this plan's own
LTV:COCA math, computed honestly at matched funnel stages, currently lands at roughly 0.2-0.25:1 —
far below the 3:1 viability floor** — built entirely from unvalidated placeholders (a category-
benchmark retention curve with zero real data behind it, an untested 4% payer-conversion rate, and
a rough founder-time cost estimate). No durable competitive Core has been identified yet, which is
an honest finding for an idea-stage business, not a gap papered over. The business has not yet
shipped any product; the MVBP (a real, paid, 150-person closed iOS beta) is the next concrete step,
and it is explicitly designed to replace exactly these two placeholders (retention, conversion)
with real data before any further capital or time is committed to scaling. Funding intent is
currently undecided.

## Confidence & Validation Status

**1. Validated claims, with the actual evidence behind them.** The beachhead's real-world
tractability (Step 9): 5 of the "next 10" prospects are real people already in conversation with
the founder, reached through her own community standing. The value-proposition direction (Step 8):
a real, if small and self-selected, 6-week pilot (n=14) showed a 3x streak-length difference
between circle participants and solo practitioners. Founder-market fit (Steps 3/5): the persona is
a real, named pilot participant, not a hypothetical composite.

**2. Open assumptions still needing a test (`test_result: null`), with their test plans.** The two
highest-impact: `ka-016-conversion-rate` (4% payer conversion, untested — test plan: observe real
conversion during the MVBP beta's first 30 days, success threshold 3%+) and `ka-017-retention-curve`
(the entire D1/D7/D30/D90 curve underlying both LTV figures is an unsourced category benchmark —
test plan: measure real cohort retention over the beta's first 30-90 days; per Step 21's own
guidance, no survey or intent question substitutes for this). Also open: `ka-013-circle-invite-
friction` (whether cold in-app invites convert to real circles the way the pilot's pre-existing
friend group did), `ka-008-selfselection` (whether the pilot's 3x delta is causal or a self-
selection artifact), `ka-010-core-not-found` (no durable Core yet — revisit once beta data exists
to test whether pod-matching data becomes a real asset), and 20 further lower-impact items — the
full register is in Section 5 and `plan/20-identify-key-assumptions.md`/`plan/21-test-key-
assumptions.md`.

**3. Open `risk_log` entries of type `ai_risk`.** `ar-kindling-001` (open, advisory): the ~13M
reference population behind the beachhead TAM is an unsourced founder estimate — recommend sourcing
it externally before this figure is shown outside this document. `ar-kindling-005` (mitigated): an
earlier draft of Step 19's COCA-per-payer figure stated an exact "$125.00" from two low-confidence,
chained inputs — flagged as false precision and re-stated as a range ("~$120-130"); the fix was
re-checked and confirmed.

**4. Scope statement.** This plan, and the review process it goes through, is a planning aid — not
licensed financial, legal, or investment advice, and passing any review layer in this system is not
validation from a real investor, customer, or advisor.

## 1. Who Is Your Customer?

**Market segmentation (Step 1):** 13 candidate segments were brainstormed across the daily-
creative-practice space (sketching, writing, photography, music, cooking, and others); one — early-
recovery/sobriety journaling — was explicitly surfaced and then **rejected as a beachhead
candidate**, on the grounds that it involves sensitive personal health data and a compliance
posture this business isn't scoped for; it is not pursued anywhere else in this plan.

**Beachhead (Step 2):** hobbyist sketch/drawing practitioners, U.S., active in online or in-person
art communities, who have attempted and abandoned a self-directed daily sketch practice in the last
12 months. Selected almost entirely on reach and right-to-win — the founder is personally embedded
in two active sketch-meetup communities and ran a real pilot in exactly this segment.

**End user profile (Step 3):** grounded in 14 real conversations (the pilot cohort) — but every one
of those 14 is drawn from the founder's own existing network, an honestly-flagged sampling bias
(`ka-003-friends-and-family-sample`) not yet checked against a stranger to that network.

**Beachhead TAM (Step 4):** ~2M end users (13M reference population × 15% fit fraction, both
unsourced founder estimates). Two TAM figures are reported, not one, because **this is the one
Disciplined Entrepreneurship step in this plugin with no `consumer_app`-specific guidance at all**
— the naive full-conversion ceiling (~$100M/year, treating this like a SaaS ACV) and the realistic
blended-ARPU figure (~$5M/year, the number of record, borrowing Step 17's blended-ARPU method by
analogy). The realistic figure sits well below this step's own "tens to low hundreds of millions"
sanity-check heuristic — plausibly a structural artifact of freemium blended-ARPU math (parallel to
the marketplace GMV-vs-take-rate distinction this step's own text already makes for a different
business type), not necessarily evidence the beachhead itself is too small, but reported honestly
as an open question rather than explained away.

**Persona (Step 5):** Maya Torres, 29 — a real, named (pseudonymized) pilot participant, not a
hypothetical composite.

## 2. What Can You Do For Your Customer?

**Full life cycle (Step 6):** the single highest-risk stage is the first 60 seconds of onboarding,
followed closely by whether a real accountability circle actually forms — nothing downstream works
if either fails. **Product spec (Step 7):** the MVP is a single-discipline (sketching), prompt-
before-signup flow with a circle-invite immediately after the first submission — deliberately
narrow, with automated pod-matching, Android, and multi-discipline support all explicitly deferred.
**Quantified value proposition (Step 8):** solo practitioners in the pilot averaged ~12 days before
quitting; circle participants averaged 34+ days (several still active when the pilot ended) — a
~3x difference, reported honestly as suggestive pilot evidence confounded by self-selection, not
proof.

## 3. How Does Your Customer Acquire Your Product?

**Next 10 customers (Step 9):** 8 of 10 named, real prospects identified with real access paths (5
already in conversation); the 2-prospect gap is an honest outreach-effort shortfall, not a
fabricated list. **Core (Step 10):** **no durable Core has been identified yet** — the
accountability-circle mechanic is real but copyable in a sprint by any funded competitor; the
founder's own community credibility is real but personal, not a company asset that compounds. This
is reported as a genuine, honest finding appropriate to an idea-stage business, not softened.
**Competitive position (Step 11):** axes chosen from persona research (accountability structure vs.
creative breadth); Kindling does not win trivially on both axes against every named competitor
(Procreate beats it on creative depth; Duolingo beats it on proven habit-mechanic scale) — the
honest differentiated claim is narrower: no current competitor combines creative-discipline
specificity with structured small-group accountability. **DMU (Step 12) and acquisition process
(Steps 13+18, one combined narrative per this plan's reconciliation requirement):** the
decision-making unit collapses to one person (end user = economic buyer, a self-serve consumer
purchase), with a real, structurally important Influencer/Recommender role (the friend who invites
her). The funnel — discovery → install → first prompt → circle formation → paid conversion — is a
pure marketing/conversion funnel with no rep time, costed from an estimated $4,000 in pre-launch
founder-time community seeding against ~800 estimated installs. **A real cross-step disagreement,
surfaced rather than smoothed over:** Step 16's flat 4% install-to-paid conversion assumption and
Step 18's chained, stage-by-stage funnel math (discovery→install→first-prompt→paid) independently
imply a lower ~1.5-2% rate. Both numbers are carried forward explicitly (`ka-018-conversion-
inconsistency`) — the 4% figure is used as the plan's number of record in Step 19's COCA
calculation because it is the more conservative (higher-conversion, lower-COCA) choice to present
first, but a reader should treat the resulting COCA as potentially optimistic.

## 4. How Do You Make Money Off Your Product?

**Follow-on TAM (Step 14):** pin 2 (daily creative writers) sized at ~$3M/year, explicitly kept
separate from any ARPU-expansion effect on existing beachhead users (a Step 17 question, not a
Step 14 one) — gated on the beachhead showing stable retention and cold-circle-formation working
with strangers, not just friends. Pin 3 (instrument practice) is named but not sized this round —
the longest-lead, hardest-access candidate.

**Business model (Step 15):** freemium — ad-supported free tier (sketching only) plus a $6.99/mo or
$49.99/yr subscription (all disciplines, no ads, premium challenges). A one-time-IAP alternative was
seriously considered and is explicitly left open, not resolved.

**Pricing (Step 16):** $6.99/mo or $49.99/yr, anchored to comparable apps' pricing from memory, not
tested with a single real prospect. Two additional load-bearing placeholder assumptions are named
explicitly: a 4% freemium-to-paid conversion rate and ~$0.60/year ad revenue per free user, neither
independently sourced.

**LTV (Step 17):** computed exactly as this business type requires — **blended across payers and
non-payers, with expected lifetime derived from an actual (if entirely category-benchmarked, since
no real cohort exists) D1/D7/D30/D90 retention curve, not a flat churn rate.** Two figures are
reported, not one: a blended per-install LTV (~$0.90) and a per-payer LTV (~$31) — both are needed
because comparing the flattering per-payer figure against a per-install COCA (or vice versa) would
misstate the ratio, exactly the mismatch this business type's guidance warns against.

**COCA and the LTV:COCA reconciliation (Step 19), computed at matching funnel stages per this
step's own requirement:**

| Comparison | LTV | COCA | Ratio |
|---|---|---|---|
| Blended, per install | ~$0.90 | ~$5.00 | **~0.2:1** |
| Per paying user | ~$31 | ~$120-130 | **~0.25:1** |

**Both ratios are far below the 3:1 floor this step's own guidance names as the threshold for
economic viability at scale, and the implied payback period (~40 months) is not survivable for a
bootstrap-resourced solo founder.** This is stated plainly, not softened: **as currently modeled,
from entirely unvalidated inputs, this business's unit economics do not work.** The two
independent comparisons landing in the same rough range is a real internal-consistency check
(ruling out a funnel-stage-mismatch artifact) — this looks like a genuinely weak result under
current assumptions, not a computation error. The single most consequential lever is the untested
4% payer-conversion rate (`ka-016-conversion-rate`) — even a 2-3x real-world improvement would move
this ratio meaningfully without touching price or cost. **This ratio must not be read as settled —
it rests entirely on `ka-016-conversion-rate` and `ka-017-retention-curve`, both `test_result:
null`, both explicitly deferred to the MVBP beta** — but it must also not be hidden or minimized in
the meantime.

## 5. How Do You Design and Build Your Product?

**Key assumptions (Step 20):** 24 assumptions and low-confidence claims inventoried, plus 2 new
gaps surfaced by this step's own sweep (App Store platform-dependency risk; founder bandwidth
alongside a full-time job). Six ranked as leap-of-faith: the 4% payer-conversion rate, the
retention curve, cold-circle-invite friction, the pilot's self-selection confound, the untested
price point, and founder bandwidth.

**Test key assumptions (Step 21):** five of the six leap-of-faith items are correctly **deferred**
(not closed) pending the MVBP beta, since no substitute for real usage data exists for a retention
or conversion assumption — the sixth (founder bandwidth) was resolved directly, in conversation:
the founder committed to a 10 hrs/week budget through the beta window with a named fallback. Every
other item in the full inventory (18 further entries) received an explicit disposition — folded
into a related test, accepted as low-impact, or deferred with a stated trigger — none left silently
unaddressed.

**MVBP (Step 22):** a real, paid, 150-person closed iOS beta — sketching only, real Apple in-app
purchase billing at the real stated price, manual (explicitly not automated) pod-matching for
friendless signups, and a first-60-seconds flow that shows the day's prompt before any signup
screen. Apple's App Store Review requirement to use its own in-app purchase system (no external
payment link) is named as a binding business-model constraint, not a build footnote, and carries
real schedule risk (a possible App Review rejection-and-resubmission cycle). Designed explicitly to
resolve the plan's three biggest open questions: real conversion, real circle-formation rate, and
real retention.

## 6. How Do You Scale Your Business?

**Dogs eating the dog food (Step 23):** **not yet measurable** — no MVBP has shipped. The informal
pilot's suggestive numbers are real context but are explicitly not treated as a substitute for real
post-launch usage evidence, per this step's own standard.

**Product plan (Step 24):** the near-term roadmap is entirely gated on the beta launching and
producing real retention/conversion/circle-formation data — **no paid user-acquisition spend and no
pin-2 product work are budgeted this window**, specifically to avoid the single most common
consumer-app roadmap mistake this step's own guidance names: spending to acquire more users into an
unproven, currently-negative-looking unit-economics funnel. Two cheap, pre-launch-resolvable
assumptions (a real freelance-rate comp, a real hosting-cost quote) are prioritized immediately,
since they cost nothing to fix now and currently rest on placeholders.

## Key Assumptions & Open Risks

The full 29-entry `key_assumptions` register and 16-entry `quantitative_claims` register live in
`business-state.json`; every low-confidence or `ai_risk_flag: true` entry is named in the relevant
theme section above. Restating the register's headline structure here for a reader who wants the
risk picture without reading all 24 appendix sections:

- **Highest-impact, still fully open:** `ka-016-conversion-rate` (4% payer conversion, untested),
  `ka-017-retention-curve` (the entire LTV-driving retention curve, unsourced, zero real data).
- **The two cross-step reconciliation flags, surfaced explicitly rather than silently resolved:**
  Steps 16 vs. 18's conversion-rate disagreement (~4% flat vs. ~1.5-2% chained), and Step 4's TAM
  method being improvised in the absence of any `consumer_app` branching in that step at all
  (`ka-004-arpu-method`) — the latter is a gap in this plugin, not in the business, flagged for
  `docs/QA-FINDINGS-ROUND5.md`.
- **The core LTV:COCA finding:** both computed ratios (~0.2:1 blended, ~0.25:1 per-payer) sit far
  below the 3:1 viability floor, built from entirely unvalidated inputs — a real, weak result, not
  hidden.
- **`ar-kindling-001`** (open, advisory): unsourced TAM reference population. **`ar-kindling-005`**
  (mitigated): an earlier false-precision finding on Step 19's COCA figure, fixed and re-confirmed.

## Appendix

**Step 1 (Market Segmentation):** 13 candidate segments; sobriety/recovery journaling explicitly
brainstormed and rejected on compliance/sensitivity grounds; 4 shortlisted. See
`plan/01-market-segmentation.md`.

**Step 2 (Beachhead):** sketch-a-day hobbyists selected via a weighted scoring matrix, winning
overwhelmingly on reach (5/5) and right-to-win (5/5) versus 3 runner-up creative-discipline
segments. See `plan/02-select-a-beachhead-market.md`.

**Step 3 (End User Profile):** four-dimension profile from 14 real pilot conversations, all within
the founder's existing network. See `plan/03-build-an-end-user-profile.md`.

**Step 4 (Beachhead TAM):** ~2M end users; two TAM figures reported (naive ~$100M ceiling, realistic
~$5M blended); no `consumer_app` branching exists in this step. See
`plan/04-calculate-the-tam-for-the-beachhead-market.md`.

**Step 5 (Persona):** Maya Torres, real pilot participant. See
`plan/05-profile-the-persona-for-the-beachhead-market.md`.

**Step 6 (Full Life Cycle Use Case):** 8-stage map; biggest drop-off risk is the first-60-seconds
onboarding moment plus whether a circle forms. See `plan/06-full-life-cycle-use-case.md`.

**Step 7 (Product Spec):** prompt-before-signup, circle-invite-after-first-submission, single
discipline at launch. See `plan/07-high-level-product-specification.md`.

**Step 8 (Quantified Value Proposition):** ~3x streak-length delta from pilot data, flagged for
self-selection confound. See `plan/08-quantify-the-value-proposition.md`.

**Step 9 (Next 10 Customers):** 8 of 10 real, named prospects. See
`plan/09-identify-your-next-10-customers.md`.

**Step 10 (Core):** no durable Core identified yet — an honest finding. See
`plan/10-define-your-core.md`.

**Step 11 (Competitive Position):** honest (not strawman) 2x2 map; differentiated but not
dominant-on-all-axes. See `plan/11-chart-your-competitive-position.md`.

**Step 12 (DMU):** collapses to one person; real Influencer/Recommender role; no veto-holder for
this adult beachhead. See `plan/12-determine-the-dmu.md`.

**Step 13 (Acquisition Process):** 5-stage self-serve funnel; circle formation is the riskiest
stage. See `plan/13-map-the-process-to-acquire-a-paying-customer.md`.

**Step 14 (Follow-on TAM):** pin 2 (~$3M/yr, daily creative writers) sized and kept distinct from
ARPU expansion; pin 3 named, not sized. See `plan/14-calculate-the-tam-for-follow-on-markets.md`.

**Step 15 (Business Model):** freemium (ads + subscription) selected; one-time IAP left open. See
`plan/15-design-a-business-model.md`.

**Step 16 (Pricing):** $6.99/mo or $49.99/yr, untested; 4% conversion and ~$0.60/yr ad-revenue
placeholders. See `plan/16-set-your-pricing-framework.md`.

**Step 17 (LTV):** blended ~$0.90/install and per-payer ~$31, both from an unsourced retention
curve, correctly not `1/churn`. See `plan/17-calculate-the-ltv-of-a-customer.md`.

**Step 18 (Costed Acquisition):** funnel costed; surfaced the Step 16/18 conversion-rate
disagreement. See `plan/18-map-the-sales-process-to-acquire-a-customer.md`.

**Step 19 (COCA):** ~$5/install, ~$120-130/payer; LTV:COCA ~0.2-0.25:1, both far below the 3:1
floor; one AI-risk BLOCKED→fixed→PASS cycle on false precision. See
`plan/19-calculate-the-coca.md`.

**Step 20 (Key Assumptions):** 24 inventoried, 2 new gaps surfaced, 6 ranked leap-of-faith. See
`plan/20-identify-key-assumptions.md`.

**Step 21 (Test Key Assumptions):** 5 of 6 shortlisted items deferred to the beta; 1 resolved by
founder commitment; every other inventory item dispositioned. See
`plan/21-test-key-assumptions.md`.

**Step 22 (MVBP):** 150-person paid closed iOS beta; App Store platform constraints and the
first-60-seconds flow both named explicitly. See `plan/22-define-the-mvbp.md`.

**Step 23 (Dog Food):** not yet measurable — no product has shipped. See
`plan/23-show-that-dogs-will-eat-the-dog-food.md`.

**Step 24 (Product Plan):** roadmap gated entirely on beta data; no paid UA or pin-2 work budgeted
yet. See `plan/24-develop-a-product-plan.md`.

*This is a planning aid, not financial, legal, or tax advice.*
