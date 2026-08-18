# Plugin Conventions — 30-Minute Startup

This file is the shared contract every builder in this repo writes against. Read it before
creating any agent, skill, or command file. It exists so dozens (eventually hundreds) of
agents/skills interoperate without a central author reconciling formats by hand.

## 1. Directory layout (plugin root)

```
.claude-plugin/plugin.json      # plugin manifest (do not edit structure, only add discoverable dirs if needed)
agents/                         # subagent definitions, one .md per agent, may use subfolders
  orchestrator.md               # the central "Startup Operator" agent (frontmatter name: startup-operator)
  business-plan-editor.md       # a singleton agent can live directly under agents/ — not every
  connectors-liaison.md         #   agent needs a category subfolder, just a well-formed file
  council/                      # review council agents (VC panel, expert panels, etc.)
  design/                       # brand/landing-page/pitch-deck design agents
  gtm/                          # go-to-market agents (launch, marketing, sales, fundraising)
  ops/                          # operations, analytics, finance, scaling agents
  product/                      # product management / roadmap agents (round 9)
  qa/                           # testing / quality assurance agents
  risk/                         # AI risk, privacy, compliance agents
skills/                         # SKILL.md packages, one folder per skill
  disciplined-entrepreneurship/
    01-market-segmentation/SKILL.md
    02-...-24.../SKILL.md
  business-plan/                # assembling, versioning, diffing the plan
  connectors/
  design/
  gtm/
  interview/                    # onboarding + recurring check-in interview flows
  ops/
  product/                      # product management / roadmap skills (round 9)
  qa/
  risk/
  autonomous-continuation/SKILL.md  # a singleton skill can live directly under skills/ too, same
                                 #   rule as the agents/ singletons above — not every skill needs
                                 #   a category subfolder
commands/                       # slash commands, one .md per command
docs/                           # ARCHITECTURE.md, ROADMAP.md, DATA-CONTRACT.md, QA-FINDINGS-*.md, etc.
scripts/                        # validate-plugin.sh — structural drift checker; run before opening a PR
                                 #   that touches agents/skills/commands (see docs/ARCHITECTURE-IMPLEMENTATION.md §4)
.github/workflows/              # CI: validate-plugin.yml runs scripts/validate-plugin.sh on every push/PR
```

Use kebab-case for every skill folder, agent file, and command file.

**`docs/QA-FINDINGS-*.md` naming.** Each end-to-end dry run or targeted audit gets its own,
never-overwritten file: `docs/QA-FINDINGS-ROUND<N>.md` for a general dry run that round (role-play
a real founder through the real flow, producing real `.startup/<slug>/` artifacts), or
`docs/QA-FINDINGS-<SCOPE>-ROUND<N>.md` (e.g. `GATES`, `CONNECTORS`) for a pass scoped to one
subsystem. Open with a `# QA Findings — Round N: <title>` heading and a `**Method.**` paragraph
that states plainly what was actually exercised — a real fixture, a full read of named files —
never a hypothetical description of what a run would produce. A later round's findings are always
a new, dated file, not an edit to a prior round's file, so the history of what was found and fixed
when stays intact.

## 2. SKILL.md frontmatter

```yaml
---
name: kebab-case-skill-name
description: >
  Third-person, trigger-focused description of WHEN to use this skill and what it produces.
  Front-load concrete trigger phrases the way existing Claude skills do (see the skills listed
  in your own system reminder for examples of the style). Keep it under ~100 words.
---
```

Body: plain instructions for the agent executing the skill — steps, questions to ask, what
file(s) to read/write (see §5 Data Contract), and what "done" looks like. No filler.

## 3. agents/*.md frontmatter (subagent definitions)

```yaml
---
name: kebab-case-agent-name
description: >
  When Claude should delegate to this agent (used for auto-routing) and what it's responsible for.
tools: <comma-separated tool list, or omit for all tools>
model: <omit unless the agent genuinely needs a specific tier>
---
```

