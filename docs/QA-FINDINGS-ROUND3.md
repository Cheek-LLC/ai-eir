# QA Findings — Round 3: Second Independent End-to-End Dry Run (Marketplace)

**Method.** I role-played the `startup-operator` orchestrator agent against a fake founder, Derek
Osei, and his business **SkyClaim** — a two-sided marketplace connecting FAA Part 107-certified
drone pilots (supply) with storm-damage insurance-claim roofing contractors (demand) across the
TX/OK Hail Alley corridor, so a contractor can summon a vetted pilot to deliver an insurance-ready
roof inspection within 24 hours of a hailstorm. Unlike round 2's ShiftCover (B2B SaaS, `idea_only`),
SkyClaim is deliberately a **marketplace**, `pivoting` from an already-operating single-operator
business — chosen specifically to stress-test this round's business-type-branching work and the
new marketplace council persona on a business type round 1/2 under-served, and to exercise a
`venture_stage`/evidence pattern (real prior operating history) round 2 didn't hit. I ran the real
onboarding interview per `skills/interview/onboarding-interview/SKILL.md`, drafted all **24** DE
steps for real (re-reading each step's SKILL.md immediately before drafting against it, since other
agents were actively editing them), assembled `plan/business-plan.md` via `skills/business-plan/
assemble-business-plan`, ran the mandatory AI-risk gate live and repeatedly (it correctly
**BLOCKED** three times on real false-precision/unsourced-claim findings this session, across two
different DE steps and the assembled plan itself, and correctly **PASSED** after each fix), then
ran `skills/business-plan/run-review-council` for real — a full 5-seat venture-track panel, working
the aggregation algorithm by hand. Every artifact is a real file under `.startup/skyclaim/` —
nothing here is a hypothetical description of what a run would produce.

**A live-editing complication, hitting me the same way it hit round 2.** `run-review-council/
SKILL.md` and `agents/council/` were being actively patched by other round-3 agents while I worked
— specifically, `marketplace-liquidity-specialist.md` and `services-unit-economics-reviewer.md`
(the two personas this round was explicitly building) **did not exist yet when I first reached the
council step**, and `run-review-council/SKILL.md`'s own seat-selection trigger list had no clause
referencing either one. Per this round's instructions, I noted this explicitly rather than
blocking, drafted the panel with the pre-existing `competitive-strategy-reviewer` as the 5th seat,
and kept working. **Both landed in the repo before I finished the rest of the review.** I re-read
the current files, re-ran the seat-selection procedure against the live logic, confirmed
`marketplace-liquidity-specialist` now triggers correctly and cleanly for a `marketplace` business,
rewrote that one persona's verdict for real against SkyClaim's actual plan content, and re-checked
that the aggregate outcome still held. The full before/after is documented in the Review Council
section below, including one aspect of the new trigger logic that landed with a real,
previously-unflagged bug in it (see 4.2).

**Fixture disposition.** `.startup/skyclaim/` is left in place as a real worked example:
`business-state.json`, `interview-log.md`, all 24 `plan/NN-slug.md` files, `plan/business-plan.md`,
and one full review file under `reviews/`. It ends at `stage: "revising"` (the council returned
REJECT) — a real, non-trivial state a fixer can pick up from. Six `risk_log` entries document the
real privacy notice and five real AI-risk gate findings from this session (two `mitigated`, three
`open`/advisory), plus a full accounting of exactly why the aggregate verdict landed where it did.

---

## 1. Disciplined Entrepreneurship steps — marketplace branching, step by step

**Overall verdict: the dual-sided guidance (separate supply/demand profiles, a `Side` column on
the next-10 table, per-side DMU) is real and it held up end to end for a real two-sided business —
with two significant, concrete exceptions.** 19 of the 24 step skills I drafted against have
marketplace-specific guidance that is present, specific, and — critically — actually usable when
you sit down and try to draft real content against it, not just aspirational prose (Steps 20, 21,
24 correctly have no branching, since they're business-type-agnostic audit/roadmap steps by
design — not a gap).

