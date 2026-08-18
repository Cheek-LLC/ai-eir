# QA Findings — Round 7: The Founder-Override Path, Exercised for the First Time

**Method.** `.startup/shiftcover/` came into this round at `stage: "revising"`, having just failed
its second consecutive council review — `reviews/2026-08-25-bootstrap-track-panel-v1.md`, aggregate
**REJECT** (score 4), the plan's first-ever real revision cycle having addressed 4 of 5 prior
required revisions and still come back rejected. I read every persona's full verdict in that review
file (not just the aggregate), the "Also flagging, regardless of severity" section, `CONVENTIONS.md`
§6, `docs/DATA-CONTRACT.md`, `agents/orchestrator.md` in full (state machine, Non-negotiable #3, and
Phase 4), and `skills/business-plan/run-review-council/SKILL.md` §9. I then role-played the
orchestrator handling this REJECT with founder Maria Chen through to a real, deliberate, on-record
"yes, override" — this plugin's first-ever live exercise of `agents/orchestrator.md` Non-negotiable
#3's founder-override mechanism, confirmed never before exercised by `docs/ROADMAP.md`,
`docs/TESTING.md` §3.2, and `docs/QA-LAYER3-REGRESSION-ROUND5.md`, all of which name this exact gap
by name. Every artifact below is a real file this session wrote and is still on disk:
`.startup/shiftcover/interview-log.md` (new 2026-08-27 entry), `.startup/shiftcover/business-state.json`
(4 new `risk_log` entries, `stage`, `reviews[1].resolved`, `business_basics.funding_intent`,
`gtm.funding_strategy`), and `.startup/shiftcover/reviews/2026-08-25-bootstrap-track-panel-v1.md`
(noted-but-overridden marks, not deleted). I also patched two repo files where I found small,
clear-cut bugs directly implicated by this exercise (see findings #1 and #3). `scripts/
validate-plugin.sh` passes clean (0 warnings, 0 errors) after all changes.

**Scope discipline, stated plainly.** This round deliberately stops at confirming the override
mechanism and the GTM hand-off boundary work correctly — it does **not** run `launch-director`'s
full sequencing pass (`marketing-strategist` → `sales-lead` → `gtm/launch-plan.md`). `stage` ends
this round at `"approved"`, not `"gtm"`; `gtm.status` stays `"not_started"`. Flipping those forward
without actually doing the specialist work they represent would be exactly the kind of fabricated-
artifact failure mode this QA discipline exists to catch, not commit. Full GTM execution against an
overridden plan is real, worthwhile next-round work — see "What's still untested" at the end.

---

## 1. Real bug, fixed in place: the state-machine diagram actively misdescribed the override path

**File:** `agents/orchestrator.md`, the ASCII state-machine diagram (was lines 122-127).

Before this round's fix, the diagram's only branch out of `revising` read:

```
revising
   │  required revisions addressed (or founder override logged)
   ▼
council re-run while stage is still "revising" (its own precondition)
```

Read literally, this says a founder override is followed by **another council re-run** — which is
backwards. The entire point of Non-negotiable #3's override mechanism is that it *substitutes* for
a clean re-pass; forcing a re-run after an override would mean the override accomplished nothing.
Non-negotiable #3's own prose never says this, and Phase 4's closing paragraph ("When the loop lands
on APPROVE/APPROVE_WITH_NOTES (or a logged founder override) and stage is `"approved"`...")
*implies* the real behavior (override → `approved` directly) but never states it as an instruction —
it's phrased as a precondition to the next sentence, not a step. I had to infer the correct behavior
from that one clause plus the internal logic of what an override is *for*, rather than being told it
directly anywhere. This is exactly the kind of underspecified transition the task asked me to hunt
for, and it sits in the single highest-traffic reference document in the plugin (every orchestrator
session reads this diagram to know what state comes next). **Fixed**: the diagram now shows two
distinct branches out of `revising` — "required revisions addressed" (loops back through a real
re-run) vs. "founder override logged" (goes straight to `approved`, explicitly labeled "no re-run").
**Severity: significant** (actively wrong, not just silent, in the one document a resuming session
is instructed to treat as authoritative for what happens next — and this exact branch had literally
never been exercised before this round, so the bug had zero chance of being caught by any prior dry
run).

## 2. Real ambiguity, judgment call made and logged: what `reviews[].resolved` means on the override path

**Files:** `skills/business-plan/run-review-council/SKILL.md` §9; `agents/orchestrator.md`
Non-negotiable #3.

`run-review-council`'s own comment on `resolved` says: "it becomes `true`... for REVISE/REJECT, once
`skills/business-plan/revise-business-plan` closes the loop." That sentence describes exactly one
path — revise, then re-review to a clean verdict — and says nothing about the override path, where
`revise-business-plan` is never invoked at all (confirmed by grep: every specialist skill in this
repo that touches a blocking gate explicitly states "this skill does not accept an override itself,"
routing back to the orchestrator — `revise-business-plan` has no override-acceptance logic to "close
the loop" through). Non-negotiable #3 frames the override as a fully equivalent, alternate way of
satisfying the same gate ("...unless **one of the following** is true...") — which argues `resolved`
should become `true` the moment the orchestrator itself executes the override, since that *is* the
resolution; nothing else is coming. But no file says this in so many words. **I resolved this by
judgment call**: `reviews[1].resolved` is now `true`, on the reasoning above, stated here rather than
silently assumed. A future maintainer might reasonably decide the opposite (leave `resolved: false`
forever on an overridden-not-fixed review, on the theory that "resolved" should mean "the underlying
concern was actually addressed," not "no further action is pending") — that's a real, defensible
alternative reading, which is precisely why this is a finding and not just a fix. **Fix suggestion**:
add one sentence to `run-review-council/SKILL.md` §9 covering the override branch explicitly, and/or
to `agents/orchestrator.md` Non-negotiable #3 itself, so the next agent to hit this doesn't have to
re-derive it. **Severity: minor-to-moderate** (didn't block execution — I made and documented a
defensible call — but it's a real, first-time-discovered doc gap in the mechanism's own write-back
contract).

## 3. Real bug, fixed in place: `launch-director` would have silently missed an override entirely

**File:** `agents/gtm/launch-director.md`, "Gate before you start" and "What you read" sections.

This is the finding the task's item 4 specifically asked me to check for, and the answer, before the
fix, was: **it would proceed as if the plan were clean.** Two independent reasons, confirmed by
reading the file in full, not assumed:

1. **The Gate check only reads `stage`.** Before this round's fix, "If `stage` is `approved`, this
   is a fresh GTM kickoff: proceed" was the entire check — nothing distinguished a `stage` that
   reached `approved` via a clean `APPROVE`/`APPROVE_WITH_NOTES` from one that reached it via a
   Non-negotiable #3 override on a standing REJECT. Both look identical at the `stage` field.
2. **The "What you read" section's own `risk_log` instruction would have actively hidden the
   override even if someone thought to look.** It reads "`key_assumptions` and `risk_log` (**anything
   open** and relevant to launch)" — but Non-negotiable #3's own required value for an override entry
   is `status: "accepted"`, not `open`. Taken literally, `launch-director` would filter out exactly
   the entries the override mechanism produces, by construction, every time. This isn't a hypothetical
   interaction between two files that happened to be written independently — I confirmed it directly
   against this round's real 4 new `ov-shiftcover-*` entries, all `status: "accepted"`, all invisible
   to the literal "anything open" instruction.

The net effect, unfixed: a founder who overrode a REJECT and told the orchestrator to proceed to GTM
would have gotten a `gtm/launch-plan.md` — and every subsequent interaction with `launch-director` —
with **zero mention** that this plan proceeded over a blocking verdict, exactly the silent-failure
mode the task asked me to check for and the one place downstream of the override where it would have
mattered most (a launch plan is the artifact most likely to be shown to a contractor, an early hire,
or an investor). **Fixed**: added an explicit check to the Gate section — read the most recent
`reviews[]` verdict every time `stage` is `approved`; if it's REVISE/REJECT, confirm via the review
file's override mark and the matching `accepted` `risk_log` entries, then state the override plainly
to the founder and carry it into `gtm/launch-plan.md`'s risk section by name, before any sequencing
work. **Verified working**: walked the patched gate logic against ShiftCover's actual current state
(`stage: "approved"`, `reviews[1].verdict: "REJECT"`, 4 matching `accepted` risk_log entries) and
confirmed it correctly fires the flag — see `interview-log.md`'s 2026-08-27 entry for the exact
output. **Severity: significant** (a genuine, demonstrated silent-failure risk on the one channel
this whole mechanism depends on for downstream visibility — not a stylistic gap).

## 4. Real gap, not fixed (out of authorized scope): no `risk_log.type` value cleanly fits a review-gate override

**File:** `docs/DATA-CONTRACT.md`, `risk_log[].type` enum (`ai_risk|privacy|legal|business`) — read
only, not edited, per this round's explicit restriction.

Non-negotiable #3 requires "`type` appropriate to the risk" on each override entry, but none of the
four enum values is a clean fit for "a review-council verdict was overridden." `business` is the
closest available option, but the Data Contract's own note scopes it explicitly and narrowly:
"`risk_log[].type: "business"` is for material drift/operational findings raised by the
`agents/ops/*` layer **post-launch**... distinct from `ai_risk`/`privacy`/`legal`, which are
typically raised by `agents/risk/*`." A pre-launch council-verdict override raised by the
orchestrator itself is neither of those things. I used `business` anyway, as the least-wrong fit, and
flag it here rather than silently picking a type the doc doesn't actually authorize for this purpose.
**Severity: minor** (functional workaround exists, didn't block, but is a real taxonomy gap —
`docs/DATA-CONTRACT.md` is explicitly off-limits for editing this round, so this is logged, not
fixed).

## 5. Minor observation: no `risk_log[].id` naming convention exists, unlike `key_assumptions`/`quantitative_claims`

**File:** `docs/DATA-CONTRACT.md` — the Conventions section documents `ka-NN-slug`/`qc-NN-slug` as
readability conventions (not schema requirements) for the other two arrays, but says nothing about
`risk_log[].id`. The existing entries in this business's `risk_log` all use `ar-<slug>-NNN` (an
`ai-risk-analyst` convention, implicitly), which doesn't semantically fit a founder-override entry
raised by the orchestrator, not the risk analyst. I used `ov-shiftcover-00N` (override) as a new,
self-consistent prefix, stated here so a future editor understands why it doesn't match the existing
`ar-` pattern rather than reading it as an inconsistency. **Severity: minor / no action needed** —
`risk_log[].id` values only need to be unique, exactly like `ka`/`qc`, and this satisfies that.

---

## What actually worked well

- **Non-negotiable #3's "not a shrug" bar is genuinely enforceable, not just aspirational prose.**
  Playing the founder side honestly, it was easy to feel the difference between "I guess we have to
  move on" (a shrug) and Maria's actual response — a reasoned partial agreement (accepts 2 of 4
  risks outright), a real disagreement with one specific finding stated on its own terms (not
  dismissiveness), and a plainly-stated acceptance of the one she takes most seriously. The
  instruction's own phrasing ("not a shrug or a change of subject") gave a concrete, checkable bar to
  write against, and it held up under an actual role-play rather than collapsing into a rubber stamp.
- **The review file's "Also flagging, regardless of severity" section (round 6's design addition) did
  exactly the job it was built for, on its first real founder-facing use.** `sales-motion-reviewer`'s
  `[SALES-CYCLE]` finding wasn't part of the REJECT's synthesized checklist (softer severity than the
  aggregate), but it was the single fact that mattered most to a founder deciding whether to override
  — it's the corroborating evidence keeping the REJECT from being an outlier, and it's not a
  disagreement, just a plain number (2 of 7). Having it separately labeled meant it couldn't get lost
  under the harsher verdict's own checklist, and it visibly changed the quality of the founder's
  decision in the role-play (she named it as the one she takes "most seriously," distinct from the
  three she partially disputes).
- **The aggregation accounting in the review file made an informed override possible at all.** Because
  the file shows its work (why the REJECT wasn't discarded as an outlier, that 3 of 5 seats actually
  landed at `APPROVE_WITH_NOTES`, exactly which persona and tag kept it alive), the founder could make
  a genuinely calibrated decision — "I'm overriding one persona's REJECT that's corroborated by one
  specific cross-cutting finding," not "I'm ignoring the whole panel." That distinction is real and
  the file's transparency is what makes it visible.
- **`risk_log`'s `status: "accepted"` + "never silently deleted" design worked cleanly under real
  use.** Nothing needed to be removed, hidden, or reworded — four new entries appended, the original
  three-item required-revisions list and the "Also flagging" note both still stand verbatim in the
  review file with inline overridden-marks next to them, exactly matching Non-negotiable #3's "not
  deleted" requirement.
- **Every specialist skill's "does not accept an override itself" boundary held up under a real
  cross-file check.** Grepped for "override" across the repo: `revise-business-plan`,
  `assemble-business-plan`, every DE-step skill with a blocking gate, `ai-risk-review`, and
  `privacy-check` all explicitly route back to the orchestrator rather than claiming override
  authority themselves. There was no ambiguity about *who* executes Non-negotiable #3 — only, per
  findings #1-#3 above, real gaps in exactly *what* executing it writes and *who downstream* finds
  out about it.

## What's still untested after this round

- **The full `launch-director` sequencing pass against an overridden plan.** This round confirms the
  *gate* correctly detects and flags the override; it does not exercise `marketing-strategist` or
  `sales-lead` actually producing GTM artifacts, nor confirm the override language survives intact
  into a real, complete `gtm/launch-plan.md`.
- **A founder changing their mind after an override** — e.g., a later check-in surfacing that one of
  the four accepted risks materialized for real (the Step-9 list genuinely doesn't convert, say) and
  the founder wanting to revisit rather than proceed further. Nothing in this plugin's design was
  exercised for "walk back an accepted risk" — only for accepting one.
- **A second business exercising this same path with a different shape of disagreement** — this round
  is one real data point, not a stress test of the mechanism across varied founder reasoning (e.g., a
  founder who wants to override *everything* with no partial agreement, or one whose stated reason is
  weaker and where the orchestrator's own judgment about whether a "yes, override" is genuinely
  informed becomes load-bearing).
