# QA Findings — Round 10: Customer Success Playbook (`skills/ops/customer-success-playbook` + `agents/ops/customer-success-lead.md`'s new self-correction section)

**Method.** Live dry run, not a read-through. Copied the real fixture `.startup/vantage-point-search`
to an isolated `.startup/vantage-point-search-t10-cs/` (untouched original preserved) and updated its
`business-state.json.slug` to match. Read that copy's real `business-state.json` in full, both real
`ops/*-retention-metrics.md` cycles (2026-09-15, 2026-09-29), `ops/2026-09-29-growth-metrics.md`,
`ops/2026-09-29-retro.md`, `ops/kpi-dashboard.md`, `plan/16-set-your-pricing-framework.md`,
`plan/22-define-the-mvbp.md`, `plan/09-identify-your-next-10-customers.md`, and
`plan/23-show-that-dogs-will-eat-the-dog-food.md` in full before building anything. Read
`skills/ops/customer-success-playbook/SKILL.md` and the full appended "Optimization" section of
`agents/ops/customer-success-lead.md` in full. Then actually executed the skill against this
fixture's real data — built a real health-scoring model, scored the one real currently-active
account, checked the real expansion cross-reference against `plan/16-...`, and wrote
`.startup/vantage-point-search-t10-cs/ops/customer-success-2026-09-29.md`, registering it in that
copy's `business-state.json.ops.cadence_metrics_files`. Then attempted the customer-success-lead's
new self-correction check for real, using whatever outcome data actually exists in this fixture.
No skill/agent/CONVENTIONS/DATA-CONTRACT files were modified — gaps below are reported, not fixed.

## Summary verdict

The skill is genuinely well-built for this fixture's hardest case — a project-based services
business with almost no currently "active" accounts to score, only one — and its Step 2
(threshold-setting) held up under real, messy data better than expected: it correctly supports a
**mixed, per-signal answer** rather than forcing a single global choice, which this fixture actually
needed. One real gap found in the new self-correction section: it has no explicit instruction for
the always-eventually-true first-run case (no prior snapshot to check predictions against), unlike
the main skill's own explicit provisional-threshold fallback for low volume. Full findings below.

## 1. Which threshold-setting path actually applied, and whether it was followable

Not a single answer — and that itself is a finding worth stating plainly, because the round-10 task
framing (and a shallower reading of the skill) could suggest it's an either/or choice. Re-reading
Part 1 Step 2 closely: it says "for every trackable signal" do steps 1-3, which already licenses a
per-signal answer. Applied literally against this fixture's real data:

- **Real known-good/known-bad path actually applied** for exactly one signal category —
  "Relationship/engagement signal." `plan/23-show-that-dogs-will-eat-the-dog-food.md` already
  contains a genuine, real, per-client good/bad comparison: Clients 1/2/6 (unprompted referral,
  repeat re-engagement, responsive) as known-good, Client 4 (went quiet, no referral/reference
  activity after delivery) and Client 5 (90-day guarantee invoked at day 62 — a hard risk
  indicator) as known-bad. This gap between real distributions is exactly what Step 2.2 asks for,
  and it produced a real, inspectable Yellow/Red line, not an invented one.
- **Provisional path correctly applied** for the other two in-scope signals — "delivery-milestone
  pace" (a services-specific adaptation of "usage frequency & depth") and "payment/installment
  timeliness." Both are trackable in principle (real milestone and installment dates exist), but
  neither has a known-bad comparison case anywhere in this business's 14-month record — no client
  has ever had a late payment or a comparably-tracked milestone slip on record. Step 2.3's
  provisional-threshold-from-founder-judgment fallback is the right and only honest path here, and
  the skill's own language supports reaching for it per-signal rather than only when the whole
  account base is small.
- Two signals (support-ticket sentiment/volume, NPS/CSAT) were correctly marked not-trackable —
  this business has no support tool and has never collected NPS/CSAT — rather than forcing a
  placeholder threshold onto data that doesn't exist. Excluding them from the blended-score weight
  (rather than silently defaulting them to green) matches Step 1's explicit instruction to "never
  silently assume a signal exists."

**Followable: yes, cleanly**, once the reader notices Step 2 operates per-signal rather than
globally. Worth naming as a documentation nit, not a functional bug: the SKILL.md's own worked
narrative in Step 2 (numbered 1→2→3→4) reads, on a first pass, like a single linear decision for
"this business" rather than "this signal" — the per-signal grain only becomes obvious on a second,
careful read of the opening clause ("for every trackable signal"). A business this small and messy
is exactly the case that would benefit from the SKILL.md saying explicitly, in Step 2's own text,
that different signals for the same business can and often will land on different sides of the
real-data/provisional line — right now that's an inference the executing agent has to make, not an
instruction the skill states.

## 2. Onboarding definition (services, project-based branch)

Applied cleanly, no gap found. `plan/22-define-the-mvbp.md` confirms the core loop/first-value
action (one retained-search engagement, scoped per Step 7). Part 2's services branch correctly
distinguishes recurring/retainer engagements (which get a "first renewal decision point" bar,
inapplicable here) from project-based one-off engagements (where "onboarded" converges with
"delivered," tracked as project-completion quality). This fixture is unambiguously the latter (Step
15 explicitly deferred a retainer model), and the skill's branch fired correctly without forcing a
renewal frame that doesn't apply. Engagement #5 — kickoff 2026-08-20, candidate-slate milestone
accepted without dispute 2026-09-22 — cleanly scores "onboarded: Yes" against this bar with real
dates, no invented ones.

## 3. The pricing-tier cross-reference (Part 3)