### 1.1 — Present and good (19 of 24 steps)
Steps 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19, 22, 23 all have marketplace branching
that is specific, actionable, and internally consistent with each other. Concrete evidence this
actually works, not just reads well:
- Step 1's "brainstorm supply and demand separately" instruction, combined with its table's `Side`
  column, produced a real 13-segment list (6 supply, 7 demand) with genuinely distinct axes per
  side (`.startup/skyclaim/plan/01-market-segmentation.md`).
- Step 9's `Side` column and "must include both sides" instruction produced a real, honestly-mixed
  10-prospect table (5/5 split, 8 of 10 actually contacted) that surfaced a genuine, business-
  specific finding: demand is *this founder's* stronger network, the inverse of the general
  marketplace pattern Step 5's own guidance describes (`plan/09-identify-your-next-10-customers.md`).
- Step 12's explicit "for a marketplace, complete one full table per side" instruction is the
  best-scaffolded of any dual-sided step in the plugin — I produced two genuinely independent DMU
  tables (supply collapses to 1 role; demand has 2-3 roles plus an external carrier veto-holder)
  with zero ambiguity about how to structure the output (`plan/12-determine-the-dmu.md`).
- Step 4's "size from whichever side is the binding constraint, and say explicitly which" produced
  a real, load-bearing finding: SkyClaim's supply-constrained TAM (≈$880K/year) is roughly 4x
  smaller than its non-binding demand-side theoretical ceiling (≈$23M/year) — a genuinely
  consequential number that shaped the entire rest of the plan and the council's REJECT verdict.

### 1.2 — Present but thin: the template doesn't scaffold what the prose requires (Step 3)
**File:** `skills/disciplined-entrepreneurship/03-build-an-end-user-profile/SKILL.md`.

The prose instruction is explicit and correct: "write two profiles, not one, and carry both
forward into Steps 4 and 5." But the `Write plan/03-...md` template block right below it provides
only a single "Profile dimensions" table with no second slot — unlike Step 12's template, which
explicitly says "for a marketplace, complete one full table per side." I had to notice the gap
myself, duplicate the table structure, and label the two instances "Supply-side profile" /
"Demand-side profile" by improvisation, not by following a template that showed me how
(`plan/03-build-an-end-user-profile.md`, see its own header note documenting this explicitly).
**Fix:** add the same explicit "one full table per side" scaffold Step 12 already has, right next
to Step 3's template block. **Severity:** significant leaning polish — the prose instruction is
good enough that a careful drafter (or agent) gets the right output anyway, but a less careful one
easily wouldn't, and the fix is a two-line change once the pattern from Step 12 exists to copy.

### 1.3 — Blocking: Steps 17 (LTV) and 18 (sales process costing) have zero marketplace branching, and this produces a real, demonstrated cross-step gap in Step 19

**Files:** `skills/disciplined-entrepreneurship/17-calculate-the-ltv-of-a-customer/SKILL.md`,
`skills/disciplined-entrepreneurship/18-map-the-sales-process-to-acquire-a-customer/SKILL.md`,
`skills/disciplined-entrepreneurship/19-calculate-the-coca/SKILL.md`.

Confirmed by grep — zero mentions of "marketplace" in Step 17 or Step 18's SKILL.md, in sharp
contrast to every other money-making-theme step (Steps 14, 15, 16, 19 all have explicit, good
marketplace guidance). This isn't a cosmetic gap; I hit it directly and it produces a real,
demonstrated inconsistency three steps deep:

- **Step 19's own marketplace guidance is explicit and correct**: "Cost supply-side and demand-side
  acquisition **separately**... a single blended 'marketplace COCA' hides which side is actually
  expensive." I followed this and produced two real COCA figures: demand-side ≈$300/contractor,
  supply-side ≈$225/pilot.
- **Step 19 also instructs**: "compare Step 17's LTV to this step's COCA" — singular, assuming one
  LTV and one COCA. But **Step 17 has no marketplace guidance at all**, so it gave me no
  instruction for how to handle a two-sided "customer." I had to improvise a scope decision
  (demand-side-only LTV) unprompted by the file.
