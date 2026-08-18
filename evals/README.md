# evals/ — Layer 2 behavioral eval suite (starter implementation)

This is the first real artifact for `docs/TESTING.md`'s **Layer 2 — Behavioral eval**, which
until this round was described everywhere in this repo as "out of scope for a bash script, that's
Claude Code's own `claude plugin eval` tooling" but never actually built. This directory is that
tooling actually being used, plus one thing it deliberately is *not*: a claim that everything here
has been run end-to-end and verified green. Read "Honest status" below before trusting any of the
six cases as a passing regression suite — some of it is confirmed-runnable today, some of it is
schema-correct but blocked on a feature flag this session couldn't clear.

## What's here

```
evals/
  README.md                                          — this file
  run-evals.sh                                        — entry point; runs everything below in order
  lib/
    verify_council_aggregation.py                     — deterministic, non-LLM reference check
    validate_cases.py                                 — structural validator for case.yaml files
  01-ai-risk-gate-unsourced-claim/                    — case 1 (see table below)
  02-council-verdict-aggregation/                     — case 2
  03-onboarding-vague-answer-pushback/                — case 3
  04a-de-step04-branching-saas/                       — case 4, arm A
  04b-de-step04-branching-marketplace/                — case 4, arm B
  05-connectors-liaison-fail-closed/                  — case 5
  06-revise-routes-through-revise-business-plan/      — case 6
```

Each numbered directory is a **case** in the format `claude plugin eval` actually expects: a
directory under `evals/` containing a `case.yaml` (schema described below), plus, where the case
needs a fixture business to operate on, a `scaffold.sh` that `--scaffold` runs to set up
`.startup/<slug>/` before the agent turn starts, and, for the two cases that use a `baseline`
grader, a small reference text file.

## The six behavioral properties this suite covers

| # | Case | What it checks | Real-repo oracle it's grounded in |
|---|---|---|---|
| 1 | `01-ai-risk-gate-unsourced-claim` | An unsourced numeric claim in a DE-step draft actually gets caught by the mandatory AI-risk gate (`skills/risk/ai-risk-review` → `agents/risk/ai-risk-analyst.md`) as a BLOCKING finding | `.startup/shiftcover/business-state.json`'s real `risk_log` entry `ar-shiftcover-002` (an LTV figure stated as fact with no matching `quantitative_claims` entry, actually caught in round 2) — quoted verbatim in this case's `reference-ar-shiftcover-002.txt` and used as a `baseline` grader |
| 2 | `02-council-verdict-aggregation` | A council review's aggregate-verdict computation follows the "harshest non-outlier" rule from `skills/business-plan/run-review-council/SKILL.md` §6 correctly on a constructed 5-verdict panel | §6's own hand-verified "Worked example" (Track B) — reused directly as this case's input and oracle, plus a fully independent deterministic re-implementation in `lib/verify_council_aggregation.py`, checked against **both** §6 worked examples (Track B and the Track A floor-rule case) |
| 3 | `03-onboarding-vague-answer-pushback` | The onboarding interview's vague-answer pushback actually fires on the platitude "we help small businesses grow," rather than accepting it | `skills/interview/onboarding-interview/SKILL.md`'s vague-answer playbook table, row 1 ("Everyone is my customer" / "small businesses" / "anyone who needs X" → the specific "one specific type of customer... six months" follow-up) |
| 4 | `04a-de-step04-branching-saas` + `04b-de-step04-branching-marketplace` | Business-type branching in DE Step 4 actually changes the calculation for two different `business_basics.business_type` values (`saas` vs `marketplace`) on the same step | Step 4's own "Business-type branching" section — SaaS: count × ACV/seat price; Marketplace: GMV × take rate, explicitly named there as "the most common sizing mistake at this step for this business type" when confused with per-seat pricing |
| 5 | `05-connectors-liaison-fail-closed` | `agents/connectors-liaison.md` fails **closed** (not open) when a required connector is not actually available — never claims the live action happened, still delivers the rest of the task, records the blocker | `agents/connectors-liaison.md` §6, "What 'not safe to proceed' means for your task" — the four-part contract (never claim it happened / still deliver the rest / mark the pending item explicitly / name it in the final report) |
| 6 | `06-revise-routes-through-revise-business-plan` | A REVISE council verdict actually routes back through `skills/business-plan/revise-business-plan` rather than silently letting the plan proceed | `docs/TESTING.md` §3.2, this suite's own named Layer 3 regression item, promoted here into an automatable check; fixture shape modeled directly on `.startup/shiftcover/business-state.json`'s **real, current** state (`stage: "revising"`, one unresolved `REVISE` review) as of this round |

## Honest status — read this before trusting a green checkmark

