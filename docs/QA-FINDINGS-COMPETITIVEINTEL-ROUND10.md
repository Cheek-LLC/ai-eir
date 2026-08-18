# QA Findings — Round 10: Competitive Intelligence Monitoring (`skills/ops/competitive-intelligence-monitoring`, `agents/ops/competitive-intelligence-lead.md`)

**Method.** This is a live dry run, not a read-through. I copied the real `kindling` fixture to an
isolated `.startup/kindling-t10-compintel/` (untouched original preserved), updated only its
`business-state.json.slug`, then read the fixture's real `business-state.json` and
`plan/11-chart-your-competitive-position.md` in full — the real, already-drafted competitor roster
(Procreate, Duolingo, the Streaks app, r/SketchDaily, and the status-quo "solo Instagram posting"
alternative) and axes (accountability structure × creative breadth). I then read
`skills/ops/competitive-intelligence-monitoring/SKILL.md` and
`agents/ops/competitive-intelligence-lead.md` in full and executed the skill's steps directly: built
the competitor roster from Step 11, ran a real monitoring sweep against three of the five named
competitors using live WebSearch (Duolingo pricing/hiring, Streaks pricing/ratings, Procreate
features — one WebFetch attempt to the Procreate App Store page was blocked by this session's
network egress proxy), applied the win/loss reason taxonomy to one **role-played** lost-deal
scenario, and applied the Step 4 positioning-drift threshold to one **role-played** competitive
development. **Every role-played element is labeled ROLE-PLAYED inline in
`ops/competitive-intel-2026-08-18.md` and again below — none of it is asserted as a real Duolingo,
Procreate, or Streaks event.** I then wrote the output file per the skill's exact template and
updated `business-state.json` (`ops.cadence_metrics_files`, one `risk_log` entry) per the skill's
and agent's stated write contract. Artifacts produced: full transcript in
`.startup/kindling-t10-compintel/ops/competitive-intel-2026-08-18.md`; state changes in
`.startup/kindling-t10-compintel/business-state.json`.

## Finding 1 (significant): the skill's own applicability gate is not met by the fixture it's meant to track

