# 30-Minute Startup

A Claude Code plugin that acts as an entrepreneur-in-residence. A central **Startup Operator**
agent interviews you about your idea, drives it through Bill Aulet's 24-step Disciplined
Entrepreneurship framework to a rigorous, evidence-backed business plan, puts that plan through
simulated expert and VC review councils tailored to the actual shape of your business, and then
hands off to go-to-market and ongoing-operations agents that check back in with you on a cadence
as the business grows. It doesn't skip the hard parts — it forces you through them, on the
record, with a paper trail of every assumption, claim, and revision.

## Before you start — what to actually expect

Read this before your first session; it will save you a surprise mid-conversation.

- **The name is a hook, not a time estimate.** Some of the first conversation — pinning down who
  you're really selling to, killing vague answers like "everyone is my customer" — moves fast. But
  a genuinely rigorous plan runs all 24 steps of Disciplined Entrepreneurship, plus a review
  council, plus (if you continue) go-to-market and operations. That's real back-and-forth, not
  thirty minutes. Budget one solid session to get through onboarding and the first few steps, and
  expect to return for several more sessions to finish a full plan — likely hours of total
  conversation across days or weeks, not one sitting.
- **What you need before you start:** a real idea (even a rough one — "I don't know yet" answers
  are handled honestly, see below), and the willingness to answer specific, sometimes
  uncomfortable follow-up questions rather than smoothing past them. The plugin is built to push
  back on platitudes ("huge market," "no competitors," "we'll figure out pricing later") rather
  than accept them — that pushback is the point, not a bug.
- **"I don't know" is a fine answer.** You will not be forced to invent a number you don't
  believe. Genuine unknowns get logged as an explicit assumption with a note on how it could be
  tested later, instead of a fabricated figure sitting quietly in your plan looking like fact.
