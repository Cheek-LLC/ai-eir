# QA Findings — Round 4: Third Independent End-to-End Dry Run (Services)

**Method.** I role-played the `startup-operator` orchestrator agent against a fake founder, Jordan
Reyes, and his business **Vantage Point Search** — a retained executive-search practice placing
VP/Director of Engineering hires at VC-backed Series B-D startups (50-500 employees) whose own
network and generalist recruiters have failed to fill the role. Unlike round 2's ShiftCover (B2B
SaaS, `idea_only`) and round 3's SkyClaim (marketplace, `pivoting`), Vantage Point Search is
deliberately a **services** business, `already_operating` for 14 months with real prior traction
(8 signed engagements, 6 completed placements) — chosen specifically because services is the one
business type this plugin had never yet been live-tested against, despite round 3 having just
added `services-unit-economics-reviewer` and deep services branching across all 24 DE steps. I ran
the real onboarding interview per `skills/interview/onboarding-interview/SKILL.md`, drafted all
**24** DE steps for real (re-reading each step's current SKILL.md immediately before drafting
against it, per this round's instructions, since other agents were actively editing concurrently),
assembled `plan/business-plan.md` via `skills/business-plan/assemble-business-plan`, ran the
mandatory AI-risk gate live (it correctly **BLOCKED** once, on a real false-precision finding in
Step 19's COCA figure, and correctly **PASSED** after the fix), then ran `skills/business-plan/
run-review-council` for real — a full 5-seat bootstrap-track panel, working the aggregation
algorithm by hand, including its first-ever real exercise of the Track A `vc-panel`-downgrade-to-
informational mechanism. Every artifact is a real file under `.startup/vantage-point-search/` —
nothing here is a hypothetical description of what a run would produce.

**A live-editing complication, bigger than either prior round hit.** `agents/council/` grew two
entirely new personas mid-session — `hardware-physical-product-operator.md` and `regulated-
industry-compliance-reviewer.md` — and `skills/business-plan/run-review-council/SKILL.md`'s §3 was
substantially rewritten around them: a new, highest-priority contextual-seat tier
(`regulated-industry-compliance-reviewer`, a content-signal trigger checked *ahead of* the
previously-highest `technical-feasibility-reviewer`) plus a full renumbering of every lower tier and
several new tie-break cases. I re-ran the current seat-selection procedure in full against this
live-updated logic before finalizing the review (see §4 below) rather than trusting my earlier read
of the file. The headline result: **Vantage Point Search's seat selection is completely unaffected**
— `services-unit-economics-reviewer` still wins the contextual 5th seat, `sales-motion-reviewer` is
still the logged runner-up, exactly as it would have been under the pre-change logic — but working
through *why* the new regulated-industry trigger correctly doesn't fire surfaced a real, concrete
design gap in that trigger's own specification (§4.2 below).

**Fixture disposition.** `.startup/vantage-point-search/` is left in place as a real worked example:
`business-state.json`, `interview-log.md`, all 24 `plan/NN-slug.md` files, `plan/business-plan.md`,
and one full review file under `reviews/`. It ends at `stage: "approved"` — the first of the three
rounds' fixtures to reach this terminal state (round 2 ended at `revising`, round 3 at `revising`),
because the aggregate verdict computed for real this session was `APPROVE_WITH_NOTES`. Two
`risk_log` entries document the real privacy notice and the real AI-risk gate BLOCKED→fix→PASS
cycle from this session.

---

## 1. Disciplined Entrepreneurship steps — services branching, step by step

**Overall verdict: round 3's services work is real, deep, and it held up end to end for a real
services business — this is the single clearest confirmation this round produced.** All 24 step
skills reference `business_type: services` at least once; every step I actually drafted against had
services guidance that was specific, actionable, and usable without improvisation — a sharp contrast
to round 3's finding that Steps 17/18 had *zero* marketplace branching at the time. That gap has
since been closed for both business types together: Steps 14, 15, 16, 17, 18, 19, 22, and 24 all
now carry services-specific guidance detailed enough that I never had to invent a structural pattern
the step should have given me (Steps 05, 08, 09, 12, 20, 21, 23 have shorter but equally concrete
services callouts — checked directly, not just grepped for presence).

### 1.1 — Confirmed: round 3's Steps 17-19 fix generalized correctly to services, not just marketplace
**Files:** `skills/disciplined-entrepreneurship/17-calculate-the-ltv-of-a-customer/SKILL.md`,
`18-map-the-sales-process-to-acquire-a-customer/SKILL.md`, `19-calculate-the-coca/SKILL.md`.

Round 3 found (finding 1.3, blocking) that Steps 17-18 had zero marketplace branching, producing a
demonstrated cross-step gap at Step 19. I read all three steps' *current* state before drafting and
confirmed the fix that closed that gap was written generally enough to also give services a full,
distinct treatment, not just marketplace: Step 17 explicitly requires netting **delivery cost**
(not a SaaS-typical gross margin) before computing LTV and explicitly warns against defaulting to a
70-80% SaaS margin; Step 19 explicitly requires costing founder/BD time separately from delivery
time and explicitly calls out the "ask the founder if this still works at a market-rate salary"
question as "especially load-bearing" for services. I followed both instructions for real (Step 17:
$70,500 fee − $9,000 delivery cost = $61,500 margin; Step 19: ~$5,200 COCA built almost entirely
from loaded founder BD time) and the resulting numbers are internally consistent and independently
recomputable — confirmed by my own simulated `financial-modeling-reviewer` verdict recomputing every
figure cleanly. **Severity: n/a (confirmed fixed, not a finding)** — noted here because it's exactly
the kind of "did the fix generalize or just patch the one case that was reported" question a third
round exists to answer, and the answer is yes.

### 1.2 — Significant: Step 18's costed-process template has no place for referral-driven
"background relationship maintenance" time, and this is a real, demonstrated gap for a services
business specifically

**File:** `skills/disciplined-entrepreneurship/18-map-the-sales-process-to-acquire-a-customer/
SKILL.md`.

Step 18's services guidance correctly identifies that cost is "dominated by founder/BD loaded time"
for a referral-driven business, and its output template provides one row per Step-13 acquisition
stage. I hit a real gap trying to follow this faithfully: Jordan's total BD time (45 hrs/engagement,
backed out from 14 months of actual hours vs. signed engagements) is materially larger than the sum
of time spent in the five *discrete* stages the template asks for (~16 hrs/engagement). The
remaining ~29 hrs/engagement is background relationship-maintenance — staying in touch with the two
referral sources that generate most of the pipeline — which happens *between* discrete funnel
stages, not *within* any one of them, and the step's stage-row template has nowhere to put it. I
had to add an explicit new subsection outside the template's table to avoid silently understating
what each discrete stage really costs. This is not a hypothetical concern: for a referral-driven
services business specifically (the pattern this step's own guidance names as the default), most of
the real acquisition cost may live in exactly this uncounted category. **Fix:** add an explicit
"background relationship/network maintenance" row or subsection to Step 18's output template,
specifically flagged for referral-driven businesses, so this cost isn't structurally invisible to
whoever drafts the step. **Severity: significant** — real, demonstrated, and the specific business
shape (referral-driven services) this step's own guidance identifies as the default case for
`services` is exactly where the gap bites hardest.

### 1.3 — Confirmed: round 3's marketplace TAM sanity-check fix (finding 1.4) generalized to services too
**File:** `skills/disciplined-entrepreneurship/04-calculate-the-tam-for-the-beachhead-market/
SKILL.md`.

Round 3 found the beachhead-TAM sanity-check heuristic didn't distinguish GMV from take-rate revenue
for marketplaces, producing a spurious "too small" signal. Confirmed fixed for marketplace, **and**
confirmed the fix's authors extended the same discipline to services in the same pass: the current
step explicitly states "a services TAM assumes unlimited delivery capacity, which is rarely true...
this doesn't change the TAM figure itself but should be named" — I followed this directly in Step 4
and it produced exactly the right effect: a ~$25M TAM presented honestly as a ceiling-on-the-market
figure, explicitly decoupled from what Jordan can actually capture given delivery capacity, rather
than implicitly read as achievable revenue. **Severity: n/a (confirmed fixed generally, not just
patched)** — another concrete "did the fix generalize" confirmation.

### 1.4 — What worked well: the founder-capacity thread runs through Steps 14/15/17/19/22/24 exactly
as this round's brief asked it to be stress-tested

This was the single most load-bearing question this round was designed to answer, so I'm stating the
result plainly here rather than only in "what worked well" at the end: **yes, the plan's Step 17
LTV, Step 19 COCA, and Step 24 roadmap all account for the fact that a services business can't scale
revenue without scaling headcount** — and not superficially:

- Step 15 forces the question directly ("does this model let revenue grow without linearly adding
  headcount... or does every dollar of revenue require a proportional dollar of delivery cost?") and
  I answered it honestly rather than dodging it: revenue is directly capped by the founder's own
  calendar under the current model.
- Step 17's LTV nets real delivery cost rather than a SaaS-shaped margin assumption.
- Step 19 explicitly separates "is COCA healthy" from "can this actually scale" — I wrote, and the
  step's own guidance supports, the exact sentence a services-unit-economics-reviewer-style critique
  would want to see: "acquiring a customer was never the bottleneck — delivering the work is."
- Step 24's roadmap doesn't treat "hire someone" as a free lever — it costs the associate-recruiter
  hire's salary, override commission, *and* the founder's own training-time opportunity cost
  explicitly, against a conservative (not optimistic) first-year output assumption, and names a real
  fallback if the hire doesn't work out.

This chain of steps produced a plan that a felt, in my own drafting, structurally incapable of
hiding the capacity constraint behind a healthy LTV:COCA ratio — which is exactly what round 3's
services-unit-economics-reviewer work was designed to make possible. See §5 below for how the
review council persona built on top of this rather than having to discover it cold.

---

## 2. Business-plan assembly

### 2.1 — Confirmed fixed (third round running): `Confidence & Validation Status` section
`assemble-business-plan/SKILL.md` §7 and `agents/business-plan-editor.md` both still instruct this
section explicitly, placed correctly. I wrote it in full for `plan/business-plan.md`, and the plan
passed the AI-risk gate cleanly at assembly time — its absence-check is exercised, not just assumed.

### 2.2 — Confirmed fixed (third round running): `plan.version` skeleton default
`docs/DATA-CONTRACT.md`'s `null`/absent-until-first-assembly language is still current; Vantage
Point Search's skeleton was created with `plan.version: null` and `assemble-business-plan`'s
precondition worked correctly against it.

### 2.3 — What worked well: cross-step reconciliation caught a genuinely new pattern this round
Rounds 2 and 3 each found the reconciliation logic (assemble-business-plan §3) catching a real
pricing/unit-economics inconsistency. This round's version of that same discipline surfaced a third,
distinct pattern: writing out the TAM reconciliation (Step 4 vs. Step 14) forced explicit
acknowledgment that Pin 2's follow-on TAM and Step 17's repeat-engagement LTV assumption likely
double-count some of the same future client relationships (`ka-014-pin2-repeat-overlap`) — a gap I
would not have noticed drafting Step 14 in isolation, surfaced only by being required to state both
figures side by side in the assembled plan. Three rounds, three different reconciliation catches
(round 2: a stale beachhead price vs. a downstream volume-tier refinement; round 3: a two-sided
LTV/COCA gap; round 4: a TAM/LTV double-counting overlap) — this is a real, generalizable design
strength, not a one-off.

### 2.4 — Polish: `assemble-business-plan`'s LTV:COCA reconciliation instruction only tells the writer
what to do when the ratio is *unhealthy*, not when a *healthy* ratio needs a services-specific
capacity caveat

**File:** `skills/business-plan/assemble-business-plan/SKILL.md`, §3 item 3.

The current instruction: "If the ratio is below roughly 3:1, or if either LTV or COCA rests on a
`key_assumptions` entry with no `test_result` yet, flag that plainly... Do not present the ratio as
settled fact if it isn't." This is correct as far as it goes, but it's silent on the case my own
fixture hit directly: a **healthy** ratio (11.8:1-15.7:1) for a services business that is
nonetheless capacity-constrained in a way the ratio itself says nothing about. I added the "read this
ratio correctly, not as a growth green light" caveat to `plan/business-plan.md` by hand, following
Step 19's own guidance (which does carry this instruction) rather than `assemble-business-plan`'s.
The council layer (`services-unit-economics-reviewer`) is designed to catch this if a drafter omits
it — but that's a downstream backstop, not a guarantee, and it only fires if the business actually
reaches council review. **Fix:** add one line to `assemble-business-plan` §3 item 3: "For a
`services` business, a healthy ratio still needs an explicit statement of whether it reflects real
scalability or is orthogonal to a delivery-capacity constraint — do not let a strong ratio alone read
as a growth signal." **Severity: polish** — the individual DE step (19) already carries this
instruction and I followed it; this is about making sure the assembly layer doesn't silently drop it
if a less careful drafter didn't.

---

## 3. AI-risk gate — confirmed working, live, a third consecutive independent round, on a new failure
instance of the same pattern

Both prior rounds found this gate genuinely load-bearing. I confirmed it a third time, independently:

- **Step 19 (`plan/19-calculate-the-coca.md`):** first-pass draft stated COCA as an exact
  "$5,173" and the LTV:COCA ratios to more decimal precision than the underlying $100/hr placeholder
  founder-rate and untimed ~45-hour delivery-time estimate supported. **BLOCKED** — false precision,
  the exact same AI-risk failure mode round 2 hit on ShiftCover's Step 17 LTV and round 3 hit on
  SkyClaim's Step 4 TAM and Step 17 LTV. Fixed by re-stating the figure as an honest range
  ($4,900-$5,400, ~$5,200) and rounding the ratios to one decimal place. Re-ran: **PASS**, same
  session. `risk_log` entry `ar-vps-001`.
- **Steps 4, 14, 16, 17** and the plan-assembly gate (§7.5): all called live, all **PASS** on the
  first attempt this session — a genuinely different outcome from round 3 (which hit 3 separate
  BLOCKED findings across different layers). This is not evidence the gate is weaker; every figure
  in these four steps was deliberately drafted with an explicit range/rounding/low-confidence label
  from the start, informed directly by having just re-read rounds 2 and 3's own false-precision
  findings before drafting. The gate discriminated correctly either way: it caught the one place I
  slipped (Step 19, arguably the most arithmetically complex step in the whole plan, chaining
  several estimates together) and passed the rest cleanly rather than flagging everything
  indiscriminately.
- **Onboarding privacy notice (Mode A):** confirmed called once, at the correct point (right after
  business basics, before business-type framing), logged as `privacy-onboarding-vantage-point-
  search`.

**A pattern worth naming plainly across all three rounds, not a new bug:** the exact same AI-risk
failure mode (false precision on a downstream synthesized unit-economics figure — TAM, LTV, or
COCA) has now been independently caught by this gate in **three consecutive rounds, on three
different businesses, at three different specific steps.** This reads as strong evidence the gate
is catching a real, structurally-expected pattern in how these figures get drafted (a chain of
several low-confidence inputs multiplied together tends to produce an artificially precise-looking
output unless a drafter deliberately rounds at the end) — not evidence of a persistent bug in any
one step file. **Severity: n/a (confirmation, not a finding)** — flagged here because a fourth round
hitting the same pattern a fourth time would be worth asking whether a structural fix (e.g., a
standing reminder in the shared unit-economics step template to round the final output regardless of
how the intermediate math was shown) is warranted, rather than relying on the gate to catch it every
single time indefinitely.

---

## 4. Review council

### 4.1 — What worked well: services-unit-economics-reviewer confirmed correctly selected and
confirmed to surface genuinely services-specific findings no other persona would have caught

Direct, side-by-side comparison, the same test round 3 ran for `marketplace-liquidity-specialist`:
`services-unit-economics-reviewer`'s two `[DELIVERY-CAPACITY]` findings — (1) the theoretical
solo-capacity ceiling cited in Steps 4/19 implies more weekly hours than its own 20-30 hr/week
realistic-solo heuristic supports, and (2) the guarantee-invocation cost is honestly surfaced in
Step 23 but never folded into Steps 17/19's margin figures — are findings **no other seat on this
panel's rubric owns**: `financial-modeling-reviewer` independently corroborated the *second* one
from a pure-sourcing angle (see the review file's aggregation accounting), but neither
`customer-discovery-skeptic`, `vc-panel`, nor `expert-entrepreneur-panel` has any rubric hook for a
delivery-capacity/utilization-ceiling check at all. This confirms round 3's marketplace-persona
result held for services too: the dedicated persona is a real, working addition, not a checkbox.

### 4.2 — Significant: `regulated-industry-compliance-reviewer`'s content-signal trigger, evaluated
literally, would misfire on a business's own explicit *denial* of a regulated attribute

**File:** `skills/business-plan/run-review-council/SKILL.md`, §3 rule #1 (added mid-session this
round, now the highest-priority contextual-seat trigger).

The trigger is specified as a keyword scan of `business_basics.business_type_notes` and Steps 1/7/15
for terms like "licensed provider," "HIPAA," "patient," etc. I hit two real, concrete cases where a
literal keyword match on my own fixture's actual text would misfire, neither hypothetical:

1. **`business_type_notes` itself** — the very first field this trigger scans — contains the
   sentence "No licensing requirement (retained permanent-placement search is not a licensed
   profession...)." This sentence exists specifically to state the *absence* of a regulated
   attribute, yet contains the substring "licensed" (a literal keyword in the trigger's own example
   list, "licensed provider"). A naive/literal implementation of this trigger would fire *because*
   the business explicitly said it isn't regulated.
2. **Step 1's segmentation table** necessarily surveys all candidate segments, several explicitly
   rejected — mine includes Segment 7 ("Non-tech-industry VP Eng, fintech/healthtech infra"),
   describing a candidate needing "HIPAA-adjacent experience," for a segment that was never selected
   as the beachhead and is never pursued elsewhere in the plan. This is content about a *candidate's
   résumé qualification for an unpursued segment*, not evidence the business itself handles PHI —
   but it contains the literal keyword "HIPAA."

I navigated both correctly by reading the content in context (whose activity is actually being
described, and is it the pursued beachhead or a surveyed-and-rejected alternative) rather than
pattern-matching on the keyword list, and confirmed via the review file's rationale section that the
trigger correctly did not fire. But the trigger's own specification doesn't instruct this
distinction — it says to check for "mentions of" the listed categories, which reads as a presence
check, not a check for whether the mention describes the business's *own actual, pursued* activity.
A less careful execution of this trigger (or a genuinely mechanical keyword-grep implementation, as
opposed to an LLM agent exercising judgment) would misfire on either case above, potentially bumping
`services-unit-economics-reviewer` out of the contextual seat for a business that is, by its own
explicit statement, not regulated. **Fix:** add one line to the trigger's specification: "A keyword
match only counts if it describes the business's own actual or pursued activity (the selected
beachhead, the chosen business-model archetype, the actual product/service being delivered) — not a
candidate/customer characteristic in a surveyed-and-rejected segment (Step 1 necessarily lists these
by design), and not a sentence that explicitly negates the regulated attribute rather than
asserting it." **Severity: significant** — real, demonstrated on real fixture text (not
hypothetical), and the consequence of a misfire is concrete (a wrong contextual seat for the entire
review).

### 4.3 — Significant: the outlier tag-overlap check is syntactic (exact tag match), not semantic —
demonstrated, real case where a substantively-corroborated REVISE was discarded as an "uncorroborated"
outlier

**File:** `skills/business-plan/run-review-council/SKILL.md`, §6 (outlier test, condition 2).

Ran this for real (see `reviews/2026-08-18-bootstrap-track-panel-v1.md`'s full aggregation
accounting). `expert-entrepreneur-panel`'s REVISE flagged that the associate-recruiter hiring plan
names no actual channel for sourcing the candidate (`[EXECUTION-RISK]`).
`services-unit-economics-reviewer`'s APPROVE_WITH_NOTES independently flagged, in substance, the
same underlying theme — whether the capacity-scaling plan can actually be executed as described —
via two `[DELIVERY-CAPACITY]` findings (a capacity-ceiling arithmetic inconsistency, and an
uncounted guarantee cost). These are two independent panelists converging on the same real concern
(can this hiring-based scaling plan actually work) through two legitimately distinct, correctly-
scoped rubric lenses — but because their specific findings used different tags
(`[EXECUTION-RISK]` vs. `[DELIVERY-CAPACITY]`), the mechanical overlap check in §6 condition 2 (which
checks literal tag-string presence in other reviewers' tag sets) found no overlap, and
`expert-entrepreneur-panel`'s REVISE passed all three outlier tests and was **discarded**. The
aggregate landed at `APPROVE_WITH_NOTES` (score 7) instead of `REVISE` — a materially different
real-world outcome, since it drives `stage` to `"approved"` rather than `"revising"`, meaning
Non-negotiable #3's mandatory-revision gate is never engaged for this concern.

To be clear about what this is *not*: nothing is hidden. The discarded verdict is shown in full
earlier in the file, per the "no verdict ever hidden" rule, and I wrote it up explicitly in both the
Aggregation accounting section and a `### Discarded-but-real concerns` subsection (per §8.4's own
required format), plus a severity-independent `### Also flagging, regardless of severity` note. This
is the same shape of gap round 2's finding 4.1 and round 3's finding 4.3 already identified
(findability, not concealment) — but this is a **new mechanism** producing it: those rounds' cases
were about *severity-based* checklist exclusion; this one is about the *outlier-discard test itself*
failing to recognize substantive corroboration because it checks tag identity, not tag meaning.
**Fix:** either (a) instruct the executing agent, when computing the tag-overlap check, to also
consider whether two reviewers' *prose* (not just tags) describes the same underlying finding even
under different tags — a semantic check layered on top of the mechanical one — or (b) if that's too
subjective to specify reliably, at minimum instruct that a discarded verdict whose Risks/gaps
prose substantively overlaps another surviving reviewer's finding (even under a different tag)
must be named explicitly in the `Discarded-but-real concerns` subsection with that specific
cross-reference called out, not just listed as a generic one-liner. **Severity: significant** — real,
demonstrated, affects the actual `stage` transition (not just a cosmetic checklist), but doesn't rise
to blocking because nothing is silently concealed and the required write-up sections did surface it
for a human reader.

### 4.4 — Significant: §8.4's "synthesized Required revisions" instruction has no defined content
when the aggregate verdict itself is `APPROVE_WITH_NOTES`

**File:** `skills/business-plan/run-review-council/SKILL.md`, §8.4.

Neither round 2 (aggregate: REVISE) nor round 3 (aggregate: REJECT) exercised this case — my
aggregate landed at `APPROVE_WITH_NOTES`, and §8.4 instructs building the Aggregate Verdict's
checklist as "the union of every required-revision item from every reviewer whose verdict counted
toward the aggregate severity." But per `CONVENTIONS.md` §6's own schema, a `Required revisions`
section is only part of a verdict's shape "if REVISE or REJECT" — an `APPROVE_WITH_NOTES` verdict
has no such section at all, by design (it has Strengths and Risks/gaps only). When the aggregate
severity itself is `APPROVE_WITH_NOTES`, every reviewer at that severity therefore has *zero*
Required-revisions items to union, by the schema's own construction — the instruction's literal
content is empty. I resolved this pragmatically in my review file (unioning the surviving reviewers'
Risks/gaps bullets into a "Notes to consider" list instead, labeled explicitly as an improvised
resolution) rather than leaving the Aggregate Verdict section broken or silently reusing the REVISE/
REJECT-shaped heading over empty content. **Fix:** add an explicit branch to §8.4: when the aggregate
severity is `APPROVE`/`APPROVE_WITH_NOTES`, the synthesized section should be headed differently
(e.g. "Notes to consider," not "Required revisions") and built from the union of the surviving
reviewers' Risks/gaps bullets instead — this is a small, mechanical addition, but without it the
skill's own instruction is genuinely ambiguous about what to do at this severity, which is a real
gap only a bootstrap-track-shaped, evidence-strong plan (the exact profile this round's business
was designed to have) would ever surface. **Severity: significant** — a real spec gap, not
previously exercised by either prior round, with a concrete, low-cost fix.

### 4.5 — What worked well: Track A's `vc-panel`-downgrade-to-informational mechanism, exercised live
for the first time across all three rounds, worked exactly as specified

Neither round 2 (Track C) nor round 3 (Track B) exercised `run-review-council` §4's Track A weighting
rule — the one that downgrades `vc-panel` to informational when its verdict is 100%
`[VENTURE-FIT]`-tagged. This round did, for real: `vc-panel` correctly REJECTed Vantage Point Search
on pure venture-scale-fit grounds (a services business with a headcount-linear growth model is,
per `vc-panel`'s own rubric, "the case most likely to earn a `[VENTURE-FIT]`-only REJECT even when
everything else about it is sound" — and it said so plainly, exactly as its own file instructs),
tagged every bullet `[VENTURE-FIT]` and nothing else, and was correctly excluded from the blocking
set per §4, correctly not driving the aggregate severity. This is the mechanism working exactly as
`CONVENTIONS.md` §7 and the skill's own design intent describe — a real bootstrap-intent founder's
plan doesn't get blocked by a lens that was never the right one for what they're trying to build —
confirmed live, for the first time, this round.

### 4.6 — What worked well: seat-selection and tie-break logic, re-run against substantially rewritten
mid-session logic, produced the identical correct outcome

Confirmed directly: even though `run-review-council/SKILL.md`'s §3 was rewritten around two new
personas and a new highest-priority tier mid-session, re-running the current procedure in full for
Vantage Point Search reproduced exactly the outcome the pre-change logic would have produced —
`services-unit-economics-reviewer` selected, `sales-motion-reviewer` the logged runner-up (per
Step 12's genuine DMU complexity — a comp-committee veto confirmed on 2 of 6 real closed
engagements). The new tiers did not regress the existing services-business behavior. See §4.2 above
for the one real gap this exercise surfaced in the *new* trigger's own specification.

---

## 5. Founder-capacity stress test — the central question this round exists to answer

Restating the answer plainly, since it's the round's headline ask: **yes, the plan's Step 17 LTV,
Step 19 COCA, and Step 24 roadmap genuinely account for the fact that a services business can't
scale revenue without scaling headcount, and this holds up under independent scrutiny at every
layer this round tested** — the individual DE steps (§1.4), the assembled plan's own framing
(§2.4's polish note aside), and the review council's dedicated persona (§4.1) all converge on the
same honest picture: strong per-engagement unit economics that say nothing about growth, because
growth was never gated by customer acquisition in this business — it's gated by delivery hours. The
plan states this explicitly, in its own words, rather than requiring a reviewer to infer it, and the
review council's aggregate verdict credits exactly that honesty as a strength while still flagging
the two real, nameable gaps (the uncounted guarantee cost, the capacity-ceiling arithmetic
inconsistency) that remained. This is round 3's services-specific work functioning as designed, on
an independent business, under independent (and adversarial, self-critical) drafting.

---

## 6. Round 2 and round 3 fixes — confirmed or refuted, item by item, from this third independent run

| Prior finding | This round's independent check | Result |
|---|---|---|
| R2 1.1 — orchestrator's "approved" vs "drafted" stage-diagram contradiction | Re-read `agents/orchestrator.md`'s state machine and Phase 2 body directly | **Confirmed fixed**, unchanged from round 3's confirmation — no step ever promoted past `drafted`; all 24 of my steps sat there correctly. |
| R2 1.3 / R3 3.2 — `plan.version` skeleton default trap | Created Vantage Point Search's skeleton per current guidance | **Confirmed fixed**, third round running. |
| R2 2.1 / R3 3.1 — missing `Confidence & Validation Status` section | Assembled `plan/business-plan.md` per current instructions | **Confirmed fixed**, third round running; gate exercised this check live and passed cleanly. |
| R2 §3 / R3 §2 — Steps 04/14/16/17/19 gate wiring + onboarding privacy notice | Drafted all five gated steps; ran the gate live; ran the real onboarding interview | **Confirmed fixed and working**, third round running — one real BLOCKED→fix→PASS cycle this session (§3 above), privacy notice delivered and logged correctly. |
| R3 1.3 — Steps 17/18 zero marketplace branching (blocking) | Read Steps 17/18/19's current state before drafting against them for services | **Confirmed fixed, and confirmed the fix generalized** — the same fix that closed the marketplace gap gave services a full, distinct, independently-followable treatment too (§1.1 above). |
| R3 1.4 — Step 4's TAM sanity-check heuristic not adjusted for marketplace GMV vs. take-rate revenue | Read Step 4's current state, drafted against its services guidance | **Confirmed fixed, and confirmed the fix generalized to services** — the same pass added an explicit "TAM assumes unlimited delivery capacity" caveat for services (§1.3 above). |
| R3 4.2 — vacuous "Steps 10/11 not yet approved" clause in `competitive-strategy-reviewer`'s trigger (blocking) | Re-read the current §3 rule #6 (renumbered from R3's #5) | **Confirmed fixed and holding** — still reads the real content-based signal R3's fix introduced, not a status check; renumbering from the mid-session rewrite did not regress this fix. |
| R3 4.1 — discarded-outlier findings and R3 4.3 — severity-gated checklist omissions | Ran a real 5-verdict aggregation that hit both patterns again, plus a new one | **Same root-cause family confirmed still present, in a third distinct shape** — this round's §4.3 (tag-overlap check misses substantive-but-differently-tagged corroboration) and §4.4 (undefined content when the aggregate is `APPROVE_WITH_NOTES`) are new, freshly-discovered instances of "the aggregation/synthesis layer can under-surface a real concern," not previously-reported bugs recurring identically. |
| R2 1.4 — Steps 04/11/14's "use WebSearch" has no enforcement | Did not attempt WebSearch this session either, matching both prior rounds' approach | **Not independently re-tested**, same as round 3's note — the honest-fallback discipline held (every unsourced figure got a `key_assumptions`/`quantitative_claims` entry) but the underlying enforcement gap itself wasn't specifically probed a third time. |

**New this round, not a re-test of a prior finding:** §1.2 (Step 18's referral-driven background-
time template gap), §2.4 (LTV:COCA reconciliation instruction silent on healthy-but-capacity-
constrained ratios), §4.2 (regulated-industry trigger's literal-keyword false-positive risk).

---

## What actually worked well

- **Round 3's services-specific work is real and holds up completely independently** — this is the
  single most important result of this round. Every DE step's services branching was specific and
  immediately usable; the founder-capacity thread runs coherently through Steps 14/15/17/19/22/24
  exactly as intended; `services-unit-economics-reviewer` surfaced genuinely services-specific
  findings (delivery-capacity ceiling arithmetic, uncounted guarantee cost) that no other panelist's
  rubric could have caught, confirmed by direct comparison — the same bar round 3 set for
  `marketplace-liquidity-specialist` and met here for services.
- **The AI-risk gate is genuinely load-bearing a third consecutive independent time**, and this
  round's specific instance (COCA false precision) is the same underlying failure mode both prior
  rounds hit at different steps — strong evidence this is a real, structurally-expected pattern the
  gate reliably catches, not a fluke.
- **The plugin absorbed its largest mid-session change yet (two new council personas, a rewritten
  and renumbered seat-selection tier structure) without regressing an already-working business type's
  behavior** — re-running the current seat-selection logic for a services business reproduced the
  identical, correct outcome the pre-change logic would have produced. This is round 2's and round
  3's "the plugin survives live concurrent editing" result holding a third time, under a bigger
  change than either prior round saw.
- **The Track A (`vc-panel`-downgrade) weighting mechanism, exercised live for the first time across
  all three rounds, worked exactly as specified** — a real bootstrap-intent founder's plan was
  correctly not blocked by a venture-fundability lens that was never the right one for what they're
  building, while every other seat's scrutiny remained fully blocking.
- **Cross-step reconciliation caught a third, genuinely distinct pattern** (TAM/LTV double-counting
  across Steps 4/14/17, not a pricing mismatch or a two-sided-LTV gap) — the reconciliation
  discipline generalizes to new problem shapes, not just replaying known-good patterns.
- **`docs/DATA-CONTRACT.md`'s persona-coverage table was kept in sync with the same-session council
  rewrite** — confirmed the two new personas and the renumbered tie-break logic are both accurately
  reflected there, closing exactly the kind of documentation-drift gap `docs/DATA-CONTRACT.md`'s own
  header warns against.
- **The honest-fallback and vague-answer disciplines held for a fourth business type shape**
  (`already_operating`, not `idea_only` or `pivoting`) — real operating history didn't tempt a
  drift toward overconfidence; every founder-estimate figure (TAM, turnover rate) stayed honestly
  low-confidence and flagged even though real revenue data existed elsewhere in the same plan to
  potentially lend it false credibility.
