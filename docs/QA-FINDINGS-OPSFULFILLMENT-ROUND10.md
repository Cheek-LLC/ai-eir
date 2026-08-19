# QA Findings — Round 10: Operations & Fulfillment Playbook, Marketplace Branch (First Live Run)

**Method.** I copied the real `.startup/skyclaim/` fixture to an isolated
`.startup/skyclaim-t10-ops/` (slug updated to `skyclaim-t10-ops`; original `.startup/skyclaim/`
left untouched — confirmed via `git status` before and after, no diff). I read
`business-state.json` in full, `plan/15-design-a-business-model.md`,
`plan/09-identify-your-next-10-customers.md`, `plan/22-define-the-mvbp.md`,
`plan/23-show-that-dogs-will-eat-the-dog-food.md`, and the one existing review file,
`reviews/2026-08-18-venture-track-panel-v1.md` (the venture-track panel that includes
`marketplace-liquidity-specialist`'s seat), then read `skills/ops/operations-and-fulfillment-
playbook/SKILL.md`, the appended section of `agents/ops/operations-manager.md`, and
`agents/council/marketplace-liquidity-specialist.md` in full (cross-check only, not edited). I then
**actually executed** the marketplace branch of `operations-and-fulfillment-playbook` against this
fixture's real, current state and wrote a real output file: `ops/operations-review-2026-08-18.md`
(85 lines), plus a `risk_log` entry and a `cadence_metrics_files` append to `business-state.json`,
following the skill's own "Update business-state.json" instructions exactly. Nothing here is a
hypothetical description of what a run would produce — every number, gap, and finding below traces
to a file this session actually wrote and left on disk, or to the fixture's own pre-existing,
unmodified content.

**A real precondition mismatch, surfaced by actually running this, not by reading the frontmatter.**
`business-state.json.stage` is `"revising"` (the council REJECTed plan v1, score 2/10 — see the
review file) — not `"operating"` or `"gtm"`, the skill's own stated normal trigger. More
consequentially: `plan/23-show-that-dogs-will-eat-the-dog-food.md` states plainly that **zero MVBP
transactions have occurred**. I did not fabricate a transaction history to make the skill's
formulas produce numbers — I ran it honestly against a business that hasn't launched yet, using the
skill's own frontmatter allowance for direct invocation ("run directly when a founder asks about...
marketplace supply-side vetting and liquidity health") rather than the operations-manager
check-in path. This is disclosed in the output file itself, not just here.

---

## 1. The marketplace branch produced real, differentiated content — with one section genuinely thin, for a genuine reason

Running against SkyClaim's real fixture, the three marketplace subsections split cleanly into two
kinds of outcome, and both are legitimate tests of the skill, not a failure of the exercise:

- **Section 1 (supply-side onboarding/vetting) produced a real, non-generic, materially significant
  finding.** SkyClaim's supply-side "vetting" turns out to be personal recognition (for pilots Derek
  already knows) or an unverified certificate screenshot (for pilots he doesn't), with 0 of 5 named
  candidates ever rejected. This clears the skill's own stated materiality bar on **two independent
  grounds simultaneously** — no real process exists, and the informal approval rate is ~100% with
  no filter ever exercised — for a category (FAA-regulated aerial operation, insurance-claim
  documentation, property access) the skill itself names as exactly the kind where this matters.
  This is not generic "have a vetting process" advice; it's a specific, sourced finding about this
  business's actual named pilots (Marcus Webb, Priya Chandrasekaran, Jake Fennimore, Carlos
  Districh, Tom Whitfield), logged as `risk_log` entry `ops-skyclaim-t10-ops-1`.
- **Sections 2 and 3 (quality/trust mechanisms; liquidity operations) correctly, honestly produced
  "not applicable — zero completed transactions."** Fill/match rate is a literal 0÷0; ratings,
  disputes, and deactivations cannot exist because nothing has transacted. This is the skill's own
  "you do not fabricate metrics... 'not tracked' is the honest output" discipline (SKILL.md, "What
  you read") working exactly as designed under real pressure to produce *something* — I did not
  invent a plausible-looking fill rate or dispute count to make the section look more complete, and
  the skill's own materiality language ("Material →... fill rate trending down across 2+ periods")
  is correctly inapplicable to a business with one data point of zero, not two-plus periods to trend.

**Net assessment: yes, real and differentiated, not generic ops advice** — the vetting finding in
particular is a marketplace-specific, safety/trust-category-specific finding no generic "check your
suppliers" template would produce, and it correctly threads through the fixture's actual named
prospects rather than a hypothetical example.

## 2. Significant integration gap: the skill's marketplace section never operationalizes
`marketplace-liquidity-specialist`'s highest-weighted finding

This is the one finding I consider the headline result of this round, and it emerged specifically
from doing the cross-check the task asked for rather than treating it as a formality.

`skills/ops/operations-and-fulfillment-playbook/SKILL.md`'s marketplace section opens by billing
itself explicitly as **"the ongoing-operations execution of what `agents/council/marketplace-
liquidity-specialist.md` assessed at the plan stage."** That reviewer's own review file
(`reviews/2026-08-18-venture-track-panel-v1.md`) names its **disintermediation-risk finding** —
"once a matched pilot and contractor have each other's contact info and a completed transaction's
worth of trust, what stops them from going direct next time and cutting the take rate?" — as,
in the reviewing agent's own words, **"arguably the single most consequential finding on the entire
panel"** (see that file's "Aggregate Verdict" section, the paragraph explicitly surfaced because the
literal REJECT-only checklist would otherwise hide it). It sits at the top of
`marketplace-liquidity-specialist`'s own Required revisions list, and it's the one specific
disintermediation content point named as a rubric item in `agents/council/marketplace-liquidity-
specialist.md` itself (Step 15's rubric, point 3).

I read all three of the ops skill's marketplace subsections (supply-side vetting, quality/trust
mechanisms, liquidity operations) looking specifically for a metric that would let a future
operations review actually check whether this risk is materializing — something like "% of a
previously-matched pair's repeat transactions that stay on-platform" or "known off-platform-contact
incidents." **None exists.** The closest candidate, "Quality and trust mechanisms" (ratings,
disputes, deactivations), is adjacent but doesn't cover it — a pilot and contractor could maintain
perfect ratings and zero disputes while quietly transacting off-platform after their first match,
and this skill as written would never surface that. "Liquidity operations" tracks fill rate and
founder-manual-intervention share, neither of which would move if repeat business silently leaves
the platform after a successful first match.

This is not a contradiction between the ops skill's output and the plan-stage review — my own
executed output doesn't claim disintermediation isn't a risk, and nothing in the review claims
operations has since resolved it. It is a real content gap in the plugin: a skill that explicitly
promises to be a named reviewer's operational sequel, tested for the first time against the one
fixture built specifically to carry that reviewer's most consequential finding, doesn't yet carry
a way to check it. **Severity: significant, not blocking** — the skill still produces real, honest,
non-fabricated content without this metric; it just can't yet close the loop on the specific risk
it claims to be operationalizing. Recommend adding a fourth marketplace-section check (e.g.
"repeat-transaction on-platform rate" or "known off-platform leakage incidents") to
`skills/ops/operations-and-fulfillment-playbook/SKILL.md`'s marketplace section, explicitly citing
back to `marketplace-liquidity-specialist`'s Step 15 disintermediation rubric point the way the
supply-side section already cites the same reviewer's binding-constraint framing.

## 3. Minor: `ops.status` has no clear owner when this skill is invoked directly

`skills/ops/operations-and-fulfillment-playbook/SKILL.md`'s own "Update business-state.json"
section instructs appending to `ops.cadence_metrics_files` and to `risk_log`, and updating
`updated_at` — it says nothing about `ops.status` (`not_started|active`). Per
`docs/DATA-CONTRACT.md` and `agents/ops/operations-manager.md`'s own "Update
business-state.json.ops" block, `ops.status` reads as owned by `operations-manager` (it sets
`status: "active"` as part of its own check-in write-back). The fulfillment skill's own frontmatter
explicitly allows direct invocation ("run directly when a founder asks..."), independent of
`operations-manager`'s sequencing — which is exactly the path this round exercised. Following the
skill's literal instructions, I left `ops.status: "not_started"` untouched while
`ops.cadence_metrics_files` now has a real entry — a state where a real operations review exists on
disk and is registered in the array, but the summary status field a founder or another agent might
check first still reads "not started." **Severity: minor** (no data was lost or contradicted, and
I followed the skill's literal instructions correctly rather than guessing an owner for a field it
doesn't claim) — worth a one-line clarification in the skill ("if invoked directly outside an
`operations-manager` check-in, also set `ops.status: 'active'` if it isn't already") so a
directly-invoked run doesn't leave this field looking stale relative to what's actually on disk.

## 4. Consistency check requested by the task — explicit result

**The marketplace branch's output is consistent with, not contradictory to,
`marketplace-liquidity-specialist`'s plan-stage review**, on every point I could check:
- Both treat **supply as the binding, harder-to-win side** — the review from segmentation/DMU/
  next-10 evidence, my executed output from the (new) finding that the little supply that exists
  has never been through a real quality gate either. Same direction, different angle, genuinely
  corroborating rather than duplicating.
- Neither asserts the REJECTed plan is resolved or approved — my output states the `"revising"`
  stage and the REJECT verdict plainly in its own context section rather than silently treating
  the business as further along than it is.
- The one real gap found (§2 above) is an *omission* relative to the review's content, not a
  *contradiction* of anything the review says — worth fixing, but a different category of finding
  than the task asked me to watch for as a red flag, and I want to be precise that I did not find
  the more alarming outcome (the two disagreeing).

## Fixture disposition

`.startup/skyclaim-t10-ops/business-state.json`: `slug` updated to `skyclaim-t10-ops`; `ops.
cadence_metrics_files` now contains `"ops/operations-review-2026-08-18.md"`; `risk_log` has one new
entry, `ops-skyclaim-t10-ops-1` (`type: "business"`, `status: "open"`); `updated_at` bumped. No
other key touched. `stage` deliberately left at `"revising"` — this round did not attempt to resolve
the council REJECT or advance the plan, only to test the ops skill's marketplace branch against the
business's real, current, pre-launch state. Original `.startup/skyclaim/` is unmodified (verified
via `git status` — zero diff against it before and after this session).
