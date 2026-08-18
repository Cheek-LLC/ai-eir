---
name: autonomous-continuation
description: >
  The entry point for an UNATTENDED firing of this plugin — a Claude Code Routine, cron trigger,
  or any other recurring-scheduling mechanism invoking this business with no live founder
  necessarily present to answer questions in real time. Re-reads business-state.json fresh,
  advances every autonomous-safe action available at the business's current stage (metrics
  snapshots, retros, risk scans, drafting the next artifact for founder review), and produces one
  self-contained async digest covering what it did and exactly what still needs the founder's real
  answer — never fabricating founder-only facts (revenue, qualitative feedback, decisions) it
  cannot autonomously observe, and never crossing an irreversible gate (council approval, a real
  launch, spending via a connector) without the founder physically present. Reschedules the next
  firing before ending. Use when invoked via `/continue-business`, by a scheduled/automated
  trigger, or whenever the founder is known not to be actively watching this conversation.
---

# Autonomous Continuation

You are being invoked by a mechanism that fires on a schedule, not by a founder who just sat down
to talk. That single fact changes what "doing the right thing" means here, compared to
`skills/interview/recurring-check-in` or a founder-initiated `/business-status`: there may be
nobody reading your output for hours or days. Design this session's output as a **message someone
returns to later**, not a live conversation — and never do, on the founder's behalf, anything that
requires their actual judgment or actual knowledge of the real world.

This skill does not replace `recurring-check-in` — it is what runs *instead of* a live interview
when nobody is available to have one. When a founder later opens the conversation and replies, a
normal live session (recurring-check-in, or whatever the reply calls for) picks up from there.

## Before anything else: confirm you're actually in this mode

If a founder is visibly present and actively typing in this conversation (this is a live session,
not a scheduled firing), stop and hand off to the orchestrator's normal session bootstrap instead
— this skill's async-digest framing would be a strange, stilted way to talk to someone who's right
there. Use this skill when invoked by `/continue-business`, by a scheduled trigger's prompt text,
or when there's no indication anyone is watching this conversation live.

## What you read

The whole `business-state.json` — never act on conversation memory, a scheduled firing has none
from prior sessions. Specifically: `stage`, `business_basics`, `disciplined_entrepreneurship`,
`key_assumptions`, `quantitative_claims`, `plan`, `reviews`, `gtm`, `ops`, `connectors`, `cadence`,
`risk_log`, and the tail of `interview-log.md` and anything newer than `cadence.last_check_in`
under `reviews/`, `gtm/`, `ops/`.

## The core discipline: autonomous-safe vs. founder-required

Before doing anything, classify the concrete next action per the state machine in
`agents/orchestrator.md` into one of three buckets:

1. **Autonomous-safe** — mechanical, reproducible from data already on disk or from a wired-up
   connector, requires no invented fact and no irreversible commitment. Do this work now.
2. **Founder-required** — needs a real fact only the founder has (a revenue number, whether a
   customer conversation happened, a subjective judgment call, a yes/no on an irreversible step).
   Do not guess, do not invent a plausible-sounding placeholder, do not silently skip it. Write it
   down as an explicit open question in the digest (Phase 3 below).
3. **Gated — never cross unattended, regardless of how confident you are:**
   - Treating a council `REVISE`/`REJECT` verdict as resolved, or logging a founder override
     (Non-negotiable #3 requires an explicit, real-time "yes, override" — a scheduled firing
     cannot obtain one).
   - Declaring a real-world launch happened (`gtm.status: "launched"`, `stage: "operating"`) —
     only a founder confirming shipped reality earns that transition, per Phase 5 of
     `agents/orchestrator.md`.
   - Any connector-driven action that spends real money or sends something externally-visible on
     the founder's behalf (an outbound email blast, an ad-spend change, a live send of any kind)
     — draft it, never execute it.
   - Running the onboarding interview, or writing founder-only fields (`founder.*`,
     `business_basics.*`) from an inference — those need the founder's own words.

## Autonomous-safe work by stage

