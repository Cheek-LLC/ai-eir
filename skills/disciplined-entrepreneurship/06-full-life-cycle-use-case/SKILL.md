---
name: 06-full-life-cycle-use-case
description: >
  Use to run Disciplined Entrepreneurship Step 6 with a founder: map the Persona's entire
  life cycle with the problem and product — trigger, search, evaluation, purchase, onboarding,
  ongoing use, support, and renewal/disposal — stage by stage, noting your product's role and
  drop-off risk at each. Trigger phrases: "full life cycle use case," "customer journey," "map
  the use case," "what happens before and after purchase." First step of Theme 2 ("what can you
  do for your customer"); the direct input to Step 7's product spec.
---

# Step 6: Full Life Cycle Use Case

## Role in the 24 steps

First step of Theme 2 ("What can you do for your customer?"). Maps the Persona's (Step 5) entire
arc with the problem and your product — not just usage, the *whole* life cycle from before they
know they have a problem through eventual renewal or disposal. This produces the backbone that
Step 7 (product spec) turns into features and that Steps 13/18 (acquisition/sales process, owned
elsewhere) build on later — this step covers the full arc, not the sales process in depth.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  mapping stages (see "Business-type branching").
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — **required**; this
  is written from the Persona's point of view. If missing or `not_started`, stop and tell the
  founder to complete Step 5 first.
- `.startup/<slug>/plan/03-build-an-end-user-profile.md` for problem-context detail.

## Interview the founder

1. What event or realization triggers Persona to first recognize they have this problem? Is it
   periodic (e.g., an annual budget cycle), reactive (something breaks), or externally triggered?
2. Before finding you, what do they do first — search online, ask a peer, call an existing
   vendor, do nothing?
3. What alternatives do they evaluate, including doing nothing or a manual workaround, and how
   do they compare them?
4. Who else gets pulled in before a purchase decision (light touch here — the full
   decision-making unit is mapped in Step 12)?
5. What does the actual purchase/acquisition moment look like — self-serve signup, a sales call,
   a procurement/legal review?
6. What happens right after they get the product — onboarding, setup, training?
7. What does day-to-day, ongoing use look like once it's adopted?
8. What triggers renewal, expanded usage, churn, or abandonment? Is there a natural
   disposal/replacement cycle?
9. At each stage, where's the biggest risk they get stuck or drop off?

## Business-type branching

The eight stages are universal, but what fills them changes by type:

- **SaaS:** onboarding = signup/trial/activation flow; ongoing use = login frequency and feature
  adoption; renewal = subscription renewal, upgrade, or downgrade decision.
- **Physical product:** onboarding = unboxing and first use; add shipping/fulfillment as part of
  decision & purchase; support = returns/warranty/replacement; renewal/disposal = repurchase or
  replenishment cadence, or end-of-life disposal.
- **Marketplace:** map the supply side and demand side as **separate tracks** through the same
  eight stages — a supplier's trigger, onboarding, and "renewal" (continuing to list/fulfill) look
  nothing like a buyer's trigger, evaluation, and repeat-purchase behavior. Mapping only one side
  misses where the other side actually drops off.
- **Services:** onboarding = engagement kickoff/scoping; ongoing use = the service delivery
  cadence itself (sessions, deliverables, check-ins); renewal = contract renewal or re-engagement
  decision, often gated by a relationship review rather than an automated prompt.
- **Consumer app:** search/discovery is frequently app-store browse/search, a social share, or an
  influencer/creator mention rather than a deliberate vendor search; onboarding = app-store install
  plus account creation — the single highest-drop-off stage in the whole life cycle, so probe it
  hard; ongoing use = session frequency/depth and what push notifications or habit loops actually
  bring them back; renewal = subscription renewal if the app is paid, but for free/ad-supported
  apps there is often no formal renewal moment at all, just decaying engagement toward a quiet
  uninstall — track that decay explicitly rather than assuming a renewal stage exists.
- **Other / genuine hybrid:** if the business doesn't map cleanly onto one type (a subscription
  box, a marketplace with a heavy services layer, a physical product with an attached app), map
  each of the eight stages using whichever type's lens the founder confirms fits that specific
  stage best, and say explicitly which lens was used where — don't silently blend them into a
  generic version that fits no real business.

## Method: the whole arc, stage by stage

Produce a narrative plus a stage-by-stage table covering all eight stages:

1. **Trigger** — the event/status-quo disruption that starts the clock.
2. **Search / discovery** — how they find out alternatives (including yours) exist.
3. **Evaluation** — how they compare options, explicitly including "do nothing."
4. **Decision & purchase** — who's involved, what has to happen to close.
5. **Onboarding / first use** — setup, training, first-value moment.
6. **Ongoing use** — how it fits into their regular workflow.
7. **Support / service** — what touchpoints occur during normal use.
8. **Renewal, expansion, or disposal** — what triggers each outcome.

For every stage capture: who's involved, what Persona is thinking/feeling, what has to happen
mechanically, and your product's role or touchpoint there (or the gap if it has none yet). Name
explicitly this step is the *whole* life cycle — not just the sales process (Steps 13/18 refine
that in depth later) and not the product itself (Step 7 covers that next).

## When the founder doesn't know a stage

Don't fabricate specific behavioral detail as fact for a stage the founder hasn't actually
observed. Mark that stage "hypothesis — needs validation" in the table, and if it materially
affects a product or GTM decision, add a `key_assumptions` entry: `step_ref`:
`06_full_life_cycle_use_case`, `confidence`: `low`, `test_plan`: "observe or interview real
persona-matching users through this specific stage," `test_result`: `null`.

## Write `plan/06-full-life-cycle-use-case.md`

```markdown
# Step 6: Full Life Cycle Use Case

## Persona
(reference to Step 5, one line)

## Stage-by-stage map
| Stage | Who's involved | What happens | Persona's state of mind | Product's role/touchpoint | Drop-off risk |
|---|---|---|---|---|---|
| Trigger | | | | | |
| Search/discovery | | | | | |
| Evaluation | | | | | |
| Decision & purchase | | | | | |
| Onboarding/first use | | | | | |
| Ongoing use | | | | | |
| Support/service | | | | | |
| Renewal/expansion/disposal | | | | | |

## Narrative walkthrough
(prose version, 1-2 paragraphs per stage)

## Biggest drop-off risk
(which stage, and why)

## Assumptions flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "06_full_life_cycle_use_case": {
    "status": "drafted",
    "summary": "Full life cycle mapped across 8 stages for <Persona name>; biggest drop-off risk: <stage>",
    "file": "plan/06-full-life-cycle-use-case.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key untouched.

## Definition of done

- All eight stages mapped with who/what/state-of-mind/product-role/risk.
- Biggest drop-off risk named explicitly, not glossed over.
- `business-state.json` key `06_full_life_cycle_use_case` set to `status: "drafted"`.
- Stop here — do not derive the product feature list; that's Step 7. Review/approval happens
  later via the council skill.