**`claude plugin eval` is a real subcommand** of the Claude Code CLI installed in this environment
(`claude` v2.1.234) — it is not something this round invented or guessed at. Running
`claude plugin --help` lists it directly:

```
eval [options] [target]   Run eval cases (evals/**/case.yaml or
                           evals/**/prompt.md + graders/*.md) against a plugin and report
                           scored results...
```

and `claude plugin eval --help` documents a full flag set (`--case`, `--tag`, `--runs`,
`--judge-model`, `--ablation`, `--allow-tools`, `--json`, `--report`, `--scaffold`, `--threshold`,
etc.) matching exactly what this suite's cases are written against.

**However**, actually invoking it in this environment — both `claude plugin eval init` (to
scaffold a case) and `claude plugin eval <target>` (to run one) — returns:

```
`plugin eval` is currently in early access
```

and exits without doing anything. This is a feature flag on the account/environment this round ran
in, not a defect in this suite's case files. `run-evals.sh` surfaces this plainly rather than
pretending the run succeeded — see its own output for the exact message. **Nobody has watched
these six cases execute against live model turns and confirm the graders fire correctly.** Treat
them as schema-correct, carefully designed, and ready to run the moment early access is available
— not as a suite with a track record yet. The next round that has early access enabled should run
`bash evals/run-evals.sh` (or `claude plugin eval . --scaffold`) for real, look hard at any grader
that fires wrong, and update this note once that's actually happened.

### How this schema was obtained

Given the instruction to be honest rather than invent a plausible-sounding format: the official
public docs (`code.claude.com/docs/en/cli-reference`, `.../plugins-reference`, and the plugins
`README.md` in `anthropics/claude-code`) do **not** document `claude plugin eval` at all as of this
round — its command-line `--help` output and a handful of third-party blog posts / community repos
are the only descriptions of it that exist, and the third-party sources disagree with each other
on schema details (different field names, different tools entirely bearing a similar name). Rather
than pick one of those and hope, this suite's `case.yaml` schema was extracted directly from the
actual validator code shipped inside this environment's installed `claude` binary — the same
`zod` schema object the CLI itself parses `case.yaml` against, recovered via `strings`/careful
offset-reading of the binary (see the exact `Ne.object({...})` schema fragment this was read from,
around the `case.yaml must be a YAML object` / `invalid case.yaml:` error strings the CLI itself
prints). This is about as high-confidence as a schema can be without early access to actually
execute it — it is the literal validation code, not a description of it — but it is still specific
to Claude Code **v2.1.234** on **2026-08-19**; a future version could change it (the schema itself
is versioned via its own `schema_version` field, and this binary's validator caps at major version
`1`, so `schema_version: "1.0"` was used everywhere in this suite for maximum forward compatibility
within that major version). `lib/validate_cases.py` encodes the same schema as a standalone checker
so a future round can re-verify these case files stay valid without needing early access either.

**What was confirmed to work in this environment, right now, with no eval-tooling access
required:**
- `python3 evals/lib/verify_council_aggregation.py` — passes today (see below).
- `python3 evals/lib/validate_cases.py evals` — passes today, confirms all 7 `case.yaml` files
  (case 4 has two) are structurally valid against the extracted schema.
- Every `scaffold.sh` was run in isolation and confirmed to produce valid JSON fixtures matching
  `docs/DATA-CONTRACT.md`'s shape.

**What was not, and could not be, confirmed in this environment:** that any of the six cases'
graders actually fire correctly against a real model run, that the `--scaffold` flag's runtime
`cwd`/working-directory semantics for `context.scaffold_script` match this suite's assumption
(each scaffold script assumes it runs with `cwd` = the scaffolded plugin working copy's root, so
`.startup/<slug>/...` paths resolve correctly — the most natural reading of the CLI help text, but
unverified), or that the `baseline`/`llm` grader judge model actually reads the way each case's
`criteria` text intends. Treat the `criteria`/`pattern` text in each `case.yaml` as a carefully
reasoned first draft, not a battle-tested one.

## How to run

```bash
bash evals/run-evals.sh
```

This always runs, in order:

1. **The deterministic council-aggregation check** (`lib/verify_council_aggregation.py`) — no LLM,
   no `claude plugin eval` access needed. This one has an actual, checkable pass/fail today.
2. **The structural case.yaml validator** (`lib/validate_cases.py`) — same: no LLM, no special
   access needed.
