# QA Findings — Round 2: End-to-End Dry Run

**Method.** I role-played the `startup-operator` orchestrator agent against a fake founder,
Maria Chen, and her business **ShiftCover** — a B2B SaaS tool that lets shift managers at
multi-unit QSR franchise groups (10-50 units) text a qualified backup-worker pool the moment an
hourly employee calls out sick, instead of working a paper call list. I ran the actual onboarding
interview per `skills/interview/onboarding-interview/SKILL.md`, then drafted all **24** DE steps
(not just 6-8 — I found real cross-step dependency bugs early enough that I kept going to be able
to exercise `assemble-business-plan` and `run-review-council` for real rather than stub around
them), assembled a real `plan/business-plan.md` via `skills/business-plan/assemble-business-plan`,
ran the mandatory AI-risk gate against it for real (it correctly **BLOCKED**), fixed the two
blocking findings, re-ran the gate (PASS), then ran `skills/business-plan/run-review-council` for
real — writing full, rubric-grounded verdicts for three personas
(`customer-discovery-skeptic`, `financial-modeling-reviewer`, `vc-panel`) and working the
aggregation algorithm by hand against all five seats. Every artifact is a real file under
`.startup/shiftcover/` — nothing here is a hypothetical description of what a run would produce.

**A live-editing complication, disclosed up front.** This repo was being actively patched by
other round-3 agents while I worked. Three files I initially read grew mid-session
(`skills/business-plan/assemble-business-plan/SKILL.md` +95 lines, `skills/business-plan/
run-review-council/SKILL.md` +68 lines, `skills/business-plan/revise-business-plan/SKILL.md` +21
lines, `agents/orchestrator.md` +25 lines) — most notably, `assemble-business-plan` gained a
mandatory AI-risk-gate call (§7.5) and `run-review-council` gained a "floor rule" to its outlier
test and a new `technical-feasibility-reviewer` 5th seat (whose agent file was correctly created
alongside it — no dead reference there). I re-read every file I cite below in its **current**
state before writing a finding against it, and I found a sibling document,
`docs/QA-FINDINGS-GATES-ROUND2.md`, written by another agent doing a parallel, more exhaustive
sweep of exactly which callers wire in the two risk gates. I cross-checked my own gate findings
against it rather than duplicate its table — see the Risk Gates section below for what's still
open versus what's since been fixed.

**Fixture disposition.** `.startup/shiftcover/` is left in place as a real worked example:
`business-state.json`, `interview-log.md`, all 24 `plan/NN-slug.md` files, `plan/business-plan.md`
(with a Confidence & Validation Status section added by hand — see Business-Plan section below),
and one full review file under `reviews/`. It ends at `stage: "revising"` (the council returned
REVISE) — a real, non-trivial state a fixer can pick up from. Three `risk_log` entries
(`ar-shiftcover-001/002/003`) document the real AI-risk gate run, two marked `mitigated` with a
note that the fix was applied to this one artifact, not to the skill files that should produce it
automatically.

---

## 1. Disciplined Entrepreneurship steps

