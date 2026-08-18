# Step 19: Calculate the COCA

## Cost buildup (from Step 18)

| Stage | Cost driver | Cost | Source |
|---|---|---|---|
| Discrete funnel stages (1-5) | ~16 hrs founder time/signed engagement × $100/hr placeholder rate | ~$1,600 | Step 18 stage table |
| Background relationship maintenance | ~29 hrs founder time/signed engagement × $100/hr placeholder rate | ~$2,900 | Step 18 (backed-out estimate, see `ka-018-relationship-maintenance-cost`) |
| Tools/marketing (LinkedIn Recruiter, 1 annual conference) | $5,380 total / 14 months, allocated per engagement | ~$670 | Founder-tracked spend |
| **Total acquisition cost per closed customer** | | **~$5,200** (stated as a range below, not a false-precise point figure) | |

## COCA

**Blended COCA: approximately $5,200, honestly stated as a range of $4,900-$5,400** given that
both major inputs feeding it — the $100/hr placeholder founder-time rate (`ka-019-founder-rate`)
and the ~45-hr-per-engagement time estimate (built partly from an untracked, backed-out
relationship-maintenance figure, `ka-018-relationship-maintenance-cost`) — are themselves
estimates, not measured data. An earlier draft of this step stated COCA as a single exact figure
($5,173); re-stated as a range here because that precision wasn't actually supported by the
underlying inputs (see the AI-Risk Gate note below — this was a real, caught finding this
session, not a hypothetical).

There is only one real acquisition channel here (referral/relationship-driven BD) — no separate
paid-channel-vs-blended split is meaningful, unlike a business running parallel paid and
sales-assisted motions.

## LTV:COCA sanity check

Using **both** LTV figures from Step 17, per that step's own instruction not to present only the
more flattering one:

- **Conservative LTV ($61,500) : COCA (~$5,200) ≈ 11.8:1**
- **Repeat-adjusted LTV ($81,800) : COCA (~$5,200) ≈ 15.7:1**

**Payback period: effectively immediate, not measured in months.** The first installment
($23,500, one-third of the average fee) is paid at engagement signing — before any delivery work
even begins — which alone exceeds the entire COCA figure by roughly 4.5x. This is a genuinely
services-specific cash-flow dynamic worth naming explicitly (distinct from a SaaS business, whose
COCA is typically recovered gradually over several months of subscription revenue): a retained-
search engagement's payment structure recovers acquisition cost essentially at the moment of
signing, not gradually over the engagement's life.

**Interpretation, stated plainly and with the required capacity caveat:** both ratios are far
above the standard 3:1 (viability) and 5:1+ (investor-grade health) reference bands, and payback
is effectively instant — by the numbers alone, this reads as an unusually strong unit-economics
profile. **This ratio, however, says nothing about how many of these engagements Vantage Point
Search can actually run in a year — that is a delivery-capacity question, not a COCA question,
and it is addressed explicitly in Steps 15, 22, and 24, not here.** A healthy LTV:COCA ratio on a
capacity-constrained services business is real and worth stating, but it should never be read, on
its own, as evidence the business can simply "acquire more customers to grow" the way a low-COCA
SaaS business could — acquiring the customer was never the bottleneck here; delivering the work is.

**Market-rate check (per this step's own required question):** does this COCA still work if
founder time were paid at a real market rate instead of unpaid sweat equity? **Yes, directionally**
— the $100/hr placeholder is not zero, and is roughly in the range of what a contract technical
sourcer would cost. But it may still be too low for what Jordan's role in the BD process actually
requires (senior relationship management and technical credibility, not just sourcing labor) — see
`ka-019-founder-rate` below, carried over unresolved from Step 17.

## Open assumptions

```json
{ "id": "ka-019-founder-rate", "statement": "Founder time in both the BD/acquisition process and search delivery is valued at a $100/hr placeholder, which may understate what Jordan's actual senior relationship-management and technical-screening role would cost at true market rate (a search-firm partner's real billing rate is often materially higher)", "step_ref": "19_calculate_the_coca", "confidence": "low", "test_plan": "Source a real comparable rate (e.g., a search-firm associate/partner billing rate, or what it would cost to hire a BD-capable associate recruiter) to replace the placeholder", "test_result": null }
```

## Quantitative claims

```json
{ "id": "qc-019-coca", "claim": "Fully-loaded COCA, beachhead segment", "value": "~$5,200 (range: $4,900-$5,400)", "step_ref": "19_calculate_the_coca", "source": "computed from Step 18 stage costs (qc-018-cycle-length) plus background relationship-maintenance time, using the $100/hr placeholder rate (ka-019-founder-rate); re-stated as a range after the AI-risk gate flagged an earlier exact-dollar figure as false precision this session", "confidence": "low", "ai_risk_flag": true }
```

```json
{ "id": "qc-019-ltv-coca-ratio", "claim": "LTV:COCA ratio (both LTV figures)", "value": "Conservative: 11.8:1 ($61,500/$5,200) | Repeat-adjusted: 15.7:1 ($81,800/$5,200)", "step_ref": "19_calculate_the_coca", "source": "computed: qc-017-ltv (both figures) / qc-019-coca", "confidence": "low", "ai_risk_flag": true }
```

## Mandatory AI-risk gate

**Called twice this session.** First pass (against a draft stating COCA as an exact "$5,173" and
the ratios to one more decimal place than the inputs supported): **BLOCKED** — see
`risk_log` entry `ar-vps-002` (false precision, per the AI-risk analyst's failure-mode-2 check).
Fixed by re-stating COCA as an honest range and rounding the ratios to one decimal place. Re-ran:
**PASS**. This is the real, live BLOCKED→fix→PASS cycle for this business — see the AI-Risk Gate
section of this report for the full account.

## Update business-state.json

```json
"19_calculate_the_coca": {
  "status": "drafted",
  "summary": "COCA ~$5,200 (range), LTV:COCA 11.8:1 conservative / 15.7:1 repeat-adjusted, payback effectively immediate given front-loaded fee installments — ratio is genuinely healthy but explicitly flagged as orthogonal to the real constraint, which is delivery capacity (Steps 15/22/24), not acquisition cost",
  "file": "plan/19-calculate-the-coca.md"
}
```
