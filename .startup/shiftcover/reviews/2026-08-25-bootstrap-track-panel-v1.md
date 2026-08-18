# ShiftCover — Review Council — Bootstrap Track (Track A) — Re-review v1

**Plan version reviewed:** `plan/business-plan.md` v2 (`plan/business-plan-v2.md`), the revision
produced by `skills/business-plan/revise-business-plan` addressing
`reviews/2026-08-18-balanced-panel-v1.md`'s REVISE verdict.
**Review date:** 2026-08-25.
**This is a re-review.** Prior review: `reviews/2026-08-18-balanced-panel-v1.md` (Track C,
aggregate REVISE, score 4). What changed since then: see `plan/business-plan-v2.md`'s "Response to
Council Required Revisions" section and `plan.history[1].summary_of_changes` — in short, 4 of the
prior review's 5 required revisions were substantively addressed (venture-fit framing, a real
cold-outbound test, a real engineering-resourcing decision, partial franchisor-veto confirmation);
1 ([SALES-CYCLE], recompute Step 18's funnel once 5+ prospects reach Stage 2) was honestly left
open because only 2 of 7 prospects have reached Stage 2 as of this revision.

## 0. Pre-council AI-risk gate (§1, mandatory, run again independently of revise-business-plan's
own §3.5 call)

