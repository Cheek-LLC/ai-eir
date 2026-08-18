# Step 24: Develop a Product Plan

## Services branching note

Per this step's guidance: roadmap is driven by productizing and standardizing what's currently
bespoke, before adding a new service line. The pin-2 readiness gate is a standardized delivery
playbook plus proven ability to deliver beyond just the founder's own hours. Confirmed directly —
this is exactly the shape of the roadmap below.

## Near-term roadmap (next 1-2 quarters)

| Item | Justification | Priority |
|---|---|---|
| Write the technical-screening playbook | Step 10's core-durability gap (`ka-010-playbook-informal`) — a precondition for anyone but Jordan delivering at the current quality bar | 1 |
| Hire first associate recruiter | Step 15's capacity constraint is the single largest threat to the whole plan; this is the concrete move against it | 2 |
| Run associate's first search as MVBP #2 (real paid engagement, Jordan on QA only) | Directly tests `ka-020-associate-replication`, ranked the single most consequential open assumption in Step 20 | 2 (same window as above) |
| Start lightweight CRM tracking of funnel/BD data | Closes `ka-013`/`ka-018`'s "founder memory, not logged data" gap | 3 |

## Associate-recruiter hiring plan — costed explicitly, not hand-waved

Per this business type's central economic question (can revenue grow without linearly adding
headcount, or does growth require it) — the honest answer from Step 15 is that it requires it, so
this roadmap costs that headcount addition explicitly rather than treating "hire someone" as a
free lever:

- **Comp:** $70,000 base salary + 10% override commission on the associate's own closed
  placements (a real, budgeted cost, not sweat equity).
- **Ramp/training cost:** ~4 months of ramp, during which Jordan spends an estimated 5 hrs/week on
  active oversight/training — 80 hours total × the same $100/hr placeholder rate used throughout
  Steps 17/19 = **~$8,000 in founder opportunity cost**, explicitly folded into this roadmap's cost
  math rather than treated as free.
- **Conservative Year-1 output assumption:** 3 placements from the associate in their first year
  (ramping, well below Jordan's own realized 5.1/yr solo rate, reflecting a newer network and
  earlier-stage skill).
- **Year-1 net contribution, if `ka-020` holds:** 3 placements × $61,500 conservative engagement
  margin = $184,500 gross margin, minus ~$21,150 override commission, minus $70,000 salary, minus
  $8,000 training opportunity cost = **~$85,350 net positive in Year 1 alone.**
- **Explicit dependency:** this entire calculation is conditional on `ka-020-associate-replication`
  testing positive. If it doesn't — if an associate cannot independently reach a comparable fill
  rate/quality bar — this hire is a real cost with a materially worse return, not a proven lever.
  This roadmap names that dependency rather than presenting the hire as a foregone-conclusion
  growth mechanism.

## Follow-on market readiness (Step 14 bowling pins)

Pin 2 trigger condition (from Step 14, restated): the technical-screening playbook must be written
**and** at least one associate recruiter must be delivering searches independently. **Current
distance to trigger: neither condition is met yet** — the playbook doesn't exist and zero
associate-run searches have been completed. Pin 2 (VP/Director Product search) is explicitly not
started this planning cycle.

## Sequencing rationale

Playbook-writing and the associate hire/test are sequenced first and treated as a single
dependency chain, ahead of any market-expansion work, because per Step 15's honest business-model
assessment, this business's growth is capped by delivery capacity, not by market size or
acquisition cost (Step 19's LTV:COCA ratio is already comfortably healthy) — the bottleneck is
entirely on the delivery side, so that's where roadmap effort goes first.

## Resourcing reality check — explicit fallback if the associate hire doesn't work

This roadmap assumes the associate-recruiter hire succeeds. **If `ka-020` tests negative** (the
associate cannot replicate Jordan's fill rate/quality independently, even after the playbook and
oversight period), the fallback is not "hire again and hope" — it's a deliberate strategic
reconsideration: staying a smaller, higher-fee, capacity-capped boutique practice (Jordan solo or
with one closely-supervised associate permanently, rather than a multi-recruiter firm), which is a
legitimate, sound outcome for this business, not a failure state. Naming this explicitly so the
plan doesn't implicitly treat headcount growth as the only acceptable outcome.

## Handoff briefs

### To GTM
- Positioning currently describes a solo practitioner; once (and only once) the associate model is
  validated, the positioning brief needs to change to describe a small team without overstating
  capacity that doesn't exist yet — do not market "our team" before the team is real and proven.
- A recruiting brief is needed to actually source the associate-recruiter candidate — sourcing a
  recruiter to recruit is itself a real search Jordan will need to run.

### To Ops/Scaling
- The lightweight CRM (roadmap item 3 above) is a real ops dependency for closing `ka-013`'s and
  `ka-018`'s data-quality gaps — funnel and delivery-hour tracking currently lives in Jordan's
  memory, which won't scale past one person regardless of the associate-hire outcome.
- The written playbook (once it exists) becomes the ops team's quality-control reference for
  evaluating associate-delivered searches going forward.

## Open assumptions

Restates `ka-020-associate-replication` as the load-bearing dependency for this entire roadmap;
no new assumption logged here beyond what Steps 20/21/22 already carry.

## Update business-state.json

```json
"24_develop_a_product_plan": {
  "status": "drafted",
  "summary": "Near-term roadmap: write the playbook, hire and ramp one associate recruiter (~$78K comp+training cost, explicitly folded in), run their first search as a real paid MVBP #2 test of ka-020; Pin 2 (Product search) explicitly not started, gated on this chain; explicit fallback named if the associate-replication assumption fails",
  "file": "plan/24-develop-a-product-plan.md"
}
```
