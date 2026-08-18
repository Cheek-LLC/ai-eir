# QA Findings — Round 10: Autonomous Continuation, Live-Fired for the First Time

**Method.** This was a real, live dry run, not a read-through. `.startup/vantage-point-search`
(round 7's real post-pivot fixture: `stage: de_steps_in_progress`, `gtm.status: launched`,
`ops.status: active`, one open pivot-signal `risk_log` entry, real ops metrics/retro files through
2026-09-29) was copied verbatim to `.startup/vantage-point-search-t10-auto/`, its `business-state.
json.slug` updated to match, and every other file left byte-for-byte as copied. From there I read
the copy's full `business-state.json`, the tail of `interview-log.md`, and the most recent files
under `ops/`, `gtm/`, `reviews/`, `plan/` — then read `skills/autonomous-continuation/SKILL.md`,
`commands/continue-business.md`, and the relevant sections of `agents/orchestrator.md` (state
machine, Non-negotiables, Phase 2, Phase 6 "Reopening a subset of DE steps after a pivot",
"Recurring check-ins") in full. I then role-played being invoked exactly as
`/continue-business vantage-point-search-t10-auto`, fired by a scheduled Routine with no founder
present, and executed the skill's own instructions literally against the real fixture copy —
including a real mechanical cross-step skim of `plan/*.md` (not a description of what one would
find), real edits to the copy's `business-state.json` (`updated_at`, `cadence.
scheduling_mechanism`), and a real dated `interview-log.md` entry containing the actual digest
text produced. The original `.startup/vantage-point-search/` was never touched. Only the copy and
this findings file were modified.

## What was actually exercised

1. **Setup.** `cp -r .startup/vantage-point-search .startup/vantage-point-search-t10-auto`;
   `business-state.json.slug` updated to `vantage-point-search-t10-auto`.
2. **State read.** Full `business-state.json` (149 lines), `interview-log.md`'s 2026-09-29 tail
   (lines 260-370), `ops/2026-09-29-{retro,growth-metrics,finance-metrics,retention-metrics}.md`,
   `ops/kpi-dashboard.md`, and `agents/orchestrator.md`'s state-machine/Phase-2/Phase-6/Recurring-
   check-ins sections.
3. **Classification.** `stage: de_steps_in_progress` (the pivot-reopening value, not a first pass)
   was matched against the skill's "Autonomous-safe work by stage" table's `de_steps_in_progress`
   row. Confirmed dependency readiness for Steps 01/02/04/05 by reading each step skill's own
   "Read before starting" section directly (`skills/disciplined-entrepreneurship/01-market-
   segmentation/SKILL.md`, `.../02-select-a-beachhead-market/SKILL.md`,
   `.../04-calculate-the-tam-for-the-beachhead-market/SKILL.md`), not from memory or inference:
   Step 01 has no structural prerequisite (ready now); Step 02 requires Step 01 back at `drafted`
   (blocked); Step 04 requires Step 02 (blocked) and Step 03 (already `drafted`, satisfied); Step
   05 stays correctly at `drafted`/flagged, not reverted.
4. **Autonomous-safe work performed.** A real, read-only `Grep` skim of every `plan/*.md` file
   for content still referencing the pre-pivot 50-500-employee band — the specific check
   `agents/orchestrator.md` Phase 6 item 3 names and the 2026-09-29 log entry flagged as still
   open. This found real, concrete staleness (detailed below) in two steps the original pivot
   signal did not name.
5. **Ops work explicitly not performed**, with reasoning recorded (see Finding 1 below).
6. **Digest composed** in the skill's exact Phase-3 template and written into
   `interview-log.md`'s new dated entry (verbatim, not paraphrased in this findings doc).
7. **Phase 4 (reschedule) attempted for real**: checked this session's actual tool list, confirmed
   a real scheduling capability (`mcp__Claude_Code_Remote__create_trigger` / `send_later`) is
   present, and deliberately did not invoke it against this QA fixture, recording why in
   `cadence.scheduling_mechanism` (see Finding 3).
8. **Write-back**: `business-state.json.updated_at` and `.cadence.scheduling_mechanism` updated;
   `cadence.last_check_in`/`next_check_in` left untouched per the skill's own rule; no
   `disciplined_entrepreneurship` status, `gtm`, `ops`, `risk_log`, or `key_assumptions` entry was
   touched, since none was resolvable this cycle without the founder.

Real files read: `.startup/vantage-point-search-t10-auto/business-state.json`,
`interview-log.md`, `ops/2026-09-29-*.md`, `ops/kpi-dashboard.md`, `plan/01-*.md` through
`plan/24-*.md` (dependency headers + Grep skim), `skills/autonomous-continuation/SKILL.md`,
`commands/continue-business.md`, `agents/orchestrator.md`, `skills/disciplined-entrepreneurship/
{01,02,04}-*/SKILL.md`, `skills/ops/weekly-metrics-review/SKILL.md`.
Real files written: `.startup/vantage-point-search-t10-auto/business-state.json` (2 fields),
`.startup/vantage-point-search-t10-auto/interview-log.md` (1 new dated entry), this file.

## Verdict

**The skill works as designed for the core discipline it exists to enforce, and the disciplines
held under real pressure — but this first live firing surfaced three real, concrete gaps, one of
them (Finding 1) squarely the mid-pivot edge case this round was built to probe.** None of the
three are cosmetic; all three would produce a visibly wrong or unsafe outcome for a real founder
if left unfixed and hit at the wrong moment. This is exactly the kind of result a first live
execution should produce.

## Finding 1 (the one this round targeted) — the stage table has no row for "reopened mid-operation"

`business-state.json.stage` for this fixture is `de_steps_in_progress` — but not the *first-pass*
sense the skill's table text implies (`"Re-check step dependencies/readiness per Phase 2 of
agents/orchestrator.md"`). `agents/orchestrator.md` itself explicitly overloads this same `stage`
value for a second, structurally different situation: Phase 6's "Reopening a subset of DE steps
after a pivot," where a business that is `gtm.status: "launched"` and `ops.status: "active"` gets
`stage` moved back to `de_steps_in_progress` for only the implicated steps, while GTM/ops keep
running in parallel. The skill's `de_steps_in_progress` table row cites only Phase 2 (the
first-pass sequence) and never mentions Phase 6 at all.

