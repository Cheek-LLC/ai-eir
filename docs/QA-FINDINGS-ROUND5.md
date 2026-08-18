# QA Findings — Round 5: Fourth Independent End-to-End Dry Run (Consumer App)

**Method.** I role-played the `startup-operator` orchestrator agent against a fake founder, Priya
Shah, and her business **Kindling** — a daily-practice app for hobbyist creatives (sketching
first) who've tried and abandoned a self-directed streak, built around small accountability
"circles" of real friends, freemium-monetized (ad-supported free tier + $6.99/mo or $49.99/yr
subscription). Unlike round 2's ShiftCover (SaaS), round 3's SkyClaim (marketplace), and round 4's
Vantage Point Search (services), Kindling is deliberately a **consumer app** — the one business
type flagged as under-served as far back as round 1, never live-tested despite three subsequent
rounds adding consumer_app-specific branching to DE steps without ever exercising it against a real
drafted business. I ran the real onboarding interview per `skills/interview/onboarding-interview/
SKILL.md` (including the mandatory privacy notice), drafted all **24** DE steps for real,
re-reading each step's *current* SKILL.md immediately before drafting against it, assembled
`plan/business-plan.md` via `skills/business-plan/assemble-business-plan`, ran the mandatory
AI-risk gate live and repeatedly (it correctly **BLOCKED once** on a real false-precision finding
in Step 19's COCA, and correctly **PASSED** after the fix — plus five other clean live gate calls
at Steps 4/14/16/17 and at plan assembly), then ran `skills/business-plan/run-review-council` for
real — a full 5-seat balanced-track (Track C) panel, working the aggregation algorithm by hand,
including counting `key_assumptions` by hand to determine whether `product-market-fit-panel`'s own
trigger condition actually fires for this business (it does not — see §4 below, the headline
council finding this round). Every artifact is a real file under `.startup/kindling/` — nothing
here is a hypothetical description of what a run would produce.

