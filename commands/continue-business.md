---
description: Continue an existing business unattended — the safe entry point for a scheduled/automated Routine firing with no live founder necessarily present, as opposed to /business-status or /check-in which assume one.
---

The invoker of this command may not be a live founder watching this conversation — this command is
the designated target for a Claude Code Routine, cron trigger, or any other scheduled/automated
mechanism that fires this plugin on a recurring cadence with nobody necessarily reading the output
in real time. It may also be run manually by a founder who wants exactly this behavior (do the
autonomous-safe work and hand back a digest) rather than a live interview right now.

Arguments given (may be empty): `$ARGUMENTS` — expected to be a business slug.

## Steps

1. **Resolve the business** — same resolution rule `/business-status` and `/check-in` use:
   - If `$ARGUMENTS` is non-empty, treat it as a slug or business name: if it matches an existing
     `.startup/<slug>/` directory, use it directly; otherwise look for a case-insensitive
     `business_name` match under `.startup/*/business-state.json`.
   - If `$ARGUMENTS` is empty: if exactly one business exists under `.startup/`, use it; if
     multiple exist, since nobody may be present to answer a clarifying question, proceed with
     whichever has the soonest `cadence.next_check_in` (or, if none has one set, the most recently
     `updated_at`) and say plainly in the digest which business was picked and why, rather than
     stalling on a question nobody's there to answer; if none exist, do nothing — there is no
     business to continue, and this command never creates one.
   - If the resolved slug has no `business-state.json`, stop — this command never creates a new
     business (that's `/start-business`, which is inherently interactive and wrong for this
     entry point).

2. **Delegate to `skills/autonomous-continuation`** for the resolved slug. That skill owns the
   entire unattended-firing discipline: re-reading state fresh, classifying autonomous-safe vs.
   founder-required work, doing the former, never fabricating or gating past the latter, and
   producing the single async digest message. Do not run `skills/interview/recurring-check-in` or
   any other live-interview-shaped skill from this command — that is exactly the failure mode
   `autonomous-continuation` exists to prevent (asking questions into a conversation nobody is
   reading, or worse, answering them on the founder's behalf).

3. **Let it reschedule itself.** `skills/autonomous-continuation`'s own Phase 4 handles finding
   (or honestly disclaiming) a scheduling capability and recording `cadence.scheduling_mechanism`
   — don't duplicate that logic here.

This command's whole job is routing to the right skill with the right framing; it does not contain
its own interview logic, and it never advances a business past a gate (council approval, a real
launch, an irreversible connector action) that `agents/orchestrator.md`'s Non-negotiables reserve
for a founder who is actually present.