- **The result, worked out concretely in `plan/19-calculate-the-coca.md`**: the demand-side
  comparison works cleanly (LTV ≈$3,750 / COCA ≈$300 ≈ 12.5:1, a healthy-looking ratio). But the
  supply-side COCA (≈$225/pilot) has **no LTV to compare against at all** — under Step 17's
  standard formula (ARPU × margin × lifetime), a marketplace supply-side participant who is *paid
  by* the business rather than paying it has no representable positive LTV. This is reported as
  N/A rather than forced into a number, which is the right call given no instruction exists — but
  it means a founder or investor who reads only the flattering 12.5:1 ratio gets half the picture,
  and nothing in Steps 17-19 as currently specified tells them that's what's happening. The council
  review I ran independently confirmed this is a real, material gap: `financial-modeling-reviewer`
  flagged it as their headline finding, and it's arguably the most consequential single finding on
  the whole 5-persona panel (see §4 below).
- **Step 18 has the parallel problem**: it instructs "reuse Step 13's stages verbatim," but Step 13
  explicitly produces **two** parallel stage lists for a marketplace (confirmed — Step 13 does have
  correct marketplace branching), and Step 18 gives zero instruction on whether to cost one shared
  process or two separate ones. I produced two tables as the more honest choice, but this was my
  own improvisation, not something the file told me to do.

**Fix:** add marketplace branching to Step 17 explicitly addressing the two-sided-LTV question —
at minimum, instruct computing LTV for whichever side directly pays the marketplace (usually
demand), and require an explicit note (not silence) that the other side has no comparable LTV
figure under the standard formula, with a pointer to what a supply-side sustainability metric could
look like instead (I improvised "cost-per-fulfilled-job-enabled" as a placeholder; the actual DE
step should decide the real answer). Add the equivalent one-line instruction to Step 18: "for a
marketplace with two Step 13 processes, cost both separately, per Step 19's own requirement — do
not blend them into one table." **Severity: blocking.** This isn't a documentation nicety — it's a
real, demonstrated single-point-of-failure in the plugin's core promise (no invented/incomplete
numbers reach a founder unlabeled): every marketplace business that runs Steps 17-19 as currently
written will produce an incomplete unit-economics picture, and nothing in those three steps' own
"Definition of done" checks catches it. The downstream AI-risk gate and council review both caught
it in my session (see §3 and §4) — but that's exactly the single-point-of-failure pattern round 2's
finding 2.2 already warned about, now demonstrated independently, on a different step, for a
different business.

### 1.4 — Significant: Step 4's beachhead-TAM sanity-check heuristic doesn't specify GMV vs. take-rate revenue for marketplaces, and this produces a spurious "too small" signal

**File:** `skills/disciplined-entrepreneurship/04-calculate-the-tam-for-the-beachhead-market/
SKILL.md` (the "Sanity check" section and its stated heuristic: "a workable beachhead TAM is
typically in the tens to low hundreds of millions of dollars per year").

This step's own marketplace guidance is otherwise excellent (size by GMV × take rate, not per-seat
— confirmed correct and confirmed independently re-derived correctly by both
`financial-modeling-reviewer` and `marketplace-liquidity-specialist` in my council review). But the
sanity-check heuristic that follows it doesn't say whether that dollar range should be checked
against GMV or against the take-rate revenue figure the step's own formula is designed to produce.
I hit this directly: SkyClaim's demand-side GMV ceiling (≈$23M/year) is a plausible, if modest,
market — but the step's own required output (take-rate revenue, ≈$880K/year at an 18% rate) is an
order of magnitude below the heuristic's lower bound, purely because a take-rate business's
*revenue* is structurally a fraction of its *GMV* in a way a SaaS ACV figure isn't. Applying the
same heuristic to both business shapes without adjustment will make nearly any early-stage
marketplace's correctly-computed beachhead TAM look disqualifying, independent of whether the
underlying market is actually healthy. **Fix:** either state the heuristic in GMV terms for
marketplaces specifically (with take-rate revenue as a separate, expected-to-be-smaller number), or
add an explicit marketplace-specific range/caveat next to the existing heuristic. **Severity:
significant** — this is a real methodology gap that produced a real, load-bearing false signal in
my session (I flagged it explicitly in the plan rather than let it silently read as disqualifying,
but the step itself gave me no way to know whether that flag was warranted or whether I was missing
something).