Re-ran `skills/risk/ai-risk-review` against `plan/business-plan.md` (v2, unchanged since
`revise-business-plan`'s own gate pass). **PASS.** No new findings this call — the 3 findings
raised during the revision cycle (`ar-shiftcover-004` blocking-then-fixed, `ar-shiftcover-005` and
`ar-shiftcover-006` advisory) are already logged in `risk_log` and were addressed or accepted as
advisory before this council convened, per the "who must call this, and when" table's requirement
that the pre-council call happen independently rather than being assumed satisfied by the
revising skill's own call. Proceeding to panel selection.

## 1. Track assignment — changed this cycle (§2's explicit re-derivation rule)

**Track A — bootstrap-track**, a change from v1's Track C. `gtm.funding_strategy` remains
`undecided` and `business_basics.funding_intent` does not exist on this business's record, so per
§2's re-review rule the starting point is "keep the prior track (Track C) unless a genuinely new
explicit signal has appeared." **A genuinely new explicit signal has appeared**: the Executive
Summary of `plan/business-plan-v2.md` now quotes the founder directly — *"I'm not trying to raise
a venture round on this — if it works I want to run it as a real, profitable business, and I'd
rather it be a $15-20M/year business I own 100% of than chase something bigger I don't."*
(`interview-log.md`, 2026-08-25 entry) — a clear, first-time, explicit bootstrap signal that was
not present in v1. Per §2's rule, the new signal wins and the track changes; stated plainly here
as required. Note: this signal has not been (and per this skill's own boundary, cannot be) written
into the canonical `business_basics.funding_intent` field by `revise-business-plan` — that field
is owned by `skills/interview/onboarding-interview`/`recurring-check-in` — so this track assignment
is this review's own provisional inference from plan prose per §2 step 2, not a read of an
authoritative field. Flagging to the orchestrator that a `recurring-check-in` should capture this
formally so future reviews don't have to re-derive it from prose each cycle.

## 2. Panel (5 seats) — unchanged from v1

`customer-discovery-skeptic`, `financial-modeling-reviewer`, `vc-panel`, `expert-entrepreneur-panel`
(four fixed seats), plus **`sales-motion-reviewer`** as the contextual 5th seat — trigger
unchanged from v1: Step 12's DMU still names multiple stakeholder roles beyond a single self-serve
buyer-user-payer (End User ≠ Champion ≠ Primary Economic Buyer, plus the franchisor veto-holder
role, which this revision's own franchisor-confirmation calls showed is still real for at least 1
of the 3 prospects sampled). `technical-feasibility-reviewer` and `regulated-industry-compliance-
reviewer` do not trigger (no hardware/deep-tech/regulated content, unchanged).

All 5 personas were invoked as genuinely independent, simultaneous evaluations of
`plan/business-plan-v2.md`, each given the plan and this business's prior review file plus the
`plan.history` change summary for re-review context, with no visibility into any other panelist's
output this cycle.

---

### customer-discovery-skeptic

## Verdict: REJECT
**Score:** 4
**Reviewer persona:** Applied customer-discovery coach, Steve Blank tradition — deliberately the
harshest reviewer on the panel, hunting for pattern-matching to founder's desired story over real
evidence in Steps 1-9.

### Strengths
- Real, if partial, forward motion on Step 9 exists for the first time: 2 of 7 prospects (Alex
  Torres, Priya Nair) have had an actual first conversation, not just "in conversation"/"awaiting
  reply" outreach status. That is a genuine, if small, step toward what my v1 review asked for.
- The franchisor-veto confirmation calls (Step 12) are a real, honest piece of evidence-gathering
  done exactly right: a direct question asked of real people, an honest partial (3 of 7) result
  reported without over-generalizing to the other 4 or the beachhead broadly. This is the kind of
  evidence discipline I was asking for elsewhere in the plan too.
- The cold-outbound test (Step 19) shows the same discipline: a real test run, a small honest
  result reported, and — critically — no new COCA figure manufactured from an insufficient sample.
  This plan continues to resist exactly the automation-bias trap it could have fallen into.

### Risks / gaps
- [PERSONA-VALIDITY] My v1 required revision #1 — at least 7 more real conversations specifically
  with GMs/shift managers (not Directors of Operations) — was **not addressed this cycle**. Every
  conversation logged this revision (the 3 franchisor calls, the 20 cold-outbound contacts) was
  with Directors of Operations/Owner-Operators, the economic-buyer role, not the end-user role
  Step 3's profile is built on. Step 3 still rests on 3 real GM conversations out of 14 total.
- [EVIDENCE-GAP] My v1 required revision #2 asked for an actual stated signal of interest from
  Step 9's prospects — "a scheduled pricing conversation, a stated 'yes, interested,' or a
  declined-with-reason" — before the list is used to justify anything downstream, and I named
  sales-cycle length explicitly as one of the things this evidence gap taints. **This is still not
  met.** A "first conversation held" (Alex Torres) or "scheduled" (Priya Nair) is real motion, but
  by the standard I set — an actual stated signal, not outreach/meeting status — zero of the 7
  prospects have yet said anything that counts. I want to be precise: I'm not discounting the
  motion as worthless, I'm saying it hasn't crossed the specific bar my required revision named,
  and that bar is exactly what `sales-motion-reviewer`'s own [SALES-CYCLE] finding this cycle
  independently confirms from a different angle — the same 2-of-7, not-yet-a-signal pipeline
  status is why neither of us can sign off on downstream figures (COCA, sales-cycle length, TAM
  confidence) that assume this list is more real than it currently is.
- [SOURCING] My v1 required revision #3 — an independently checkable source for the 3,000-group
  beachhead count — was **not addressed this cycle**. Step 4's TAM is unchanged; still a founder
  recollection with no trade-association or market-report cross-check.

### Required revisions
1. [PERSONA-VALIDITY] Conduct at least 7 more real conversations specifically with GMs/shift
   managers (not Directors of Operations) before treating Step 3's profile as more than a
   hypothesis. **Carried forward unchanged from v1 — not addressed this cycle.**
2. [EVIDENCE-GAP] Get Step 9's prospects to an actual stated signal of interest — a scheduled
   pricing conversation, a stated "yes, interested," or a declined-with-reason — before this list
   is used to justify anything downstream. **Carried forward — 2 of 7 have real motion (a first
   conversation), which is not yet a signal by the standard this item sets.**
3. [SOURCING] Find or commission an independently checkable source for the 3,000-group beachhead
   count before this TAM is shown to anyone outside this working session. **Carried forward
   unchanged — not addressed this cycle.**

**This REJECT rests on the same independent evidence-quality concerns as v1, none of which this
revision cycle's actual routed work touched — the revision addressed the aggregate review's
synthesized checklist (which did not include my items, since my v1 REJECT was discarded as a
non-corroborated outlier in that review's aggregation), not my own required revisions directly.**

---

### financial-modeling-reviewer

## Verdict: APPROVE_WITH_NOTES
**Score:** 7
**Reviewer persona:** Former startup CFO / financial-modeling consultant — independently
re-derives every material figure and checks its sourcing.

### Strengths
- The new cold-outbound figure checks out: 3/20 = 15% exactly as stated, and — correctly — no
  attempt was made to derive a per-contact cost or a recomputed COCA from a 20-contact sample.
  That restraint is exactly right; a lesser plan would have been tempted to show a "cold COCA"
  number here and this one wasn't.
- The contractor-quote range ($18,000-$24,000) is presented as a range, sourced to real obtained
  quotes, and not laundered into a single false-precision figure. Good discipline, consistent with
  this plan's existing handling of its other estimates.
- v2's Confidence & Validation Status section correctly self-corrected a v1 miscount (7 vs. the
  actual 8 quantitative_claims entries) rather than silently carrying the error forward — a small
  thing, but it's exactly the kind of self-auditing discipline I want to see more of, not less.

### Risks / gaps
- [FINANCIAL-ARITHMETIC] The Step 4/Step 16 pricing-tier mismatch I flagged in v1 (Step 4's TAM
  uses the flat $149/location/month rate for all locations; the LTV calculation correctly applies
  the $129 volume-tier rate) is **still unreconciled** — Step 4 was not part of this revision
  cycle's routed work, and the ~13% TAM overstatement I computed in v1 still stands. Not a required
  revision from v1 (I APPROVE_WITH_NOTES'd, no blocking items), so this is not a new blocker, but
  it remains real and I'd like it addressed in the next revision that touches Step 4 for any
  reason.
- [FINANCIAL-ARITHMETIC] The same false-precision pattern I noted in v1 (headline $52,503/$118M/
  $70.8M/$6,000 figures carried to 3-5 significant figures) is unchanged in v2's body text, though
  the newly-added figures (15%, $18k-$24k) are handled with appropriately rounder precision.

### Required revisions
_(none — APPROVE_WITH_NOTES; both notes above are real but not blocking on their own, unchanged
from v1's assessment)_

---

### vc-panel

## Verdict: APPROVE_WITH_NOTES
**Score:** 6
**Reviewer persona:** Seed/Series A generalist VC, ~10-12 years, evaluates for venture-scale
return potential.

### Strengths
- All three of my v1 required revisions are genuinely addressed, not cosmetically reworded:
  1. **Venture-fit framing** — the plan no longer implies scale it hasn't earned. It states
     plainly that this reads as a strong non-venture outcome, matches my own v1 read (~$10-30M/yr)
     back to me accurately rather than disputing it, and — notably — the founder now has an
     explicit, on-record preference for exactly this kind of business rather than a bigger one she
     doesn't actually want. I take a founder stating her own ceiling honestly as a *positive*
     signal about execution focus, not a concession.
  2. **Scalability/COCA test** — a real cold-outbound batch ran. It's small (20 contacts) and I
     wouldn't read anything quantitative into a 15% reply rate yet, but the plan correctly doesn't
     either — it reports the test honestly without manufacturing a new ratio from it. That is
     exactly the caution I asked for.
  3. **Engineering-resourcing gap** — a real, time-boxed, falsifiable plan now exists (no-code
     attempt, 2-week checkpoint, funded contractor fallback) where a genuine unknown sat before.
- No larger follow-on market was invented to manufacture venture scale — I'd have flagged that as
  worse than the original gap, and it didn't happen.

### Risks / gaps
- [DEFENSIBILITY] Unchanged from v1: the intended Core (cross-location reliability-data network
  effect) still does not exist — zero real usage has been generated this cycle either, since no
  MVBP customer exists yet. This wasn't part of my v1 required revisions (I raised it as a
  Risks/gaps item, not a blocker), and it isn't fixable by a planning-session revision anyway — it
  needs real usage data. Still worth naming: the only real advantage today remains the founder's
  personal network, a moat, not a Core.

### Required revisions
_(none — APPROVE_WITH_NOTES. All three of my v1 required revisions are resolved.)_

**Track note:** this review runs Track A (bootstrap). Per §4, my verdict would only be downgraded
to informational-weight if every one of my Risks/gaps and Required-revisions bullets were tagged
`[VENTURE-FIT]` with no other tag. My only bullet this cycle is `[DEFENSIBILITY]`, not
`[VENTURE-FIT]` — so per the letter of that rule my verdict counts at full weight in the blocking
set despite Track A, the same as every other seat. Stating this explicitly since it's a real,
non-obvious application of the rule, not a default.

---

### expert-entrepreneur-panel

## Verdict: APPROVE_WITH_NOTES
**Score:** 8
**Reviewer persona:** Serial operator-founder lens, evaluates operational buildability rather than
venture-scale fundability.

### Strengths
- The engineering-resourcing decision is exactly the kind of real, time-boxed, falsifiable
  commitment I want to see from an operator-founder: not "I'll figure it out," but a specific
  stack (Twilio Studio + Retool), a specific checkpoint (2 weeks), and a specific, already-priced
  fallback (2 real contractor quotes in hand) if the checkpoint is missed. This is a founder
  managing her own execution risk directly, not hoping it resolves itself.
- The franchisor-confirmation calls and the cold-outbound test both show the founder doing real,
  unglamorous validation work between review cycles rather than just rewriting prose to sound more
  finished — that's the actual behavior I'm evaluating for, more than any single number in the
  plan.

### Risks / gaps
- [EXECUTION-RISK] The underlying gap I raised in v1 alongside `vc-panel` — no proven path to
  actually building the MVBP — is **softened, not closed**: a real plan now exists, but the
  2-week no-code checkpoint hasn't happened yet, and a founder with an operations (not
  engineering) background attempting a Twilio Studio + Retool build for the first time is a real,
  if now time-boxed and hedged, execution risk. Worth watching at the next check-in, not blocking.

### Required revisions
_(none — APPROVE_WITH_NOTES)_

---

### sales-motion-reviewer

## Verdict: REVISE
**Score:** 5
**Reviewer persona:** Enterprise/complex-sale specialist, evaluates DMU and acquisition-process
rigor.

### Strengths
- My v1 required revision #1 (confirm franchisor sign-off for the top 3 Step 9 prospects) is
  **genuinely addressed** — 3 of 7 prospects called directly, 2 of 3 clear, 1 of 3 has a real but
  non-fatal added step. This is exactly the kind of DMU-risk retirement I asked for, done honestly
  (explicitly not over-generalized to the other 4 prospects).

### Risks / gaps
- [DMU-COMPLEXITY] Largely resolved for the sampled 3 of 7 (see Strengths) — carried here only as
  a partial note: the remaining 4 named prospects and the beachhead broadly are still unconfirmed,
  so this shouldn't be read as a fully retired risk yet.
- [SALES-CYCLE] My v1 required revision #2 — recompute Step 18's funnel once 5+ real prospects
  have moved through at least the first two stages — is **not met**. Only 2 of 7 prospects
  (Alex Torres, Priya Nair) have reached Stage 2 as of this revision. To the plan's credit, it did
  not fabricate a recomputed funnel from 2 data points — it said plainly that the bar wasn't met
  and left the ~68-day/3.6%-conversion figures unchanged. I'd rather see that honesty than a
  premature recompute, but the underlying required revision itself is still open.

### Required revisions
1. [SALES-CYCLE] Recompute Step 18's funnel once 5+ real prospects have moved through at least the
   first two stages. **Carried forward from v1 — 2 of 7 as of this revision, bar not yet met.**

---

## Aggregation accounting

**Track A weighting (§4):** `customer-discovery-skeptic`, `financial-modeling-reviewer`,
`expert-entrepreneur-panel`, and the contextual 5th seat (`sales-motion-reviewer`) are fully
blocking by default. `vc-panel`'s verdict would be downgraded to informational only if 100% of its
Risks/gaps and Required-revisions bullets were tagged `[VENTURE-FIT]` with no other tag — its only
bullet this cycle is tagged `[DEFENSIBILITY]`, not `[VENTURE-FIT]`, so per §4's explicit "even one
bullet under a different tag" rule, **`vc-panel` counts at full weight**. The blocking set is all
5 seats, same as it would be under Track C — the track change mattered for framing (see §1) but
did not change the blocking-set composition this cycle, since `vc-panel` never had a
100%-`[VENTURE-FIT]`-only verdict to begin with.

| Persona | Verdict | Severity | Score | Tags |
|---|---|---|---|---|
| customer-discovery-skeptic | REJECT | 4 | 4 | PERSONA-VALIDITY, EVIDENCE-GAP, SOURCING |
| sales-motion-reviewer | REVISE | 3 | 5 | DMU-COMPLEXITY, SALES-CYCLE |
| vc-panel | APPROVE_WITH_NOTES | 2 | 6 | DEFENSIBILITY |
| financial-modeling-reviewer | APPROVE_WITH_NOTES | 2 | 7 | FINANCIAL-ARITHMETIC |
| expert-entrepreneur-panel | APPROVE_WITH_NOTES | 2 | 8 | EXECUTION-RISK |

**Round 1.** Harshest severity = REJECT (4), held alone by `customer-discovery-skeptic`.
- Test 1 (alone at severity): yes.
- Test 2 (tag overlap, literal): `customer-discovery-skeptic`'s tags (`PERSONA-VALIDITY`,
  `EVIDENCE-GAP`, `SOURCING`) do not literally appear in any other reviewer's tags this cycle
  (`sales-motion-reviewer`: DMU-COMPLEXITY/SALES-CYCLE; `vc-panel`: DEFENSIBILITY;
  `financial-modeling-reviewer`: FINANCIAL-ARITHMETIC; `expert-entrepreneur-panel`:
  EXECUTION-RISK). No literal tag match.
- **Test 2 (semantic overlap, required by §6 Step C beyond the literal tag check):**
  `customer-discovery-skeptic`'s `[EVIDENCE-GAP]` finding and `sales-motion-reviewer`'s
  `[SALES-CYCLE]` finding are, on a substantive read, **the same underlying concern viewed from two
  rubric angles**, not two independent findings that happen to coincide. Concretely:
  `customer-discovery-skeptic`'s own v1 required revision #2 explicitly named "sales-cycle length"
  as one of the downstream things the Step 9 evidence gap taints ("before this list is used to
  justify anything downstream (COCA, **sales-cycle length**, TAM confidence)") — this is not an
  inferred connection, it is stated directly in the reviewer's own prior-cycle text. Both personas,
  this cycle, land on the identical fact pattern (2 of 7 prospects have reached Stage 2, and
  neither persona will sign off on downstream figures built from that pipeline) from their
  distinct lenses (general evidence-quality skepticism vs. enterprise-sales-process rigor). Per
  §6 Step C test 2's explicit instruction to look past the tag vocabulary for substantive overlap,
  and its "if genuinely unsure, resolve in favor of not discarding" guidance, **this is treated as
  corroboration, not coincidence.**
- → **Fails test 2. Not discardable. REJECT stands as the aggregate.**

No further rounds needed — the harshest severity was not discarded, so the algorithm stops here
per §6 ("If it fails any test, it is not discarded — the current harshest severity stands as the
aggregate").

## Aggregate Verdict

## Verdict: REJECT
**Score:** 4 *(customer-discovery-skeptic's own score — the only reviewer at the final aggregate
severity)*

### Required revisions (from the sole reviewer at the aggregate severity)
1. [PERSONA-VALIDITY] Conduct at least 7 more real conversations specifically with GMs/shift
   managers (not Directors of Operations) before treating Step 3's profile as more than a
   hypothesis.
2. [EVIDENCE-GAP] Get Step 9's prospects to an actual stated signal of interest — a scheduled
   pricing conversation, a stated "yes, interested," or a declined-with-reason — before the list
   is used to justify anything downstream (COCA, sales-cycle length, TAM confidence).
3. [SOURCING] Find or commission an independently checkable source for the 3,000-group beachhead
   count before this TAM is shown to anyone outside this working session.

**All three items are carried forward unchanged from `reviews/2026-08-18-balanced-panel-v1.md`** —
none were part of this revision cycle's routed work, because `revise-business-plan` worked the
prior review's *aggregate* synthesized checklist (which did not include these items, since
`customer-discovery-skeptic`'s v1 REJECT was itself discarded as a non-corroborated outlier in
that review's own aggregation), not the full panel's individual verdicts. See "Also flagging"
below and `docs/QA-FINDINGS-ROUND6.md` for why this is a structural finding worth the founder's
and the maintainers' attention, not just a repeated review comment.

### Also flagging, regardless of severity
`sales-motion-reviewer`'s `[SALES-CYCLE]` finding (only 2 of 7 prospects have reached Stage 2, short
of the council's 5+ bar from v1) is not part of the aggregate-severity checklist above — its own
verdict (REVISE, severity 3) is softer than the REJECT aggregate (severity 4), so per the literal
checklist-construction rule it doesn't contribute items directly. But it is the **specific
corroborating evidence that kept `customer-discovery-skeptic`'s REJECT from being discarded as an
outlier** in the accounting above — without it, this aggregate would very likely have come back
APPROVE_WITH_NOTES (three of five seats landed there this cycle). It is worth the founder's direct
attention on that basis alone, not just as a secondary note buried under a harsher verdict.

## Council-integrity note

Genuine independence and real verdict variance this cycle: REJECT, REVISE, and three distinct
APPROVE_WITH_NOTES scores (6, 7, 8) — no score-clustering, no uniform verdict pattern.
`customer-discovery-skeptic` and `sales-motion-reviewer` converged on the same underlying pipeline-
immaturity concern from genuinely distinct rubric angles (evidence-quality skepticism vs.
enterprise-sales-process rigor) — treated as corroboration per the aggregation accounting above,
not templating, since the convergence is substantive and independently derivable from each
persona's own stated method, not a reused sentence. `vc-panel`, `financial-modeling-reviewer`, and
`expert-entrepreneur-panel` each independently confirmed their own v1 required revisions were
resolved without simply echoing each other — `vc-panel` focused on venture-framing honesty,
`financial-modeling-reviewer` on arithmetic/precision discipline in the new figures,
`expert-entrepreneur-panel` on the operational credibility of the build decision. No rubber-
stamping signal this pass; re-ran the pre-council gate independently (§0 above) rather than
assuming the revising skill's own gate call carried over, and it found nothing new. This panel's
combination of real corroborated pushback (REJECT standing) alongside real, verified progress on 3
of 5 seats' concerns is itself a healthy sign that this council is not simply rubber-stamping any
plan that shows visible effort — it is still checking whether the effort answered the actual
question each persona asked.

## Disclaimer

This review is a planning aid produced by simulated reviewer personas grounded in the Disciplined
Entrepreneurship framework and this business's own stated facts — it is not licensed financial,
legal, or investment advice, and passing it is not validation from a real investor, customer, or
advisor. See `docs/AI-RISK-FRAMEWORK.md` for what this system's review layers do and do not verify.