### 1.1 — Blocking: no mechanism anywhere ever sets a DE step's status to `approved`
**Files:** `agents/orchestrator.md` (line 110, and Phase 2 body ~line 169-183); every
`skills/disciplined-entrepreneurship/NN-slug/SKILL.md` (all 24, "Update business-state.json"
sections); `skills/business-plan/run-review-council/SKILL.md` (§9, "Do not touch
`disciplined_entrepreneurship`...").

The orchestrator's own state-machine diagram reads: `de_steps_in_progress │ all 24 DE steps
drafted (each step status: approved) ▼ plan_assembled` — self-contradictory on its face (says
"drafted" then parenthetically "approved"), and the prose below it is unambiguous: "A step's
`status` only becomes `approved` once it holds up... When all 24 steps are `approved`, set
`stage: "plan_assembled"`." I confirmed by grep that **no file in the repo ever writes
`status: "approved"` for a `disciplined_entrepreneurship.NN_*` key** — every one of the 24 step
skills' own "Definition of done" stops at `drafted` and says "review/approval happens later via
the council skill," but the council skill (`run-review-council`) explicitly refuses to touch
`disciplined_entrepreneurship` at all (§9: "Do not touch `disciplined_entrepreneurship`... those
belong to other skills/agents"). Meanwhile `assemble-business-plan`'s own precondition is more
lenient and accepts `status` in `{drafted, reviewed, approved}` — so the system only works in
practice because that skill's gate is looser than the orchestrator's stated one. I ran into this
directly: all 24 of my steps sat at `drafted` (nothing ever promoted them), and `assemble-
business-plan` happily proceeded anyway.
**Fix:** either (a) the orchestrator's own Phase 2 body needs to state explicitly *how* a step
becomes `approved` — presumably the orchestrator itself writes that value after its own "push
back if vague" checkpoint, in which case say so explicitly and show the write — or (b) drop
"approved" from the stated gate entirely and align the diagram with what `assemble-business-plan`
actually checks (`drafted` is sufficient). Right now it's a documented promise nothing fulfills.
**Severity:** significant (the system still functions because the looser gate wins, but the
diagram lies about what actually gates the transition, and a founder told "steps must be approved
before the plan assembles" is told something that can never become true).

### 1.2 — Significant: orchestrator's dependency examples don't match what the step skills actually declare as required
**File:** `agents/orchestrator.md`, Phase 2, item 1: *"a step should generally not start until the
steps it structurally depends on are `approved` (e.g. step 05 needs 02–04; step 08 needs 06–07;
step 17 needs 09–16; step 19 needs 17–18)."*

Checked against each step's own "Read before starting" section:
- Step 05 (persona) marks Step 03 **required**, Step 04 read "for context (not a hard
  dependency)" — it never reads or requires Step 02 at all. The orchestrator's "needs 02-04" is
  not what Step 5 actually declares.
- Step 08 marks Step 07 **required**; Step 06 is read but not marked required. Close enough to
  "needs 06-07," not exact.
- Step 17 marks Step 16 and Step 15 **required**, and Step 08 "if present." It does **not** read
  or require Steps 9-14 at all. The orchestrator's "step 17 needs 09–16" is simply wrong — it
  overstates the real dependency by 7 steps.
- Step 19 marks Step 18 and Step 17 **required** — this one matches "17-18" correctly.
**Fix:** either correct the inline examples to match each step's actual "Read before starting"
list, or state plainly that these are illustrative and non-authoritative and point to the step
files as the source of truth (the orchestrator already says "If the DE-24-STEPS doc or the step's
own skill states a dependency, respect it" — so the wrong inline examples are actively
misleading against the orchestrator's own stated tie-breaker).
**Severity:** significant — an orchestrator instance that trusts its own inline examples would
block Step 17 from starting until Steps 9-16 are all done, which is 7 steps more gating than the
system actually needs.

### 1.3 — Significant: `docs/DATA-CONTRACT.md`'s `plan.version` default is a trap for skeleton creation
**Files:** `docs/DATA-CONTRACT.md` (top-level shape: `"version": "integer, starts at 1"`);
`skills/interview/onboarding-interview/SKILL.md` (Step 0, "using empty/default values for
everything you don't own yet" — never specifies `plan`'s default); `skills/business-plan/
assemble-business-plan/SKILL.md` (§1: "there shouldn't be one yet at version 1 — if one exists...
stop and hand off to `revise-business-plan` instead").

If whoever writes the initial skeleton reads the Data Contract's inline `"starts at 1"` literally
and initializes `plan.version` to `1` at business creation (before any plan exists), `assemble-
business-plan`'s own precondition check would immediately misfire on the very first business —
it would think a plan already exists and hand off to `revise-business-plan`, which requires an
unresolved REVISE/REJECT review to exist (it won't) and would just report nothing to do,
deadlocking plan assembly for a business that has never been assembled once. I avoided this by
initializing my skeleton's `plan.version` to `0`, but nothing in the Data Contract or the
onboarding skill states that `0`/absent is the correct pre-assembly default — I had to infer it
from `assemble-business-plan`'s own precondition text.
**Fix:** `docs/DATA-CONTRACT.md` should state explicitly that `plan.version` is absent/`0`/`null`
until the first assembly, and "starts at 1" describes the value `assemble-business-plan` writes,
not the skeleton default. One sentence closes this.
**Severity:** significant — silent, business-breaking on first assembly if triggered, easy to
avoid once you know, easy to hit if you don't.

### 1.4 — Polish/significant: Step 4/14's "use WebSearch" instruction is a soft suggestion with no enforcement
**Files:** `skills/disciplined-entrepreneurship/04-calculate-the-tam-for-the-beachhead-market/
SKILL.md` and `.../14-calculate-the-tam-for-follow-on-markets/SKILL.md` ("When the founder doesn't
know the count or the price": "use WebSearch for a credible published count... If nothing
credible turns up, use a clearly labeled range"); `.../11-chart-your-competitive-position/
SKILL.md` (same pattern for competitor positions).

I deliberately did not invoke WebSearch while drafting Steps 4, 11, and 14 for ShiftCover — I
went straight to the "nothing credible turns up" fallback branch. Nothing in any of these three
step skills' "Definition of done" checks whether a search was actually attempted before falling
back — the honest-fallback path and the lazy-skip-straight-to-fallback path are indistinguishable
from the output alone. To be clear, **the honest-fallback path itself worked exactly as designed**
(see "What worked well" below) — every unverified figure got flagged low-confidence with a
`key_assumptions`/`quantitative_claims` entry, nothing was silently invented. The gap is narrower
than "the system fails here": it's that a real executing agent under time pressure has no
structural nudge to actually try the search before reaching for the fallback, and the file can't
tell the difference after the fact.
**Fix:** add one line to each step's "Definition of done": *"If no WebSearch was attempted before
falling back to a founder-estimate/range, say so explicitly in the plan file's Assumptions
section — 'no external search attempted this session' — so a reviewer can tell the two paths
apart."*
**Severity:** polish leaning significant (it's a real, repeatable gap in three step skills, but
the honest-fallback discipline they fall back to is sound).

### 1.5 — Polish: `docs/DE-24-STEPS.md` and `CONVENTIONS.md` never mention `qc-*`/`ka-*` id-prefix conventions are non-canonical
Every step skill invents its own example id prefix (`qc-04-tam`, `qc-016-price`, `ka-013-...`,
`ka-015-model-fit`) with inconsistent padding (`04` vs `016`). None of this breaks anything
mechanically (ids are just strings, uniqueness is the only real requirement, and I kept them
unique throughout the fixture), but it means two different builders' step skills produce visibly
inconsistent id styles in the same `business-state.json`, which is a minor readability tax on
anyone auditing the file by eye. Not worth a schema change; worth a one-line style note in
`docs/DATA-CONTRACT.md`'s Conventions section if anyone revisits it.
**Severity:** polish.

---

## 2. Business-plan assembly

### 2.1 — Blocking (now fixed in `assemble-business-plan`, but the gap still lives one layer down): `agents/business-plan-editor.md` never instructs writing the required "Confidence & Validation Status" section
**Files:** `docs/AI-RISK-FRAMEWORK.md` (lines ~132-160, "Into the founder-facing plan"); `agents/
risk/ai-risk-analyst.md` (line ~139-144, flags its absence as a blocking structural finding);
`skills/business-plan/assemble-business-plan/SKILL.md` §7 ("Delegate the writing" — instructs the
editor to write the theme mapping, reconciliations, Key Assumptions & Open Risks, appendix, and
executive summary — **never mentions this section**); `agents/business-plan-editor.md` ("What you
write" / "Section structure" list — same omission, and this file is the one that actually decides
what gets written).

I confirmed by grep that `"Confidence & Validation Status"` appears in exactly the risk-layer
files that *require* it and **nowhere** in the two files that would actually produce
`plan/business-plan.md`. I proved this is a real, live bug, not a theoretical gap: I followed
`assemble-business-plan` and `business-plan-editor` exactly as written, produced a v1 plan with no
such section, ran `skills/risk/ai-risk-review` against it for real, and it correctly **BLOCKED**
(`risk_log` entry `ar-shiftcover-001`) — meaning every single business that reaches its first plan
assembly through this plugin, followed exactly as specified, will fail the mandatory pre-council
gate on the very first attempt, every time, until a human or another round notices and adds the
section by hand (which is what I did to keep testing downstream — see `ar-shiftcover-001`'s
`mitigated` note in `business-state.json`, which says explicitly the underlying skill files were
**not** patched).
**Fix:** add a `## Confidence & Validation Status` section to `agents/business-plan-editor.md`'s
"Section structure" list (placed right after Executive Summary, per the framework doc's stated
placement), and add one line to `assemble-business-plan/SKILL.md` §7 instructing the editor to
write it, sourced from `key_assumptions`/`quantitative_claims`/`risk_log` exactly as
`docs/AI-RISK-FRAMEWORK.md` specifies its four required parts. Same fix needed in `revise-
business-plan`'s synthesis instructions (§3) since it reuses "the same synthesis logic."
**Severity:** blocking — confirmed with a real produced artifact and a real gate run, not
inferred from reading alone.

### 2.2 — Significant: Step 17 (LTV) can silently skip its own mandatory `quantitative_claims` entry, and nothing catches it until a downstream reviewer notices
**Files:** `skills/disciplined-entrepreneurship/17-calculate-the-ltv-of-a-customer/SKILL.md`.

While drafting my fixture I made exactly the mistake this step is supposed to prevent: I wrote
`plan/17-calculate-the-ltv-of-a-customer.md` with a full LTV derivation and stated the $52,503
figure as the step's headline result, but never wrote the `qc-017-ltv` entry the step's own
"Quantitative claims (required)" section shows as an example — I only logged the *assumption*
entries (`ka-017-churn`, `ka-017-margin`). I caught it myself while drafting Step 19 (which needed
to cite the LTV figure and had nothing to cite). This is exactly the AI-risk failure mode #1 the
whole plugin is built to prevent, and it happened despite my following the step's instructions in
good faith — because the step's own "Definition of done" checklist says "Every material figure
has a `quantitative_claims` entry with a source" as a **prose instruction**, not something the
step mechanically verifies against its own output before reporting `drafted`. I later confirmed
`ai-risk-analyst`'s failure-mode-1 check (grep the artifact for factual figures with no matching
`quantitative_claims` entry) would in fact catch this — which is exactly what happened when I ran
the real gate (`risk_log` entry `ar-shiftcover-002`, also BLOCKING).
**Fix:** this is less a spec bug than a demonstrated single-point-of-failure: the *only* thing
standing between "an agent forgets one entry" and "an unsourced number reaches the founder" is the
downstream AI-risk gate actually being called — which is exactly why finding 3.1 below (the gate
not being wired into the DE steps themselves) matters so much. Recommend each step's "Definition
of done" include an explicit self-check line: *"Before reporting `drafted`, re-read this file's
own 'Quantitative claims logged' section and confirm every dollar figure/percentage/ratio stated
as fact above it has a matching entry — a heading with no JSON block under it is not done."*
**Severity:** significant — real, self-caught, but also a demonstration of exactly how easy the
slip is and how much weight rests on the gate actually running.

