# Step 4: Calculate the TAM for the Beachhead Market

## Methodology (bottom-up, services)

Per this step's services guidance: count = number of target clients in the beachhead; multiplier
= average annual contract/engagement value. Capacity is explicitly flagged as a separate question
from the TAM figure itself (see caveat below).

## Bottom-up calculation

- **Count:** US-based, VC-backed, Series B-D companies, 50-500 employees, with a live or recent
  (within 12 months) VP/Director of Engineering opening. Founder estimate: ~2,400 companies fit
  the funding-stage/headcount band nationally at any given time (see `ka-001-segment-counts`,
  Step 1 — not sourced from a paid data provider; no WebSearch attempted this session, honest
  fallback to founder estimate). Of those, an estimated 15%/year have a live or recent VP/Director
  Engineering opening (leadership roles turn over roughly every 2.5 years on average, plus
  headcount-growth-driven net-new roles) → **~360 addressable searches/year** in the beachhead
  population.
- **Multiplier:** average retained-search fee per engagement, from Step 16's pricing (30% of
  average $235K base salary) = **$70,500/engagement**.
- **TAM = 360 searches/year × $70,500 = ~$25.4M/year.**

## Sanity check and explicit capacity caveat

This is a TAM figure — the theoretical dollar value of the addressable market if a single provider
captured all of it — not a revenue projection. Per this step's own services guidance, stated
explicitly and not glossed over: **a services TAM assumes unlimited delivery capacity, which is
not true here.** Even a well-funded, staffed Vantage Point Search could not realistically capture
more than a small fraction of $25.4M/year without a large recruiting team — this number should
never be read as "Jordan's addressable revenue," only as evidence the beachhead itself isn't
too small to be worth pursuing. The real constraint on captured revenue is delivery capacity
(Steps 17/19/22/24), not market size.

## Quantitative claims

```json
{ "id": "qc-004-tam", "claim": "Beachhead TAM, VP/Director Engineering search at VC-backed Series B-D companies", "value": "~$25M/year (bottom-up: ~360 addressable searches/year x $70,500 average fee)", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "founder estimate — company count and turnover rate are Jordan's informed market-exposure estimate, not a paid data-provider pull; no external search attempted this session; fee figure sourced from Step 16 pricing", "confidence": "low", "ai_risk_flag": true }
```

## Open assumptions

```json
{ "id": "ka-004-turnover-rate", "statement": "The 15%/year leadership-opening rate used to size the addressable search count is a founder estimate, not sourced from an industry turnover study", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "confidence": "low", "test_plan": "Look for a published exec-search-industry turnover benchmark once time allows; until then, treat this TAM as order-of-magnitude only", "test_result": null }
```

## Mandatory AI-risk gate

Called per this step's contract. See `business-state.json.risk_log` entry `ar-vps-001` — this
step's TAM figure was reviewed alongside the assembled plan; see the AI-Risk Gate section of this
report for the outcome.
