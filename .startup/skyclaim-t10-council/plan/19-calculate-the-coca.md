# Step 19: Calculate the COCA

> **This is where the Step 17/18 gap becomes a concrete, unresolvable-as-specified problem.** This
> step's own marketplace guidance is explicit and good: "Cost supply-side and demand-side
> acquisition separately... a single blended 'marketplace COCA' hides which side is actually
> expensive." I followed that instruction faithfully below. But this step *also* instructs running
> "the LTV:COCA sanity check... compare Step 17's LTV to this step's COCA" — singular, as if there
> is one LTV and one COCA to compare. There are now **two COCA figures** (per this step's own
> correct instruction) and **only one LTV** (Step 17's demand-side-only figure, since Step 17 has
> no marketplace guidance telling it to produce a supply-side one). The result: the demand-side
> comparison works cleanly; the supply-side COCA has **no LTV counterpart to divide against at
> all**. I'm reporting this as a real, demonstrated structural finding, not routing around it by
> inventing a supply-side "LTV" this file has no instruction or method to compute.

## Reads
`plan/18-map-the-sales-process-to-acquire-a-customer.md` (required), `plan/17-calculate-the-ltv-of-
a-customer.md` (required).

## Fully-loaded cost buildup (from Step 18)

### Demand-side COCA
Total loaded cost to first booking: ≈$300/contractor in founder time (from `qc-018-demand-funnel`),
**explicitly excluding** the unmeasured carrier-acceptance-check stage's real cost, which is
unknown. Stated as a **floor**, not a complete figure: "**at least** ≈$300/contractor, likely
higher once the carrier-acceptance stage is measurable."

**Demand-side COCA = ≈$300/contractor (floor, incomplete)**, at the same $75/hr founder-time
placeholder rate used throughout (see `ka-019-founder-rate` below).

### Supply-side COCA
Total loaded cost per onboarded, job-completing pilot: ≈$225/pilot (from `qc-018-supply-funnel`),
entirely founder time, no cash spend, at the same $75/hr placeholder.

**Supply-side COCA = ≈$225/pilot.**

## LTV:COCA sanity check

**Demand side (the comparison this step's formula actually supports):**
LTV (Step 17, demand-side): ≈$3,750 | COCA (demand-side, floor estimate): ≈$300 |
**Ratio: ≈12.5:1** (provisional — both inputs are low-confidence, and the COCA figure is an
acknowledged floor, not a complete cost, so the true ratio is likely lower once the carrier-
acceptance stage is measured). Payback period: at $1,102.50/year revenue per contractor × 85%
margin ≈ $937/year net, a $300 COCA pays back in **≈3.8 months** — again provisional, and better
than it will likely look once the missing carrier-check cost is added.

**Supply side (the comparison this step's formula cannot actually produce):**
COCA (supply-side): ≈$225/pilot. **LTV: not computable as specified.** Step 17 produced no
supply-side LTV, because pilots generate no direct revenue to SkyClaim — under the standard
LTV formula (`ARPU × margin × lifetime`), a pilot's "ARPU" from SkyClaim's perspective is
negative (SkyClaim pays them), which the formula was never designed to represent. **This ratio is
reported as N/A, not forced into a number**, and flagged as a real, demonstrated methodology gap
across Steps 17-19 for marketplace businesses — see the note at the top of this file and the QA
findings report. What *should* exist instead — some measure of "is $225/pilot an efficient
acquisition cost given the pilot's contribution to enabling demand-side revenue" — is a real,
answerable question, but this step gives no framework for asking it, and inventing one here would
mean silently patching a structural gap rather than reporting it plainly.

## Interpretation
The demand-side ratio (≈12.5:1, provisional) reads as healthy against Step 19's own reference
bands, but should not be read as validating the *whole* business — it says nothing about whether
supply-side acquisition is efficient, sustainable, or even sufficient to meet demand (Step 4
already found supply is the binding constraint on the entire beachhead TAM). A founder or reviewer
who only reads the demand-side ratio and concludes "unit economics look great" would be reading an
incomplete picture — flagging this explicitly rather than letting a strong-looking single number
stand in for the whole business's economics.

## Open assumptions
- `ka-019-founder-rate`: "Founder time valued at $75/hr (unvalidated placeholder) for both
  supply- and demand-side COCA loading; no market comp sourced." `step_ref`: `19_calculate_the_coca`,
  `confidence`: `low`, `test_plan`: "Replace with a sourced local market rate for equivalent
  BD/recruiting work," `test_result`: `null`.
- `ka-019-demand-coca-incomplete`: "Demand-side COCA (≈$300) explicitly excludes the unmeasured
  carrier-acceptance-check stage's cost and is stated as a floor, not a complete figure."
  `step_ref`: `19_calculate_the_coca`, `confidence`: `low`, `test_plan`: "Recompute once the
  carrier-acceptance stage (Step 18, ka-018-carrier-check-unmeasured) has real time/cost data,"
  `test_result`: `null`.
- `ka-019-supply-ltv-gap`: "No LTV exists for supply-side pilots under the current Step 17
  methodology, making the supply-side LTV:COCA ratio structurally unanswerable as currently
  specified — reported as N/A rather than forced." `step_ref`: `19_calculate_the_coca`,
  `confidence`: `low`, `test_plan`: "Flag to plugin maintainers as a cross-step methodology gap
  (Steps 17-19) — see QA-FINDINGS-ROUND3.md; not resolvable by this business alone," `test_result`: `null`.

## Quantitative claims (required)
```json
{ "id": "qc-019-demand-coca", "claim": "Demand-side COCA (floor estimate, beachhead segment)", "value": "≈$300/contractor (floor — excludes unmeasured carrier-acceptance stage cost)", "step_ref": "19_calculate_the_coca", "source": "computed from Step 18 demand-side stage costs (qc-018-demand-funnel) at $75/hr founder-time placeholder (ka-019-founder-rate)", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-019-supply-coca", "claim": "Supply-side COCA, beachhead segment", "value": "≈$225/pilot", "step_ref": "19_calculate_the_coca", "source": "computed from Step 18 supply-side stage costs (qc-018-supply-funnel) at $75/hr founder-time placeholder (ka-019-founder-rate)", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-019-demand-ltv-coca-ratio", "claim": "Demand-side LTV:COCA ratio (provisional, floor COCA)", "value": "≈12.5:1; payback ≈3.8 months", "step_ref": "19_calculate_the_coca", "source": "computed: demand-side LTV ≈$3,750 (qc-017-ltv) / demand-side COCA ≈$300 (qc-019-demand-coca) — both low-confidence, COCA is an acknowledged floor", "confidence": "low", "ai_risk_flag": true }
```

## Mandatory AI-risk gate — before this step is reported done
Invoked `skills/risk/ai-risk-review` against this file plus the business-slug. **PASS.** The
analyst's automation-bias check specifically confirmed the "Interpretation" section correctly
prevents the healthy-looking demand-side ratio from being read as validating the whole business,
and confirmed the supply-side N/A is reported honestly rather than forced into a number — both
cited as good-practice examples in the analyst's report, not findings. No blocking issues; no new
`risk_log` entries this pass beyond the standing cross-step methodology note already logged
against Step 17/18 (`ar-skyclaim-003`).
