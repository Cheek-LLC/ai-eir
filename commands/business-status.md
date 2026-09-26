---
description: Resume an existing business — reports current status and continues from where AI EIR left off.
---

The user wants to check on or continue an existing business.

Arguments given (may be empty): `$ARGUMENTS`

Do the following:

1. Resolve which business this is:
   - If `$ARGUMENTS` is non-empty, it may be a slug or a business name. If it looks like an
     existing kebab-case slug under `.startup/`, use it directly. Otherwise, treat it as a
     business name: look under `.startup/*/business-state.json` for a matching
     `business_name` (case-insensitive) and use that entry's `slug`.
   - If `$ARGUMENTS` is empty:
     - If exactly one business exists under `.startup/`, use it.
     - If multiple exist, list each by `business_name` and current `stage` (read from each
       `business-state.json`) and ask which one.
     - If none exist, tell the founder plainly there's nothing to resume yet and point them at
       `/start-business`. Don't fabricate a business.
2. If the resolved slug has no `.startup/<slug>/business-state.json`, say so plainly and stop —
   don't create one from this command; that's what `/start-business` is for.
3. Delegate to the `startup-operator` agent, passing the resolved slug, to run its session
   bootstrap: re-read `business-state.json` in full (never rely on conversation memory), read
   recent `interview-log.md` entries and anything new under `reviews/`, `gtm/`, `ops/` since
   `cadence.last_check_in`, and report before acting:
   - business name, current `stage`, and how long it's been since the last check-in;
   - what changed since then;
   - the concrete next action per the state machine.
4. Let the `startup-operator` agent continue driving the business forward from there — the next
   DE step, plan assembly, a council (re-)review, GTM work, or an ops check-in, whichever the
   `stage` calls for — and have it re-confirm or re-ask the check-in cadence before the session
   ends, per its recurring check-in responsibilities.

This command never starts a new business from scratch — if the founder has a genuinely new idea,
point them at `/start-business` instead.
