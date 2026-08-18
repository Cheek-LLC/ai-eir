# Step 16: Set Your Pricing Framework

## Pricing metric

Project-based fee: **30% of the placed candidate's first-year base salary**, billed in three equal
installments — 1/3 at engagement signing (non-refundable), 1/3 at candidate-slate delivery (~day
30), 1/3 at the placed candidate's start date. 90-day replacement guarantee (free re-run, not a
refund) if the hire leaves within 90 days of starting.

## Value anchor (from Step 8)

Quantified value: $15,000-$21,000 of founder-time opportunity cost avoided (low confidence,
`qc-008-time-saved`), plus an unquantified vacancy-cost avoidance. Proposed price at an average
$235K base salary: **$70,500**. This price is **not** primarily anchored to the Step 8 time-saved
figure — it would be a ~3.4-4.7x multiple of that figure alone, which would look aggressive if
that were the only justification. It is anchored, honestly, to **industry-standard retained-
search fee structure** (25-33% of first-year base is the common range for technical/executive
retained search) — the real value driver clients are paying for is landing a hire they could not
land themselves at all within a reasonable timeframe, not merely time saved. Stating this
explicitly rather than forcing a value-to-price ratio narrative onto a price that's actually set
by market convention.

## Price point(s) — no tiers; scales with the placed candidate's salary

| Component | Basis | Example at $235K average base |
|---|---|---|
| Total fee | 30% of first-year base salary | $70,500 |
| Installment 1 (signing) | 1/3 of total | $23,500 |
| Installment 2 (slate delivery, ~day 30) | 1/3 of total | $23,500 |
| Installment 3 (start date) | 1/3 of total | $23,500 |

Fee scales directly with the placed candidate's actual base — a $260K VP hire yields $78,000; a
$210K Director hire yields $63,000. Average $235K is the blended figure across the beachhead's
VP/Director band, not a fixed price.

## Competitive anchor check (from Step 11)

- Large firms: comparable or higher percentage (sometimes 33%+), but decline this deal size
  entirely.
- Contingency recruiters: much lower (10-15%), but clients who've tried them and moved to Jordan
  did so specifically because of the technical-screening gap (Step 11), not price — no client has
  pushed back on the 30% figure itself in any of the 8 signed engagements to date.

## Effective-rate sensitivity check (required for services — scope creep and non-billable time)

The headline $70,500 fee looks healthy on its face. What it works out to per hour of Jordan's
actual delivery time is a separate, more honest number: per-engagement delivery time runs ~90
hours (sourcing, screening, candidate coordination, offer-negotiation support — see Step 19's cost
buildup), which is **~$783/hour of delivery time** at the $70,500 average fee before any COCA/BD
time is subtracted. This effective rate holds up well — but the real risk this step's guidance
flags isn't scope creep on an individual engagement (the scope is fixed by role, not by an
open-ended hourly clock) — it's that **the 90-hour delivery estimate itself has never been
timed precisely**; see `ka-016-delivery-hours-estimate` below.

## Validation status

Tested with real prospects? **Yes** — this exact fee structure has been quoted and accepted 8
times across 14 months (6 closed, 2 pending/lost for reasons unrelated to price — see Step 13).
This is real, not a hypothesis.

## Quantitative claims

```json
{ "id": "qc-016-price", "claim": "Average retained-search fee per engagement", "value": "$70,500 (30% of $235K average first-year base salary; scales with actual placed candidate's salary)", "step_ref": "16_set_your_pricing_framework", "source": "founder data — actual fee structure used and accepted across 8 real signed engagements in the last 14 months; $235K average base is the blended average of the 6 completed placements' actual salaries", "confidence": "high", "ai_risk_flag": false }
```

## Open assumptions

```json
{ "id": "ka-016-delivery-hours-estimate", "statement": "The ~90-hour-per-engagement delivery-time estimate (feeding the effective-rate calculation above and Step 19's COCA/delivery-cost buildup) is Jordan's rough recollection, not logged time-tracking data", "step_ref": "16_set_your_pricing_framework", "confidence": "low", "test_plan": "Time-track the next 3 engagements explicitly rather than estimating from memory", "test_result": null }
```

## Mandatory AI-risk gate

Called per this step's contract. `qc-016-price` is high-confidence (real, repeated market data),
so this step's own figures are not expected to trip the gate — result recorded in the AI-Risk
Gate section of this report.

## Update business-state.json

```json
"16_set_your_pricing_framework": {
  "status": "drafted",
  "summary": "30% of first-year base salary (avg $70,500/engagement), 3 installments; validated across 8 real signed engagements; effective per-delivery-hour rate ~$783/hr before COCA, though the underlying delivery-hours estimate itself is not yet precisely time-tracked",
  "file": "plan/16-set-your-pricing-framework.md"
}
```
