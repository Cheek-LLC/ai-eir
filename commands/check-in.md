---
description: Manually trigger a recurring check-in on a business right now, outside its automatic cadence — also the manual fallback when the environment has no scheduling capability.
---

The user wants to run a check-in on an existing business right now, independent of whatever
`cadence.check_in_frequency` / `cadence.next_check_in` says in `business-state.json`. This command
exists for two overlapping reasons, both legitimate:

1. A founder wants to check in early — before their chosen cadence would normally bring them back.
2. This environment has no scheduling/trigger capability available to the agent, so this command
   *is* the recurring check-in mechanism — see `agents/orchestrator.md`'s "Recurring check-ins"
   section, point 2 ("If none exists: ... tell the founder they need to run `/business-status
   <slug>` themselves on their chosen cadence"). This command is that manual fallback made
   explicit and check-in-flavored, rather than a generic status read.

Arguments given: `$ARGUMENTS` — expected to be a business slug.

## Steps

1. **Resolve the business.**
   - If `$ARGUMENTS` is non-empty, treat it as a slug or business name, same resolution rule
     `/business-status` uses: if it matches an existing `.startup/<slug>/` directory, use it
     directly; otherwise look for a case-insensitive `business_name` match under
     `.startup/*/business-state.json`.
   - If `$ARGUMENTS` is empty: if exactly one business exists under `.startup/`, use it; if
     multiple exist, list each by `business_name` and current `stage` and ask which one; if none
     exist, say so plainly and point at `/start-business` — don't fabricate a business.
   - If the resolved slug has no `business-state.json`, stop and say so — this command never
     creates a new business.

2. **Delegate to the `startup-operator` agent** to run its session bootstrap for this slug: re-read
   `business-state.json` in full, read recent `interview-log.md` entries, and skim anything new
   under `reviews/`, `gtm/`, `ops/` since `cadence.last_check_in` — exactly the "on resume" report
   the orchestrator already defines (business name, current `stage`, what changed, the concrete
   next action). This command does not re-derive that logic; it invokes the agent that owns it.

3. **Run the check-in content itself.** This is a real check-in, not just a status read: delegate
   to the recurring check-in variant of `skills/interview/*` for the actual conversation (what's
   changed in the real world since last time, any new facts that should update
   `key_assumptions`/`quantitative_claims`, whether the founder wants to revisit anything), then
   let the `startup-operator` continue driving the business forward per whatever `stage` calls for
   — the next DE step, a plan re-assembly, a council re-review, GTM work, or an ops retro.

4. **Update cadence state.** Set `cadence.last_check_in` to now. Re-confirm or re-ask
   `cadence.check_in_frequency` (`weekly | biweekly | monthly | manual`) exactly as the
   orchestrator's recurring check-in responsibilities require, and recompute
   `cadence.next_check_in` from it.

5. **Be straight about scheduling, every time.** Before ending the session, follow the
   orchestrator's rule exactly:
   - If a scheduling/trigger capability is available in this session, use it to schedule the
     *next* automatic check-in and record the mechanism in `cadence.scheduling_mechanism`.
   - If none is available, set `cadence.scheduling_mechanism: "manual-reminder"` and end the
     session by explicitly reminding the founder — as the last thing they read, not buried — that
     `/check-in <slug>` (or `/business-status <slug>`) is how the next one actually happens, on
     whatever cadence they just confirmed.

Never let this command's session end silently — it closes exactly like any other session that
touches this business: what happened, what's next, and the cadence/reminder status.
</content>