Followed literally, the table gave a coherent, safe answer for this cycle (only the DE-step
readiness check was authorized; no ops work was authorized) — but that's because this fixture
happened to have no new ops period to snapshot anyway. The real risk is a **different** timing: a
business that pivots mid-operation, reopens 2-3 steps, and then has an unattended cycle fire while
the founder is deep into gathering real founder-reported metrics for the current period (or a
connector *is* wired up and has fresh data sitting there). Under a strict reading of the table,
that cycle would skip the ops snapshot entirely — silently, because `stage` says
`de_steps_in_progress` and the table's row for that stage says nothing about ops — even though
`ops.status: "active"` and there's real, safe, connector-sourced work sitting undone. The table is
single-axis (`stage` only); this business's real state is two-axis (`stage` for the DE-step
progression, `ops.status`/`gtm.status` for whether the business is still live). Recommend the table
either (a) add an explicit note that `ops`/`gtm` autonomous-safe work continues independently of
`stage` whenever `ops.status: "active"`/`gtm.status: "launched"`, regardless of what `stage` says,
or (b) add a dedicated row/footnote for "de_steps_in_progress via a pivot reopening, ops/gtm still
live" that says plainly what is and isn't safe in that combined state. I made a conservative call
here (skip ops work, explain why) rather than silently improvising past the table — the right
outcome for this specific cycle, but only because this fixture had nothing new to snapshot; a
future fixture with fresh ops data sitting on disk would make the gap visible and costly (a real
founder losing a scheduled ops check-in silently, with no error, during exactly the period they
most need visibility — mid-pivot).

