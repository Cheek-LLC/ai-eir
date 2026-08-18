# Step 19: Calculate the COCA

## Cost buildup (from Step 18)
| Stage | Cost driver | Cost | Source |
|---|---|---|---|
| 1. Awareness | 14.0 hrs founder time @ $85/hr loaded rate | $1,190 | Founder-time placeholder rate, `ka-019-founder-rate` below |
| 2. First conversation | 12.6 hrs @ $85/hr | $1,071 | Same |
| 3. Champion buy-in | 4.2 hrs @ $85/hr | $357 | Same |
| 4. Franchisor check | 3.0 hrs @ $85/hr | $255 | Same |
| 5. Contract & pricing | 4.0 hrs @ $85/hr | $340 | Same |
| Paid marketing/tools | None — zero paid channel spend to date | $0 | No paid channel exists yet; see `ka-018-channel-scalability` |

**Total acquisition cost per closed customer: $1,190 + $1,071 + $357 + $255 + $340 = $3,213**
(rounding note below).

## COCA
**Blended COCA: $3,213 per signed group contract.** No per-channel breakdown exists — 100% of
acquisition to date runs through Maria's warm personal/professional network (see
`ka-018-channel-scalability`); there is no paid channel yet to compute separately.

## LTV:COCA sanity check
LTV (Step 17): $52,503 per group contract | COCA: $3,213 | **Ratio: ≈16.3:1**
Payback period: COCA / (monthly revenue per customer × gross margin) = $3,213 / ($2,838 × 74%) =
$3,213 / $2,100 ≈ **1.5 months**.

**Interpretation — read with real caution, not at face value.** A 16.3:1 ratio and a 1.5-month
payback look extremely healthy, and taken alone would suggest outstanding unit economics. This
reading should be treated as **misleadingly optimistic** for one specific, structural reason: the
entire COCA figure above is built exclusively from a warm, personal-network sales channel that
Step 9 already showed tops out at roughly 7-28 real leads. Neither the founder's time-only cost
structure nor the near-100% eventual conversion this channel produces will hold once acquisition
has to reach beyond that warm network into cold outbound or paid channels — at that point COCA
should be expected to rise substantially and this ratio should be expected to compress. Presenting
16.3:1 as "the" LTV:COCA ratio without this caveat would be exactly the kind of confident,
uncaveated unit-economics claim the AI-risk framework flags. Both LTV (`ka-017-churn`,
`ka-017-margin`) and COCA inputs here rest on low-confidence, unmeasured assumptions — this ratio
is provisional, not settled.

## Open assumptions
```json
{ "id": "ka-019-founder-rate", "statement": "Founder time in the sales process valued at $85/hr (unvalidated placeholder, chosen as a rough AE/SDR-equivalent market rate) for COCA loading, since no market comp has been formally sourced.", "step_ref": "19_calculate_the_coca", "confidence": "low", "test_plan": "Replace with a sourced local market salary comp for an equivalent AE/SDR role.", "test_result": null }
```
```json
{ "id": "ka-019-ratio-not-representative", "statement": "The 16.3:1 LTV:COCA ratio and 1.5-month payback are built entirely from a non-scalable warm-network acquisition channel (see ka-018-channel-scalability) and should not be presented as representative of unit economics once paid/cold channels are required to grow past the initial ~7-28 warm leads.", "step_ref": "19_calculate_the_coca", "confidence": "low", "test_plan": "Recompute COCA and the ratio once a paid or cold-outbound channel has been tested with real spend and real conversion data.", "test_result": null }
```

## Quantitative claims logged
```json
{ "id": "qc-019-coca", "claim": "Fully-loaded COCA, beachhead segment", "value": "$3,213 per signed group contract", "step_ref": "19_calculate_the_coca", "source": "computed from Step 18 stage costs (qc-018-cycle-length) and founder time at an $85/hr placeholder rate (see ka-019-founder-rate); zero paid-channel spend included since none exists yet", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-019-ltv-coca-ratio", "claim": "LTV:COCA ratio", "value": "≈16.3:1 (provisional — see interpretation caveat above)", "step_ref": "19_calculate_the_coca", "source": "computed: LTV $52,503 (qc-017... note: Step 17 did not assign its own quantitative_claims id to the LTV figure in its file — see QA finding) / COCA $3,213 (qc-019-coca)", "confidence": "low", "ai_risk_flag": true }
```

## Note on Step 17 traceability
Step 17's plan file states the LTV figure ($52,503) in prose but its own "Quantitative claims
logged" section was left as a placeholder heading with no actual `quantitative_claims` entry
written for the LTV figure itself (only the churn, margin, and TAM-mismatch assumptions were
logged as `key_assumptions`). This step's `qc-019-ltv-coca-ratio` entry above cites the LTV value
directly since no `qc-017-ltv`-style id exists to reference — flagged here rather than silently
patched, since it means Step 17 did not fully meet its own Data Contract obligation ("every
material figure has a quantitative_claims entry").