| `stage` | Autonomous-safe this cycle | Founder-required (list, don't fabricate) |
|---|---|---|
| `interview` | Nothing — onboarding is inherently a live conversation. Note the business hasn't started onboarding and stop; don't attempt it. | Everything. |
| `de_steps_in_progress` | Re-check step dependencies/readiness per Phase 2 of `agents/orchestrator.md`; identify precisely which step is next and exactly what founder-only inputs it needs. **Do not draft DE-step content that requires founder judgment or founder-only facts on their behalf** — every DE step is built to force real founder thinking, and a plausible-sounding autonomous guess defeats the entire point of the framework. | The next step's actual content — list the specific questions it will ask so the founder can think about them before the next live session. |
| `plan_assembled` | If not yet assembled and all 24 steps are genuinely `drafted`, run `skills/business-plan/assemble-business-plan` — this is mechanical (it reads existing step files, invents nothing new). | Nothing new unless assembly surfaces a gap. |
| `revising` | Route any required revision that's purely technical (an AI-risk/privacy fix, a plan-structure fix, re-sourcing a `quantitative_claims` entry that already has the real number sitting in another step file) to the owning specialist skill/agent and re-check. | Any revision needing new founder judgment (narrowing a beachhead, a pricing call) — list it, don't attempt it. |
| `approved` (pre-GTM) | Draft launch-plan and GTM artifacts via `agents/gtm/launch-director.md` and its skills — drafting is safe, it is explicitly not a real launch. | The founder's actual go-ahead to launch. |
| `gtm` | Continue drafting/sequencing GTM artifacts already in motion. | Confirming anything has actually shipped. |
| `operating` | Metrics snapshots and retros via `agents/ops/*` / `skills/ops/*` against data already on disk or from wired-up connectors (never inventing a number a connector didn't actually report); risk scans via `agents/risk/*`; drafting (not shipping) any optimization-agent output — pricing review, experiment log update, competitive-intel scan, product-roadmap draft — that only needs data already available. | Founder-reported numbers no connector provides, qualitative signals ("what's working / what's not"), any pivot-adjacent judgment call. |
| `paused` | Nothing except noting how long it's been paused. | Whether to resume at all. |

For any downstream skill whose own instructions assume a live conversational founder mid-skill
(every DE step skill, `skills/interview/onboarding-interview`, the interactive phases of
`skills/interview/recurring-check-in`), do not invoke it to produce final, founder-attributed
content. You may invoke fully open-loop skills that complete without a live founder answer:
`skills/business-plan/assemble-business-plan`, `skills/business-plan/run-review-council` (only
re-running against an already-resolved revision, never as a fresh submission decision), any
`skills/ops/*` skill operating on data already on disk or from a connector, `agents/risk/*` scans,
`agents/connectors-liaison.md` in discovery/status-only mode (never installing something that
spends money), and the optimization-agent skills (pricing, experimentation, competitive
intelligence, product roadmap, customer success, operations/fulfillment, hiring) when their own
inputs are already on disk.

## Write-back rules

Same discipline as `skills/interview/recurring-check-in`: read-modify-write, never blind-overwrite
(Non-negotiable #2), never invent a `quantitative_claims`/`key_assumptions` entry, never delete a
`risk_log` entry. Additionally:

- Any artifact you produce autonomously that a downstream skill would normally only finalize with
  founder input must say so plainly in its own file header — e.g. `**Status: autonomous draft,
  awaiting founder confirmation before this is treated as final.**` — and must not cause a
  `disciplined_entrepreneurship.NN_slug.status` to advance past what real founder-confirmed content
  earns (per `agents/orchestrator.md` Phase 2 item 4, status never exceeds `drafted`, and even
  `drafted` requires the real founder-forced content this skill will not fabricate).
- Append a dated entry to `interview-log.md` covering exactly what this cycle did autonomously —
  this is the durable record a resumed live session reads to avoid re-deriving what already
  happened.
- Update `cadence.last_check_in` is intentionally **not** done by this skill — that field means a
  real check-in conversation happened, and this cycle may have had none. Leave it untouched unless
  Phase 3 below produced a genuine reconciliation of open items (see Phase 3).

## Phase 1 — Do the autonomous-safe work

Work through the table above for the business's actual `stage`. Invoke only the skills/agents
listed as safe. Log every action taken.

## Phase 2 — Reconcile anything reconcilable without the founder

If any `key_assumptions[]` or `risk_log[]` item can be resolved purely from data already on disk
or a connector (not from asking the founder), resolve it and record the source. Leave everything
else exactly as it is — do not mark an item resolved on a guess.

## Phase 3 — Compose the digest

This is the entire deliverable a returning founder will read. Write it as a single, well-organized
message — not a transcript of your internal steps:

```
## Since [cadence.last_check_in or created_at], while you were away

**What I did on my own:**
- [concrete action] → [file written / field updated]
- ...
(or: "Nothing autonomous-safe was available at this stage — see below for what's next.")

**What still needs you** (I did not guess at any of these):
1. [specific question, tied to the specific step/decision it unblocks]
2. ...

**Current stage:** <stage>, next concrete action: <one sentence>

**Next scheduled check:** <when, if rescheduled — see Phase 4>
```

Keep it tight — a founder scanning this on their phone should understand what happened and what's
needed from them in under 30 seconds.

## Phase 4 — Reschedule

Follow `agents/orchestrator.md`'s "Recurring check-ins" logic exactly: look for a scheduling
capability in this session's available tools; if one exists, use it to schedule the next firing
(prompt text: invoke `/continue-business <slug>`, per that command's own contract), and record the
mechanism in `cadence.scheduling_mechanism`. If none exists, this cycle itself couldn't have been
autonomous in the first place — a human just ran `/continue-business` manually — so simply remind
them, in the digest, when their chosen cadence says to run it again.

## Done means

Every autonomous-safe action available at the current stage was actually taken (or explicitly
noted as unavailable); nothing founder-only was fabricated; nothing gated was crossed; the digest
is a single, scannable message a founder can act on cold; `interview-log.md` has the dated record;
and the next firing is scheduled (or the manual-fallback reminder is stated plainly) exactly as
`agents/orchestrator.md`'s recurring check-in rules require.
