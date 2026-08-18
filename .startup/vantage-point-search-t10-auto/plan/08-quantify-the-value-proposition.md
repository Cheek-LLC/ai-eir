# Step 8: Quantify the Value Proposition

## As-is vs. possible (services framing)

Per this step's services guidance: value here is the outcome delivered (a filled leadership seat,
faster and with a stronger candidate bar than DIY) net of the service's cost and the client's own
time spent managing the engagement.

## Quantified value

- **Time saved:** Dana's DIY attempt consumed an estimated 8-10 hours/week of her own time over
  10-14 weeks before engaging Jordan (source: founder estimate from client discovery-call
  descriptions, not independently measured) — roughly 100-140 hours of a senior engineering
  leader's time. At a conservative $150/hr value of a VP-level leader's time (their fully-loaded
  comp equivalent), that's **$15,000-$21,000 of opportunity cost avoided** by not continuing the
  DIY approach, separate from the placement fee itself.
- **Cost of the vacancy itself:** an open VP Engineering seat at a 35-person org means slower
  roadmap execution, more escalations landing on the CTO/founder directly, and (in two of Jordan's
  real client cases) a named delay to a specific product milestone. Neither client would put a
  precise dollar figure on this when asked directly — logged as a real, unquantified value
  driver rather than an invented number (see `ka-008-vacancy-cost` below).
- **Quality delta:** the client's own DIY slate (pre-Jordan) averaged 4 candidates who did not
  clear their technical bar over 10+ weeks; Jordan's slate (per engagement) averages 4-6 candidates
  who clear an explicit technical screen, delivered in ~30 days. This is real (all 6 closed
  engagements had a successful hire from Jordan's slate), but the dollar value of "a better hire"
  is not separately quantified here — folded into the placement outcome itself, not double-counted.

## Quantitative claims

```json
{ "id": "qc-008-time-saved", "claim": "Estimated founder-time value avoided by engaging Jordan vs. continuing DIY search", "value": "$15,000-$21,000 per engagement (range, not a point estimate)", "step_ref": "08_quantify_the_value_proposition", "source": "founder estimate: 100-140 hours of DIY search time (per client discovery-call accounts) x $150/hr placeholder value of a VP-level leader's time; not independently verified against any client's actual comp", "confidence": "low", "ai_risk_flag": true }
```

## Open assumptions

```json
{ "id": "ka-008-vacancy-cost", "statement": "The cost of a prolonged vacancy itself (delayed roadmap, escalations) is real per client anecdote but has never been quantified in dollars by any client", "step_ref": "08_quantify_the_value_proposition", "confidence": "low", "test_plan": "Ask the next 3 clients directly to estimate a dollar cost of the vacancy period before engaging", "test_result": null }
```