## Finding 2 — the pivot's own implicated-step list was already incomplete, and nothing catches that except this skill's mechanical skim

The mechanical, read-only cross-step check this cycle performed (Phase 6 item 3, explicitly
flagged as still-open in the 2026-09-29 log) found real staleness `agents/ops/operations-manager.
md`'s original pivot-signal write did not catch:

- `plan/09-identify-your-next-10-customers.md` still lists prospect #2 (~80 employees) as
  "proposal sent" and #4 (~60 employees) as "first conversation only" — **these are the exact two
  prospects `ops/2026-09-29-growth-metrics.md` already recorded as declined**, on
  2026-09-24/2026-09-26, for the exact fee-justification reason that triggered the pivot in the
  first place. Step 9's own file is now stale against ops data written the same session. It also
  still lists #6 (~95 employees) and #8 (~55 employees) as live/active prospects, both below the
  founder's stated new ~120-employee floor.
- `plan/14-calculate-the-tam-for-follow-on-markets.md` states outright that its Pin-2 TAM uses
  "the same company-count basis" as Step 4's 50-500-employee band — the exact same cascade
  dependency Step 4 has (which *was* named) — but Step 14 was not in the pivot signal's implicated-
  steps list at all.

This is a real gap one level up from the skill under test: `agents/ops/operations-manager.md`'s
pivot-handling section (round 9's own build) named steps 01/02/04/05/16 as implicated but missed
09 and 14, both of which any DE-24-steps-aware skim finds mechanically, without any founder
judgment. Whether this is a bug in `operations-manager.md`'s pivot section (should do this skim
itself before naming implicated steps) or a permanent gap this round's own `autonomous-continuation`
skill is meant to catch on a later cycle is a real design question, not obviously either answer —
recording it here for a human/integration pass rather than guessing. I deliberately did **not**
apply a `NEEDS RE-CONFIRMATION` marker to either step's `summary` field myself: `agents/
orchestrator.md`'s Phase 6 describes implicated steps as "named by whoever raised it:
operations-manager, launch-director, the founder directly, or you [the orchestrator]" — a list
that does not obviously include an unattended continuation cycle. Reported the finding in the
digest/log for the founder/orchestrator to confirm and apply, rather than deciding unilaterally
that this cycle's authority extends that far. This is exactly the kind of judgment call the task
asked me to watch for — I found myself at a real fork with no clean textual answer, and chose the
more conservative reading rather than guessing which was intended.

## Finding 3 — Phase 4's "if one exists, use it" has no allowance for "exists, but shouldn't be used here"

Phase 4 reads: "look for a scheduling capability... if one exists, use it... If none exists, this
cycle itself couldn't have been autonomous in the first place... so simply remind them." This
session genuinely has a scheduling capability
(`mcp__Claude_Code_Remote__create_trigger`/`send_later`) — so, strictly, the "if one exists, use
it" branch applies, not the fallback the task anticipated I'd need. I did not invoke it, because
doing so would create a real, persistent Routine against the operator's real account, tied to a
disposable QA fixture slug (`vantage-point-search-t10-auto`) — a genuine, unwanted side effect for
a test, and outside this task's explicit file scope. This is a real gap in the skill's own text,
not just an artifact of the QA environment: nothing in `skills/autonomous-continuation/SKILL.md`
or `commands/continue-business.md` distinguishes "a real business a founder wants on a recurring
cadence" from "a test/fixture/one-off run that happens to be invoked in an environment where a
scheduling tool is technically available." A literal, mechanical execution of Phase 4 in a non-test
environment — e.g., someone running `/continue-business` once, by hand, just to see what it does,
in a session that happens to have Routine-creation tools available — would silently wire up a real
recurring trigger the user never asked for. Recommend Phase 4 gain an explicit check: confirm with
the founder (or require a prior, explicit opt-in already on record, e.g. in `cadence.
scheduling_mechanism`) before creating a *new* Routine, versus freely re-arming an *existing* one
that a live session already set up on purpose. I made the conservative call for this test and
documented the override reasoning in `cadence.scheduling_mechanism` and `interview-log.md`, rather
than treating the tool's mere presence as sufficient authorization.

## Secondary observations (real, but not blocking)

- **The digest has no specified durable home.** Phase 3 says compose it; nothing in the skill or
  `commands/continue-business.md` says where it lives once composed, beyond "a message someone
  returns to later." In a live Claude Code Remote Routine firing, that's presumably the session
  transcript itself — but nothing on disk points a founder at *which* session to reopen weeks
  later, and the skill's own write-back rules only mandate the `interview-log.md` entry (a
  compressed record of what happened, not the digest verbatim). I resolved this pragmatically by
  reproducing the digest verbatim inside the `interview-log.md` entry, but the skill doesn't say to
  do that — worth making explicit rather than leaving each execution to improvise a location.
- **Ops autonomous-safety is narrower in practice than the table implies, independent of Finding
  1.** Even under `stage: "operating"`, this business's own ops skills (`weekly-metrics-review`,
  `runway-and-burn-tracking`, `retention-and-churn-analysis`) are all built to ask the founder
  directly for period actuals and explicitly refuse to fill in an unreported number — confirmed by
  reading `skills/ops/weekly-metrics-review/SKILL.md`'s own description ("Never fills in a metric
  the founder hasn't reported"). `connectors.wired_up` is empty for this business. So the `operating`
  row's promise of "metrics snapshots and retros... against data already on disk or from wired-up
  connectors" would, for *this specific business*, produce nothing new regardless of stage, unless
  a connector gets wired up first. Not a bug in the skill under test — it correctly says "from data
  already on disk or a connector" — but worth flagging that the realistic autonomous-safe ops
  surface for a connector-less business is close to zero, which the table's phrasing doesn't make
  obvious at a glance.
- **The "never fabricate / never cross a gate" disciplines held cleanly, with no guessing required
  on those two specifically.** Every candidate action this cycle actually considered had an
  unambiguous answer once the relevant "Read before starting" section or Non-negotiable was
  actually read (not assumed): no DE step content was drafted, no `founder.*`/`business_basics.*`
  field was touched, no council verdict was treated as resolved, nothing was sent/spent/launched.
  The only place real judgment was required was the *scope of this skill's own authority*
  (Findings 1-3 above), not whether a specific action was safe once its bucket was correctly
  identified.
- **The digest is genuinely usable cold.** Read back the Phase-3 digest in `interview-log.md`'s
  2026-10-13 entry as if seeing it fresh: it states the one unblocked next action in one sentence,
  lists exactly what's still open with enough specificity to act on (not vague "check assumptions"
  language), and doesn't bury the two new stale-content findings inside a wall of process narration.
  A founder scanning it on a phone would know to run Step 01 next and would see the two Step
  9/14 flags without having to reconstruct them from the interview-log's fuller prose above it.

## What a human/integration pass should do with this

1. Decide Finding 1's fix: either make ops/gtm autonomous-safe work independent of `stage`, or add
   an explicit combined-state row/footnote to the `de_steps_in_progress` table entry.
2. Decide Finding 2's fix: either broaden `operations-manager.md`'s pivot-implicated-step naming to
   include a mechanical cross-step skim before it writes the `risk_log` entry, or explicitly grant
   `autonomous-continuation` (or the orchestrator, next live session) authority to apply `NEEDS
   RE-CONFIRMATION` markers found this way, and say so in the skill text.
3. Decide Finding 3's fix: add an explicit "don't create a new Routine without a prior, on-record
   opt-in" guard to Phase 4, distinct from "re-arm an existing one."
4. Apply steps 09 and 14's `NEEDS RE-CONFIRMATION` flags (or confirm they're not needed) in a real
   session, and actually run Step 01 with Jordan — this fixture is now sitting exactly where the
   2026-09-29 session left it, one live session away from unblocking the rest of the pivot.
