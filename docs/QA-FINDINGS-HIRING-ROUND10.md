# QA Findings — Round 10: Hiring and Org Design, First Live Execution

**Method.** I copied `.startup/vantage-point-search/` to an isolated
`.startup/vantage-point-search-t10-hiring/` (updating its `business-state.json` `slug` field to
match) and worked exclusively inside that copy — the original fixture and other parallel test
agents' copies were not touched. I read `CONVENTIONS.md` and `docs/DATA-CONTRACT.md` in full, then
`business-state.json` in full and both real `ops/*-finance-metrics.md` check-in files
(`2026-09-15` and `2026-09-29`) plus the matching `ops/*-growth-metrics.md` and `ops/*-retro.md`
files and `plan/24-develop-a-product-plan.md`, before reading `skills/ops/hiring-and-org-design/
SKILL.md` and `agents/ops/people-lead.md` in full. I then role-played Jordan (the real founder in
this fixture) asking whether to proceed now with the associate-recruiter hire that
`plan/24-develop-a-product-plan.md` already costed as the roadmap's #2 near-term priority, and ran
the full should-we-hire flow — Steps 1-5 of the skill — against this fixture's **real** numbers,
not invented ones. I wrote the real output file, `ops/hiring-plan-associate-recruiter-2026-09-29.md`,
and read-modify-wrote `business-state.json` to register it in `ops.cadence_metrics_files` and to
append a `risk_log` entry, since the runway math landed Warning. Everything below reports what
actually happened running the skill against this fixture, not a hypothetical description.

