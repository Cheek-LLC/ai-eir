# SYNTHETIC TEST ARTIFACT — NOT A REAL PLAN

This file is a QA test fixture only, created for Round 10 council-persona dry run testing. It
describes a **hypothetical variant** of SkyClaim's plan, constructed solely to exercise
`operational-execution-reviewer`'s two-of-three trigger logic in `skills/business-plan/
run-review-council/SKILL.md` §3 against a case where it should actually win the contextual seat.
It does not describe SkyClaim's real plan and must never be read as such. No files under `plan/`
in this copy were modified to match this hypothetical — it is a standalone note used only for a
by-hand trigger-logic walkthrough recorded in `docs/QA-FINDINGS-COUNCIL-ROUND10.md`.

## The hypothetical modification

Take SkyClaim's real plan exactly as drafted (see the real Steps 6/13/18/22/24 in this same
directory), and add one additional, invented fact:

> Hypothetically, suppose SkyClaim's demand side also required a second, structurally distinct
> fulfillment channel alongside the real per-property spot-booking flow already described in Step
> 22: a wholesale-style volume contract for large regional roofing chains (e.g., a multi-property
> batch inspection agreement with its own scheduling, batch-reporting, and invoicing mechanics,
> separate from the individual $175/property spot bookings). This second channel would run
> *concurrently* with the real spot-booking flow, on the same solo/two-person founding team
> (Derek, optionally with one early co-founder or hire — the hypothetical does not add a bigger
> team), with no additional headcount named to run it.

Nothing else about the real plan changes: the real multi-stage demand-side sales process (Steps
13/18's Awareness → Evaluation → Carrier-acceptance-check → First booking, already a real,
drafted 4-stage founder-time-consuming process) stays exactly as drafted. The real MVBP timeline
(3 transactions in 6 weeks) and the real staged-automation deferral in Step 22/24 also stay
unchanged.

## Why this construction

This adds exactly one new signal (multi-channel/multi-mode fulfillment) on top of one signal that
was already real and already firing on its own in the actual plan (the multi-stage/high-touch
sales process), while deliberately leaving the third signal (aggressive concurrent-build timeline)
unresolved either way, since the trigger only requires two of three. It also deliberately keeps
the team-size gate satisfied (still a solo-or-two-founder team, no larger headcount named) so nothing
about the gate condition changes between the real test and this synthetic one.

See `docs/QA-FINDINGS-COUNCIL-ROUND10.md` §"Test #2" for the full by-hand trigger walkthrough
against this hypothetical, including the resulting seat-selection outcome and the logged
runner-up.
