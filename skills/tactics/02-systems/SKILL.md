---
name: 02-systems
description: >
  Use once a business reaches `stage: approved` (typically right after Tactic 1/goals) to decide,
  concretely and by name, which tooling/systems backbone this specific founder needs before real
  execution starts — project management, CRM, accounting, comms, and any category their business
  type demands — and in what order to stand them up. Trigger phrases: "what tools do we need,"
  "set up our systems," "what should we wire up before we start selling," "we're drowning without
  a real system for X." This is Tactic 2 of Paul Cheek's 15 Tactics: the recommendation and
  sequencing decision. It does not perform the actual connection; that routes through
  `agents/connectors-liaison.md` exactly like every GTM/ops skill.
---

# Tactic 2: Systems — Startup Tooling and Systems

## Role in the 15 tactics

Second of the two Foundations tactics, meant to run alongside or right after Tactic 1 (Goals) and
before Tactic 3 onward (Market Testing) start drawing on real tools. A founder who has committed
goals but no CRM, no accounting system, and no shared task tracker will lose the next-10-customers
list to a spreadsheet nobody updates and the burn numbers to memory. This tactic's job is a real,
opinionated recommendation of which systems this founder specifically needs, in what order — not
an exhaustive tour of every SaaS category a startup could theoretically use.

## What you read