Worked, but with nothing to actually cross-reference against this period, which is itself worth
reporting honestly rather than skipping the section. `plan/16-set-your-pricing-framework.md` exists
and was read in full — it is a single flat-rate structure (30% of first-year base salary, scales
continuously with the placed candidate's comp, no tiers or add-ons at all). No account this period
showed a concrete expansion trigger (the one active account, engagement #5, is Green but has not
requested scope beyond its current engagement, and this business's flat per-search fee has no
retainer-hours ceiling to max out the way Part 3's services trigger example describes). Because
nothing was expansion-ready, the "map to a real tier" instruction had literally nothing to map. I
still exercised the "no existing tier covers this" gap-naming instruction proactively, since it's
checkable independent of a live trigger: **if** an expansion trigger did fire (e.g., a request to
run a second concurrent search, or interest in the Step 14 Pin-2 Product-search line), Step 16 truly
has no tier/add-on that names that today — flagged in the output file as a real, checked gap, not a
hypothetical one skipped for lack of an active account to hang it on.

## 4. The self-correction check (customer-success-lead's new "Optimization" section) — real gap found

This is the substantive finding of this round. Attempted for real, using the only real outcome data
this fixture has:

- This is the fixture's **first-ever** `ops/customer-success-*.md` run — there is no prior snapshot
  whose predictions have had time to play out against a later real result. A false-positive/
  false-negative rate is structurally a comparison between a past prediction and a later outcome;
  with zero past predictions, there is nothing to compute.
- The one dataset that looks tempting to substitute — `plan/23-...`'s real historical per-client
  good/bad record — cannot substitute, and I want to flag explicitly that I checked and rejected
  this rather than skip the reasoning: that record is the *same* data this run's own thresholds
  were derived from (finding §1 above). Scoring those same 6 historical clients against a model
  built from their own outcomes is not an out-of-sample check; Client 5 would "correctly" score Red
  only because Client 5 is literally why the Red threshold exists. Using it as if it were
  calibration evidence would be a fabricated confirmation, not a real one — exactly the failure mode
  this business's own AI-risk gate has caught elsewhere in this fixture (`ar-vps-001`, false
  precision on the COCA figure).
- Net, honest result: **false-positive/false-negative rate is not computable this period, for a
  structural reason (first run), not a volume problem** — different from "insufficient data because
  the sample is small," which is the more common case this plugin's other skills already handle
  gracefully. No recalibration trigger fires (there's no rate to compare against a materiality bar).
  No miscalibration `risk_log` entry was warranted.

**The gap:** `agents/ops/customer-success-lead.md`'s Optimization section (lines ~142-173) gives
detailed instructions for *how* to compute the rates once prior predictions exist, and for what to
do if they're materially off — but it has **no explicit instruction for the first-run case**, the
one case every business using this skill will hit exactly once, unconditionally, before any
self-correction cycle can ever run. Contrast this with `customer-success-playbook/SKILL.md`'s Part 1
Step 2, which explicitly names and instructs the low-volume provisional-threshold fallback in the
skill's own text (Step 2.3) rather than leaving it to the executing agent's inference. The
self-correction section has no equivalent — I handled it by stating the insufficiency plainly,
matching this plugin's consistent "insufficient data, said honestly" house style seen throughout
this fixture's other ops files (e.g. `ops/2026-09-29-growth-metrics.md`'s COCA section, the retro's
LTV/COCA/TAM drift section) — but that consistency came from inferring house style across the
plugin, not from an instruction this specific agent file actually gives. A different execution of
this same agent file, without that cross-file context, could plausibly either (a) silently skip the
self-correction section with no output at all (looks like the check was forgotten), or (b) do what I
explicitly rejected in the paragraph above — misuse the historical Step 23 record as if it were an
independent calibration check, producing a confirmation that looks real but isn't. Recommend adding
one short explicit clause to the Optimization section along the lines of: "If no prior
`customer-success-*.md` snapshot exists yet, say so explicitly and skip the rate computation — this
is a structural first-run gap, not a volume problem, and does not warrant a `risk_log` entry; note
which future snapshot cycle will produce the first real comparison." This would close the gap this
round found without changing the section's substance.

## 5. Other observations, not gaps

- The "current active accounts" concept for a project-based services business collapsed to exactly
  one row (engagement #5) this period, since the other 5 completed placements are closed
  relationships, not currently-managed accounts. The skill's template (an "Account health snapshot"
  table) handled a 1-row table without friction — no part of the template assumes a minimum account
  count.
- Weighting: no founder-stated reason existed to weight one signal over another, so equal weighting
  was used per the skill's own default — correctly the boring, right answer here, not a gap.
- The hard-risk-indicator override rule (Part 1: "never assign green to an account carrying an
  unresolved hard risk indicator regardless of the blended score") did not need to fire this period
  (no hard indicator is currently open), but its definition mapped cleanly onto this business's real
  hard-indicator case (guarantee invocation) when checked against the historical record — the rule
  is concrete and correctly typed for this business, not generic boilerplate.

## Files touched this round

- `.startup/vantage-point-search-t10-cs/` — isolated copy, `business-state.json.slug` updated to
  `vantage-point-search-t10-cs`.
- `.startup/vantage-point-search-t10-cs/ops/customer-success-2026-09-29.md` — new, the skill's real
  output for this run.
- `.startup/vantage-point-search-t10-cs/business-state.json` —
  `ops.cadence_metrics_files` updated to register the new output file (read-modify-write, all other
  keys preserved; no `risk_log` entry added, correctly, since no escalation/miscalibration trigger
  fired this period).
- `docs/QA-FINDINGS-CUSTOMERSUCCESS-ROUND10.md` — this file.

The original `.startup/vantage-point-search/` fixture was not modified.