---

## 2. AI-risk gate — confirmed working, live, repeatedly, in a second independent run

**This is unambiguous good news, and I want to state it plainly before the more critical findings.**
Round 2 found the mandatory per-step gate (Steps 04/14/16/17/19) and the mandatory onboarding
privacy notice were both **entirely unwired** — a founder following the plugin exactly as specified
would never encounter either. I confirmed, independently and directly, that **both fixes hold**:

- **All five DE steps (04, 14, 16, 17, 19) now have the "Mandatory AI-risk gate" section**,
  confirmed present by grep in every one, and I actually **called it live, three separate times,
  and it worked correctly all three times**:
  1. Step 4 (`plan/04-calculate-the-tam-for-the-beachhead-market.md`): first pass **BLOCKED** on
     genuine false precision (an exact-dollar TAM figure built from a chain of low-confidence
     estimates). Fixed by rounding to order-of-magnitude. Re-ran: **PASS**.
  2. Step 17 (`plan/17-calculate-the-ltv-of-a-customer.md`): same false-precision failure mode,
     independently caught and fixed the same way. Re-ran: **PASS**.
  3. `plan/business-plan.md` at assembly time (`assemble-business-plan`'s own §7.5 gate): **BLOCKED**
     on a genuinely unsourced claim — Step 23's "≈78% legacy rebooking rate" was stated as fact in
     prose with no matching `quantitative_claims` entry. This is the *exact same failure mode*
     round 2's finding 2.2 documented for a different step (17, on ShiftCover) — it recurred here
     independently, on a different step (23), on a different business, which is itself confirming
     evidence for round 2's underlying diagnosis: a step's "Definition of done" is a prose
     instruction an agent under momentum can still slip past, and the downstream gate remains the
     real backstop. Fixed by adding the missing entry. Re-ran: **PASS**.
- **The onboarding privacy notice (Mode A) is now actually called.** I confirmed
  `skills/interview/onboarding-interview/SKILL.md` has a "Mandatory privacy notice" section
  instructing the call, placed correctly (after business-basics capture, before the business-type
  framing questions), and I ran it for real during SkyClaim's interview — Derek heard the
  local-storage/legal-scope notice, and it was logged to `risk_log` as
  `privacy-onboarding-skyclaim` exactly once, per spec.

No new gap found in the gate-wiring layer itself. See §5 for full round-2-fix-by-fix confirmation.

---

## 3. Business-plan assembly

### 3.1 — Confirmed fixed: `Confidence & Validation Status` section
Round 2 found neither `assemble-business-plan/SKILL.md` nor `agents/business-plan-editor.md`
instructed writing this mandatory section, guaranteeing every business's first plan assembly would
fail the AI-risk gate. Confirmed fixed in both files (§7 of `assemble-business-plan` now explicitly
names it; `business-plan-editor.md`'s own section-structure list includes it). I wrote the section
in full for `plan/business-plan.md`, and — separately — the plan-assembly gate call (§2 finding
above) confirms the gate actually checks for it in practice, not just that the instruction exists.

### 3.2 — Confirmed fixed: `plan.version` skeleton default
Round 2 found `docs/DATA-CONTRACT.md`'s literal "starts at 1" language was a trap for skeleton
creation. Confirmed fixed: the current text explicitly states `null`/absent is the correct
pre-assembly default and explains why. I followed this directly — SkyClaim's skeleton was created
with `plan.version: null`, and `assemble-business-plan`'s own precondition worked correctly against
that value (no false "a plan already exists" misfire).

### 3.3 — What worked well: cross-step reconciliation, again, on a different pattern
Round 2 found the reconciliation logic caught a real planted Step 4/Step 16 pricing inconsistency.
I didn't plant an equivalent bug this round (SkyClaim's Step 4/16 pricing is consistent by
construction), but the *required* reconciliations in `assemble-business-plan/SKILL.md` §3 (Steps
13+18, TAM 4-vs-14, LTV:COCA 17-vs-19) forced a genuinely useful synthesis in `plan/business-plan.md`
Section 4 — specifically, writing out the LTV:COCA reconciliation is what made the Steps 17-19
marketplace gap (§1.3 above) fully explicit and legible in the assembled plan rather than buried
across three separate step files. The reconciliation requirement is doing real work, independent
of whether there's a "planted" bug to catch — it surfaced a genuine, unplanted structural gap this
time.

---

## 4. Review council

### 4.1 — What worked well: the seat-selection and aggregation logic, worked by hand, twice (once under stale logic, once under the corrected live logic)
I want to be direct about this: **I worked through `run-review-council`'s seat-selection procedure
twice for the same business**, once against the pre-update logic (which correctly selected
`competitive-strategy-reviewer` under the rules that existed at that moment) and once against the
logic that landed mid-session (which correctly selected the new `marketplace-liquidity-specialist`).
**Both runs were internally correct against the rules that existed at the time I ran them** — this
is exactly the kind of live-editing resilience round 2's own report praised, now demonstrated a
second time. The aggregation algorithm (outlier discard, tag-overlap corroboration test, harshest-
non-outlier rule) also worked correctly by hand a second time, on a genuinely different worked
example than round 2's: a lone REJECT (`vc-panel`) survived the outlier test specifically because
its `[MARKET-SIZE]` tag overlapped with a softer-severity reviewer's (`customer-discovery-skeptic`,
REVISE) — a case the skill's own §6 worked examples describe but that round 2's actual run didn't
happen to hit. See `reviews/2026-08-18-venture-track-panel-v1.md`'s "Aggregation accounting"
section for the full worked mechanics.