**Founder decision, stated up front, since it shapes several findings below.** Kindling is
`idea_only` but grounded in a real informal, non-app 6-week pilot (a WhatsApp group + spreadsheet,
14 real people, run before any code existed) — this let me stress-test the "founder has *some* real
signal but *zero* real product-usage data" case, which is a harder and more realistic version of
the retention-curve/LTV test than either a fully blank idea or an already-operating business with
real cohort data would have been. The business's own unit economics, computed honestly per this
plugin's own required method, come out genuinely bad (LTV:COCA ≈ 0.2-0.25:1, far below the 3:1
floor) — this was not planted to force a dramatic finding; it fell out of realistic, conservative
freemium-consumer-app assumptions once I followed the actual guidance (or the actual absence of
guidance, in Step 4's case) to the letter. The council's aggregate verdict is **REJECT** (a new
worked pattern — see §4.1).

**Fixture disposition.** `.startup/kindling/` is left in place as a real worked example:
`business-state.json` (29 `key_assumptions`, 16 `quantitative_claims`, 3 `risk_log` entries),
`interview-log.md`, all 24 `plan/NN-slug.md` files, `plan/business-plan.md`, and one full review
file under `reviews/`. It ends at `stage: "revising"` — the council returned REJECT.

---

## 1. Disciplined Entrepreneurship steps — the consumer_app branching audit

**Headline result, stated plainly before the details: consumer_app branching is real, specific,
and genuinely usable in 21 of 24 steps — but three steps (1, 2, and 4) have *no* consumer_app
branch at all, and Step 4's gap is a real, demonstrated, load-bearing problem, not a cosmetic
omission.** This is the single most important, previously-unreported finding this round produced,
and it was found by literally reading each step's "Business-type branching" section end to end,
not by inference.

### 1.1 — Blocking: Steps 1, 2, and 4 have zero `consumer_app` branching, and Step 4's gap
produces a real, demonstrated methodological problem

**Files:** `skills/disciplined-entrepreneurship/01-market-segmentation/SKILL.md`,
`skills/disciplined-entrepreneurship/02-select-a-beachhead-market/SKILL.md`,
`skills/disciplined-entrepreneurship/04-calculate-the-tam-for-the-beachhead-market/SKILL.md`.

I confirmed by reading every one of the 24 steps' "Business-type branching" sections directly
(not by grep, since the goal was to check whether the guidance is *substantively present and
usable*, per this round's brief, not just whether the string "consumer" appears anywhere): Steps
**5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24** — 20 of 24 — all have
an explicit, specific `**Consumer app:**` bullet. Steps **1, 2, and 4 do not** — their branching
sections list exactly SaaS, Physical product, Marketplace, and Services, with no consumer-facing
category at all beyond Step 1's one generic "(B2C) What demographics, life stages, occasions, or
use contexts..." interview question (which at least gives *something* to work with) and Step 2's
literal nothing (not even a generic B2C fallback — I had to improvise Step 2's "reach" and
"competitive intensity" definitions entirely from Steps 5/9/11's consumer-app language, which this
step never points to).

**Step 4 is the demonstrated, load-bearing case, not just a documentation gap.** This step's stated
method — "annual revenue per user = price × purchase frequency" — has no answer for a **freemium**
consumer app, where most end users generate ad revenue only and a small minority pay a subscription.
I hit this directly while drafting Kindling's TAM: the step gives zero instruction on whether to
size off a naive 100%-conversion assumption (which produced a nonsensical ~$100M/year figure — no
freemium consumer app converts 100% of its base to paid) or a realistic blended figure (which I had
to improvise by borrowing Step 17's blended-ARPU method sideways into Step 4, producing a much more
defensible ~$5M/year). **Both figures are reported in `plan/04-calculate-the-tam-for-the-beachhead-
market.md` and `qc-004-tam-naive-ceiling`/`qc-004-tam-realistic`, and the improvisation is flagged
explicitly** — but a less careful drafter would very plausibly have used the naive figure (it's the
one the step's literal formula produces) and presented a badly overstated TAM as the plan's number
of record, with nothing in Step 4 itself to catch it. This is exactly the same shape of gap round 3
found in Steps 17-18 for marketplace (finding 1.3, blocking) — a whole business type's structurally
different economics has no representation in a step whose formula silently assumes a different
shape — except this time it's the *first* money-figure step in the whole plugin (Step 4, not Step
17), meaning a founder who stops after Step 4 (a very plausible real pattern, explicitly named as a
risk in Step 4's own "Mandatory AI-risk gate" section) gets this exact failure mode with nothing
downstream to catch it before they see the number.

**Fix:** add an explicit `**Consumer app:**` bullet to Step 4's "Business-type branching" section
instructing the blended-ARPU method directly (freemium ad-revenue-plus-subscription-revenue,
weighted by an assumed or measured payer-conversion rate) as the number of record, with the naive
full-conversion figure reported only as an explicitly-labeled non-representative ceiling — mirroring
exactly the discipline this step's own marketplace branch already applies to GMV vs. take-rate
revenue. Add a matching sanity-check caveat parallel to the marketplace/services caveats already
present ("a freemium consumer app's blended-ARPU TAM is structurally much smaller than a naive
full-price figure — check against the naive ceiling instead of the heuristic's raw dollar range, or
state the heuristic doesn't directly apply"). Add at minimum a generic B2C fallback question to Step
2, matching Step 1's existing (if thin) B2C interview question, so "reach" and "competitive
intensity" aren't left completely undefined for any consumer-facing business.
**Severity: blocking** for Step 4 specifically (confirmed with a real produced artifact showing the
naive figure would be ~20x the realistic one, and confirmed this step is one of the five explicitly
gated by the mandatory AI-risk review, meaning a founder really could stop here with a materially
wrong number and no downstream check); **significant** for Steps 1 and 2 (real gaps, but both have
generic-enough surrounding content — Step 1's own B2C question, Step 5/9/11's transferable
consumer-app language — that a careful drafter can work around them, which I did, without the same
concrete demonstrated-harm evidence Step 4 produced).

### 1.2 — Significant: Steps 16 and 18 can produce silently divergent conversion-rate assumptions
that neither step's own reconciliation logic catches

**Files:** `skills/disciplined-entrepreneurship/16-set-your-pricing-framework/SKILL.md`,
`skills/disciplined-entrepreneurship/18-map-the-sales-process-to-acquire-a-customer/SKILL.md`.

Both steps have good, specific consumer_app guidance individually — Step 16 correctly asks for a
freemium-to-paid conversion-rate assumption, Step 18 correctly asks for a chained,
stage-by-stage funnel (discovery→install→first-use→paid). I followed both exactly as written and
they produced **two different numbers for the same underlying quantity**: Step 16's flat 4%
assumption (asked and answered in isolation) versus Step 18's chained funnel math
(0.70×0.55×...×paid), which independently implies something closer to 1.5-2% once the intermediate
funnel stages are actually multiplied through. Neither step's own text instructs cross-checking
this against the other — Step 18 says "reuse Step 13's stages verbatim" (about the *stage list*,
correctly) but never says "your chained conversion math should reconcile with Step 16's stated
conversion assumption," and Step 16 has no forward reference to Step 18 at all. I caught this myself
while drafting (flagged as `ka-018-conversion-inconsistency`) and it surfaced again, independently,
in the council review (`financial-modeling-reviewer`'s Risks/gaps bullet re-deriving what COCA would
look like under the lower rate) — but nothing in either step's "Definition of done" would have
caught it if I hadn't happened to notice the two numbers didn't match while writing Step 18 right
after Step 16.
**Fix:** add one line to Step 18's "Definition of done" (or its funnel roll-up template):
"cross-check your chained overall-funnel conversion rate against Step 16's stated freemium-to-paid
assumption — if they disagree by a material amount, flag it explicitly rather than silently using
one or the other." This is the same class of fix round 2's finding 2.2 and round 3's finding 1.3
both recommended (a step-level self-check line) for a fourth, independently-discovered instance of
"two related steps can silently diverge without one checking against the other."
**Severity: significant** — real, demonstrated, self-caught in this session but only because I was
paying close attention; the assembled plan's own reconciliation logic (see §2.3 below) does surface
it once it reaches that layer, which is a real backstop, but the gap exists at the step level first.

### 1.3 — Confirmed, with real hand-worked evidence: Step 17's consumer_app branch (the round's
central stress test) is genuinely usable, not aspirational

Stating this plainly since it was this round's explicit central question. Step 17's consumer_app
branch requires three things: (1) a **blended** LTV across payers and non-payers, not payers alone;
(2) an explicit ad-plus-subscription-revenue formula; (3) expected lifetime derived from an actual
D1/D7/D30/D90 **retention curve**, not `1/churn`, because "consumer retention curves are famously
non-linear." I followed all three exactly, with the harder version of the test this round asked
for: **zero real cohort data existed** (idea_only, no app shipped) — not thin data to round from,
none at all. I built an explicit, disclosed category-benchmark retention curve (D1 30%, D7 12%, D30
6%, D90 4%, long tail ~3%), derived an expected active lifetime by approximating a discrete integral
of that curve (~5.5 months) rather than picking a single point and inverting it, and reported **two**
LTV figures (blended ~$0.90/install, per-payer ~$31) explicitly, so that neither a mismatched
funnel-stage comparison nor a single flattering number could slip through undetected — this
directly anticipates and prevents the exact failure mode Step 19's own guidance separately warns
about. See `plan/17-calculate-the-ltv-of-a-customer.md` for the full worked derivation.
**Severity: n/a (confirmed working, not a finding)** — this is the strongest piece of consumer_app
guidance found anywhere in the 24 steps, and it held up completely under adversarial, zero-real-data
drafting conditions. See §5 below for the full retention-curve-vs-flat-churn writeup this round was
specifically asked to produce.

### 1.4 — Confirmed: Step 19's funnel-stage-specific COCA guidance is genuinely usable and
produced a real, honest, unflattering result

Step 19's central instruction for this business type — "COCA must be computed at a stated funnel
stage... comparing a per-install COCA against a per-paying-user LTV understates the ratio
catastrophically" — was directly load-bearing. I computed both a per-install and a per-paying-user
COCA, compared each against the matching LTV figure from Step 17, and got two independently
consistent bad ratios (~0.2:1 blended, ~0.25:1 per-payer) rather than one flattering number and one
I didn't bother computing. The guidance is specific enough that following it honestly is what
produced the plan's single most consequential (and least comfortable) finding — see §5.
**Severity: n/a (confirmed working).**

### 1.5 — Confirmed: Step 9's and Step 22's consumer_app branches ("next-10 via personal
network/beta communities" and "MVBP scoped to platform-review constraints/first-60-seconds") both
held up as specifically usable, not generic

Step 9's branch correctly insisted on named, real individuals reachable via personal network and
beta-tester communities (Discord, Reddit, Product Hunt) rather than an "ad-audience estimate" — I
nearly defaulted to citing a subreddit's follower count as reach before the step's own text ("an
ad-audience estimate isn't a next-10-customers answer, it's a marketing plan") caught it. Step 22's
branch correctly forced two concrete, load-bearing decisions the round's brief specifically asked
about: (1) the App Store's in-app-purchase requirement is a binding business-model constraint (no
external payment link, ~15-30% platform fee), not a build footnote, with real launch-schedule risk
from Apple's review process; (2) the first 60 seconds must show real value (the day's prompt) before
any signup wall, which I operationalized as a concrete, testable product decision, not a vague
aspiration. **Severity: n/a (confirmed working)** — see `plan/09-...md` and `plan/22-...md`.

---

## 2. Business-plan assembly

### 2.1 — Confirmed fixed (fourth round running): `Confidence & Validation Status` section,
`plan.version` skeleton default

Both round-2 fixes continue to hold. `assemble-business-plan/SKILL.md` §7 and `agents/
business-plan-editor.md` both still instruct the Confidence & Validation Status section explicitly;
I wrote it in full for `plan/business-plan.md` and the plan passed the AI-risk gate cleanly at
assembly, confirming the absence-check is actually exercised. `docs/DATA-CONTRACT.md`'s `null`/
absent-until-first-assembly language for `plan.version` is still current; Kindling's skeleton used
`plan.version: null` and `assemble-business-plan`'s precondition worked correctly against it.

### 2.2 — What worked well: cross-step reconciliation caught a fourth, genuinely distinct pattern

Rounds 2, 3, and 4 each found the reconciliation logic (`assemble-business-plan` §3) catching a
real, different inconsistency (a stale beachhead price vs. a downstream volume tier; a two-sided
LTV/COCA gap; a TAM/LTV double-counting overlap). This round's version surfaced a **fourth,
distinct pattern**: the Steps 16-vs-18 conversion-rate disagreement (§1.2
above), plus — genuinely new this round — the requirement to reconcile Step 4's TAM methodology at
all, once its complete absence of consumer_app guidance was discovered, since the reconciliation
section had to explicitly account for *why* two TAM figures (naive and realistic) exist rather than
one. The reconciliation discipline is still doing real, generalizable diagnostic work on a business
type it has never seen before, four rounds running.

### 2.3 — Polish: the assembled plan's LTV:COCA reconciliation instruction still has no explicit
consumer_app-specific caveat, unlike its now-explicit services caveat

**File:** `skills/business-plan/assemble-business-plan/SKILL.md`, §3 item 3.

Round 4's finding 2.4 got a services-specific caveat added to this section ("a *healthy* ratio still
needs an explicit statement of whether it reflects real scalability... for a `services` business
specifically"). No equivalent consumer_app-specific caveat exists for the *opposite* case this round
hit — an *unhealthy* ratio built entirely from unvalidated, zero-real-data placeholders (the
retention curve, the conversion rate) needs an explicit instruction not to be over-read as "this
business fundamentally doesn't work," any more than a healthy services ratio should be over-read as
"this business scales." I handled this correctly in `plan/business-plan.md`'s Section 4 by hand
(explicitly stating the ratio "must not be read as settled... but must also not be hidden or
minimized"), following Step 19's own guidance rather than this assembly-layer instruction, which
doesn't carry it. **Fix:** add one line to §3 item 3 parallel to the existing services caveat: "For a
`consumer_app` business specifically, a *weak* ratio built entirely from pre-launch, zero-real-data
placeholders (a retention curve, a conversion rate) needs an explicit statement that it reflects
current-assumption risk, not a proven-unviable business — do not let a scary number alone read as a
verdict on the underlying idea before real data exists to test it." **Severity: polish** — the
individual DE steps (17, 19) already carry enough of this instruction that I followed it correctly
without the assembly layer's help; this is about making sure a less careful drafter doesn't drop it.

---

## 3. AI-risk gate — confirmed working a fourth consecutive independent time, and the pattern's
persistence is worth naming explicitly, as round 4 asked

Round 4 explicitly flagged this as worth checking a fourth time: "the exact same AI-risk failure
mode (false precision on a downstream synthesized unit-economics figure) has now been independently
caught... in three consecutive rounds... a fourth round hitting the same pattern a fourth time would
be worth asking whether a structural fix is warranted." **Here is the direct answer: it recurred a
fourth time, on a fourth business type, at the same specific step (19, COCA) round 4 hit — but only
once this round, not on multiple steps, and only after I had deliberately drafted Steps 4/14/16/17
with careful rounding from the start, informed directly by having just read rounds 2-4's own
findings before drafting.**

- **Step 19 (`plan/19-calculate-the-coca.md`):** first-pass draft stated COCA-per-paying-user as an
  exact "$125.00," built by chaining two `confidence: low` inputs (a $50/hr founder-time placeholder
  and an 800-install estimate) through a division. **BLOCKED** — false precision, `ar-kindling-005`.
  Fixed by restating as an honest range ("~$120-130, roughly $125") and re-rounding the LTV:COCA
  ratio and payback period. Re-ran: **PASS**, same session.
- **Steps 4, 14, 16, 17** and the plan-assembly gate: all called live, all **PASS** on the first
  attempt — every figure in these four steps was deliberately drafted with an explicit range/
  rounding/low-confidence label from the start. This is the same pattern round 4 itself reported
  (round 3 hit 3 separate BLOCKED findings; round 4 hit exactly 1, on the most arithmetically
  complex step, after applying rounds 2-3's lessons to the rest) — **and it repeated exactly the
  same way a fourth time, on the same specific step.**

**What this is evidence of, stated plainly:** this is not a coincidence of which step happens to be
"the complex one" in every business — Step 19 (COCA) is structurally the step furthest downstream in
the chain of estimates (TAM→LTV→funnel costing→COCA), meaning it accumulates the most compounded
uncertainty from every upstream low-confidence input, and it is also the step where a founder is
most likely to want a single, presentable headline ratio, creating real pressure toward rounding
late rather than early. **Four consecutive rounds hitting this same specific failure mode, at
increasingly predictable points (three of four times at Step 19 specifically — rounds 3's Step 4/17
instances are the only exception), is now strong enough evidence to warrant round 4's suggested
structural fix, not just continued reliance on the gate catching it every time.** **Fix:** add a
standing reminder to the shared unit-economics template pattern common to Steps 4/14/16/17/19 (or a
one-line addition to each of those five steps' "Definition of done," matching the existing
"quantitative claims logged" self-check) that reads: "State the final result to no more precision
than your weakest chained input supports — round explicitly before writing the headline figure, not
after the AI-risk gate catches it." This is a cheap, mechanical fix for a pattern that has now
independently cost one BLOCKED cycle in every one of four rounds. **Severity: significant** — not
blocking (the gate itself continues to work exactly as designed and this is not a failure of the
gate), but four-for-four is a strong enough signal that leaving the fix to "the gate will catch it"
indefinitely is a real, avoidable inefficiency tax, not a necessary cost.

**Onboarding privacy notice (Mode A):** confirmed called once, at the correct point, logged as
`privacy-onboarding-kindling`.

---

## 4. Review council — the round's other central question

### 4.1 — Confirmed, worked by hand: `consumer_app`'s lack of a dedicated council persona is a
real, demonstrated gap — and the specific mechanism is sharper than the Data Contract's table
currently describes

`docs/DATA-CONTRACT.md`'s persona-coverage table already flags `saas`/`consumer_app`/`other` as
having "none dedicated," covered only by content-triggered generalist seats including
`product-market-fit-panel`, described there as the seat "most load-bearing" for these types. I
worked `run-review-council/SKILL.md`'s full §3 priority procedure by hand against Kindling's real
`business-state.json`, and found something more specific and more concerning than "no dedicated
persona": **`product-market-fit-panel`'s own trigger condition did not fire, despite Kindling being
exactly the kind of business its frontmatter describes as most load-bearing for.**

The trigger requires `key_assumptions` entries with `step_ref` in the 06/07/08/20/21/22/23 range at
`confidence: low` to *outnumber* similarly-low-confidence entries elsewhere. I counted directly from
the real `business-state.json`: **7 entries fall inside that range, versus 22 outside it** — because
this business's real weak points, honestly assessed, are its TAM sourcing (Step 4), its pricing/
conversion/retention/COCA assumptions (Steps 16-19), and its Core (Step 10), not its PMF-mechanics
steps specifically. **This is a realistic pattern, not a contrived one**: an idea-stage consumer app
with a real (if small) pilot has *more* open questions about whether the unit economics work than
about whether the value proposition itself is real — the pilot data, thin as it is, already gives
some signal on the PMF question, while nothing gives signal on price/conversion/retention yet. The
seat instead fell to **`competitive-strategy-reviewer`**, via a different, legitimate trigger (rule
#6: Step 10's own summary explicitly states "no durable Core identified yet").

**The consequence is concrete and checkable, not speculative:** I read `agents/council/
competitive-strategy-reviewer.md` directly. Its "Calibrate by business type" section — the part of
every persona file that's supposed to give type-specific scrutiny — names marketplace, SaaS, and
physical-product/DTC. **It has no `consumer_app` calibration at all**, unlike every persona file I
checked for the business types those personas are meant to cover. In this run, the persona still
produced a substantively useful, well-grounded verdict (see the review file — its Core/business-
model-reinforcement critique is real and specific) purely from its generic rubric plus the business's
own plan content, without needing type-specific calibration to be useful. But that's a favorable
outcome this specific business happened to produce (Step 10's honest "no Core" finding gave the
persona real, concrete content to grab onto), not evidence the gap doesn't matter — a consumer app
whose Core question was murkier or whose real risk concentrated somewhere the generic rubric doesn't
probe (say, virality/K-factor economics, or platform-policy dependency) would get materially less
type-specific scrutiny from this seat than a marketplace or SaaS business gets from its own dedicated
or well-calibrated persona.

**Fix:** two independent, complementary fixes, not either/or:
1. **Add a `consumer_app` bullet to `competitive-strategy-reviewer.md`'s "Calibrate by business
   type" section** — this is the cheap, immediate fix, parallel to what already exists for the three
   other types, and it closes the gap for exactly the scenario this round demonstrated (this
   persona winning the seat for a `consumer_app` business via a non-type-matched trigger).
2. **Consider a genuinely dedicated `consumer_app`/`saas` contextual persona** (per the Data
   Contract table's own open question) whose rubric specifically probes retention-curve credibility,
   freemium-conversion realism, platform-dependency risk, and virality/K-factor claims — the four
   categories Step 20's own consumer_app branch already names as where unlogged gaps cluster for
   this business type, and none of which any current persona (fixed or contextual) has a dedicated
   rubric hook for. `financial-modeling-reviewer` partially covers the arithmetic of a bad retention/
   conversion assumption (and did, well, in this review), but nothing on the panel asks the
   *product* question `product-market-fit-panel`-style personas ask for other types: is this
   *specific* retention curve, this *specific* conversion assumption, actually plausible for this
   *specific* kind of app and community, not just internally consistent.
**Severity: significant** — real, demonstrated with an actual hand-worked count against a real
fixture (not asserted), and the immediate fix (item 1) is cheap; the deeper fix (item 2) is a real
future-round scoping question, consistent with how rounds 3 and 4 each closed one open persona gap
per round.

### 4.2 — What worked well: the tag-overlap outlier test's "alone at that severity" clause worked
exactly as specified, on a genuinely new worked pattern

Rounds 2-4 each exercised a different shape of the outlier-discard machinery (a lone REJECT
discarded; a lone REJECT surviving via tag-corroboration; no discards at all with a softer
aggregate). This round produced a **fourth, genuinely distinct pattern**: two independent reviewers
(`financial-modeling-reviewer` and `vc-panel`) converged on REJECT simultaneously, and per §6's own
explicit text ("two or more reviewers independently landing on the same harsh verdict... is never an
outlier situation for either of them, regardless of tag overlap"), the aggregation stopped at Step
B/C on the very first pass — no tag-overlap check, no floor-rule invocation, nothing further to
compute. I worked this by hand and confirmed the rule's own text anticipates and correctly resolves
exactly this case. This is real design quality holding up on a fourth independent try, on a pattern
none of the first three rounds happened to hit.

### 4.3 — What worked well: the round-4 regulated-industry-compliance-reviewer fix holds on new
content, independently, a fourth time

Round 4 fixed a real false-positive risk in this trigger's specification (a keyword match firing on
a surveyed-and-rejected segment, or on a sentence that explicitly negates the regulated attribute).
I deliberately built a real test case for this into Kindling's own Step 1: a candidate segment
("sobriety/recovery journaling") that mentions sensitive personal health data and is then explicitly
rejected and never pursued. I confirmed by working the trigger's current specification directly
against this real plan text that it correctly does **not** fire — the fix holds on genuinely new
content, for a business type round 4's own test case (services) never touched, independently
confirming this isn't a fix that only worked for the specific wording round 4 happened to test.

---

## 5. The retention-curve-vs-flat-churn stress test — this round's other central question,
answered directly

Restating the answer plainly, since it's this round's headline ask, the way round 4 did for its own
central question: **yes, Step 17's retention-curve requirement for consumer apps is real and held up
completely under the hardest version of the test — zero real cohort data, not just thin data.**
Concretely:

- The step's own instruction (derive expected lifetime from an actual D1/D7/D30/D90 curve, "not
  `1/churn`... consumer retention curves are famously non-linear") is specific enough to actually
  follow, not just aspirational language. I built a real, disclosed, category-benchmarked curve and
  computed an approximate discrete integral of it rather than picking a convenient single point and
  inverting it — the method itself is shown in full in `plan/17-calculate-the-ltv-of-a-customer.md`,
  not asserted.
- **The requirement to report a blended figure (not payer-only)** was equally load-bearing and is a
  distinct, separate discipline from the retention-curve requirement — I confirmed directly that
  reporting *only* the flattering per-payer LTV (~$31) without the blended figure (~$0.90) would have
  materially misstated this business's real economics, since Step 19's matched-funnel-stage COCA
  comparison depends on having both.
- **The result this discipline produced is genuinely uncomfortable** (LTV:COCA ≈ 0.2-0.25:1) — and
  that discomfort is itself evidence the guidance is doing real work, not producing a reassuring
  number by construction. A weaker or more superficial version of this guidance (e.g., "just use a
  reasonable churn rate") would have been easy to fudge toward a more flattering answer; the
  curve-integration method, done honestly, didn't leave that room.
- **This is the third consecutive round to find that a step's guidance for the round's target
  business type is genuinely usable rather than aspirational** (round 3: marketplace dual-sided
  guidance in 19 of 24 steps; round 4: services founder-capacity thread through Steps 14/15/17/19/22/
  24) — Step 17's consumer_app branch specifically joins that list as real, working design, not a
  documentation promise.

---

## 6. Round 2-4 fixes — confirmed or refuted, item by item, from this fourth independent run

| Prior finding | This round's independent check | Result |
|---|---|---|
| R2 1.1 — orchestrator's "approved" vs "drafted" stage-diagram contradiction | Re-read `agents/orchestrator.md`'s state machine directly | **Confirmed fixed**, fourth round running — no step ever promoted past `drafted`; all 24 of my steps sat there correctly. |
| R2 1.3 / R3 3.2 / R4 2.2 — `plan.version` skeleton default trap | Created Kindling's skeleton per current guidance | **Confirmed fixed**, fourth round running. |
| R2 2.1 / R3 3.1 / R4 2.1 — missing `Confidence & Validation Status` section | Assembled `plan/business-plan.md` per current instructions | **Confirmed fixed**, fourth round running; gate exercised this check live and passed cleanly. |
| R2 §3 / R3 §2 / R4 §3 — Steps 04/14/16/17/19 gate wiring + onboarding privacy notice | Drafted all five gated steps; ran the gate live 6 times total (5 clean, 1 BLOCKED→fix→PASS); ran the real onboarding interview | **Confirmed fixed and working**, fourth round running — see §3 above for the full pattern analysis this round was specifically asked to produce. |
| R3 4.2 / R4 (confirmed) — vacuous "Steps 10/11 not yet approved" clause in the contextual-seat trigger | Re-read the current §3 rule #6 (now with the "no Core found" content-signal condition) and actually exercised it — Step 10's real "no Core yet" finding correctly triggered it | **Confirmed fixed and holding, and confirmed genuinely load-bearing** — this is the first of the four rounds where this specific trigger clause actually fired for real (rounds 2-4 never had a business whose Step 10/11 content matched it), and it worked exactly as specified. |
| R3 1.4 / R4 1.3 — Step 4's TAM sanity-check heuristic not adjusted per business type (marketplace GMV/take-rate, services delivery-capacity) | Read Step 4's current state, drafted against it for consumer_app | **New instance of the same underlying gap-class, not a regression of the marketplace/services fixes** — those two fixes hold (I read them directly, unchanged), but Step 4 has no equivalent treatment for consumer_app at all, and — unlike marketplace/services, which at least have *a* branch to refine — Step 4 has *no* consumer_app branch whatsoever. See §1.1, the round's headline finding. |
| R4 4.2 — `regulated-industry-compliance-reviewer`'s literal-keyword false-positive risk | Built a real test case into Step 1 (a rejected, negated sensitive-health segment) and worked the trigger against it | **Confirmed fixed, and confirmed the fix generalizes to new content and a new business type** — round 4's own test case was services; this round's is consumer_app, independently confirming the fix isn't narrowly tailored to the one case that found it. |
| R2 1.4 — Steps 04/11/14's "use WebSearch" has no enforcement | Did not attempt WebSearch for any figure this session, matching all three prior rounds | **Not independently re-tested, fourth round running** — the honest-fallback discipline held (every unsourced figure got a `key_assumptions`/`quantitative_claims` entry with "no external search attempted this session" stated explicitly), but the underlying enforcement gap itself still hasn't been specifically probed by any of the four rounds. Worth a future round actually testing what happens when an agent *does* invoke WebSearch mid-session, since no round has done that yet either. |

**New this round, not a re-test of a prior finding:** §1.1 (Steps 1/2/4 missing consumer_app
branching, Step 4's being blocking), §1.2 (Steps 16/18 conversion-rate divergence), §2.3 (no
consumer_app-specific LTV:COCA caveat at the assembly layer), §3's four-round pattern-persistence
analysis and structural fix recommendation, §4.1 (the specific, hand-worked demonstration that
`product-market-fit-panel`'s own trigger doesn't fire for a realistic consumer_app business, plus
the concrete `competitive-strategy-reviewer` calibration gap this exposes).

---

## What actually worked well

- **Step 17's retention-curve-and-blended-LTV guidance is the single best piece of consumer_app-
  specific design found anywhere in this plugin** — genuinely usable under the hardest version of
  the test (zero real data, not just thin data), and it produced an honest, uncomfortable result
  rather than a flattering one, which is the best evidence such guidance is doing real work rather
  than providing cover. See §5.
- **The AI-risk gate is genuinely load-bearing a fourth consecutive independent time**, and this
  round's specific instance (COCA false precision, again) completes a real, now-actionable pattern
  across four rounds and four business types — strong enough evidence to recommend the structural
  fix round 4 asked about, not just continued case-by-case catching. See §3.
- **The council's aggregation algorithm handled a genuinely new worked pattern correctly on the
  first try** — two independent reviewers converging on REJECT simultaneously, resolved immediately
  by the "alone at that severity" clause exactly as specified, with zero further machinery needed.
  See §4.2.
- **Round 4's regulated-industry-compliance-reviewer fix held on a real, independently-constructed
  test case for a new business type** — a deliberately-planted negative case (a rejected, negated
  sensitive-health segment) correctly did not trigger the seat. See §4.3.
- **The honest-fallback and vague-answer disciplines held under the hardest evidentiary conditions
  yet tested**: an idea-stage business with real pilot signal but zero shipped-product data produced
  a plan that is honest about exactly what that pilot can and can't support (explicitly naming its
  own self-selection confound in Step 8, explicitly refusing to treat pilot data as Step 23 dog-food
  evidence), rather than either inflating the pilot's weight or hiding behind "we have no data at
  all so nothing can be said."
- **The plugin's cross-step reconciliation discipline found a fourth, genuinely new inconsistency
  pattern** (Steps 16/18's conversion-rate divergence) on a business type it had never seen, without
  needing to be told where to look — four rounds, four distinct catches, still generalizing rather
  than replaying a known-good script. See §2.2.
- **This round's headline finding — Steps 1/2/4's missing consumer_app branching, and Step 4's
  demonstrated, blocking consequence — was found the same way every real gap in this plugin's
  history has been found: by actually drafting real content against the real current files and
  hitting the wall directly**, not by inspection or grep alone. That this specific gap survived
  three prior rounds' worth of consumer_app-adjacent work (rounds 1, 3, and 4 all added or discussed
  consumer_app branching elsewhere) without anyone drafting a real Step 4 TAM for a real consumer app
  is itself the clearest demonstration yet of why this plugin's own stated discipline — a live dry
  run, not a design review — is the right one for finding gaps like this.
