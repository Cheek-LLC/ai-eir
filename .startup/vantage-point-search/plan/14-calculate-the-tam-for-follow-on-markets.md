# Step 14: Calculate the TAM for Follow-on Markets

## Bowling pin sequence

Beachhead (VP/Dir Engineering search, VC-backed Series B-D) → **Pin 2: VP/Dir Product search, same
client base** → Pin 3: VP/Dir Data/ML search, same client base.

## Pin 2: VP/Director of Product search (Segment 3 from Step 1)

- **Adjacency logic:** Same client company profile (VC-backed, Series B-D, 50-500 employees), and
  — critically — often the *same client relationship*: 2 of Jordan's 8 signed engagements were
  repeat business from a prior client hiring a second leadership role. Reusing an existing trusted
  relationship to sell a second search is structurally different (and cheaper to acquire) than
  cold-starting a new client relationship — this should be reconciled against Step 17's LTV
  repeat-engagement assumption (`qc-017-ltv`), not double-counted as fresh TAM on top of it.
  Jordan does not personally have a Product-leader-specific network as deep as his Engineering
  network — this is a real adjacency limitation, not just an opportunity.
- **TAM calculation (bottom-up):** same ~2,400-company population, applying a comparable
  ~12%/year VP/Dir Product opening rate (lower than Engineering's 15%, founder estimate — product
  leadership roles turn over somewhat less often at this stage) × similar average fee (~$65,000,
  Product comp trending slightly below Engineering at this level) → ~288 searches/year × $65,000 ≈
  **~$18.7M/year**.
- **Trigger condition to pursue:** per Step 10's core assessment, do not pursue Pin 2 until the
  Engineering-search playbook is written down and at least one associate recruiter is running
  Engineering searches independently — spreading Jordan's own limited hours across two role
  categories before the core is even repeatable in one compounds the capacity problem rather than
  diversifying it. This restates the delivery-capacity flag explicitly here, per this step's own
  services guidance, since capacity constraints compound across pins.

## Pin 3: VP/Director of Data/ML search (Segment 4)

- **Adjacency logic:** same client base, a growing category, but Jordan has the least existing
  network here of the three — treat as more speculative than Pin 2.
- **TAM:** not sized in detail this pass — flagged as a later-pin question, not urgent now.

## Quantitative claims

```json
{ "id": "qc-014-pin2-tam", "claim": "TAM for follow-on market: VP/Director Product search, same client base", "value": "~$19M/year (bottom-up: ~288 searches/year x ~$65,000 average fee)", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "source": "founder estimate, same company-count basis as qc-004-tam; opening-rate and fee figures are Jordan's informed estimate, not independently verified", "confidence": "low", "ai_risk_flag": true }
```

## Open assumptions

```json
{ "id": "ka-014-pin2-repeat-overlap", "statement": "Some portion of Pin 2 (Product search) demand will come from clients who are also counted in Step 17's repeat-engagement LTV assumption — this TAM figure and that LTV figure are not yet reconciled to confirm they aren't double-counting the same repeat-client revenue", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "confidence": "low", "test_plan": "Track, going forward, whether a given repeat engagement counts as 'LTV repeat rate' (same role type) or 'Pin 2 TAM capture' (different role type) rather than blending the two", "test_result": null }
```

## Mandatory AI-risk gate

Called. See `business-state.json.risk_log` — this step's figures are order-of-magnitude estimates
explicitly labeled as such; gate result recorded in the AI-Risk Gate section of this report.