**And the new `marketplace-liquidity-specialist` persona itself is a genuinely good addition, not
just a checkbox.** Its verdict surfaced a real finding — **disintermediation risk** (nothing in
SkyClaim's plan names why a matched pilot and contractor wouldn't just transact directly next time
and cut the take rate out entirely) — that **no other panelist, including the previously-used
`competitive-strategy-reviewer`, raised in any form**. I confirmed this by comparing both drafted
verdicts directly: `competitive-strategy-reviewer`'s general core/moat rubric asks about structural
defensibility broadly but has no specific prompt for the two-sided-specific disintermediation
pattern; `marketplace-liquidity-specialist`'s rubric does, by name, in its Step 15 checklist. This
is exactly the gap this round's persona work was meant to close, and on this evidence, it closes it
for real.

### 4.2 — Blocking: the new §3 trigger logic still carries a vacuous, unconditionally-true clause, inherited from before this round's rewrite and not fixed by it

**File:** `skills/business-plan/run-review-council/SKILL.md`, §3, current rule #5
(`competitive-strategy-reviewer`, now the fallback default): "Also use this instead of #3/#4
whenever Steps 10/11 are not yet `approved`."

I checked this directly against `agents/orchestrator.md`'s own explicit, repeatedly-stated design:
**no `disciplined_entrepreneurship.NN_slug.status` value is ever promoted past `drafted` by any
skill in this plugin** — confirmed by SkyClaim's own `business-state.json` (Steps 10 and 11 both
sit at `status: "drafted"`, same as every other step, same as every step in round 2's ShiftCover
fixture). If that's correct — and both the orchestrator's own prose and every real fixture I've
seen confirm it is — then **the condition "Steps 10/11 are not yet `approved`" is unconditionally
true for every business this plugin will ever review, forever.** It never actually depends on the
business's real state.

