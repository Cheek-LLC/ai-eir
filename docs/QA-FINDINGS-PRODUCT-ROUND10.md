# QA Findings — Round 10: `roadmap-and-prioritization` (product-lead) live dry run

**Method.** Copied the real fixture `.startup/vantage-point-search` to an isolated working copy at
`.startup/vantage-point-search-t10-product/` (slug field updated to
`vantage-point-search-t10-product`) and worked exclusively inside it. Read `business-state.json` in
full; `plan/03-build-an-end-user-profile.md`, `plan/05-profile-the-persona-for-the-beachhead-
market.md`, `plan/07-high-level-product-specification.md`, `plan/08-quantify-the-value-
proposition.md`, `plan/10-define-your-core.md`, and `plan/24-develop-a-product-plan.md`; both real
ops cycles (2026-09-15 and 2026-09-29) across `retention-metrics`, `growth-metrics`,
`finance-metrics`, and `retro`; `ops/kpi-dashboard.md`; and `interview-log.md` in full. Then read
`skills/product/roadmap-and-prioritization/SKILL.md` and `agents/product/product-lead.md` in full —
neither had been executed live before this round. I then actually ran the roadmap cycle against
this fixture's real data (no invented business content) and wrote the result to
`.startup/vantage-point-search-t10-product/ops/product-roadmap-2026-09-29.md`, followed by
`product-lead`'s own periodic drift check in the same file. This doc reports what actually
happened, including the real gaps it surfaced — not a hypothetical description of how the skill
would behave.

## What I actually did

