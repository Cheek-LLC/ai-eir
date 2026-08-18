---
name: ai-risk-review
description: >
  The mandatory AI-risk gate. Any skill that is about to present a numeric-claim-bearing
  artifact to the founder as final, or hand it to a review council, must call this skill first
  and cannot proceed on a blocking finding without either a fix or a logged, explicit founder
  override. In scope: DE steps 04 (beachhead TAM), 14 (follow-on TAM), 16 (pricing framework),
  17 (LTV), 19 (COCA) on completion; plan/business-plan.md on every assembly or revision; any
  fundraising deck brief under gtm/; and, periodically, reviews/*.md council verdicts for
  independence. Triggers: "run the risk gate," "check for AI risk before we present this,"
  "is this ready for the founder/council," or automatically whenever
  skills/business-plan/assemble-business-plan, skills/business-plan/revise-business-plan, or
  skills/business-plan/run-review-council reaches the point of finalizing output. Delegates the
  actual analysis to agents/risk/ai-risk-analyst.md and enforces its verdict as a hard gate.
---

# AI Risk Review — the mandatory gate

This skill is a **gate, not a suggestion**. It exists because this plugin produces numbers a
founder can act on with real money — a hallucinated TAM or a laundered "AI estimate" presented
as researched fact is the specific harm this plugin must not cause. Nothing with a numeric claim
in it reaches the founder as final, or reaches a review council, without passing through here
first.

## Who must call this, and when (binding on other builders' skills)

The following calling points are **required**, not optional, even though this skill does not
own the files that trigger them:

| Caller | Must call this gate | Before |
|---|---|---|
| `skills/disciplined-entrepreneurship/04-calculate-the-tam-for-the-beachhead-market` | on step completion | marking the step `drafted` and reporting the TAM to the founder |
| `skills/disciplined-entrepreneurship/14-calculate-the-tam-for-follow-on-markets` | on step completion | marking the step `drafted` |
| `skills/disciplined-entrepreneurship/16-set-your-pricing-framework` | on step completion | marking the step `drafted` |
| `skills/disciplined-entrepreneurship/17-calculate-the-ltv-of-a-customer` | on step completion | marking the step `drafted` |
| `skills/disciplined-entrepreneurship/19-calculate-the-coca` | on step completion | marking the step `drafted` |
| `skills/business-plan/assemble-business-plan` | after `plan/business-plan.md` is written, before the plan is presented to the founder as ready | setting `stage: "plan_assembled"` and handing off |
| `skills/business-plan/revise-business-plan` (or equivalent revision skill) | after a revised `plan/business-plan-vN.md` is written | presenting the revision as addressing council feedback |
| `skills/business-plan/run-review-council` | before convening `agents/council/*` on the plan, **and again** after collecting verdicts | (1) before the council sees the plan — no council should score an artifact this gate would already block; (2) after verdicts are collected — periodic council-integrity spot-check per failure mode 4 |
| Any `skills/gtm/*` skill producing a fundraising deck brief or investor-facing document with numbers in it | before the artifact is marked ready | handoff to the founder or to `agents/gtm/*` for external use |

If you are building or maintaining any of the skills above and this gate isn't wired in yet,
wire it in — this SKILL.md is the contract those skills are written against, per
CONVENTIONS.md's shared-contract model. Do not route around this gate because the calling
skill "already checked sourcing informally" — the gate's job includes the council-integrity
spot-check and the risk_log write-back, which nothing else in the plugin does.

## What calling this skill means, mechanically

1. **Identify the target artifact.** A single step file (`plan/NN-slug.md`), the assembled or
   revised plan (`plan/business-plan.md` or `plan/business-plan-vN.md`), a set of council
   verdict files (`reviews/*.md`) for the integrity spot-check, or a GTM/fundraising artifact.
2. **Invoke `agents/risk/ai-risk-analyst.md`** with the target artifact and instruct it to read
   `.startup/<slug>/business-state.json` in full. Do not pre-filter what you hand it — give it
   the whole artifact and let it run all four checks (unsourced/fake-sourced claims, false
   precision, automation bias, and — when applicable — council integrity) per its own
   instructions.
3. **The analyst writes findings to `risk_log` itself** (type `ai_risk`) — you do not need to
   relay findings into the state file; confirm it did (non-empty list of new `risk_log` entry
   ids in its report) rather than assuming.
4. **Read the analyst's severity read.** It reports findings as `blocking` or `advisory`,
   explicitly.

## The gate logic — this is what makes it blocking, not advisory

- **Zero blocking findings:** the artifact may proceed. Advisory findings are still logged and
  should be mentioned to the founder in passing (per orchestrator Tone: flag real uncertainty
  once, plainly) but do not stop the handoff.
- **One or more blocking findings:** the artifact **may not** be presented to the founder as
  final, and may not be sent to a review council, until one of the following is true:
  1. The blocking issue is actually fixed — the source is corrected, the number is re-rounded
     to a defensible precision, the absolute-confidence language is replaced with honest
     validation-status language, or the missing Confidence & Validation Status section is added
     — and the artifact is re-run through this gate to confirm the fix holds (do not assume it
     holds; re-check).
  2. The founder explicitly and knowingly overrides it. This is the orchestrator's call, not
     this skill's — route back to the orchestrator (Non-negotiable #3 in `agents/orchestrator.md`)
     rather than accepting an override yourself. This skill's job is to refuse to wave the
     artifact through silently; it is not the thing that has the founder conversation.
  3. There is no third option. A blocking finding that is neither fixed nor overridden means the
     artifact stays exactly where it is — not "presented with a caveat," not "sent to council
     with a note." The whole point of a gate is that silence doesn't count as passing.
- **This applies even under time pressure.** "30-Minute Startup" is a promise about speed of
  drafting, not a license to skip the one check that exists specifically to keep the founder
  from acting on invented numbers. Do not let a caller skip this gate because the founder wants
  to move fast — say so if asked to skip it.

## Special case: the council-integrity spot-check

`skills/business-plan/run-review-council` calls this gate twice per the table above. The second
call (after verdicts are collected) exists specifically for failure mode 4 — checking whether
the panel that just ran shows genuine independence or looks templated. This check does not
block the verdict that was just produced (the verdict stands on its own merits per
CONVENTIONS §6's harshest-non-outlier rule) but it can and should produce a **structural**
blocking finding against the council/persona-set itself if rubber-stamping is detected — in that
case, tell the calling skill and the orchestrator explicitly that future verdicts from that
council should be treated as reduced-confidence until the persona prompts are revised, and that
this is a standing concern, not a one-off note.

## Reporting back to the caller

Return, plainly:

1. **PASS** or **BLOCKED**, first line, unambiguous.
2. If BLOCKED: the specific blocking finding(s), in plain language, and what would resolve each
   one (not just "see risk_log" — name it here too so the caller doesn't have to go look it up
   mid-workflow).
3. The `risk_log` entry ids written this pass (blocking and advisory both).
4. Any council-integrity read, if this call included that check.
5. One line, stated once: this gate checks AI-risk failure modes only (sourcing, precision,
   confidence framing, council independence) — it does not evaluate whether the underlying
   business idea, market read, or numbers are actually correct. That's still on the founder and
   on real diligence. See `docs/AI-RISK-FRAMEWORK.md` for the full policy and what's out of
   scope.

## Done looks like

- The target artifact has either zero blocking `ai_risk` findings or a logged, explicit founder
  override for each one that remains.
- Every finding raised this pass exists as a `risk_log` entry in `business-state.json` — never
  only in this skill's conversational output.
- The calling skill received an unambiguous PASS/BLOCKED and did not have to infer the gate's
  outcome from prose.