### 2.3 — Polish: `docs/AI-RISK-FRAMEWORK.md`'s required placement ("immediately after the executive summary") isn't cross-referenced in the theme-to-step mapping table
`assemble-business-plan`'s §2 theme-mapping table and §6 "Executive summary — written last" don't
mention where the Confidence & Validation Status section sits relative to the six theme sections —
once 2.1 is fixed, whoever fixes it should also state the placement inline in §7, not just rely on
the AI-risk framework doc being read separately.
**Severity:** polish (folds into the 2.1 fix).

### 2.4 — What actually worked well here
The **cross-step reconciliation logic actually caught a real, planted inconsistency.** I
(deliberately, to stress-test this) let Step 4's TAM use the flat $149/location/month rate while
Step 16 later introduced an 11+-location volume tier ($129/mo) that the beachhead's own average
group size (22 locations) qualifies for — a classic "upstream step gets outrun by a downstream
refinement" bug. Step 17's own file caught it and logged `ka-017-step4-price-mismatch`; the
assembled plan's Key Assumptions & Open Risks section surfaces it explicitly (Section 4 of
`plan/business-plan.md`); and the `financial-modeling-reviewer` persona independently re-derived
it during the council review and confirmed the ~13% TAM overstatement with real numbers, without
being told where to look. This is the reconciliation discipline working exactly as the
`assemble-business-plan` skill and `agents/business-plan-editor.md` intend, three layers deep.