Built the roadmap with 7 real intake items, each sourced to a specific file: `ri-vps-01` (write the
playbook, `plan/24` + `ka-010-playbook-informal`), `ri-vps-02` (fee-floor/tiered pricing test for
sub-120-employee prospects, `ka-025-segment-fee-floor` + the two real declines #2/#4 in
`ops/2026-09-29-growth-metrics.md`), `ri-vps-03` (a referral/advocacy ask, sourced from Jordan's
own reported surprise about prospect #8 in `interview-log.md` 2026-09-15), `ri-vps-04` (time-track
delivery hours, `ops/2026-09-29-retro.md`'s "2 consecutive check-ins, no founder action"),
`ri-vps-05` (hire/ramp an associate recruiter + first paid search, `plan/24` + `ka-020-associate-
replication`), `ri-vps-06` (lightweight CRM/BD tracking, `plan/24` + `ka-013`/`ka-018`), and
`ri-vps-07` (feature-request tracking — correctly logged as "not tracked anywhere," a real finding
per the skill's own instruction, not a scored item). `risk_log["ops-vantage-point-search-001"]`
(the already-open pivot signal) was deliberately **not** re-entered as a new intake item, per the
skill's own instruction not to re-surface a drift finding another agent already logged — only the
distinct fee-floor *alternative* Step 16 named was scored. Full detail, evidence citations, and the
`product-lead` drift check are in the roadmap file itself; this doc summarizes what that exercise
revealed.

## Finding 1 — RICE was followable for customer-facing items, structurally not for infrastructure items, and the skill's "Unscored" bucket doesn't say why

Three of the seven intake items — `ri-vps-01` (playbook), `ri-vps-04` (time-tracking), `ri-vps-06`
(CRM) — could not be RICE-scored, and it is worth being precise about *why*, because it is not the
failure mode the skill's own "Unscored — needs data" section anticipates. That section is written
for weak evidence ("an item with no real evidence behind it still goes on the list... tagged
`confidence: low`"). These three items have *strong* evidence — dated, repeated, directly cited
(the playbook gap and the delivery-hours gap were both independently named at two consecutive real
check-ins). What they lack is a **Reach number**, and structurally cannot have one: Reach is
defined as "the number of distinct customers/users this item affects" (Step 3), but these are
internal capability/tooling investments — exactly the kind of item Step 24's own "product plan" for
a services business is mostly made of — that touch zero customers directly. Their value is entirely
mediated through a downstream, already-scored item (`ri-vps-01`'s real payoff only exists once
combined with `ri-vps-05`, the associate hire it gates). RICE, as specified here, is a
consumer/SaaS-flavored feature-prioritization framework; it maps cleanly onto items with a direct
user count and awkwardly onto the capability-building items that dominate a real services-business
roadmap. This is a genuine framework-fit gap, not a data problem, and the skill's Unscored bucket
currently conflates the two — a founder reading "Unscored — needs data" next to the playbook item
would reasonably conclude the evidence is thin, when the opposite is true.

## Finding 2 — Effort and cycle capacity had no real disk-sourced source at all; I had to role-play the founder

This is the sharper version of what round 10's `experimentation-and-optimization` finding likely
also hit (ICE effort estimates), but RICE's Effort field and Step 5's capacity question make it
unavoidable here: every Reach/Impact/Confidence input I used traced to a real fixture file, but
**no file in this fixture contains a single person-week estimate for anything**, nor a stated
"available capacity this cycle" figure. The skill's own text assumes this is always obtainable
("Always labeled as an estimate, state who gave it") because in a live session the agent would just
ask the founder. In this async, fixture-only dry run there is no live founder to ask. I resolved
this by role-playing Jordan for exactly these two categories of input (Effort per item, capacity
this cycle), keeping the voice consistent with his established characterization elsewhere in
`interview-log.md`, and labeling every such figure inline as "role-played founder estimate, this
session" rather than presenting it as sourced data. This is a legitimate way to dry-run a
skill that is architecturally built around synchronous founder interaction, and it is exactly the
kind of substitution the skill's own "Never fabricate" section would flag if left unlabeled — but
it is a real, structural fact about this skill worth naming plainly: **RICE's Reach/Impact/
Confidence can be evidence-sourced from ops files; Effort and capacity, as this skill specifies
them, cannot be, ever, without either a live founder or an explicit convention for what an
agent should do when running asynchronously** (e.g., "if no founder capacity/effort figure exists
on disk, treat the whole Now/Next sequencing as provisional and say so," which the skill doesn't
currently instruct). Neither the skill nor the agent file has a fallback for this case; nothing
routes Effort-less items to the Unscored bucket the way Reach-less items are routed there.

## Finding 3 — the drift check produced something concrete and useful, on the very first cycle, including a real internal tension in the RICE ranking itself

This was the most valuable part of the exercise. Running the skill's own mechanics honestly — RICE
order, then a hard capacity cut — produced a "Now" bucket of `ri-vps-02` (RICE 2.0) and `ri-vps-03`
(RICE 1.0), both tagged **Context**, with `ri-vps-02` also tagged **Off-segment**. That is not a
contrived result: `ri-vps-02` is a fee-floor pricing *test for the exact sub-120-employee segment
the founder is actively trying to stop serving*, per the same-day pivot signal already logged as
`risk_log["ops-vantage-point-search-001"]`. It out-scored the Core-reinforcing, Step-15-critical
associate-hire item (`ri-vps-05`, RICE 0.56) purely because its Effort was ten-plus times smaller —
a textbook RICE bias toward cheap items over strategically important expensive ones, showing up on
this fixture's real numbers, not a hypothetical. Step 4's Drift Flag mechanism fired correctly and
usefully (100% Context, 50% off-segment in "Now," both stated as explicit fractions). `product-
lead`'s own drift check §§1-2 then correctly identified that, on a *first* cycle, its own "material"
bar (2+ consecutive cycles, or a jump from a prior baseline) cannot literally fire — both clauses
presume history that doesn't exist yet — and said so plainly rather than either forcing a false
"material" read or silently suppressing a real signal. It also correctly recognized that the
off-segment reading substantively overlaps with the already-open `ops-vantage-point-search-001`
entry and did not duplicate it, which is exactly what the agent file's Reads section asks for. This
is the skill/agent pairing working as designed, and it is a genuinely useful early-warning
mechanism: a founder using this cycle's Now bucket at face value would be spending BD effort in a
period he's explicitly told his ops layer he wants to exit.

## Finding 4 — a real, unaddressed precondition conflict: `stage` vs. an operationally-live, mid-pivot business

Both files gate on `stage: "operating"` (or an explicit late-`gtm` beta exception). This fixture's
actual `business-state.json.stage` is `"de_steps_in_progress"` as of 2026-09-29, because Steps
01/02/04 were reopened by the pivot signal — even though `gtm.status` is `"launched"`, `ops.status`
is `"active"`, and two full ops check-in cycles with real usage data exist. Neither file has any
instruction for this state, which is not a hypothetical edge case — it is exactly the state this
fixture is in right now, produced by round 9's own pivot-handling work in the prior round. I
proceeded anyway (documented explicitly at the top of the roadmap output) on the same kind of
judgment call `operations-manager` and the orchestrator made elsewhere in this fixture's history
when the schema had no exact state for "launched and operating, but with a subset of early DE steps
reopened." This should be treated as a real gap for the maintainer, not a one-off: any business
that pivots post-launch (which `operations-manager`'s own pivot-handling section actively invites)
will land in exactly this `stage` value, and `product-lead` is the one agent whose entire job is
"is the roadmap still tracking the plan" — it is precisely the agent that should have an explicit
answer for this state, not silence.

## Finding 5 — Step 8's value-proposition check and Step 7's spec-creep check were correctly, honestly unrunnable this cycle — not a skill failure, but worth confirming aloud

`product-lead` drift checks §3 (value-proposition) and §4 (spec creep) both came back
"insufficient/not applicable": no launch-era engagement has completed (`ops/*-retention-metrics.md`
both periods: "not applicable... no engagement concluded"), and this is the first-ever roadmap
cycle so there is no "shipped since last cycle" list to compare against Step 7. Both reads are
correct and match the same insufficient-data discipline `operations-manager`/`scaling-strategist`
already apply elsewhere in this fixture — confirmed working as intended, not a gap, but worth
recording since it means two of the drift check's four legs are currently untestable end-to-end
against this fixture and will only become checkable once a real engagement completes.

## Net assessment

The skill is real and well-built for its intended shape of business (evidence-sourced intake,
honest RICE math, Core/beachhead tagging that actually traces to plan language) and the drift check
in `product-lead` is genuinely more than decorative — it caught a real, material tension in this
cycle's own RICE ranking and correctly declined to force a "material" verdict it couldn't yet
support. The two structural gaps worth the maintainer's attention are (1) RICE's Reach concept
doesn't fit the capability/infrastructure items that dominate a services business's real roadmap,
and the Unscored bucket doesn't distinguish "thin evidence" from "no Reach concept applies here";
and (2) Effort and cycle-capacity inputs have no async fallback and no data source in this fixture
at all — every such figure in this run is a labeled role-play substitute for a live founder answer,
which is honest but means this skill, more than most in this plugin, cannot be meaningfully dry-run
without either a live interlocutor or an explicit convention the skill currently doesn't state.