- **It will not check back in on its own unless your environment supports that.** This plugin runs
  inside a Claude Code session — it has no way to wake itself up and message you later unless the
  environment hosting it exposes a scheduling/trigger capability as a tool. Some environments have
  this; many don't. The Startup Operator checks for one honestly every session and tells you
  plainly which case you're in. If your environment doesn't have it, nothing bad happens
  automatically — but nothing happens automatically at all: **you are responsible for coming back
  and running `/business-status` (or `/check-in`) yourself, on whatever cadence you agree to.**
  See [Recurring check-ins, honestly](#recurring-check-ins-honestly) below for the concrete detail.
- **Literally, what to type first:** `/start-business`, optionally followed by a name or a
  one-sentence idea (e.g. `/start-business ShiftCover, a scheduling tool for shift workers`). If
  you type it with no arguments, the Startup Operator will ask you for a working name and a
  one-liner directly — you don't need to have those polished in advance.

## Install and use

This is a [Claude Code plugin](https://docs.claude.com/en/docs/claude-code/plugins). Add this
repository as a plugin source and enable it, then invoke it from within a project directory (or
any directory where you're comfortable with a `.startup/` working folder being created — see
[Directory layout](#directory-layout) below). The full manifest is
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).

### Commands

Two commands cover the whole lifecycle, and you'll use these almost exclusively:

- **`/start-business [name or one-liner]`** — begins a brand-new business. If you don't pass
  arguments, the Startup Operator asks for a working name and a one-sentence description before
  anything else happens. This command only ever creates something new; it refuses to overwrite an
  existing business with the same slug.
- **`/business-status [name or slug]`** — resumes an existing business from wherever it left off.
  With no arguments it auto-resolves if you have exactly one business under `.startup/`, or lists
  your businesses and asks which one otherwise. It re-reads the business's full state from disk
  (never from conversation memory), reports what changed since the last session, and continues
  the next concrete action — another Disciplined Entrepreneurship step, plan assembly, a council
  review, go-to-market work, or an operations check-in. **This is also the command you run
  yourself, on your own schedule, if your environment can't schedule check-ins automatically —
  see below.**

Four more commands exist for specific, less-frequent situations:

- **`/check-in [slug]`** — manually triggers a recurring check-in conversation right now, either
  because you want to check in early or because `/business-status` is your only way to trigger one
  at all (no automatic scheduling available). Functionally close to `/business-status`, but framed
  explicitly as a check-in rather than a general resume. This one assumes **you're here live** —
  it asks you questions and waits for real answers.
- **`/continue-business [slug]`** — the unattended counterpart to `/check-in`: the command a
  scheduled Routine should invoke, not a founder sitting at the keyboard. It does whatever
  autonomous-safe work is available (metrics snapshots, retros, risk scans, drafting the next
  artifact), never invents a founder-only fact or crosses an irreversible gate (a real launch, a
  council override, spending money) on your behalf, and leaves you a short digest of what it did
  and exactly what it needs from you next. See
  [Setting up a fully automated recurring routine](#setting-up-a-fully-automated-recurring-routine)
  below.
- **`/run-council [slug] [council-name...]`** — manually convenes a review council against your
  current plan outside the normal review gate — useful for an early gut-check before you're ready
  to formally submit for review. Doesn't skip or replace the real gate.
- **`/list-skills [filter]`** — prints a categorized summary of every skill, agent, and command
  currently in the plugin. Mostly useful if you're curious what's under the hood or contributing
  to the plugin itself.

Everything else — the 24 step skills, the review councils, go-to-market and operations agents,
the risk layers — is driven by the Startup Operator through these commands. You generally won't
invoke individual agents or skills directly.

## Recurring check-ins, honestly

Once your plan is approved and you move into go-to-market and operations, the Startup Operator
asks what cadence you want to check back in on (`weekly`, `biweekly`, `monthly`, or `manual`) and
records it. What happens next depends entirely on whether the environment running this plugin
exposes a scheduling/trigger capability as a tool:

- **If it does**, the Startup Operator schedules the next check-in itself and tells you when to
  expect it — no action needed on your part.
- **If it doesn't** (a plain Claude Code session with no scheduling tool available, for example),
  the plugin says so explicitly, sets `cadence.scheduling_mechanism` to `"manual-reminder"` in
  your business's state file, and — this is the important part — **that check-in will never
  happen unless you make it happen.** Nothing is silently missed on the plugin's end because
  nothing was ever scheduled; it's simply on you to come back and run `/business-status <slug>`
  or `/check-in <slug>` yourself on whatever cadence you picked.

Know which case you're in before you finish your first session — the Startup Operator will tell
you plainly, and it's worth writing down your own reminder (a calendar entry, a recurring to-do)
if you're in the manual case and this business matters to you.

### Setting up a fully automated recurring routine

If your environment supports scheduled triggers (Claude Code on the web / claude.ai/code calls
these **Routines** — recurring or one-shot prompts that fire back into a session on their own),
you can have this plugin genuinely check in and keep working on your business without you
initiating each session. Two ways to get there:

1. **Let the Startup Operator do it for you.** When it asks about check-in cadence at the end of a
   session, say yes to scheduling — it looks for a scheduling capability itself and, if your
   environment has one, sets it up automatically (see above). This is the path most founders should
   use; nothing further to configure.
2. **Set it up yourself, explicitly**, if you want more control over the cadence or you're setting
   this up ahead of a session rather than at the end of one. Ask Claude directly, in your own
   words, something like:

   > "Set up a recurring Routine that runs `/continue-business <your-business-slug>` every
   > [weekday / week / two weeks — whatever cadence you want]."

   Claude will create the Routine (a cron-style schedule) targeting this exact command. Two things
   matter about the command it targets:

   - **It must be `/continue-business`, not `/check-in` or `/business-status`.** Those two assume
     you're present to answer questions live; if a Routine fires them with nobody watching, the
     session just sits there having asked a question into the void. `/continue-business` is built
     for exactly this situation — it never asks a question it expects an immediate answer to.
   - **Include the business slug in the prompt** (the `.startup/<slug>/` folder name) so each
     firing knows which business to continue without you present to clarify.

**What actually happens on each automated firing, honestly:**

- It re-reads your business's real state from disk (never from memory of a prior session) and does
  whatever mechanical, data-grounded work is safe to do without you — a metrics snapshot, a retro,
  a risk scan, drafting (not sending/shipping) the next artifact.
- It leaves you a short digest: what it did, and a specific, short list of exactly what it needs
  from you — never a fabricated number or a guessed answer standing in for something only you
  actually know.
- It will **never**, on its own: treat a review council's REVISE/REJECT verdict as resolved,
  declare a real launch happened, spend money or send anything externally through a connector, or
  write anything into `founder`/`business_basics` on your behalf. Those all require you, present,
  saying so.
- It reschedules the next firing itself before ending, the same way the Startup Operator does when
  it sets this up for you in path 1 above.

**Checking on it or turning it off:** ask Claude to list your Routines, or just say "stop the
recurring check-ins for `<slug>`" — this plugin doesn't manage the Routine itself once it's
created, so cancelling it is a normal Claude Code Routine action, not a plugin command.

## Directory layout

The plugin ships four top-level areas, plus a per-business working directory it creates at
runtime:

- **`agents/`** — subagent definitions: the orchestrator (`orchestrator.md`, the "Startup
  Operator"), the review councils (`agents/council/`), go-to-market agents (`agents/gtm/`),
  operations/analytics/finance agents (`agents/ops/`), AI-risk and privacy/compliance agents
  (`agents/risk/`), QA agents (`agents/qa/`), brand/design agents (`agents/design/`), and the
  connector-liaison agent (`connectors-liaison.md`, a singleton file directly under `agents/`,
  not a subfolder).
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

**This also is not** a service that runs in the background on its own. See
[Recurring check-ins, honestly](#recurring-check-ins-honestly) above — outside of a session you
are actively driving, or an environment that genuinely supports scheduled triggers, nothing about
your business advances on its own.

## Contributing

Every agent, skill, and command in this repo is written against one shared contract:
[`CONVENTIONS.md`](CONVENTIONS.md). It defines the directory layout, frontmatter formats, the
review-council verdict schema, and the data contract that lets independently-authored pieces
interoperate without a central author reconciling formats by hand. Read it before adding anything
— it's what keeps a swarm of contributors coherent as this grows from dozens of agents/skills
toward the hundreds the long-term vision describes (see [`docs/ROADMAP.md`](docs/ROADMAP.md)).