---

## 3. Risk gates

**Note:** a sibling document, `docs/QA-FINDINGS-GATES-ROUND2.md`, already did an exhaustive,
caller-by-caller sweep of both risk gates (21 expected-caller pairs, only 2 real, 1 vague, 18
missing at the time it was written). I independently re-confirmed a representative subset by grep
rather than duplicate its table. Two of its "MISSING ENTIRELY" findings have since been fixed by
another concurrent round-3 pass — flagging the delta here since that doc may now read as
slightly stale on those two rows:

- **`skills/business-plan/assemble-business-plan/SKILL.md`** — that sibling doc's row #6 says
  "MISSING ENTIRELY." As of my read, this is **fixed**: §7.5 now calls `skills/risk/ai-risk-review`
  correctly, with an unambiguous BLOCKED/PASS branch. I confirmed this the hard way — my own dry
  run's gate call (finding 2.1 above) only happened because this wiring now exists.
- **`skills/business-plan/revise-business-plan/SKILL.md`** — that sibling doc's row #7 says
  "MISSING ENTIRELY." Also **fixed** as of my read: §3.5 now calls the gate correctly, in the
  same shape.

Everything else in that sibling document I independently re-confirmed as still accurate,
specifically:
- **Steps 04, 14, 16, 17, 19** (the five DE steps `ai-risk-review`'s own calling table names by
  name) still have **zero** reference to the gate anywhere in their files — confirmed by grep
  (`grep -n -i "ai-risk\|risk-review"` across all five returns nothing but one unrelated prose
  mention of "the Data Contract's AI-risk rule" in Step 14, which is not a gate call). This means,
  concretely, that in my own dry run **none of my five unit-economics/TAM steps were ever
  individually gated** — the AI-risk-review call that eventually caught my two real bugs (2.1,
  2.2) only happened once, at plan-assembly time, not five times earlier when it was supposed to
  per the gate's own contract. A founder stopping after Step 4 (very plausible — "let's just see
  the market size before going further") would get an unsourced-TAM figure with zero mechanical
  check on it, since the gate that's supposed to catch that never runs until assembly.