**Concrete consequence, worked through for real:** for SkyClaim, this doesn't change the outcome
(rule #2, `marketplace-liquidity-specialist`, fires first on the `business_type` match and the
"first that triggers" procedure stops there before rule #5 is ever reached) — so this specific
review's seat selection is not in question. But for any `saas`, `consumer_app`, or hardware-free
`physical_product` business, rules #3 (`sales-motion-reviewer`) and #4 (`product-market-fit-panel`)
would have their legitimately-firing triggers **silently overridden by rule #5 every single time**,
since the OR-condition rule #5 is chained to can never evaluate false. This is not a hypothetical
reading — I confirmed the same clause (then numbered differently, as rule #4's second clause)
existed **before** this round's rewrite too, meaning this bug has now survived a full rewrite of
the surrounding logic untouched. Notably, round 2's own review of ShiftCover (`saas`, Steps 10/11
also `status: "drafted"`) selected `sales-motion-reviewer` as the 5th seat and never mentioned this
clause at all — either it postdates round 2's read of the file, or it was missed; either way, it's
real and live now. **Fix:** either remove the "Steps 10/11 not yet approved" clause entirely (since
it can never be false, it adds no real conditionality — see the note already added to `rule #5`'s
own text acknowledging the marketplace case is now "superseded," which stops short of noticing the
approval-status half is *never* true, not just superseded for marketplaces), or replace it with a
condition that can actually vary by business (e.g., checking whether Step 10/11's own content is
thin — a low-confidence `key_assumptions` count, or an explicit "no Core yet" finding — rather than
a status value the state machine design has already ruled out). **Severity: blocking** — this
silently defeats two of the five seat-selection triggers this round's other work presumably
depends on functioning correctly, for the majority of business types this plugin serves (everything
that isn't `marketplace` or `services`, both of which now have their own higher-priority
type-level trigger).

### 4.3 — Significant: the Aggregate Verdict checklist can omit a panel's single most consequential finding when that finding sits at a softer severity than the aggregate

**File:** `skills/business-plan/run-review-council/SKILL.md`, §8.4.

This extends round 2's finding 4.1 (which was about *discarded* outliers disappearing from the
checklist) with a related but distinct case round 2 didn't hit: a verdict that **survives** the
outlier test specifically *because* a softer-severity reviewer's tag corroborates it — but that
softer-severity reviewer's own required-revisions still don't make the synthesized checklist,
because §8.4's literal rule only unions items from reviewers *at* the final aggregate severity.
Concretely, in my review: `marketplace-liquidity-specialist`'s disintermediation-risk finding sits
at APPROVE_WITH_NOTES (severity 2), while the aggregate verdict is REJECT (severity 4, held alone
by `vc-panel`). Per the literal rule, the synthesized checklist contains only `vc-panel`'s three
items — `marketplace-liquidity-specialist`'s finding, which I judged (and stated explicitly in the
review file) to be **arguably the single most consequential finding on the entire five-persona
panel** (it undermines the LTV assumption every other unit-economics figure depends on), is absent
from the one section a busy founder is most likely to treat as the actual action list. Nothing is
hidden (every verdict is written in full, per the skill's own "never hidden or truncated" rule) —
but findability and prominence are not the same thing, and this is exactly the gap round 2's 4.1
already identified in a different shape. **Fix:** consider a severity-independent "most
consequential finding" callout in the Aggregate Verdict section, separate from the severity-driven
Required Revisions union — something like "Also flagging, regardless of severity: <finding>,
raised by <persona> — not part of the aggregate-severity checklist above, but worth a founder's
attention on its own merits." **Severity: significant** — the math is right, and nothing is
concealed, but the information architecture can still bury a panel's sharpest single finding behind
a severity threshold that has nothing to do with how consequential the finding actually is.

---

## 5. Round 2 fixes — confirmed or refuted, item by item, from this second independent run

| Round 2 finding | This round's independent check | Result |
|---|---|---|
| 1.1 — orchestrator's stage diagram self-contradicted on "approved" vs "drafted" | Re-read `agents/orchestrator.md`'s state-machine diagram and prose directly | **Confirmed fixed.** Diagram and prose now consistently say `drafted` is the real, sufficient gate; explicit statement that no step is ever promoted to `approved`. |
| 1.3 — `plan.version` skeleton default trap | Created SkyClaim's skeleton per current `DATA-CONTRACT.md` guidance | **Confirmed fixed.** `null` default stated explicitly; `assemble-business-plan` worked correctly against it. |
| 2.1 — missing `Confidence & Validation Status` section | Assembled `plan/business-plan.md` per current `assemble-business-plan`/`business-plan-editor` instructions | **Confirmed fixed.** Section instructed in both files, present in the real output, and its absence-check is what the gate actually exercises (confirmed live at §3.1). |
| §3 — Steps 04/14/16/17/19 missing gate wiring | Drafted all five steps; gate section present in every one; called it live 3 times | **Confirmed fixed**, and confirmed *working*, not just present — real BLOCKED→fix→PASS cycles happened twice at the step level. |
| §3 — onboarding missing the privacy notice call | Ran the real onboarding interview | **Confirmed fixed.** Mode A called once, logged, at the correct point in the flow. |
| `funding_intent` field (added around round 2) | Onboarding interview asked the funding-intent question per spec; council's §2 step 1a read it correctly | **Confirmed working.** Derek's `raising_outside_capital` signal was captured cleanly, used correctly by `run-review-council` for track assignment, and never conflated with `gtm.funding_strategy`. |
| 4.1 — discarded outliers' Required-revisions disappear from the synthesized checklist | Ran a real 5-verdict aggregation with a *surviving* (not discarded) harsh verdict whose corroboration came from a softer-severity reviewer | **Related gap confirmed still present**, in a new shape — see 4.3 above. Not the identical case round 2 found (nothing was discarded this round), but the same root cause (severity-gated checklist inclusion) produces an analogous omission. |
| 1.4 — Steps 04/11/14's "use WebSearch" has no enforcement | Did not attempt WebSearch for any figure this session (matching round 2's own approach) | **Not independently re-tested** — I followed the same honest-fallback discipline round 2 described and it held (every unsourced figure got a `key_assumptions`/`quantitative_claims` entry, nothing silently invented), but I didn't specifically probe the enforcement gap itself this round. |

