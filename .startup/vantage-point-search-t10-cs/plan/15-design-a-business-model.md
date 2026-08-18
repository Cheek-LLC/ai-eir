# Step 15: Design a Business Model

## Value capture logic (from Step 8)

Value metric: time saved + a stronger technical hire, net of engagement cost. Value quantified:
$15,000-$21,000 of founder/CTO time avoided per engagement (low confidence, see `qc-008-time-
saved`), plus an unquantified vacancy-cost avoidance.

## Archetypes considered

| Archetype | Fits? | Why / why not | Effect on COCA | Effect on LTV | Operational requirement |
|---|---|---|---|---|---|
| **Fee-for-service / project-based** | **Yes — selected** | Matches how retained search is actually bought and delivered industry-wide; each engagement is a discrete, scoped, high-touch deliverable | Neutral — doesn't change acquisition cost either direction | Caps LTV at (fee × expected repeat rate) rather than a compounding subscription curve | None beyond what already exists |
| Retainer (ongoing "search-as-a-service" subscription) | Considered, rejected for now | Would require standardizing to a fixed monthly scope (e.g., "up to 2 active searches/month for $X/month") — Jordan does not yet have the delivery capacity or a written playbook (Step 10) to credibly promise a standing capacity commitment; would risk becoming an uncapped-hours commitment exactly like Step 16's pricing-review warns against | Could lower COCA per search (one sales conversation buys multiple engagements) | Could raise LTV meaningfully | Requires the written technical-screening playbook (Step 10 dependency) and at least one associate recruiter, so a bad month for Jordan personally doesn't break a standing commitment |
| Licensing | No | No IP to license — the core is relationship + method, not licensable technology | n/a | n/a | n/a |
| Contingency (pay only on placement, no retainer) | Considered, rejected | Lower barrier to first sale (could lower COCA), but removes the non-refundable upfront installment that currently funds search execution costs before any placement — would push Jordan's own cash flow risk up for no clear COCA benefit given referral-driven demand already converts reasonably well | Might lower COCA slightly | No effect | None, but worse cash-flow timing |

## Selected model

**Fee-for-service / project-based, industry-standard retained-search structure** — the honest
starting point pre-productization, exactly as this step's services guidance frames it. Jordan
explicitly considered and rejected a retainer/subscription framing for now (see table above)
rather than defaulting to it because "recurring revenue" sounds more scalable — the standardization
this step requires before a retainer becomes credible (a written playbook, delivery capacity beyond
just Jordan) does not exist yet.

## The delivery-capacity question this step's services guidance requires be answered explicitly

**Does this model let revenue grow without linearly adding headcount, or does every dollar of
revenue require a proportional dollar of delivery cost?** Honest answer, stated plainly rather than
left unexamined: **under the current project-based model with Jordan as sole deliverer, revenue is
directly capped by Jordan's own calendar — every additional engagement requires proportional
delivery hours from the same one person.** This is not a defect unique to Vantage Point Search
(most solo-practitioner services businesses share it), but it is the single most important fact
about this business's growth ceiling, and it is why Step 24's roadmap is built around hiring and
training associate recruiters rather than assuming the current model scales on its own. Nothing
about the fee-for-service archetype itself changes this — the archetype and the capacity question
are separate decisions, and this plan does not let the model choice obscure the capacity one.

## Open assumptions

```json
{ "id": "ka-015-retainer-revisit", "statement": "A retainer/subscription model may become credible once the technical-screening playbook is written and at least one associate recruiter is delivering independently — not assumed now, explicitly deferred", "step_ref": "15_design_a_business_model", "confidence": "medium", "test_plan": "Revisit once Step 24's associate-recruiter hiring milestone is reached", "test_result": null }
```

## Dependencies flagged for Step 22 (MVBP)

- The MVBP is close to the existing delivery model already (see Step 22) — this model choice
  doesn't create new MVBP dependencies beyond what already exists.

## Update business-state.json

```json
"15_design_a_business_model": {
  "status": "drafted",
  "summary": "Fee-for-service/project-based retained-search model (30% of first-year base, 3 installments); retainer/subscription explicitly considered and deferred pending a written playbook and delivery capacity beyond the founder; revenue is directly capped by founder calendar under the current model, named explicitly as the central constraint carried through Steps 17/19/22/24",
  "file": "plan/15-design-a-business-model.md"
}
```
