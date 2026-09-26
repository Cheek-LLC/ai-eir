---
name: 10-engineering
description: >
  Use once Tactic 9's testing has validated (or the founder is committing to) a design, and the
  founder needs to move from validated design to a real build — deciding what to build in-house
  vs. buy/integrate, choosing a prototyping-to-production path, and sanity-checking the build
  timeline against DE Step 24's product plan. Triggers: "start building," "engineering plan,"
  "build vs buy," "how long will this actually take to build," "tactic 10," "engineering tactic."
  Branches sharply by `business_basics.business_type`: software handoff (`saas`, `consumer_app`,
  `marketplace`, `services` with a software component) vs. hardware/manufacturing handoff
  (`physical_product`) — do not apply the software discipline to a physical product or vice versa.
---

# Tactic 10: Engineering — Transitioning From Product Design to Development

## What this tactic is (and isn't)

Tactic 8 designed the experience; Tactic 9 tested it with real users and routed what needed to
change. This tactic is the handoff moment itself: committing real engineering (or manufacturing)
resources to build the validated design for real, at a scope and timeline that's been sanity-
checked rather than assumed. It is not a redo of Tactic 8's design work, and it does not reopen
Tactic 9's findings — it takes the design as validated (with any required Tactic-8/Step-22 fixes
already applied) and plans how it actually gets built.

**Read `business_basics.business_type` before anything else** — this tactic reads fundamentally
differently for a `physical_product` business than for `saas`/`consumer_app`/`marketplace`/
`services`, and applying the wrong branch's discipline produces useless guidance (a sprint-based
software estimate is meaningless for a contract-manufacturer lead time, and a tooling-amortization
framework is meaningless for a web app).

## What you read

- `.startup/<slug>/business-state.json` — `business_basics.business_type` (the branch gate) and
  `tactics.09_user_testing` (confirms testing happened and what, if anything, is still pending a
  fix before build starts).
- `tactics/08-design.md` — required. The validated design/prototype and its per-stage fidelity
  notes; this tactic builds *that*, not a reinterpretation of it.
- `tactics/09-user-testing.md` — required. Any finding still routed and unresolved should block or
  reshape this tactic's scope, not be silently built around.
- `.startup/<slug>/plan/24-develop-a-product-plan.md` — required. The near-term roadmap's stated
  sequencing and any resourcing assumptions it already flagged; this tactic's timeline check runs
  against this file specifically.
- `.startup/<slug>/plan/10-define-your-core.md` — required. What's actually Core (defensible,
  build in-house) vs. Context (commodity, safe to buy/integrate) — the anchor for the build-vs-buy
  decision in both branches below.

## What you write

- `tactics/10-engineering.md` — the build-vs-buy decisions, prototyping-to-production path, and
  timeline sanity check (template below; contents differ by business-type branch).
- This skill does **not** write `business-state.json.tactics` itself. The orchestrator confirms
  `tactics/10-engineering.md` was written and updates `business-state.json.tactics.10_engineering`.

## Step 1 — Build vs. buy/integrate, anchored on Core vs. Context

Regardless of branch, run every planned build item against Step 10's Core/Context distinction
before deciding how to build it:

- **Core** (the specific capability the business is actually defensible on) — default to building
  in-house. This is the thing a vendor or off-the-shelf integration can't be trusted to own,
  because owning it *is* the differentiation.
- **Context** (necessary but undifferentiated) — default to buy/integrate. Building a commodity
  capability in-house (auth, payments, generic hosting infra, standard CRM/analytics tooling for
  software; a standard component or off-the-shelf part for hardware) burns build capacity the
  roadmap could spend on Core work instead.

Push back on a founder who wants to build a Context item from scratch "because we might need to
customize it later" — ask what specific customization is actually needed now, not hypothetically,
and whether it's cheaper to switch vendors later than to have built and maintained it from day one.
Equally, push back on buying/integrating a Core capability — a defensible capability handed to a
vendor is a defensibility problem, not a build-speed win.

## Step 2 — Branch: software handoff

Applies to `saas`, `consumer_app`, `marketplace`, and any `services`/`other` business whose MVBP
has a real software component.

1. **Architecture decisions, named specifically.** What's the actual stack, and why — tied to
   what the team can realistically execute (existing skills, not an aspirational rewrite), not the
   most interesting technology available. Flag explicitly if the proposed stack requires a skill
   the current team doesn't have — that's a resourcing gap DE Step 24 should already have surfaced
   (per its "Resourcing reality check" deliverable); if it didn't, name the gap here.
2. **Prototyping discipline.** Distinguish a **throwaway prototype** (built to learn something
   specific — e.g. validate a technical approach — and discarded) from **production-track code**
   (built once, meant to ship and be maintained). State explicitly which stages from Tactic 8 are
   getting which treatment; building production-quality code for a stage still likely to change
   after more testing wastes real engineering time.
3. **Realistic timeline check.** Take the founder/engineer's raw estimate for each roadmap item and
   apply an explicit reality check: ask what past estimate-vs-actual ratio this team has (if any
   history exists, use it; if not, apply a standard discipline — pad an initial raw estimate by at
   least 1.5-2x rather than accepting it at face value, and say so plainly as an adjustment, not a
   hidden assumption). Compare the padded timeline against Step 24's stated near-term-roadmap
   sequencing: if the real timeline pushes a roadmap item meaningfully later than Step 24 assumed,
   say so explicitly rather than letting the plan's timeline silently go stale.