Both the skill and the agent state their scope explicitly: "an operating business (`stage:
operating`, or late `gtm` post-soft-launch)." The `kindling` fixture is at `stage: "revising"` —
plan v1 was REJECTed by the 5-seat council panel, no MVBP has launched, `gtm.status` is
`"not_started"`. Neither condition holds. Nothing in the skill or the agent says what to do when
invoked against a business in this state — no refusal instruction, no "warn and proceed only if the
founder explicitly asks anyway" carve-out, nothing. I proceeded anyway per this QA task's explicit
instruction, and documented the mismatch prominently in the output file itself, but a real
orchestrator/founder session has no guidance from the skill about whether to run this at all
pre-launch. Given this is explicitly "the ongoing-ops sequel to DE step 11's one-time competitive
chart," and every other `agents/ops/*` skill in this plugin I'm aware of gates similarly on
`operating`, this specific gap (silence on the pre-condition-not-met case) is worth a one-line
addition to the skill — e.g. "if invoked before `stage: operating`/late-`gtm`, either decline and
say why, or explicitly label the pass as an early/advisory one-off" — but I did not edit the skill
file per my file-scope restriction.

## Finding 2 (the core question asked): is the drift-detection threshold actually applicable in practice?

**Partially, and one specific piece of its wording broke down under a real test.**

The four numbered RE-REVIEW criteria in Step 4 are, on the whole, unusually concrete for this kind
of judgment call — criteria 1, 3, and 4 gave me clean, mechanically checkable conditions (new
entrant on both axes; 3+/90-day win-loss count; a Core-claim-specific undercut). That's a real
strength versus most "use your judgment" thresholds elsewhere in this plugin.

Criterion 2 is where it broke down, in a way a real pass on this exact business will hit again:
criterion 2 requires a move that "closes the gap on **both** axes at once, not just one," with the
carve-out that a one-axis move only escalates if it's "the axis carrying the whole differentiated
position." I ran a role-played test — a hypothetical "Duolingo Sketch" pods feature that would move
Duolingo along the Y-axis (creative breadth) only, since Duolingo already sits at parity with
Kindling on the X-axis (accountability structure) per Step 11's own chart. Applying the threshold
literally required an answer to "which axis carries the whole differentiated position?" — but Step
11's own "Your differentiated position" section explicitly frames Kindling's differentiation as the
**combination** of both axes, not either one alone. The threshold's phrasing presumes a chart shape
(one dominant axis) that this real Step 11 chart doesn't have. I had to make an explicit,
stated-in-the-output judgment call (treating "already-tied-on-one-axis plus now-closing-the-other"
as functionally equivalent to closing both) rather than mechanically apply the rule as written. A
different agent/session could reasonably read the same case the opposite way (a strict "only one
axis literally moved, so it's a one-axis move, so note it and move on") and reach a different
verdict from the same evidence — that's a real gap, not a nitpick, since the two readings produce
opposite escalation outcomes.

A second, independent gap surfaced from a **real** (non-role-played) sourced observation: Streaks'
list price moved from ~$4.99 to $5.99 (~20%, sourced via WebSearch, dated 2026-08-18) — over the
note-it bucket's own "~15%" illustrative figure, but with no axis-position effect. None of the four
numbered RE-REVIEW criteria mention price magnitude in isolation — "repricing" only appears inside
criterion 2, gated on a both-axis effect. Read literally, this means no price move, however large,
crosses the threshold on its own without an axis effect — which is almost certainly the intended
reading, but the "~15%" figure sitting inside the note-it bucket's bullet list reads, on a first
pass, like an independent trigger rather than illustrative color. I resolved this the same way I'd
expect most agents to (note it and move on), but flag that the wording invites the opposite,
over-cautious misreading.

**Bottom line on Finding 2:** the threshold is applicable for 3 of its 4 criteria without
difficulty. Criterion 2 is applicable but under-specified for any Step 11 chart (like this real
one) whose differentiated position is explicitly framed as a two-axis combination rather than one
axis carrying it — which may well be the common case, since Step 11's own instructions push
founders toward exactly that "doesn't win trivially on both axes" honest framing rather than a
strawman chart.

## Finding 3: win/loss taxonomy produced something concrete, worked cleanly at small N

The role-played lost-deal scenario (a beta-waitlist prospect declining Kindling, citing Duolingo's
hypothetical new sketch-pods feature) mapped cleanly onto the fixed taxonomy: primary reason
"Feature gap," secondary "Relationship/incumbent switching cost," source labeled as a direct quote
(role-played) rather than blurred into "founder's read." The 3+/90-day pattern math worked exactly
as specified: with zero prior `competitive-intel-*.md` files and one entry this pass, the count
(Duolingo × Feature gap = 1) correctly did **not** cross the pattern threshold, and the skill's own
"don't manufacture a finding" discipline was easy to follow — no positioning-and-messaging hand-off
was warranted, and the output says so plainly rather than padding it. I did not get to test the
taxonomy's "unknown — no exit conversation happened" path or the 3+-pattern hand-off language
itself in this pass (would need at least 3 role-played entries across a spread of dates to exercise
that), which is a real limit of a single-pass dry run, not a defect found.

## Finding 4 (minor): "Next scheduled pass" template field assumes a date exists

`cadence.check_in_frequency` is `"manual"` for this fixture. Step 2 correctly says a manual-cadence
pass runs "when the founder asks or at a natural milestone" — but the output template's closing
field is literally `## Next scheduled pass` / `<Date, per the cadence rule in Step 2.>`, which
presumes a date. For `manual` cadence there is no date to state, only a trigger condition. Not
blocking (I wrote a condition instead of a date and it reads fine), but the template's own
phrasing doesn't anticipate its most bounded cadence value.

## Finding 5 (environment note, not a skill defect)

`WebFetch` to `apps.apple.com` was blocked by this session's network egress proxy
(`EGRESS_BLOCKED`). WebSearch worked throughout and was sufficient to source every claim actually
made in the output file. Noted because the skill leans on both WebSearch *and* WebFetch
("Competitor's own pricing page (WebSearch/WebFetch)") — in an environment where a given
competitor's own site is proxy-blocked, an agent following this skill needs to fall back to
WebSearch-only sourcing and mark the cell honestly ("not checked — WebFetch blocked"), which is
exactly what happened here and is itself a reasonable, already-supported outcome per the skill's
"not checked this pass — \<reason\>" convention. No change needed; recorded as an observed real
constraint, not a gap in the skill.

## Summary

- Roster build, monitoring-sweep discipline (sourced/no-change/not-checked, never blank), and the
  win/loss taxonomy all held up well under a real (partially live-sourced) execution.
- Two concrete, evidence-backed gaps: (1) the skill has no stated behavior for being invoked outside
  its own `operating`/late-`gtm` scope — silently proceeds; (2) Step 4 criterion 2's "axis carrying
  the whole differentiated position" language has no clean referent against a Step 11 chart whose
  differentiation is explicitly a two-axis combination, which is a real, reachable case, not an edge
  case invented to break the skill — this fixture's own Step 11 file is written that way.
- No fabrication occurred: every competitor claim is either sourced-and-dated (real WebSearch) or
  explicitly labeled ROLE-PLAYED; the one win/loss entry is explicitly role-played and labeled as
  such throughout, including in the `risk_log` entry written to `business-state.json`.
