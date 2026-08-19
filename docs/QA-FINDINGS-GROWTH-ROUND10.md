# QA Findings — Round 10: `experimentation-and-optimization` (growth-analyst) live dry run

**Method.** Copied the real fixture `.startup/vantage-point-search` to an isolated working copy at
`.startup/vantage-point-search-t10-growth/` (slug field updated to match) and worked exclusively
inside it. Read `business-state.json` in full, both real `ops/*-growth-metrics.md` cycles
(2026-09-15 and 2026-09-29), `plan/13-map-the-process-to-acquire-a-paying-customer.md`,
`plan/18-map-the-sales-process-to-acquire-a-customer.md`, and `ops/kpi-dashboard.md`, then read
`skills/ops/experimentation-and-optimization/SKILL.md` and the appended "Owning disciplined
experimentation" section of `agents/ops/growth-analyst.md` in full. This was never executed live
before this round. I then actually ran the skill against this fixture's real numbers — no
hypothetical data — and wrote the resulting log to
`.startup/vantage-point-search-t10-growth/ops/experiments-log.md`. Full arithmetic is in that file;
this doc summarizes what I did and what it revealed.

## What I actually did

**Candidates sourced from real data**, per Step 1's priority order, using the real stage
conversion rates in `plan/18-...md` (1→2: 74%/26/35, 2→3: 69%/18/26, 3→4: ~85%/15/18, 4→5:
~52%/8/15, overall 23%/8/35) and the real funnel-losses table added ad hoc in
`ops/2026-09-29-growth-metrics.md` (#2 and #4, both declined at the internal-budget-check stage,
same stated mechanism: can't justify the 30% fee internally for a first senior hire):

1. **Budget-check ROI one-pager** (targets Stage 4→5, the biggest real drop-off, 52%/48 points
   lost) — ICE 8/7/2 → **5.7/10**.
2. **Segment-specific fee-floor/payment plan** for sub-120-employee prospects (directly the
   untested alternative named in `ka-025-segment-fee-floor`) — ICE 4/6/2 → **4.0/10**.
3. **Outbound message/template test** on the first-touch email (Stage 1→2, the "standing
   activation slot" per Step 1 priority 5, since this business has no signup step) — ICE 5/3/3 →
   **3.7/10**.

All three are logged with full ICE components in `ops/experiments-log.md`, ranked, per the skill's
"surface the top 3, not just the winner" requirement — this was straightforward to follow from
real data; the funnel table and the funnel-losses table gave clean, unambiguous inputs for Impact
and Confidence. **This part of the skill worked well and was genuinely usable.**

**Sample-size arithmetic — the actual stress test**, run against the top-ranked candidate (Stage
4→5, real baseline p = 8/15 = 0.5333, stated in the plan as "~52%"):

- To detect the hypothesis's stated 25% relative lift (52%→65%): formula gives **n ≈ 225 per
  variant** (450 total), the 100-conversion floor already cleared by that n.
- To detect the boldest plausible variant, a 50% relative lift (52%→78%): formula gives n ≈ 57/arm,
  but that's *below* the ~100-conversion floor, so the **floor binds instead: n ≈ 188/arm** (376
  total).
- Real historical volume through this exact stage: **15 entrants over 14 months ≈ 12.9/year.**
- Time to reach the required sample at that real rate: **~35 years** (25% lift target) or **~29
  years** (50% lift target, floor-bound).
- Cross-checked against the highest-volume stage in the whole funnel (Stage 1→2, 74% baseline, all
  35 conversations/14mo ≈ 30/year) with the boldest assumption and the floor binding: **still ~9
  years.**

Logged all of this as EXP-01 in `ops/experiments-log.md`, with the explicit decision **not to run
this as a quantitative A/B test** — routed to qualitative signal instead, per the skill's own
Step-3 escape hatch ("accept up front that this stage can't be validly A/B tested at current
traffic... route the change through qualitative signal instead").

## Was the formula/table actually usable against this fixture's real numbers?

**The arithmetic itself is correct and easy to execute** — `16 × p × (1−p) / d²` is a one-line
computation, and I could run it directly from numbers already sitting in `plan/18-...md` with no
invented inputs. That part of the skill is genuinely well-built.

**But applied honestly to this business's real scale, the answer is not usable, and the skill
under-signals that** in three concrete ways:

1. **The reference table doesn't cover this business's actual baseline rates at all.** The
   "Worked reference table" only has rows for 2%/5%/10%/20% baseline. This fixture's
   decision-relevant stages run 52%–74% — a DMU-qualified, warm, referral-heavy B2B services
   funnel, not a cold web-conversion funnel. A founder or analyst reading the table "plainly" (as
   the skill instructs) gets no guidance at all for a services business shaped like this one; they
   have to fall back to the raw formula with no worked example anywhere near their actual numbers.
   This is a real usability gap for exactly the business type (`services`) this fixture and
   `growth-analyst.md`'s type-dispatch section both call out by name.

2. **The skill never asks the analyst to compute months/years-to-reach-sample from the business's
   own real historical stage rate — that derivation isn't in the skill's steps at all.** Step 3
   tells you to compute *n*, tells you the duration floor (1 week / 2 cycles), and tells you the
   100-conversion floor, but nowhere instructs "divide the required *n* by this stage's real
   historical volume-per-period to get a real calendar estimate, and state that number explicitly
   before proposing the test." I had to derive that division myself, using a number
   (15 entrants/14 months at this exact stage) that only exists in `plan/18-...md`, not in the
   skill's own Step 3 checklist. Without that extra derivation step, a founder plugging real
   numbers into the formula gets a technically correct "n ≈ 225 per variant" and could easily read
   that as "achievable" without realizing it implies 35 years at this business's real pace. The
   skill's own worked example ("if a stage gets 200 visits a period...") is pitched at a
   volume two orders of magnitude above what this real fixture has (this business is closer to
   "1-3 stage-4 entries per *check-in period*," i.e., 2 weeks — not 200 visits per period) — the
   example doesn't scale down to warn a founder at this real scale as directly as it should.

3. **Step 3's "accept up front that this stage can't be validly A/B tested... route through
   qualitative signal instead" clause is the right answer and it is in the skill** — but it's one
   sentence inside a paragraph under the reference table, not a decision gate the process forces
   you through before designing a test. ICE's ease scoring gestures at folding in
   time-to-valid-result, and I did use it that way (Ease scored 2/10 for candidate #1 specifically
   because of this), but nothing in Step 1–3 tells the analyst to run the
   real-volume-vs-required-sample division *before* writing a hypothesis and a "Started" date into
   the log. As executed, I designed the full EXP-01 hypothesis, target metric, and variant
   description before the arithmetic told me it wasn't runnable — the skill's step ordering
   invites exactly that ordering (Step 2 design, then Step 3 rigor), which is backwards for a
   low-volume business: the volume check should gate whether Step 2 is worth doing at all.

## A concrete schema gap found while logging

The experiment log template's `Status` field only allows `running | shipped | killed |
inconclusive-retest`. **None of these accurately describes "designed, rigor-checked per Step 3,
and determined not to be quantitatively testable before a variant was ever shipped."** I logged
EXP-01 as `running` (the least-wrong of the four) with an explicit note in both the Status line and
Notes explaining the mismatch. This is a real, fixable schema gap in
`skills/ops/experimentation-and-optimization/SKILL.md`'s Step 4 template — worth adding a fifth
status value (something like `not-viable-qualitative-only`) for exactly this outcome, since Step 3
explicitly anticipates and endorses this outcome as legitimate but Step 4's template has nowhere
correct to record it.

## Minor data-fidelity note (not a skill bug)

`plan/18-...md` states Stage 4→5 conversion as "~52% (8/15 est.)" but 8/15 computes to 53.3%, not
52%. Immaterial to the conclusion (both round to "about half," and the arithmetic above used the
precise 0.5333), but noted here since the round's brief asked for real, precise arithmetic — this
is a small, pre-existing rounding softness in the fixture's own plan content, not something this
skill introduced.

## Bottom line

The ICE-prioritization mechanism worked well and was fully followable from this fixture's real
funnel and funnel-losses data — no complaints there. The statistical-rigor section's formula and
100-conversion floor are individually correct, but **applied honestly to this real, early-stage,
low-volume B2B services business, the sample-size math says this business cannot validly
quantitatively A/B test any stage of its funnel for years — 9 years in the best realistic case,
29-35 years for the actual highest-priority candidate.** The skill contains the right escape hatch
(route to qualitative signal) but doesn't force the volume-vs-sample check early enough, doesn't
give the analyst a table or worked example anywhere near a warm/referral funnel's real conversion
rates, and its own log template has no status value for the (correct, skill-endorsed) outcome this
run actually produced. This is exactly the kind of real gap this round's brief asked me to surface
if the numbers said so — they did.