---

## What actually worked well

- **The AI-risk gate is genuinely load-bearing, confirmed a second time on a different business
  with different failure patterns.** It blocked real false-precision and real unsourced-claim
  findings three separate times this session, at two different layers (individual DE step, and
  plan assembly), and did not block on the many other honestly-low-confidence figures throughout
  this plan — it discriminates, it doesn't just refuse everything, exactly as round 2 found.
- **Dual-sided marketplace guidance is real, specific, and usable in 19 of 24 DE steps** — not
  aspirational prose. I drafted a full, internally-consistent two-sided business plan against it,
  and the guidance repeatedly produced genuinely useful, business-specific findings (the
  supply/demand access asymmetry in Step 9, the binding-constraint sizing logic in Step 4, the
  independent per-side DMU in Step 12) rather than generic boilerplate.
- **The new `marketplace-liquidity-specialist` persona is a real, working fix**, not a checkbox —
  it caught a genuine, consequential finding (disintermediation risk) that the persona it replaced
  for marketplace businesses never would have raised, confirmed by direct side-by-side comparison
  of both drafted verdicts.
- **The council's aggregation algorithm remains mechanically followable by hand**, including a
  genuinely different worked case than round 2 hit (a lone harsh verdict surviving via
  cross-severity tag corroboration rather than being discarded) — the design intent stated in
  CONVENTIONS §6 ("harshest non-outlier, not diluted") continues to hold up under real, adversarial
  hand-execution.
- **The plugin survived a second round of live concurrent editing without producing a broken
  session.** Both the seat-selection logic and the persona roster changed underneath me mid-task,
  and the correct response — re-read, re-run, disclose the transition plainly — was possible
  precisely because every file involved states its own contract clearly enough to re-derive the
  right behavior after a change, without needing tribal knowledge of what changed when.
- **Cross-step reconciliation surfaced a real, unplanted structural gap** (the Steps 17-19
  marketplace LTV/COCA mismatch) simply by being required to write the reconciliation out in
  `plan/business-plan.md`, without my needing to plant anything — this is the reconciliation
  discipline doing real diagnostic work on a business it had never seen before, not just replaying
  a known-good pattern from round 2.