- **`skills/interview/onboarding-interview/SKILL.md`** never calls `skills/risk/privacy-check`
  Mode A — confirmed by grep (`-i "privacy"` returns zero matches in the entire file). I ran the
  full onboarding interview for ShiftCover exactly as written and never delivered the one-time
  local-storage/legal-scope notice `privacy-check`'s own file says must happen "right after the
  founder's business name and basic info are captured" — because nothing in the interview skill
  told me to. `agents/orchestrator.md` doesn't call it either (confirmed by grep — its only
  "privacy" mentions are generic delegation-map references, never an actual call instruction at
  Phase 1). This is a real, live gap I hit directly, not a hypothetical.
- **`skills/gtm/fundraising-deck-prep/SKILL.md`** — confirmed still zero references to the gate.

**Severity, my own read:** blocking for the 5 DE-step omissions and the onboarding privacy-notice
omission (both are gates the plugin's own architecture docs call mandatory, both are currently
unreachable in practice, and both are things a real founder session would hit within the first
hour of using this plugin) — see the sibling doc for the itemized, per-file fix text, which I
have nothing to add to.

---

## 4. Review council

### 4.1 — Significant: a discarded outlier's Required-revisions items disappear from the one checklist most likely to actually get read
**File:** `skills/business-plan/run-review-council/SKILL.md`, §6 (aggregation) and §8.4
("Aggregate Verdict" section — "the union of every required-revision item from every reviewer
whose verdict counted toward the aggregate severity").

I ran this for real (see `reviews/2026-08-18-balanced-panel-v1.md`). `customer-discovery-skeptic`
correctly REJECTed ShiftCover's plan — its single sharpest finding was that **zero of the Step 9
prospects show any real external signal of interest** (no scheduled call, no stated "yes," no
decline — just outreach status). Per §6's outlier rules, that REJECT was correctly discarded as a
non-corroborated outlier (no other reviewer's tags overlapped with it), and REVISE (held by two
reviewers on unrelated grounds) became the aggregate. That's the algorithm working exactly as
specified — my complaint isn't with the math. It's that §8.4's synthesized "Aggregate Verdict"
Required-revisions checklist — the section a busy founder is most likely to treat as *the* action
list — is built only from the reviewers at the final aggregate severity, so the skeptic's three
required revisions (including arguably the single most consequential finding on the whole panel)
never appear there. They're still visible in the skeptic's own full verdict block earlier in the
file (nothing is hidden, per the skill's own "no verdict is ever hidden or truncated" rule), but
that requires reading past the synthesized checklist to find them. I wrote this out explicitly in
my own review file's "Aggregate Verdict" section as a flagged note, but the skill itself has no
instruction to do this — a real run wouldn't necessarily surface it.
**Fix:** consider requiring the "Aggregate Verdict" section to append a short, separate
"Discarded-but-real concerns" subsection listing each outlier-discarded verdict's severity and
one-line summary (not its full required-revisions list — that would defeat the outlier logic's
purpose), so a founder skimming only that section still sees "customer-discovery-skeptic REJECTed
this — see their full verdict above for why" rather than nothing.
**Severity:** significant — the math is right, but the artifact's information architecture can
bury the harshest, most-corroborated-feeling single finding on the panel.

### 4.2 — Polish: the shared tag vocabulary has no tag for "false precision," even though it's a named, required check
**File:** `skills/business-plan/run-review-council/SKILL.md` (shared tag vocabulary list);
`agents/council/financial-modeling-reviewer.md` ("False precision — check this on every figure...
This is a genuine finding in your own rubric").

While writing `financial-modeling-reviewer`'s verdict for real, I hit this directly: the persona's
own instructions require flagging false precision as a distinct check from arithmetic errors and
sourcing gaps, but the vocabulary list (`[MARKET-SIZE]` ... `[FINANCIAL-ARITHMETIC]` ...) has no
dedicated tag for it. I tagged my false-precision findings `[FINANCIAL-ARITHMETIC]` for lack of a
better fit and said so explicitly in the review file. This isn't cosmetic: the whole aggregation
algorithm depends on mechanical tag-overlap checks across personas (§6, test 2) — a false-
precision concern raised by one persona under `[FINANCIAL-ARITHMETIC]` and a genuine arithmetic
error raised by another persona under the same tag would look like corroborating overlap when
they're actually unrelated findings, which could change an outlier-discard decision.
**Fix:** add `[FALSE-PRECISION]` to the shared tag vocabulary.
**Severity:** polish leaning significant (low probability of actually flipping an aggregate
verdict, but the mechanism for it to happen is real and I found it on the very first council run).

### 4.3 — What actually worked well here
The **panel-selection trigger logic is genuinely followable and correctly context-sensitive.** I
worked through §3's priority procedure by hand against ShiftCover's actual `business_basics` and
Step 12 content: `technical-feasibility-reviewer` correctly did not trigger (no hardware/regulated
content), and `sales-motion-reviewer` correctly did — not because of `business_type` (ShiftCover
is `saas`, which doesn't match that trigger's first clause) but because Step 12's DMU genuinely
does describe "anything beyond a single self-serve buyer-user-payer" (End User ≠ Champion ≠
Economic Buyer, plus a brand-dependent veto-holder). Getting this right required actually reading
Step 12's content, not just checking a category field — exactly the design intent stated in the
skill's own comments. The **outlier-discard algorithm, including the new floor rule, is
mechanically followable by hand** — I worked a real 5-verdict example (one REJECT correctly
discarded, two REVISEs correctly surviving as the aggregate with the harsher of the two scores
winning) without needing to guess at any step. The **track-inference logic** correctly landed on
Track C (no funding signal anywhere in my fixture) without forcing a read that wasn't there,
exactly as instructed.

---

## 5. GTM/ops handoff (spot-check)

I spot-checked `agents/gtm/launch-director.md` against what my fixture actually produced (the
business never reached `stage: approved` in this run — it's at `revising` — so I checked
structural alignment rather than running it live).

**Everything checks out.** Every file path and `business-state.json` key `launch-director` lists
under "What you read" exists and matches exactly what upstream skills produce: `plan/
business-plan.md` (produced by `assemble-business-plan`, same path); `business_basics.
venture_stage`/`business_type` (written by `onboarding-interview`, same key names); `gtm.*`
(present with the exact sub-keys `launch-director` expects to read/write:
`funding_strategy`/`status`/`launch_plan_file`/`artifacts`); `key_assumptions` and `risk_log`
(both populated, both readable for "open" entries); the most recent `reviews/*.md` entry
(`reviews/2026-08-18-balanced-panel-v1.md`, matching the naming convention `launch-director`'s own
example uses — `<date>-<track-slug>-panel-v<N>.md`); and the individually-named step files it
falls back to for thin sections (`plan/02-...md`, `plan/09-...md`, `plan/15-...md`,
`plan/22-...md`, `plan/23-...md`) all exist. `launch-director`'s own gate logic ("if `stage` is
anything before `approved`... stop and report back... name the specific blocker") is exactly the
behavior a real invocation would need to produce against my fixture's current `revising` state,
and its own worked example format (quoting a specific `reviews/*.md` filename and verdict) matches
the real file I produced almost exactly. No dead cross-references found here.

I also structurally checked `agents/ops/operations-manager.md`'s reads against my fixture (not run
live, since the business never reached `stage: operating`): its `quantitative_claims` step_ref
filter (`04`, `14`, `17`, `19`) matches real entries in my `business-state.json` with those exact
`step_ref` values, and the four plan files it reads directly (`plan/04-...md`, `plan/14-...md`,
`plan/17-...md`, `plan/19-...md`) all exist with the derivations it would need. No issues found.

**Severity:** n/a (nothing broken) — noted as a clean result, not skipped.

---

## 6. Other / cross-cutting

### 6.1 — Significant: `recurring-check-in`'s delegation map entry drifted, but this looks self-corrected
Nothing to report here beyond confirming `agents/orchestrator.md`'s Delegation Map row for
"Recurring check-in interview content" correctly points to `skills/interview/recurring-check-in`
(I checked this specifically because an earlier version I'd read pointed to a vaguer
`skills/interview/*` glob — the current file has the precise path). Noted as a clean result.

### 6.2 — Polish: `docs/DE-24-STEPS.md` step 18's parenthetical is easy to misread
Step 18's canonical name in `docs/DE-24-STEPS.md` is followed by a long parenthetical
("refines Step 13 with the rigor needed to cost it — expect overlap with Step 13, resolve it
explicitly rather than repeating the same content") that reads, on a fast skim, like it's
describing step 19, since it's the line immediately before step 19's TAM/COCA cluster starts.
Purely a formatting nit — I didn't misread it myself after slowing down, but it's worth a line
break for skimmability.
**Severity:** polish.

---

## What actually worked well

This is a genuinely well-designed system, and running it end to end for real surfaced more good
decisions than bad ones:

- **The vague-answer and genuine-unknown protocols in `onboarding-interview` and every DE step are
  followable, not just aspirational.** I pushed back on a real platitude ("we help restaurants
  manage their staff better") during onboarding exactly per the skill's playbook, got a real
  second-pass answer, and the "I don't know" protocol (cross-location backup-pool tolerance)
  produced a correctly-shaped `key_assumptions` entry instead of a forced number. This discipline
  held for all 24 steps, not just onboarding — every step I drafted that hit a real gap (thin
  end-user research, unsourced TAM, untested pricing, zero real usage data) produced an honest
  flag instead of a plausible-sounding invention, even when I was the one under implicit pressure
  to just produce a complete-looking plan.
- **The reconciliation logic actually works, three layers deep** (see finding 2.4) — a planted
  Step 4/Step 16 pricing inconsistency was caught by Step 17's own file, surfaced in the assembled
  plan's Key Assumptions section, and independently re-derived by a council persona, without any
  of the three needing to be told where to look.
- **The AI-risk gate is not security theater.** It genuinely blocked a real, freshly-produced plan
  on its first pass, for real, specific, correctly-identified reasons (missing structural section,
  one genuinely unsourced figure) — and did not block on the several other headline numbers that
  *were* properly sourced with honest low-confidence labels, showing the gate discriminates rather
  than just refusing everything.
- **The council's panel-selection and aggregation logic is mechanically followable by hand**,
  including a genuinely tricky worked example (a lone REJECT correctly discarded as an outlier,
  two REVISEs correctly surviving to become the aggregate) — see finding 4.3. This is real design
  quality: CONVENTIONS.md §6's "harshest non-outlier, not diluted" principle is not just a slogan
  here, it's an algorithm a person (or an agent) can actually execute correctly.
- **The GTM/ops handoff layer has zero dead cross-references** against everything upstream
  actually produces — every file path and `business-state.json` key lines up exactly (Section 5).
  For a system built by 15 parallel builders who never saw each other's work, this is a real
  achievement, not a given.
- **The tone and rigor bar (CONVENTIONS §7, `docs/UX-INTERVIEW-DESIGN.md`) is genuinely distinct
  and enforceable** — "no filler, no stacked hedges, one probing follow-up not a third
  rephrasing" is specific enough that I could actually tell when I was following it versus
  drifting into generic assistant-speak, which is a real design achievement for a document meant
  to guide LLM behavior.
