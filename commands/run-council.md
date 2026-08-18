---
description: Manually convene a review council against a business's current plan, outside the normal review-gate flow — a mid-process gut-check or a way to test the council system.
---

The user wants to run a review council on demand — either a founder wanting an early read before
the plan formally reaches the `council_review` gate, or a maintainer testing the council system
itself. This command is a manual side-door into `skills/business-plan/run-review-council`; it does
not replace or skip the real review gate the orchestrator enforces at `stage: "council_review"`
(see `agents/orchestrator.md`, Phase 4 and Non-negotiable #3).

Arguments given: `$ARGUMENTS` — expected shape is `<business-slug> [council-name...]`. The first
whitespace-separated token is the business slug (required). Anything after it is optional: one or
more council names to run instead of the default set (e.g. `vc-panel`, `expert-panel`, or whatever
personas/panels exist under `agents/council/`). If only a slug is given, run whatever council(s)
`skills/business-plan/run-review-council` selects by default for this business's strategy.

If `$ARGUMENTS` is empty, ask the founder for the business slug directly — don't guess, and don't
silently fall back to "the only business that exists" the way `/business-status` does, since a
council run is a deliberate, resource-spending action that shouldn't fire on an ambiguous target.

## Steps

1. **Resolve the business.** Confirm `.startup/<slug>/business-state.json` exists. If it doesn't,
   say so plainly and point at `/start-business` — don't create anything here.

2. **Resolve the review target.** Read `business-state.json`:
   - If `plan.file` points at an assembled `plan/business-plan.md`, that's the default target.
   - If the plan hasn't been assembled yet (no `plan.file`, or `stage` is still
     `de_steps_in_progress` or earlier), tell the founder plainly that there's no assembled plan
     to review yet, and offer the real options: assemble it now via
     `skills/business-plan/assemble-business-plan` first, or point the council at a specific
     drafted step file (`plan/NN-slug.md`) instead if that's genuinely what they want reviewed.
     Don't silently invent a target.
   - A maintainer testing the council system may explicitly name a specific file or step as the
     target in their own words — honor that instead of defaulting to the full plan.

3. **Resolve which council(s) to run.** If council names were given in `$ARGUMENTS`, use them —
   check they exist under `agents/council/` first and tell the founder plainly if a named council
   isn't found (list what actually is available there, per CONVENTIONS.md's discovery-not-guessing
   principle) rather than silently substituting something else. If no council names were given,
   let `skills/business-plan/run-review-council` pick the appropriate panel(s) for this business's
   strategy, same as it would during the normal Phase 4 flow.

4. **Delegate the actual review.** Hand off to `skills/business-plan/run-review-council` with the
   resolved slug, target, and council selection. Do not reimplement panel logic, persona scoring,
   or the verdict schema here — that skill and `agents/council/*` own all of it. This command's
   only job is resolving what to run and against what, then getting out of the way.

5. **Record the result, but respect the gate's real semantics.** Every review that actually runs
   still gets appended to `reviews[]` in `business-state.json` (per the Data Contract, this is the
   single source of truth — an ad-hoc review is still a real review and must not be dropped) and
   its full write-up saved under `reviews/`, using the same schema as any other council run
   (CONVENTIONS.md §6).
   - If the business's `stage` is already `council_review` or `revising` when this runs, treat the
     verdict exactly as Phase 4 would: it can move the business forward or keep it in `revising`
     per the orchestrator's Non-negotiable #3 — this command is then just how that phase's review
     got manually kicked off rather than auto-triggered.
   - If the business is at any earlier or later stage (an early gut-check, or a check run on an
     already-`approved`/`operating` business), record the review but **do not** change `stage` on
     its own authority — tell the founder plainly this was an advisory read, state the verdict and
     required revisions if any, and let them decide whether to act on it now, fold it into the
     next real council cycle, or ignore it. Make clear to the founder which of these two modes just
     happened; don't let them think an early gut-check silently became the official gate decision,
     or vice versa.

6. **Report the verdict plainly**, using the same schema every council output uses (verdict,
   score, reviewer persona, strengths, risks/gaps, required revisions) — don't summarize away a
   blocking objection because this was "just a gut-check."
</content>
