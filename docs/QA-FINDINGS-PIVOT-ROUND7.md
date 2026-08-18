# QA Findings — Round 7: Second Recurring Check-In and a Real Mid-Lifecycle Pivot

**Method.** I picked up **Vantage Point Search** (`.startup/vantage-point-search/`) from round 6's
end state (`stage: "operating"`, one real ops check-in on file, cadence `biweekly`, next check-in
2026-09-29) and drove it, for real, through the two things this plugin has never once exercised:
a **second** recurring check-in cycle (`ops/2026-09-29-*`, `interview-log.md`'s 2026-09-29 entry),
and a **genuine, evidence-based pivot signal** through `agents/ops/operations-manager.md`'s "When
ops data points toward a pivot" section and `agents/orchestrator.md`'s pivot-reopening protocol.
Every artifact below is a real file this session wrote and is still on disk; nothing here is a
hypothetical description of what a run would produce. `scripts/validate-plugin.sh` passes clean (0
warnings, 0 errors) after all changes, and `business-state.json` was checked for valid JSON after
every edit.

**Why this data, not "steady, unremarkable" traction.** I had real latitude to pick either a quiet
second data point or a genuine negative pattern. I chose the pattern deliberately, for two reasons.
First, informativeness: round 6 already demonstrated the "insufficient data, nothing material"
path once — a second demonstration of the same path would be safe but would leave the plugin's
single most consequential, never-tested code path (the pivot-signal and DE-step-reopening
machinery) completely unexercised for another round, which is exactly the gap `docs/ROADMAP.md`
names this round as closing. Second, plausibility: the pivot I constructed isn't manufactured from
nothing — it's the direct, foreseeable consequence of two things the plan *already* named as real
risks before this round started: Step 18's own text calling the internal-budget-check stage "the
single biggest drop-off point" (52%, 8/15 historical conversion), and Step 2's beachhead band being
a fairly wide 50-500 employees with no sub-segmentation by company size. Two real prospect losses at
the low end of that band, both stalling at exactly that stage for exactly the same stated
reason (inability to justify a 30% fee for a first senior hire without a formal spend-approval
process), is the kind of thing a services beachhead defined by headcount band would plausibly
surface within its first month of real GTM execution — not a contrived edge case.

**Fixture disposition.** `.startup/vantage-point-search/` now has `stage: "de_steps_in_progress"`
(reverted from `operating`), `business_basics.venture_stage: "pivoting"` (from
`already_operating`), DE steps 01/02/04 reverted to `status: "not_started"` with reopening notes, DE
step 05 left `drafted` but flagged for re-confirmation, a new `key_assumptions` entry
(`ka-025-segment-fee-floor`), `ka-011-vc-intro-competition` resolved with a real data point, a new
`risk_log` entry (`ops-vantage-point-search-001`, `status: "open"`), 3 new `ops/2026-09-29-*.md`
files, and `cadence` advanced a second time (`last_check_in`/`next_check_in` both moved forward).

---

## 1. Significant: the Data Contract assigns pivot-driven `business_basics` updates to
`recurring-check-in`, but that skill's own file never implements it — the trail genuinely goes cold

**Files:** `docs/DATA-CONTRACT.md` ("Conventions" section, the `business_basics` ownership note);
`skills/interview/recurring-check-in/SKILL.md` (entire file, especially "What you read/write" and
Phase 2).

`docs/DATA-CONTRACT.md` states plainly: "`business_basics` is set by `skills/interview/
onboarding-interview` and owned by it thereafter (**a pivot updates it via
`skills/interview/recurring-check-in` handing the change to the orchestrator**, never a silent
overwrite by a step skill)." That's an unambiguous assignment of responsibility. But
`skills/interview/recurring-check-in/SKILL.md`'s "What you read / write" section lists exactly what
it writes — `interview-log.md`, `key_assumptions[].test_result`, `risk_log[].status`,
`cadence.check_in_frequency`/`last_check_in` — and `business_basics` is not among them, anywhere in
the file. Phase 2 does correctly *anticipate* the moment ("What's working that you didn't expect,
and what's not... This is where pivot signals and real learning surface — don't skip it"), but
having surfaced the signal, the skill gives its executor no next step at all: no instruction to flag
it, no instruction to write anything, no instruction to hand it to the orchestrator, no mention of
`agents/ops/operations-manager.md`'s pivot section even existing. I hit this directly, for real, at
the exact moment Jordan gave the quoted pivot statement in `interview-log.md`'s 2026-09-29 entry —
I had nothing in this skill's own text to follow, and had to reconstruct the intended path myself by
going back to `docs/DATA-CONTRACT.md`'s statement of intent and then to
`agents/ops/operations-manager.md`'s pivot section (which *does* have complete, followable
instructions — see §5 below) to actually execute the write. **Fix:** add a short paragraph to
`skills/interview/recurring-check-in/SKILL.md`'s Phase 2 or a new short Phase 2a: "If the founder's
answer here amounts to wanting to change the beachhead, persona, or business model (not just a
tactical adjustment), don't try to resolve it in this conversation — name it back to the founder as
a real decision point, then hand back to the orchestrator to route it through
`agents/ops/operations-manager.md`'s 'When ops data points toward a pivot' section (if this is
already an operations-manager-coordinated check-in) or directly execute that section's steps
yourself if none is running this session." **Severity: significant** (not a broken feature — I was
able to complete the work by inference from the Data Contract and a sibling agent's file — but this
is a real, first-time-discovered gap in the one skill the Data Contract explicitly names as owning
this write, and a less careful executor following only `recurring-check-in/SKILL.md` literally would
have no idea what to do with the moment its own text says matters).

## 2. Significant: `agents/orchestrator.md`'s DE-step reopening protocol is a single sentence with
no mechanics — partial reopening, per-step status semantics, and transitive impact are all
unspecified

**File:** `agents/orchestrator.md`, Phase 6 ("...may return to `gtm` for a new launch/campaign, or
to `de_steps_in_progress` if a pivot reopens earlier steps — always via `revising`/`council_review`
before re-approval") and the state-machine diagram's identical one-line mention.

This is the entire specification for what is, structurally, the most consequential state transition
this plugin can make post-approval. Trying to follow it literally for a real, specific pivot signal
(narrow the beachhead band, which implicates steps 01/02/04 directly and 05 only for
re-confirmation) surfaced three concrete gaps, none of them resolvable from the text as written:

- **No partial-reopening mechanic.** Phase 2's only instruction for driving DE steps is "Drive the
  steps in numeric order, 01 through 24, exactly as enumerated" — written for the *first* pass
  through all 24. Nothing tells you how to reopen 4 of 24 without either (a) literally re-running
  all 24 in order again (wasteful and wrong — steps 6-24 mostly don't depend on the exact employee
  count), or (b) inventing your own subset logic, which is what I had to do.
- **No status semantics for a reopened-but-previously-drafted step.** The Data Contract's status
  enum is `not_started|drafted|reviewed|approved`, and `agents/orchestrator.md` itself says no step
  ever reaches `reviewed`/`approved`. That leaves exactly one way to mark a step "needs real rework"
  — revert it to `not_started` — but nothing says so explicitly, and nothing addresses the
  in-between case I actually hit: Step 05's persona is *probably* still valid (it already describes
  a ~130-person Series C company, inside the proposed narrower band) but hasn't been formally
  re-confirmed against the new band either. I left it at `drafted` with a flag in its `summary`
  field rather than reverting it — a reasonable call, but one the schema and orchestrator text give
  no basis for; a different session could just as defensibly have reverted it to `not_started` too,
  and the two choices aren't reconcilable from anything written down.
- **No transitive-impact guidance for the other 19 steps.** Steps 6-24 were not reviewed for
  consistency against the narrower band this session (documented as an open item in
  `interview-log.md` rather than silently resolved either way). Step 9's next-10 list and Step 13's
  DMU/process-map both currently include the two now-declined, now-out-of-band companies (#2, #4) as
  real named prospects — are those step files now stale in a way that blocks re-assembly, or is that
  fine because they're historical data, not forward-looking claims? `agents/orchestrator.md` gives no
  method for answering this — no "reverse dependency" map the way `docs/DE-24-STEPS.md` gives forward
  dependencies for initial sequencing.

**Fix:** add a short "Reopening a subset of DE steps after a pivot" subsection to
`agents/orchestrator.md` Phase 6 that states: (a) only the specifically-implicated steps (as named
by whoever raised the pivot — `operations-manager`, `launch-director`, or the founder directly) need
reverting to `not_started`; every other step keeps its `drafted` status and content as-is unless a
specific downstream step is separately flagged; (b) a step whose prior content is likely still valid
but hasn't been re-confirmed against the change gets a named third state — even an informal
convention like "a note in `summary` starting `NEEDS RE-CONFIRMATION:`" would be enough, as long as
it's written down somewhere rather than improvised per-session; (c) before re-assembling the plan,
skim (not fully re-run) every step file for content that names the specific thing that changed (a
segment boundary, a persona detail, a pricing number) as a cheap, mechanical check, not a full
re-derivation. **Severity: significant** (this is exactly the "does the trail go cold" question the
round was scoped to answer — and the honest answer is yes, right at the reopening step, which is the
step that most needs to be reliable since it's guarding re-entry into a gate the business already
cleared once).

## 3. Significant: `agents/gtm/launch-director.md`'s mid-GTM pivot section doesn't cover a pivot
signal that fires after launch (`stage: operating`), only one that fires during active sequencing
(`stage: gtm`)

**File:** `agents/gtm/launch-director.md`, "When the founder wants to pivot mid-GTM" section, plus
its own frontmatter `description` and "Gate before you start" section.

The pivot section's own framing example list — "weak response from the next-10 list,
`agents/ops/operations-manager.md`'s retro flagging beachhead/segment drift, a founder gut-check
after a few real conversations" — genuinely reads as compatible with a post-launch signal (an ops
retro flagging drift is exactly what happened here). But the section's actual instructions ("stop
sequencing new drafting work against the old plan," "finish or park whatever's mid-flight") are
written assuming GTM work is still actively in motion — they don't say anything about what to do
with GTM artifacts that are **already complete and live** (`gtm.status: "launched"`,
`gtm/positioning.md`, `gtm/content-calendar.md`, `gtm/outbound-sales-playbook.md` all already
produced and shipped, all implicitly targeting the wider 50-500 employee band). The agent's own
frontmatter `description` scopes its use to "kick off go-to-market, re-sequence the launch plan
after a plan revision, or check what GTM work is blocked on" — arguably covers "re-sequence after a
revision," but I could not find anything telling me whether `launch-director` is even the right
agent to re-invoke once `stage` has already moved past `gtm` into `operating`, or whether that's now
squarely `operations-manager`'s and the orchestrator's job with `launch-director` only re-entering
once the DE steps are re-drafted and a fresh council pass clears them. I left this genuinely
unresolved this session (documented in `interview-log.md` rather than guessed at either way) —
`gtm.status` stays `"launched"`, the artifacts are untouched, and nobody has been told they're
targeting a stale band except this findings doc and the interview log. **Fix:** add one clause to
`agents/gtm/launch-director.md`'s pivot section explicitly addressing the post-launch case: "If
`stage` is already `operating` (not `gtm`) when a pivot signal arrives, the already-shipped
`gtm.artifacts` don't get 'parked' — they're live and already reaching prospects — but the
orchestrator should flag them as targeting the pre-pivot band in the launch plan's risk section, and
`launch-director` should be re-invoked once the DE steps are re-drafted and re-cleared, to determine
which artifacts need real revision (a positioning doc that names the wrong employee band probably
needs a real edit, not just a note) rather than assuming the launch is simply 'done' and immune to
the pivot." **Severity: significant** (a real, previously undocumented gap — the plugin has never
had a pivot signal fire after `gtm.status: "launched"` before this round, so this case has never come
up).

## 4. Confirmed working as specified: `operations-manager`'s own drift-comparison mechanism is
plan-vs-actual only, and correctly does NOT have a cross-period trend algorithm for this specific
finding — the qualitative "founder says so" path is what actually carried this pivot, exactly as
the file's own text says it should

**Files:** `agents/ops/operations-manager.md`, "The drift comparison (yours, not delegated)"
section and "When ops data points toward a pivot" section.

This was one of the round's core questions: does the four-comparison drift mechanism (LTV, COCA,
LTV:COCA, TAM/segment) actually do cross-period trend analysis, or only plan-vs-actual? Running it
for real against a second data point answers this precisely: **the four comparisons are plan-vs-
actual by construction** (each one is stated as "plan figure X vs. this-period actual Y"), and the
only trend-aware language anywhere in the section is a single soft phrase in comparison #3 ("the
ratio's trend across the last several periods is closing rather than holding") with no accompanying
algorithm — no threshold for how many periods, no formula for "closing," nothing like the discipline
the four comparisons themselves get (`ka-NN`, `qc-NN` ids, explicit % gaps, explicit thresholds).
Applied for real this period: all four comparisons correctly stayed "insufficient data" a second
time (0 launch-motion closes across both periods), and the actual pivot-carrying signal — the
Series-B-decline pattern — **never touched any of the four formulas at all**, because it's a
lost-deal pattern among prospects who never converted, not a drift in acquired-customer profile
match. This is not a bug: it's the file's own §1 working exactly as written ("persistence across
periods... or the founder explicitly saying they want to change direction... one of those two") —
the founder-statement path is what fired, and it fired correctly, with the retro explicitly
distinguishing "this is a Watch List item on the numbers alone" from "this became a real pivot
signal once Jordan said so directly," per the file's own required discipline against manufacturing
a pivot from thin data. **Not filing this as a defect** — flagging it as the precise, now-confirmed
answer to the round's own question: the numeric drift layer is genuinely narrow-scoped (plan vs.
this-period-or-rolling actual), and the plugin's actual defense against a real qualitative pattern
like this one is the "ask the founder directly, weight their explicit words" discipline, which held
up under a real test. **Severity: informational / confirmed-as-specified**, logged because the task
explicitly asked whether this is checkable now, and it is.

## 5. Minor gap, real when it mattered: `weekly-metrics-review`'s founder-input field list has no
structured place for a lost-deal reason, and this period's whole finding lived in an ad hoc table

**File:** `skills/ops/weekly-metrics-review/SKILL.md`, Step 1 ("Ask the founder for real actuals")
and the `ops/<timestamp>-growth-metrics.md` output template.

Step 1's field list (traffic/leads, new signups, new paying customers, spend, channel breakdown)
has a field for customers *closed* but nothing for prospects *lost*, let alone *why*. Every prior
round's growth-metrics files (round 6 included) never needed this, because nothing material had
happened on the loss side yet. This round did — the two Series-B declines and their stated reasons
were the entire finding — and I had to add an ad hoc table to
`ops/2026-09-29-growth-metrics.md` outside the skill's own template to record it, flagged inline in
that file's own "Data gaps" section as a real template gap rather than silently improvised. This
mirrors `agents/growth-analyst.md`'s own framing of its job ("you notice when the funnel is
leaking") — a funnel-leak's *reason* is exactly the kind of thing this specialist should have a
structured place to record, not just close counts. **Fix:** add a "Funnel losses this period" row
(or subsection) to the output template: prospect id/company, stage lost at, and reason if the
founder has one — same "not tracked"/"unknown" discipline as every other field here if the founder
doesn't have a reason. **Severity: minor** (worked around cleanly this round with no data lost, but
this is the second time in this plugin's history — after round 6's own §5 finding about the
`key_assumptions` walk not scaling — that a real second-cycle stress test surfaced a template gap
that a single-cycle dry run couldn't have found).

## 6. Confirmed fixed: round 6's runway-normalization bug holds correctly under a second, opposite-
direction real test

**Files:** `skills/ops/runway-and-burn-tracking/SKILL.md` Step 2;
`.startup/vantage-point-search/ops/2026-09-29-finance-metrics.md`.

Round 6 found and fixed a real bug: the skill's runway formula had no period-normalization step,
which would have silently overstated a biweekly business's runway by ~2.1x. This round is the first
time the fixed skill has been exercised again, and in the *opposite* direction from round 6's
case — this period was net cash-generative (revenue $23,500 exceeded spend $1,140, from a single
lumpy fee-installment payment), which is exactly the other edge case the fixed Step 2 text names
explicitly ("if monthized net burn ≤ 0... state runway as 'not applicable — cash-generative this
period,' not an infinite number or a divide-by-zero artifact"). Applied it literally and it produced
the correct output cleanly, with no ambiguity to improvise around this time. Also worth naming: I
added an explicit "read this correctly, not as a growth trend" note in the finance-metrics file
myself, because a $22,360 cash swing driven by one milestone payment is exactly the kind of number a
less careful read could mistake for two consecutive "healthy and improving" periods, which it isn't
— this is my own addition, not something the skill's text prompted, and it's the same false-trend
risk symmetric to round 6's false-precision finding, just not yet written into the skill itself.
Not filing a new bug (the skill handled the case it explicitly documents correctly) — logged as
confirmation the round-6 fix generalizes, plus a possible future addition (a one-line caution about
reading a single lumpy-payment period as a trend) if a future round wants to harden this further.
**Severity: informational.**

## 7. Confirmed working: `scaling-strategist`'s "≥3 periods" bar correctly kept it un-invoked a
second time, even with finance nominally "Healthy" twice running

**Files:** `agents/ops/operations-manager.md`, "Decide who's due" §; `agents/ops/scaling-
strategist.md`, "Insufficient data is not a pass."

A shallow reading of `operations-manager`'s trigger ("several consecutive healthy periods") could
have been satisfied by 2 straight "Healthy" finance classifications and used to justify invoking
`scaling-strategist` this period. It correctly wasn't: `scaling-strategist`'s own file states
fewer-than-3-periods trend data makes any trend-dependent criterion "insufficient-data, not a pass,"
and this period's "Healthy" reading is itself flagged (see §6) as a one-time payment, not a stable
pattern — running the checklist now would have produced exactly the false read the file exists to
prevent. Confirmed the skip held correctly under real pressure from a plausible-looking trigger, not
just in the unambiguous zero-data case round 6 tested. **Severity: informational, worked as
specified.**

## 8. Minor / design observation: the 16→20-item `key_assumptions` walk was deliberately scaled down
this session — logged as a disclosed departure, testing round 6's own flagged concern for real

**File:** `skills/interview/recurring-check-in/SKILL.md`, Phase 3.

Round 6 flagged (its own §5) that walking every open `key_assumptions` item by name doesn't scale
gracefully against a tight cadence, without filing it as a bug. This round is the first real test of
that concern with the list now grown to 20 unresolved entries (16 carried, 3 resolved/updated this
round net to +1 with `ka-025` added) on the same biweekly cadence. I deliberately did not re-walk
all 20 by name this session — instead asked Jordan directly whether anything had moved beyond what
the ops check-in already surfaced, and named the specific items with real activity by name rather
than the full list. This is a disclosed departure from Phase 3's literal text ("list each one by its
`statement`"), logged plainly in `interview-log.md` rather than silently done, and it's exactly the
lighter-touch mechanism round 6 speculated might help. **Not filing as a bug** (the skill's own
"leave it, but note it was asked about again" language already tolerates a "no movement" answer per
item, and asking "anything change, or business as usual" is a reasonable-faith execution of that
same intent at scale) — but flagging that this is now a real, lived design tension across two
sessions running, and the skill's text still doesn't explicitly sanction the shortcut I took, so a
different session could just as defensibly have insisted on the full 20-item walk and produced a
noticeably longer, more repetitive check-in for the same net information. **Severity: minor / worth
formalizing**, same as round 6.

---

## What actually worked well

- **`operations-manager`'s pivot-signal discipline held up under a real, close call.** The Watch
  List item (2 declines, suggestive pattern) was correctly *not* escalated to a `risk_log` pivot
  entry from the numbers alone — it took the founder's own explicit statement to cross that line,
  exactly per the file's own §1 rule against manufacturing a pivot from one period's data. This is
  the first time this specific discipline has been tested against data that actually looked
  pivot-shaped, and it didn't overreact.
- **Once the founder's statement came in, `operations-manager`'s pivot section executed cleanly and
  completely** — named the evidence, named the specific implicated steps (01/02/04 required, 05
  flagged for re-confirmation only, 16 named as worth considering), didn't touch any plan file
  itself, logged the `risk_log` entry in the correct schema, and hand back to the orchestrator was
  explicit rather than assumed. Every instruction in that section was followable to the letter, in
  contrast to §§1-3 above.
- **The Step 05 persona detail turned out to already be consistent with the corrected segment** —
  Dana, the worked persona example, was already described as hiring at a ~130-person Series C
  company, comfortably inside the proposed narrower band, even though Step 02's stated band was
  50-500 employees. This is a real, interesting confirmation that the plan's own qualitative detail
  (a specific named persona) had implicitly tracked the real ideal customer more accurately than the
  step's own quantitative band statement — exactly the kind of cross-step consistency check a
  reopening pass should surface, and it surfaced correctly here.
- **The finance skill's round-6 fix generalized correctly to the opposite edge case** (cash-
  generative, not just burn-heavy) on its first real re-use — see §6.
- **`scaling-strategist`'s insufficient-data bar held under a plausible-looking trigger** (2
  nominally "Healthy" periods) rather than only in the unambiguous first-check-in case — see §7.
- **`ka-011-vc-intro-competition` resolved with a real, if unwelcome, data point** — the test plan
  written back in Step 20/21 ("ask lost/quiet prospects directly how the role eventually got
  filled") was executed for real this period and produced exactly the kind of answer that plan
  anticipated (a free VC-intro fill), confirming the assumption-testing loop this plugin is built
  around works across a real multi-week gap, not just as a one-time exercise.
- **The cadence mechanism itself advanced correctly a second time** — `cadence.last_check_in`/
  `next_check_in` both moved forward correctly (2026-09-15 → 2026-09-29 → 2026-10-13), and the
  scheduling-mechanism disclosure was repeated honestly rather than silently reused verbatim from
  the prior session, confirming `docs/ROADMAP.md`'s "does `cadence.next_check_in` actually advance
  correctly a second time" open question from round 6 has a real, positive answer.