- `.startup/<slug>/business-state.json` — confirm `stage` is `approved` or later. Read
  `business_basics.business_type`/`business_type_notes` (the primary driver of which categories
  actually matter first), `connectors.wired_up` and `connectors.needed_not_installed` (don't
  re-recommend what's already connected or already flagged), and any existing `tactics.02_systems`
  entry if you're revising.
- `.startup/<slug>/plan/15-design-a-business-model.md` and
  `plan/16-set-your-pricing-framework.md` — the revenue model determines whether payments/billing
  is urgent now or later, and what an accounting system needs to actually track.
- `.startup/<slug>/tactics/01-goals.md` if it exists — the committed goals tell you which systems
  are urgent (a goal that depends on a next-10-customers pipeline needs a CRM now; a goal three
  quarters out doesn't).
- `docs/CONNECTORS-CATALOG.md` — read in full. This is the plugin's existing map of connector
  categories, canonical ids, example real tools, what data flows, and the privacy consideration
  for each. Your recommendation must use this catalog's categories and canonical ids, not invent
  parallel ones.
- `agents/connectors-liaison.md` — read in full. This is who actually wires up any real connector
  once you and the founder have decided what's needed; you never call a connector-shaped tool
  yourself or claim a system is "connected."

## What you write

Output file: `tactics/02-systems.md`. **You do not write `business-state.json.tactics` yourself** —
draft the file, confirm it with the founder, then tell them (or the orchestrator) that
`tactics.02_systems` is ready to be set, exactly like every DE step skill and Tactic 1 work. You
also do not write to `business-state.json.connectors` — that key belongs exclusively to
`agents/connectors-liaison.md`; this skill only produces the recommendation and hands off to it.

## Division of labor with the connectors layer (read this before doing anything else)

This tactic and the connectors layer solve two different problems:

- **This skill decides *which* systems, for *this* business, in *what order*.** That's a judgment
  call informed by business type, stage, goals, and team size — the kind of call the catalog
  itself doesn't make (the catalog just lists what exists per category).
- **`agents/connectors-liaison.md` performs the actual wiring** — checking live availability,
  prompting the founder to connect, gating any real data flow behind
  `skills/risk/privacy-check` Mode B, and recording `connectors.wired_up`/`needed_not_installed`.

Do not do the liaison's job here: do not attempt to detect whether a tool is actually connected,
do not initiate a connection yourself, and do not tell the founder something is wired up. Once the
founder agrees on a system and it's one this plugin can actually route data through (see the
catalog), your output names the connector category/canonical id and hands off — the founder or
orchestrator invokes `agents/connectors-liaison.md` next. For a system that's genuinely
founder-only tooling with no connector in this plugin (e.g. a project-management tool with no
catalog row), your job ends at the recommendation; there's nothing to route.

## Method: recommend, don't inventory

1. **Start from what's already missing and urgent, not a fresh clean-slate list.** Cross-reference
   `connectors.wired_up` — don't recommend standing up something already live. Cross-reference
   `connectors.needed_not_installed` — if the founder already has an outstanding need flagged by
   another skill (e.g. `hubspot` flagged by a GTM skill), surface it here too so systems planning
   is centralized, don't silently duplicate a separate untracked recommendation for the same
   category.

2. **Classify by urgency against the committed goals (Tactic 1), not a generic checklist:**
   - **Needed now** — without this, a committed goal or an imminent tactic (3+) is blocked or will
     be tracked in someone's head/a scratch spreadsheet. Justify each one against a specific goal
     or upcoming tactic, not "most startups have this."
   - **Needed soon** — real but not blocking anything in the next 4-6 weeks.
   - **Not yet** — genuinely premature for this stage/team size (e.g. a full HRIS for a two-person
     team, an enterprise CRM before there's a real pipeline to log). Say so explicitly and why —
     over-provisioning tooling this early is a real cost (money, setup time, a founder learning a
     tool they don't need yet), not a free "just in case."

3. **Recommend one real tool per category, not a menu.** This tactic exists specifically because
   an exhaustive list ("here are 6 CRMs, pick one") pushes the decision back onto a founder who
   asked for a recommendation. Name the specific tool you'd actually pick for this business type
   and stage, using the catalog's "Example real tools" column as your option set, and say why
   (team size, price sensitivity signals from the plan, technical sophistication of the founder,
   what the plan's business model actually needs tracked). If the founder already uses something
   specific, prefer it over your default recommendation — never talk them out of a working tool
   just to match a template.

4. **Sequence, don't just categorize.** Give an explicit order: what gets stood up in week 1 vs.
   what waits. A pre-revenue SaaS founder needs a task tracker and a lightweight CRM before
   accounting matters; a physical-product founder taking pre-orders needs payments and inventory
   tracking before a fundraising-deck tool. Tie the sequence back to the committed goals and their
   dates from `tactics/01-goals.md`.

5. **Flag anything outside this plugin's connector scope honestly.** Some real needs (a domain
   registrar, a business bank account, a specific vertical tool) have no catalog row and no
   connector this plugin can wire up. Recommend them anyway if they're genuinely needed — say
   plainly that this is founder-action-required tooling, not something `connectors-liaison` will
   set up, so the founder doesn't wait on a handoff that isn't coming.

## Business-type notes

- **SaaS:** task/project tracker + lightweight CRM + payments (Stripe) are usually the week-1 set;
  accounting can typically wait until there's real revenue to reconcile.
- **Marketplace:** both-sides CRM or a CRM configured for two pipelines (supply and demand) tends
  to matter earlier than for a single-sided business — recommend explicitly for both sides, not
  just demand-side sales tracking.
- **Physical product:** payments + inventory/fulfillment tracking is usually more urgent than a
  CRM if the founder is DTC from day one; a wholesale/retail channel raises CRM urgency instead.
- **Services:** a CRM/pipeline tool plus time-tracking/utilization tracking (feeds Tactic 12's
  financial model and the services KPI set in `skills/ops/kpi-dashboard-setup`) typically outrank
  a marketing-automation tool this early.
- **Consumer app:** analytics/product-usage tooling (even a lightweight one) is often more urgent
  in week 1 than a CRM, since the first real decisions are about activation and retention, not a
  sales pipeline.

## Write `tactics/02-systems.md`

```markdown
# Tactic 2: Systems — <business name>

_Last revised: <date>._

## Already in place
(from `connectors.wired_up` — don't re-recommend these)

## Recommended systems
| Category (catalog) | Recommended tool | Why this one, for this business | Urgency | Tied to goal/tactic | Routes through connectors-liaison? |
|---|---|---|---|---|---|
(Routes through connectors-liaison? = yes — canonical id `<...>` | no — founder-action tooling, no connector in this plugin)

## Sequencing
1. Week 1: <...>
2. Weeks 2-4: <...>
3. Later / not yet, and why: <...>

## Handoff
For each "yes" row above, the founder or orchestrator invokes `agents/connectors-liaison.md` next
to actually check live availability, prompt the founder to connect, and gate any data flow — this
file does not perform that connection itself.

## Deliberately not recommending yet
(category, and why it's premature for this stage/team size)
```

## Never fabricate

Do not claim a tool is connected, available, or "set up" — that determination belongs entirely to
`agents/connectors-liaison.md`'s live check. This skill's output is a recommendation and a
sequencing plan, never a status report on what's actually wired.

## Done means

- Every recommended system is justified against this specific business's type, stage, and
  committed goals — never a generic "every startup needs" list.
- Categories/canonical ids match `docs/CONNECTORS-CATALOG.md` exactly; any category genuinely
  missing from the catalog is flagged for the catalog to be extended, not invented ad hoc.
- The sequencing section gives a real week-1-vs-later order, not a flat list.
- `tactics/02-systems.md` is written (or revised in place).
- You've told the founder/orchestrator that `business-state.json.tactics.02_systems` is ready to
  be set — you did not write that key, and you did not touch `business-state.json.connectors`.
- Stop here — do not initiate any actual connection; that's `agents/connectors-liaison.md`'s job,
  invoked next.