4. **QA/testing setup.** State what testing discipline exists before shipping (even minimal —
   manual QA checklist, automated tests for the core workflow) — "we'll test it as we go" is not a
   plan.

## Step 3 — Branch: hardware/manufacturing handoff (`physical_product`)

Applies whenever `business_basics.business_type` is `physical_product`. Do not apply Step 2's
software discipline here — the constraints are structurally different (lead times measured in
months, minimum order quantities, tooling amortization, a single supplier as a point of failure).

1. **Design-for-manufacture (DFM) review.** Before committing to a build, check whether Tactic 8's
   design was made with real manufacturing constraints in mind (material choice, tolerances,
   assembly steps) or purely for prototype/demo purposes — a design that works as a one-off
   prototype frequently doesn't survive contact with a real production process without changes.
   Name any DFM change needed explicitly rather than assuming the prototype design ships as-is.
2. **Manufacturing partner and path.** State whether this build goes to a contract manufacturer or
   stays in-house/small-batch for now (per Step 22's likely small-batch/handmade MVBP approach),
   the specific named manufacturer if one is selected, the stated minimum order quantity, and the
   quoted lead time. **Cross-reference `agents/council/hardware-physical-product-operator.md`**
   directly — that persona's whole professional lens is the gap between "we built one" and "we can
   build these," and its disclosed bias (distrust prototype-to-production extrapolation until a
   real pilot batch closes the gap) is exactly the check this step should apply: don't let a
   confident per-unit cost or timeline pass without a named manufacturer, a stated MOQ, and a real
   cited lead time. If the plan's council review already ran that persona's seat, pull its findings
   forward rather than re-deriving them from scratch.
3. **Realistic timeline check.** State the actual tooling lead time, production lead time, and
   freight/customs time separately — not a single bundled "build time" number — and compare the sum
   against Step 24's stated near-term sequencing. A production lead time measured in months against
   a roadmap that assumed weeks is exactly the pattern `hardware-physical-product-operator` warns
   against; name the gap explicitly if the plan's timeline doesn't already account for it.
4. **Ongoing operational handoff.** This tactic ends at "engineering/manufacturing is under way,"
   not at ongoing operations. **Cross-reference `skills/ops/operations-and-fulfillment-playbook`**
   by name for what happens after production starts — inventory/reorder points, supplier defect-
   rate monitoring, dual-sourcing decisions — rather than duplicating that playbook's content here.
   State the handoff explicitly: "once units are in production/inventory, ongoing supply-chain and
   fulfillment operations are that skill's job, run by `agents/ops/operations-manager.md`."

## Output file: `tactics/10-engineering.md`

```markdown
# Tactic 10: Engineering — Transitioning From Product Design to Development

## Business type branch
`business_basics.business_type`: <value> — <software handoff | hardware/manufacturing handoff>

## Build vs. buy/integrate
| Item | Core or Context (Step 10) | Build in-house or buy/integrate | Reasoning |
|---|---|---|---|
| ... | ... | ... | ... |

### Software branch (if applicable)
Architecture/stack: ...
Skill gap vs. current team: ... (or "none")
Prototyping treatment per Tactic-8 stage: <throwaway vs. production-track, per stage>
Raw estimate vs. reality-checked estimate: <raw> -> <padded, with the adjustment factor stated>
QA/testing setup: ...

### Hardware branch (if applicable)
DFM review finding: <design changes needed for real manufacturing, or "none identified">
Manufacturing partner: <named, or "not yet selected" — state why>
MOQ: ... | Quoted lead time: ...
Cross-reference: `agents/council/hardware-physical-product-operator.md` findings (if a council
review already ran) or this tactic's own read applying its same distrust-until-proven-otherwise
discipline
Ongoing ops handoff: `skills/ops/operations-and-fulfillment-playbook` (run by
`agents/ops/operations-manager.md`) once production/inventory begins

## Timeline sanity check vs. Step 24
Step 24's stated near-term sequencing: <summary, cited>
Reality-checked timeline from this tactic: <summary>
Gap (if any): <explicit statement of how much later/different, and why>

## Open risks
<Anything unresolved before committing real build resources — a missing manufacturer, an
unvalidated skill gap, an unresolved Tactic-9 finding still blocking scope>
```

## Done means

- The correct business-type branch was applied — software or hardware — never the wrong
  discipline borrowed from the other.
- Every planned build item was checked against Step 10's Core/Context distinction before its
  build-vs-buy decision was made.
- The timeline was reality-checked against Step 24's stated sequencing, with any gap named
  explicitly rather than left implicit.
- For `physical_product`: `agents/council/hardware-physical-product-operator.md` and
  `skills/ops/operations-and-fulfillment-playbook` are cross-referenced by name, not duplicated.
- `tactics/10-engineering.md` written with all sections populated for the applicable branch.
- `business-state.json.tactics` was **not** written by this skill — left to the orchestrator.
