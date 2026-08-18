# 30-Minute Startup

A Claude Code plugin that acts as an entrepreneur-in-residence. A central **Startup Operator**
agent interviews you about your idea, drives it through Bill Aulet's 24-step Disciplined
Entrepreneurship framework to a rigorous, evidence-backed business plan, puts that plan through
simulated expert and VC review councils tailored to the actual shape of your business, and then
hands off to go-to-market and ongoing-operations agents that check back in with you on a cadence
as the business grows. It doesn't skip the hard parts — it forces you through them, on the
record, with a paper trail of every assumption, claim, and revision.

## Install and use

This is a [Claude Code plugin](https://docs.claude.com/en/docs/claude-code/plugins). Add this
repository as a plugin source and enable it, then invoke it from within a project directory (or
any directory where you're comfortable with a `.startup/` working folder being created — see
[Directory layout](#directory-layout) below). The full manifest is
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).

Two entry points cover the whole lifecycle:

- **`/start-business [name or one-liner]`** — begins a brand-new business. If you don't pass
  arguments, the Startup Operator asks for a working name and a one-sentence description before
  anything else happens. This command only ever creates something new; it refuses to overwrite an
  existing business with the same slug.
- **`/business-status [name or slug]`** — resumes an existing business from wherever it left off.
  With no arguments it auto-resolves if you have exactly one business under `.startup/`, or lists
  your businesses and asks which one otherwise. It re-reads the business's full state from disk
  (never from conversation memory), reports what changed since the last session, and continues
  the next concrete action — another Disciplined Entrepreneurship step, plan assembly, a council
  review, go-to-market work, or an operations check-in.

Everything else — the 24 step skills, the review councils, go-to-market and operations agents,
the risk layers — is driven by the Startup Operator through these two commands. You generally
won't invoke individual agents or skills directly.

## Directory layout

The plugin ships four top-level areas, plus a per-business working directory it creates at
runtime:

- **`agents/`** — subagent definitions: the orchestrator (`orchestrator.md`, the "Startup
  Operator"), the review councils (`agents/council/`), go-to-market agents (`agents/gtm/`),
  operations/analytics/finance agents (`agents/ops/`), AI-risk and privacy/compliance agents
  (`agents/risk/`), QA agents (`agents/qa/`), and connector-liaison agents
  (`agents/connectors/`).
- **`skills/`** — one folder per skill, each a `SKILL.md` package: the 24 Disciplined
  Entrepreneurship step skills (`skills/disciplined-entrepreneurship/01-...` through `24-...`),
  business-plan assembly and revision (`skills/business-plan/`), onboarding and recurring
  check-in interviews (`skills/interview/`), and further packages for go-to-market, operations,
  design/brand, and connectors.
- **`commands/`** — the slash commands described above, plus any supporting commands the
  plugin-engineering layer adds.
- **`docs/`** — this narrative documentation, the data contract, the DE-24-steps reference, and
  the mechanical architecture/implementation notes.

At runtime, every business gets its own working directory, `.startup/<business-slug>/`, which is
the single source of truth every agent and skill reads and writes — canonical state in
`business-state.json`, the interview transcript, one file per DE step, the assembled plan,
timestamped council reviews, GTM and ops artifacts, connector status, and check-in cadence. The
full schema is documented in [`docs/DATA-CONTRACT.md`](docs/DATA-CONTRACT.md); the system-level
narrative of how these pieces move through a business's lifecycle is in
[`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

## What this is — and isn't

**This is** a serious planning and thinking partner: a forcing function that makes you name a
real customer, size a real market, quantify a real value proposition, and defend your numbers
before you write a check or quit your job. It structures the work Bill Aulet's Disciplined
Entrepreneurship framework says matters, keeps a durable record of every claim and its source,
and stages that record through review panels built to actually push back rather than rubber-stamp
you.

**This is not** a substitute for talking to real customers, real lawyers, real accountants, or
real investors. The review councils are simulated personas grounded in the framework and in your
own stated facts — they are not licensed advisors, they have not seen your market with their own
eyes, and their approval is not due diligence. Any number presented as fact in the plan is
required to carry a source (founder estimate, cited research, or cited benchmark) precisely
because this system cannot independently verify the world — see
[`docs/DATA-CONTRACT.md`](docs/DATA-CONTRACT.md) for how that's enforced. Treat every output as a
draft to pressure-test with real people, not a document to hand a real VC unedited.

## Contributing

Every agent, skill, and command in this repo is written against one shared contract:
[`CONVENTIONS.md`](CONVENTIONS.md). It defines the directory layout, frontmatter formats, the
review-council verdict schema, and the data contract that lets independently-authored pieces
interoperate without a central author reconciling formats by hand. Read it before adding anything
— it's what keeps a swarm of contributors coherent as this grows from dozens of agents/skills
toward the hundreds the long-term vision describes (see [`docs/ROADMAP.md`](docs/ROADMAP.md)).