3. **`claude plugin eval` itself**, if the `claude` CLI is on `PATH` and the `eval` subcommand
   exists — with `--scaffold` (so each case's fixture business actually gets created) and
   `--no-publish` (keeps the HTML report local). If early access isn't enabled, this prints the
   CLI's own "early access" message and the script says so plainly rather than faking success.

### To run one case directly (once early access is available)

```bash
claude plugin eval . --case "01-*" --scaffold --report evals/results/case-01.html
```

Swap the `--case` glob for any case name, or use `--tag ai-risk` / `--tag connectors` / etc. to
run by category. Add `--ablation with-without` explicitly if you want the no-plugin baseline arm
even when the default heuristic wouldn't otherwise add it; the `arm: with-only` graders in these
cases (mostly `tool_used: Skill` delegation checks) are deliberately marked so they don't unfairly
zero out a no-plugin baseline run that has no `Skill` tool to call in the first place — see the
`--ablation` flag's own `--help` text for why.

## If your Claude Code version's `claude plugin eval` schema differs from this

Every `case.yaml` here is a small, self-contained YAML file — if a future version's schema has
moved on, the fix is mechanical: re-run the schema-extraction approach above against your version
(or just read `claude plugin eval --help` and try `claude plugin eval init --bare <name>` to get a
scaffold in your version's actual format), then port these six scenarios' `execution.prompt` text,
`context.scaffold_script` fixtures, and grader `criteria`/`pattern` text into whatever the new
shape is — the actual behavioral design work (what to test, what fixture to construct, what the
correct answer looks like) is the expensive part and travels unchanged; the YAML wrapper around it
is not.

## Design notes worth knowing before extending this suite

- **Fixtures are self-contained, not pointers into `.startup/shiftcover/`.** Cases 1 and 6 are
  explicitly modeled on real fixture data in this repo (`ar-shiftcover-002`, and ShiftCover's
  actual current `stage: "revising"` state) but each case's `scaffold.sh` inlines its own copy
  under a fresh eval-only slug, rather than depending on the real `.startup/shiftcover/` directory
  being reachable/writable from wherever `claude plugin eval` executes a scaffolded run. This
  keeps each case reproducible in isolation and never risks mutating this repo's real fixture
  businesses.
- **`baseline` graders are used for genuine contrastive judging, not busywork.** Case 1's
  `baseline_file` is the real `ar-shiftcover-002` finding text, used to judge whether this run's
  finding matches that real precedent's rigor. Case 4b's `baseline_file` is a hand-authored
  SaaS-branch exemplar, used to judge whether the marketplace run is *structurally different in
  kind* (GMV × take rate) rather than merely different in the numbers — directly encoding "business
  type actually changes the output," not just "the two runs don't look identical."
- **`arm: with-only` is used deliberately, not decoratively**, on the `tool_used: Skill` /
  `tool_used: Task` delegation checks (e.g. "did it actually delegate to
  `agents/connectors-liaison.md`") — per `--ablation`'s own documented semantics, a no-plugin
  baseline arm has no `Skill` tool to call at all, so scoring that grader against the baseline
  would be an unwinnable, unfair comparison rather than a real signal.
- **Every `execution.prompt` names the exact file** (`skills/.../SKILL.md`, `agents/....md`) the
  agent should act as/delegate to, rather than describing the task in generic terms and hoping
  auto-routing finds the right skill. This is deliberate: these cases are testing whether the
  *named* skill/agent's own documented judgment logic holds up under a live model turn, the same
  target `docs/TESTING.md` Layer 2 describes — they are not (primarily) testing this plugin's
  auto-routing/trigger-matching, which is a different, real, but separate question a future case
  could test on its own.

## Extending this suite

Six cases is a starting point, not coverage. Natural next additions, in roughly the order
`docs/TESTING.md`'s own Layer 2 examples suggest priority:
- `business-plan-editor`'s cosmetic-revision refusal (`docs/TESTING.md` §3.2's other named item —
  "submit a revision that only reorders/rewords a flagged section and confirm it comes back not
  resolved").
- The founder-override path (`agents/orchestrator.md` Non-negotiable #3) — confirm a shrug doesn't
  count as an override, and a real "yes, override" produces the exact `risk_log` shape
  `docs/DATA-CONTRACT.md` specifies.
- A second DE-step branching pair beyond Step 4 (Step 16 pricing, or Step 19 COCA, both of which
  also branch by `business_basics.business_type` per their own SKILL.md files).
- The privacy-check Mode A/B split (`skills/risk/privacy-check`) — onboarding's one-time notice vs.
  a real per-task data-flow gate.

Follow this same pattern for each: a real fixture or a fixture modeled closely on one, a prompt
naming the exact skill/agent under test, and graders that mix mechanical checks (`regex`,
`file_exists`, `tool_used`) with at least one `llm` or `baseline` grader carrying the actual
judgment call — a mechanical check alone usually can't tell "pushed back correctly" from "pushed
back," and that distinction is the entire point of Layer 2.
