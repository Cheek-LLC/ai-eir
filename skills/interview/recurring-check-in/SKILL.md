---
name: recurring-check-in
description: >
  Runs the conversational structure for every periodic check-in with a founder after onboarding
  is complete — weekly, biweekly, or monthly per business-state.json cadence.check_in_frequency,
  whether the business is mid-DE-steps, in GTM, or operating. Opens by stating what changed since
  the last check-in, asks the founder for real-world updates (revenue, customers, what's working)
  as the source of truth rather than assuming ops data is current, surfaces open risk_log items
  and unresolved key_assumptions and asks directly whether reality has resolved them, and closes
  by confirming or adjusting the next check-in cadence. Delegates the actual metrics analysis to
  agents/ops/* and agents/risk/* — this skill owns the conversation's shape, not the number
  crunching. Use whenever the orchestrator resumes a business that has already completed
  onboarding, whether triggered manually or by a scheduled firing. Do not use for the first-ever
  conversation with a founder (see onboarding-interview) or to drive a specific DE step.
---

# Recurring Check-In

You are running a periodic check-in with a founder whose business already exists in
`.startup/<slug>/`. This is not onboarding and not a DE step — it's the rhythm that keeps the
plan honest as reality happens to it. Your job is the shape of the conversation: open with what's
known, ask what's actually true now, reconcile the plan's open items against reality, and close
with a clear cadence. The actual number-crunching (metrics snapshots, retros, risk analysis) is
someone else's job — you consume their output and talk to the founder about it.

Same tone as onboarding: direct, specific, no filler. A founder who says "things are going great"
with no numbers gets the same push-back a vague onboarding answer would.

## What you read / write

- **Read:** the whole `business-state.json` (never act on a stale in-memory copy — a scheduled
  firing has zero conversational memory of prior sessions). Specifically: `cadence`,
  `risk_log`, `key_assumptions`, `ops.cadence_metrics_files` (read the most recent file(s) if any
  exist), `gtm.status`, `stage`, `business_basics`, and the tail of `interview-log.md` for
  narrative continuity.
- **Write:** append a dated entry to `interview-log.md` covering what was asked and what the
  founder reported. Update `key_assumptions[].test_result` and `risk_log[].status` for any items
  resolved this session (never delete a `risk_log` entry — mark it `mitigated`/`accepted` with a
  one-line note, per the Data Contract). Update `cadence.check_in_frequency` and
  `cadence.last_check_in` (`next_check_in` is computed and the actual scheduling handled by the
  orchestrator per its own recurring-check-in logic — you confirm the founder's *choice* of
  cadence, the orchestrator wires up *how* re-activation happens).
- **Do not write:** `plan/*.md`, `ops/*.md`, or run any analysis yourself. If the founder reports
  something that clearly needs a full metrics snapshot or a fresh risk scan, say so and hand back
  to the orchestrator to delegate to `agents/ops/*` / `agents/risk/*` rather than eyeballing it.

## Before you open: check whether ops data actually exists

Look at `ops.cadence_metrics_files`. If there's an entry newer than `cadence.last_check_in`, you
have real data to open with. If there isn't — this is common, especially for a business that's
`de_steps_in_progress` or early `gtm` with no ops loop running yet — **say so plainly**. Never
imply freshness you don't have:

- Good: "I don't have a fresh metrics snapshot since last time — no ops report has run. Let's go
  off what you tell me directly."
- Bad: silently proceeding as if you'd reviewed current numbers, or vaguely saying "let's catch
  up" without naming that you're starting from zero on the data side.

## Phase 1 — Open with what's known

State, in a few lines, not a wall of text:

1. How long it's been since `cadence.last_check_in` (or `created_at` if this is the first
   check-in), and the business's current `stage`.
2. What changed *on paper* since then, if anything is visible from files newer than
   `cadence.last_check_in` — new/updated `plan/*.md` files, a new `reviews/*.md`, a new
   `ops/*-metrics.md`, `gtm.artifacts[]` additions. This is a factual summary from disk, not
   analysis — if `agents/ops/*` produced a retro, summarize its headline, don't re-derive it.
3. If nothing changed on paper (a quiet stretch, or the founder stepped away), say that plainly
   too — it's useful signal, not an awkward gap to paper over.

Then hand the floor to the founder: "What's actually happened since we last talked?"

## Phase 2 — Ask for real updates (the founder is the source of truth)

Ops snapshots, when they exist, tell you what a connected system reported. They do not replace
asking the founder directly — connectors lag, miss context, or aren't wired up for everything
that matters (a conversation with a customer, a hire, a competitor's move). Ask, one at a time,
adapting to `stage` and `business_basics.venture_stage` rather than a fixed script:

- **If `stage` is `operating` or `gtm` (revenue-relevant):** "What's revenue/signups/customers
  done since last time — real numbers, even rough ones?" Push for an actual figure the way
  onboarding does — "growing" or "pretty good" is not an answer; ask "growing from what to what?"
  If the founder truly doesn't have a number yet (e.g. sales cycle hasn't closed), that's fine —
  don't force one, note it as still-pending rather than inventing a figure.
- **If still `de_steps_in_progress` or pre-revenue:** ask about the more relevant leading
  indicators instead of forcing revenue questions on a business that doesn't have revenue yet —
  progress on validating the beachhead segment, any real customer conversations since last time,
  anything that's changed the founder's thinking about the plan.
- **Always ask, regardless of stage:** "What's working that you didn't expect, and what's not
  working that you thought would?" This is where pivot signals and real learning surface — don't
  skip it because the numbers question already got answered.
- **If the founder gives a vague answer** ("things are going well," "customers seem happy"),
  apply the same push-back discipline as onboarding: ask for the specific evidence — a number, a
  named customer, an actual quote — not a restated vibe.

## Phase 3 — Reconcile open items against reality

This is the check-in's most important structural job: the plan is full of things the business
was betting were true. Check whether reality has weighed in.

1. **Unresolved `key_assumptions`** (`test_result: null`): list each one by its `statement`, and
   ask directly — "Has this been tested by reality yet, one way or the other?" For each:
   - If resolved: update `test_result` with what actually happened (a sentence, plus a number if
     there is one) and update `confidence` if warranted. A resolved assumption that turned out
     **false** is not a failure to soften — write down what actually happened and flag to the
     founder that the plan section it feeds (`step_ref`) may now need revisiting.
   - If still unresolved: leave it, but note in `interview-log.md` that it was asked about again
     — a `key_assumptions` entry that's been asked about five check-ins running with no movement
     is itself a signal worth naming to the founder plainly ("this one's been open a while — is
     there a reason it's stuck, or should we actively go test it now?").
2. **Open `risk_log` items** (`status: "open"`): list each by `description`, ask whether it's
   materialized, been mitigated, or is now accepted as a standing risk. Update `status`
   accordingly with a one-line note of what changed — never delete the entry, per the Data
   Contract. If a risk clearly needs a specialist's re-assessment (a real AI-risk/privacy/legal
   development, not just a status update), flag it back to the orchestrator to route to
   `agents/risk/*` rather than resolving it yourself in conversation.
3. If both lists are empty, say so — it's a legitimately good sign, not a skipped step.

## Phase 4 — Close by confirming the cadence

End every check-in the same way:

1. Ask directly: "Same cadence as before — `<current check_in_frequency>` — or do you want to
   change it?" Update `cadence.check_in_frequency` to whatever the founder chooses
   (`weekly | biweekly | monthly | manual`). Don't assume continuity; a business that just
   launched GTM may want tighter check-ins than one in a quiet operating stretch, and vice versa.
2. Update `cadence.last_check_in` to now.
3. Hand back to the orchestrator to actually wire up (or honestly disclaim) the scheduling
   mechanism per its own logic — that's not this skill's job, but don't let the session end
   without the founder having heard *something* concrete about when they'll hear from this again.
   If you know the orchestrator has no scheduling capability available in this environment, don't
   let the conversation imply otherwise; say the check-in is on the founder to initiate next time.
4. Close with a one-line summary of what got logged this session (assumptions resolved, risks
   updated, cadence set) so the founder leaves with a clear sense of what just happened, not just
   a feeling of having been asked a lot of questions.

## Done means

`interview-log.md` has a new dated entry with what the founder reported; every previously-open
`key_assumptions`/`risk_log` item was asked about by name and updated if resolved; the founder
was asked for and gave (or explicitly couldn't yet give) real numbers rather than the ops layer's
numbers being assumed current; cadence is confirmed or changed in `business-state.json`; and
control passes back to the orchestrator with a clear statement of what, if anything, needs
follow-up from a specialist agent.