**Bottom line: the skill is well-built and the execution produced a real, usable, non-generic
deliverable — but it surfaced two genuine gaps (one in this skill, one inherited from the data
contract/other skills' fixture state) worth fixing, plus one execution-order judgment call I made
that the skill doesn't resolve for you.**

---

## 1. The runway-gate math was computable, but only with a judgment call the skill doesn't cover

This was the most consequential finding. The skill's mandatory runway math (Step 1b) requires
"the latest `ops/*-finance-metrics.md`" as the baseline. The literal latest file for this fixture,
`ops/2026-09-29-finance-metrics.md`, reports runway as **"not applicable — cash-generative this
period"** — a single $23,500 fee-installment payment made that period's net burn negative. That
same file explicitly warns, in its own words, that this is "a single lumpy fee-installment
payment... not a repeatable revenue run-rate" and that "next period's spend/revenue will most
likely look like period 1 again."

If I had mechanically plugged that literal "latest" figure into the skill's formula (`post-hire
net burn = latest net burn + hire cost − revenue contribution`), the result would have been **a
hire that still looks cash-generative after $7,583/month of new fixed cost** — a materially
misleading "no runway objection" result produced directly from the finance-metrics file's own
explicit warning against reading that number as ongoing. I instead used the *prior* period's
steady-state monthized burn ($2,571/month) as the baseline, paired with the *current* (higher,
real) cash-on-hand figure — which produced a real, honest Warning-level result (~5.6 months
post-hire runway) instead of a false-negative "all clear."

**This is a real gap in `skills/ops/hiring-and-org-design/SKILL.md`, not a fixture artifact.** Step
1b assumes "latest monthized net burn" is always a usable number. It doesn't say what to do when
the producing skill (`runway-and-burn-tracking`) has itself flagged the latest figure as
non-representative or "not applicable." A less careful executor of this skill — or a future
automated run with no one to apply judgment — would very plausibly take the literal latest number
at face value and produce a dangerously wrong "proceed, no runway concern" read for a business that
is, in every other respect, still burning cash at its normal rate. Recommend the skill add explicit
guidance: when the latest finance-metrics file itself flags its period as non-representative
(one-time payment, cash-generative from a lump sum, etc.), fall back to the prior period's
steady-state figure (or ask the founder) rather than using the literal latest number unmodified.
I documented this judgment call transparently in the output file itself
(`ops/hiring-plan-associate-recruiter-2026-09-29.md`, "Baseline-burn judgment call" section) so it's
auditable, but the skill shouldn't require every executor to invent this reasoning from scratch.

## 2. The services-specific sequencing guidance's own stated trigger did not actually fire — and the skill's "confirm against evidence" instruction is exactly what caught it

Step 2's `services` pattern names one concrete trigger for a delivery-staff first hire: "triggered
when the founder's own billable hours are the bottleneck (check... utilization data if it
exists)." The real utilization data in this fixture (`ops/2026-09-29-growth-metrics.md`) reports
**28% billable utilization** (up from 22%) — nowhere near a bottleneck reading. By the pattern's
own stated trigger, this does not currently support the hire.

This is worth calling out as a **success**, not just a gap: the skill's own instruction to "confirm
against what `operations-manager`'s retros have actually shown as the binding constraint (the
pattern below is a prior, not a substitute for the business's own evidence)" is exactly what
surfaced this. It stopped me from mechanically citing "founder capacity is the bottleneck" when
the retro evidence plainly said otherwise, and it forced a more honest sequencing rationale in the
output file: the real justification for this hire (per `plan/24`) is validating
`ka-020-associate-replication` ahead of demand, not relieving current capacity pressure — a
legitimate but *different* reason than the one the pattern's trigger names. The skill still
produced a defensible "full-time hire" classification, but only because I wrote out the honest
distinction rather than following the pattern mechanically. A less careful execution could easily
have cited the stock trigger language without checking it against the real utilization number —
worth a small SKILL.md addition noting explicitly that a business-type pattern can support a hire
for a reason other than its own named trigger, and that the output should say so plainly when that
happens, rather than only checking the box.

## 3. The `operating`-stage gate doesn't cleanly describe this fixture's actual (pivot-in-progress) state — inherited from round 7, not new to this skill

`business-state.json.stage` is `de_steps_in_progress` (steps 01/02/04 reopened by round 7's pivot,
05 flagged for re-confirmation), not `operating`. Both this skill and `agents/ops/people-lead.md`
gate on "`stage: operating` (or a late-`gtm` key hire)." In substance this business is squarely
operating — `gtm.status: "launched"`, `ops.status: "active"`, two real biweekly check-ins on file,
real revenue collected — the `stage` field just hasn't been reset because a pivot is running in
parallel with continued operations. This isn't a bug this skill introduced (round 7's findings
document the same `de_steps_in_progress` reversion as the pivot protocol's own documented
behavior), but it is a real interaction gap between the pivot protocol and every ops-layer skill
that gates on `stage: "operating"` literally: `hiring-and-org-design` (this round) joins
`runway-and-burn-tracking`/`weekly-metrics-review`/the retro pipeline (round 7) as a skill that had
to either read past the literal `stage` value or risk incorrectly refusing to run for a business
that is very obviously still operating. Worth a documented convention (in `docs/DATA-CONTRACT.md`
or `agents/orchestrator.md`) for how ops-layer skills should treat `stage: de_steps_in_progress`
when it coexists with `ops.status: "active"` and `gtm.status: "launched"`, rather than leaving each
ops skill to independently decide to treat the gate as satisfied in substance, as I did here.

## 4. The job description and interview scorecard deliverable is genuinely concrete and usable

Unlike a "generic hiring advice" output, both deliverables are grounded in real fixture content,
not templated filler:
- The JD's outcomes/KPIs cite the actual `plan/24` ramp assumption (~4 months), the actual
  conservative Year-1 output figure (3 placements), and the actual guarantee-invocation rate
  (17%) as the bar this role must meet.
- The must-haves are short (4) and screen for the specific thing `ka-020-associate-replication`
  is actually testing (technical-screening judgment), not a generic recruiter wish list.
- The interview scorecard's Stage 2 working session is built directly around the not-yet-written
  technical-screening playbook gap (`ka-010-playbook-informal`) — the candidate is evaluated on
  the exact skill the business doesn't yet have written down, which is the real reason this hire
  is risky and worth testing carefully.
- Comp used Jordan's own already-decided real structure from `plan/24` ($70,000 base + 10%
  override) rather than inventing a new figure — Step 3's bootstrap guidance and this fixture's
  actual founder decision agreed cleanly here, no conflict to resolve.

This part of the skill worked as designed with no gaps found.

## 5. Minor: `risk_log` id numbering after a slug rename, and an "ask the founder first" ambiguity

Two small, non-blocking notes, both disclosed transparently in the output artifacts themselves
rather than silently worked around:

- The skill's `id` convention (`ops-<slug>-<sequential-number>`) increments from the highest
  existing `ops-<slug>-*` id. Because this QA round's isolation step renames the slug
  (`vantage-point-search` → `vantage-point-search-t10-hiring`), the pre-existing entry
  (`ops-vantage-point-search-001`, from before the rename) doesn't share the new slug prefix. I
  used `ops-vantage-point-search-t10-hiring-002` (continuing the sequence number, updating the
  prefix) — a reasonable reading, but this is purely a QA-harness artifact of the copy/rename step,
  not a skill bug worth changing anything for.
- The skill instructs logging a `risk_log` entry when "the founder proceeds despite a Critical or
  Warning post-hire read." In this dry run, no live founder was actually asked whether to proceed —
  per this round's task instructions, I drove the deliverable through Step 4 regardless so the JD/
  scorecard artifact could be produced and evaluated. I logged the `risk_log` entry per the letter
  of the instruction (Warning + deliverable produced) but flagged the ambiguity explicitly inside
  both the output file and the `risk_log` description itself: it's not obvious from the SKILL.md
  text whether "produced the deliverable" and "founder proceeds anyway" are meant to be the same
  trigger, or whether a real execution should stop and ask before Step 4 when Step 1b lands
  Warning. Worth a one-line clarification in the skill: does Warning block Step 4 pending founder
  confirmation, or only gate the `risk_log` entry? I resolved it by proceeding (matching this QA
  round's explicit instruction to still produce the deliverable) and logging plainly, but a live
  founder session should probably surface the Warning read *before* spending effort on a full JD/
  scorecard for a hire that might not happen.

---

## Artifacts produced this round

- `.startup/vantage-point-search-t10-hiring/ops/hiring-plan-associate-recruiter-2026-09-29.md` —
  the full should-we-hire decision, runway math (with the baseline-burn judgment call stated
  explicitly), sequencing rationale (with the utilization-evidence tension stated explicitly),
  comp/equity band, job description, interview scorecard, org design notes, and risk flag.
- `.startup/vantage-point-search-t10-hiring/business-state.json` — `slug` updated to
  `vantage-point-search-t10-hiring`; `ops.cadence_metrics_files` appended with the new hiring-plan
  file; one new `risk_log` entry (`ops-vantage-point-search-t10-hiring-002`, type `business`,
  `raised_by: "people-lead"`, `status: "open"`); `updated_at` bumped. Verified valid JSON after
  edits. Every other key preserved untouched (read-modify-write, per Non-negotiable #2 in
  `agents/ops/people-lead.md`).
