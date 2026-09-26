# AI EIR (Entrepreneur in Residence)

A Claude Code plugin that acts as your entrepreneur-in-residence. A central **AI EIR** agent
interviews you about your idea, drives it through Bill Aulet's 24-step Disciplined
Entrepreneurship framework to a rigorous, evidence-backed business plan, puts that plan through
simulated expert and VC review councils tailored to the actual shape of your business, and then
executes Paul Cheek's **15 Tactics** (from *Disciplined Entrepreneurship: Startup Tactics*) to turn
that plan into a real, running business — checking back in with you on a cadence as it grows. It
doesn't skip the hard parts — it forces you through them, on the record, with a paper trail of
every assumption, claim, and revision.

**Created by [Paul Cheek](https://www.paulcheek.com), © Cheek LLC. Questions or feedback:
paul@startuptactics.net.**

## Set this up before you do anything else

AI EIR is built to run inside a **Claude Cowork project with its own real, persistent working
folder** — not a one-off Claude Chat conversation, and not an ephemeral Claude Code session with
no durable file system. Everything AI EIR knows about your business lives on disk under
`.startup/<slug>/`; if there's nowhere durable for that to live, there's nothing for AI EIR to
resume next time, and it will tell you so plainly and decline to start rather than pretend
otherwise.

**The first time you invoke AI EIR in a new working folder, it walks you through this itself** —
a one-time welcome, a direct question confirming you're in Cowork (not plain chat), and a
recommendation for where to point the working folder. But if you'd rather set it up in advance:

1. **Create a Claude Cowork project** and set its working folder to somewhere real and durable:
   - Your **Desktop** is a fine default (e.g. `~/Desktop/<Business Name>` or a general
     `~/Desktop/AI-EIR` folder if you'll run more than one business through it).
   - If you have **co-founders**, point it at a **shared Google Drive or Dropbox folder**
     instead — AI EIR has no account system or sync layer of its own; the shared folder *is* the
     shared memory everyone reads from and writes to the instant it's written.
2. **Add any co-founders to the Cowork project** (or make sure the shared Drive/Dropbox folder is
   shared with them) so everyone sees the same business state and history, not separate copies.
3. **Paste this into the Claude Project's own "Project instructions" field**, so every future
   session opened in this project — not just your first one — already knows what it's for:

   ```
   This project runs the AI EIR (Entrepreneur in Residence) Claude Code plugin, created by Paul
   Cheek (© Cheek LLC). This project's own folder is the working folder — all business data lives
   under .startup/<business-slug>/ here, nothing is saved anywhere else. When I say "start a
   business," "resume my business," "check status," or similar, use AI EIR's /start-business or
   /business-status commands. If co-founders are added to this project, treat any of us as "the
   founder" for the same business unless told otherwise — we share one working folder and one
   business state.
   ```
4. **Literally, what to type first:** `/start-business`, optionally followed by a name or a
   one-sentence idea (e.g. `/start-business ShiftCover, a scheduling tool for shift workers`). If
   you type it with no arguments, AI EIR will ask you for a working name and a one-liner directly.

## Before you start — what to actually expect

Read this before your first real interview session; it will save you a surprise mid-conversation.

- **This is not a thirty-minute process.** Some of the first conversation — pinning down who
  you're really selling to, killing vague answers like "everyone is my customer" — moves fast. But
  a genuinely rigorous plan runs all 24 steps of Disciplined Entrepreneurship, plus a review
  council, plus (if you continue) all 15 Tactics of actually executing the business. That's real
  back-and-forth across many sessions, not one sitting. Budget one solid session to get through
  onboarding and the first few steps, and expect to return for several more sessions to finish a
  full plan — likely hours of total conversation across days or weeks.
- **What you need before you start:** a real idea (even a rough one — "I don't know yet" answers
  are handled honestly, see below), and the willingness to answer specific, sometimes
  uncomfortable follow-up questions rather than smoothing past them. The plugin is built to push
  back on platitudes ("huge market," "no competitors," "we'll figure out pricing later") rather
  than accept them — that pushback is the point, not a bug.
- **"I don't know" is a fine answer.** You will not be forced to invent a number you don't
  believe. Genuine unknowns get logged as an explicit assumption with a note on how it could be
  tested later, instead of a fabricated figure sitting quietly in your plan looking like fact.
- **It will not check back in on its own unless your environment supports that.** Some
  environments (Claude Code on the web, for example) expose a scheduling/trigger capability as a
  tool; some don't. AI EIR checks for one honestly every session and tells you plainly which case
  you're in. If your environment doesn't have it, nothing bad happens automatically — but nothing
  happens automatically at all: **you are responsible for coming back and running
  `/business-status` (or `/check-in`) yourself, on whatever cadence you agree to.** See
  [Recurring check-ins, honestly](#recurring-check-ins-honestly) below for the concrete detail.

## Install and use

This is a [Claude Code plugin](https://docs.claude.com/en/docs/claude-code/plugins). Add this
repository as a plugin source and enable it, then invoke it from within your Claude Cowork
project's working folder (see [Set this up before you do anything else](#set-this-up-before-you-do-anything-else)
above). The full manifest is [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).

### Commands

Two commands cover the whole lifecycle, and you'll use these almost exclusively:

- **`/start-business [name or one-liner]`** — begins a brand-new business. If you don't pass
  arguments, AI EIR asks for a working name and a one-sentence description before anything else
  happens. This command only ever creates something new; it refuses to overwrite an existing
  business with the same slug.
- **`/business-status [name or slug]`** — resumes an existing business from wherever it left off.
  With no arguments it auto-resolves if you have exactly one business under `.startup/`, or lists
  your businesses and asks which one otherwise. It re-reads the business's full state from disk
  (never from conversation memory), reports what changed since the last session, and continues
  the next concrete action — another Disciplined Entrepreneurship step, plan assembly, a council
  review, a Tactic, or an operations check-in. **This is also the command you run yourself, on
  your own schedule, if your environment can't schedule check-ins automatically — see below.**

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

Everything else — the 24 step skills, the review councils, the 15 Tactics, go-to-market and
operations agents, the risk layers — is driven by AI EIR through these commands. You generally
won't invoke individual agents or skills directly.

## The 24 Steps and the 15 Tactics

AI EIR is built on two tightly-integrated frameworks, both by the team behind MIT's Martin Trust
Center for Entrepreneurship:

- **Bill Aulet's 24 Steps of Disciplined Entrepreneurship** take you from an idea to a complete,
  rigorous business plan — market segmentation through to a product plan, gated by a simulated
  expert/VC review council before it's called done.
- **Paul Cheek's 15 Tactics** (*Disciplined Entrepreneurship: Startup Tactics*) take that approved
  plan and turn it into a real business: Goals and Systems (Foundations), Market Research, Assets,
  Marketing, and Sales (Market Testing), Product Roadmap, Design, User Testing, and Engineering
  (Product Development), and Legal, Finance, Pitch Deck Design, Fundraising, and Hiring (Resource
  Acquisition). See [`docs/TACTICS-15.md`](docs/TACTICS-15.md) for the full list and how specific
  steps inform specific tactics (e.g. Step 11's competitive position informs Tactic 6's sales
  messaging).

The two frameworks don't map one-to-one and aren't meant to be run in lockstep — Tactics are
learned in order but executed iteratively, in harmony with whatever GTM and operations work is
actually happening.

## Recurring check-ins, honestly

Once your plan is approved and you move into go-to-market, operations, and the 15 Tactics, AI EIR
asks what cadence you want to check back in on (`weekly`, `biweekly`, `monthly`, or `manual`) and
records it. What happens next depends entirely on whether the environment running this plugin
exposes a scheduling/trigger capability as a tool:

- **If it does**, AI EIR schedules the next check-in itself and tells you when to expect it — no
  action needed on your part.
- **If it doesn't** (a plain Claude Code session with no scheduling tool available, for example),
  the plugin says so explicitly, sets `cadence.scheduling_mechanism` to `"manual-reminder"` in
  your business's state file, and — this is the important part — **that check-in will never
  happen unless you make it happen.** Nothing is silently missed on the plugin's end because
  nothing was ever scheduled; it's simply on you to come back and run `/business-status <slug>`
  or `/check-in <slug>` yourself on whatever cadence you picked.

Know which case you're in before you finish your first session — AI EIR will tell you plainly, and
it's worth writing down your own reminder (a calendar entry, a recurring to-do) if you're in the
manual case and this business matters to you.

### Setting up a fully automated recurring routine

If your environment supports scheduled triggers (Claude Code on the web / claude.ai/code calls
these **Routines** — recurring or one-shot prompts that fire back into a session on their own),
you can have this plugin genuinely check in and keep working on your business without you
initiating each session. Two ways to get there:

1. **Let AI EIR do it for you.** When it asks about check-in cadence at the end of a session, say
   yes to scheduling — it looks for a scheduling capability itself and, if your environment has
   one, sets it up automatically (see above). This is the path most founders should use; nothing
   further to configure.
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
- It reschedules the next firing itself before ending, the same way AI EIR does when it sets this
  up for you in path 1 above.

**Checking on it or turning it off:** ask Claude to list your Routines, or just say "stop the
recurring check-ins for `<slug>`" — this plugin doesn't manage the Routine itself once it's
created, so cancelling it is a normal Claude Code Routine action, not a plugin command.

## Directory layout

The plugin ships four top-level areas, plus a per-business working directory it creates at
runtime:

- **`agents/`** — subagent definitions: the orchestrator (`orchestrator.md`, presented to founders
  as "AI EIR"), the review councils (`agents/council/`), go-to-market agents (`agents/gtm/`),
  operations/analytics/finance agents (`agents/ops/`), product agents (`agents/product/`),
  AI-risk and privacy/compliance agents (`agents/risk/`), QA agents (`agents/qa/`), brand/design
  agents (`agents/design/`), and the connector-liaison agent (`connectors-liaison.md`, a singleton
  file directly under `agents/`, not a subfolder).
- **`skills/`** — one folder per skill, each a `SKILL.md` package: the 24 Disciplined
  Entrepreneurship step skills (`skills/disciplined-entrepreneurship/01-...` through `24-...`),
  the 15 Tactics (`skills/tactics/01-...` through `15-...`, see
  [`docs/TACTICS-15.md`](docs/TACTICS-15.md)), business-plan assembly and revision
  (`skills/business-plan/`), onboarding and recurring check-in interviews (`skills/interview/`),
  and further packages for go-to-market, operations, product, design/brand, and connectors.
- **`commands/`** — the slash commands described above, plus any supporting commands the
  plugin-engineering layer adds.
- **`docs/`** — this narrative documentation, the data contract, the 24-steps and 15-tactics
  references, and the mechanical architecture/implementation notes.

At runtime, every business gets its own working directory, `.startup/<business-slug>/`, inside
your Cowork project's own working folder — the single source of truth every agent and skill reads
and writes: canonical state in `business-state.json`, the interview transcript, one file per DE
step, one file per Tactic, the assembled plan, timestamped council reviews, GTM and ops artifacts,
connector status, and check-in cadence. The full schema is documented in
[`docs/DATA-CONTRACT.md`](docs/DATA-CONTRACT.md); the system-level narrative of how these pieces
move through a business's lifecycle is in [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

## What this is — and isn't

**This is** a serious planning and execution partner: a forcing function that makes you name a
real customer, size a real market, quantify a real value proposition, and defend your numbers
before you write a check or quit your job — and then a practical guide through the 15 Tactics that
actually turn that plan into customers, product, funding, and a team. It structures the work Bill
Aulet's Disciplined Entrepreneurship framework and Paul Cheek's Startup Tactics framework say
matters, keeps a durable record of every claim and its source, and stages that record through
review panels built to actually push back rather than rubber-stamp you.

**This is not** a substitute for talking to real customers, real lawyers, real accountants, or
real investors. The review councils are simulated personas grounded in the framework and in your
own stated facts — they are not licensed advisors, they have not seen your market with their own
eyes, and their approval is not due diligence. Any number presented as fact in the plan is
required to carry a source (founder estimate, cited research, cited benchmark, or your own real
operating data) precisely because this system cannot independently verify the world — see
[`docs/DATA-CONTRACT.md`](docs/DATA-CONTRACT.md) for how that's enforced. Treat every output as a
draft to pressure-test with real people, not a document to hand a real VC unedited.

**This also is not** a service that runs in the background on its own, and **it is not built to
run in a plain Claude Chat conversation** — see [Set this up before you do anything
else](#set-this-up-before-you-do-anything-else) and [Recurring check-ins,
honestly](#recurring-check-ins-honestly) above. Outside of a session you are actively driving, or
an environment that genuinely supports scheduled triggers, nothing about your business advances
on its own — and without a real, persistent working folder, nothing about your business persists
at all.

## Contributing

Every agent, skill, and command in this repo is written against one shared contract:
[`CONVENTIONS.md`](CONVENTIONS.md). It defines the directory layout, frontmatter formats, the
review-council verdict schema, and the data contract that lets independently-authored pieces
interoperate without a central author reconciling formats by hand. Read it before adding anything
— it's what keeps a swarm of contributors coherent as this grows from dozens of agents/skills
toward the hundreds the long-term vision describes (see [`docs/ROADMAP.md`](docs/ROADMAP.md)).

## Credits

AI EIR was created by [Paul Cheek](https://www.paulcheek.com), Executive Director of the Martin
Trust Center for MIT Entrepreneurship and author of *Disciplined Entrepreneurship: Startup
Tactics* (Wiley, 2024), built on Bill Aulet's *Disciplined Entrepreneurship: 24 Steps to a
Successful Startup*. © Cheek LLC. Licensed under [MIT](LICENSE) — see that file for the full
license text. Questions, feedback, or issues: **paul@startuptactics.net**.