Body: the agent's system prompt — its mandate, its inputs, its outputs, and (for review-council
agents) its scoring rubric. Every agent should state explicitly what file(s) it reads and what
file(s) it writes, per the Data Contract below.

## 4. commands/*.md (slash commands)

```yaml
---
description: One-line description shown in the command list.
---
```

Body: the prompt template run when the user types `/command-name`. Use `$ARGUMENTS` for
user-supplied text.

## 5. Data contract — shared business state

Every business this plugin operates on gets a working directory created wherever the user
invokes the orchestrator, named `.startup/<business-slug>/`. This is the single source of
truth all agents/skills read and write — never keep business data only in conversation memory.

```
.startup/<business-slug>/
  business-state.json     # canonical structured record — see docs/DATA-CONTRACT.md for schema.
                           # Connector status and check-in cadence live INSIDE this file, as its
                           # own `connectors` and `cadence` top-level keys — there is no separate
                           # connectors.json or cadence.json on disk.
  interview-log.md        # running transcript of every interview / check-in session
  plan/                   # one markdown file per Disciplined Entrepreneurship step, 01-24
    01-market-segmentation.md
    ...
    24-....md
    business-plan.md      # assembled, human-readable full plan (generated, not hand-edited)
    business-plan-vN.md   # prior version snapshot, written by revise-business-plan on every
                           #   revision cycle; business-plan.md always mirrors the latest version
  reviews/                # one file per council review: <YYYY-MM-DD>-<track-slug>-panel-v<N>.md
    2026-08-18-venture-track-panel-v1.md
  gtm/                    # launch plans, campaign briefs, sales collateral
  ops/                    # metrics snapshots, dashboards, retros
```

`docs/DATA-CONTRACT.md` is the authoritative schema for `business-state.json` — every field
name used by any skill or agent must be declared there. If your agent/skill needs a new field,
add it to that doc in the same PR/commit.

## 6. Review council verdict schema

Every council agent (`agents/council/*.md`) returns its verdict in this shape so the
orchestrator and other agents can parse it mechanically:

```markdown
## Verdict: <APPROVE | APPROVE_WITH_NOTES | REVISE | REJECT>
**Score:** <1-10>
**Reviewer persona:** <e.g. "Seed-stage SaaS VC, 12 years, B2B focus">

### Strengths
- ...

### Risks / gaps
- ...

### Required revisions (if REVISE or REJECT)
1. ...
```

A **formal** review council — the kind `skills/business-plan/run-review-council` convenes at the
`plan_assembled`/`council_review` gate — is a *panel* of exactly 5 distinct reviewer personas run
in parallel: 4 fixed seats (evidence quality, financial-modeling rigor, and the two generalist VC
vs. operator lenses) plus one contextual specialist seat chosen by the plan's business type and
content (see that skill for the selection and tie-break rules). It is never fewer than 5 for a
real gate decision, and never a single reviewer standing in for "the council." `/run-council`
additionally supports a smaller or differently-composed **ad-hoc** panel (as few as one named
persona) for a founder's early gut-check or a maintainer's manual test outside the formal gate —
it uses the same per-persona verdict schema below, but must be reported as advisory, never as a
substitute for the formal 5-seat gate decision (see `commands/run-council.md`). In either case,
whenever more than one persona is convened, the council's aggregate verdict is the harshest
non-outlier verdict among the panel, not an average — one credible blocking objection should
block, not get diluted.

## 7. Tone / quality bar

- No filler, no hedging disclaimers stacked on every output. State the analysis; flag real
  uncertainty once, plainly.
- Every skill must specify concrete deliverables (a file, a decision, a score) — never "provide
  general guidance."
- Business/financial content should be labeled clearly as a planning aid, not licensed
  financial, legal, or tax advice — state this once in the relevant skill, not repeatedly.
