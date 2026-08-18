# Step 19: Calculate the COCA

Business-type branching used: **Consumer app.** This branch's central instruction — "COCA must be
computed at a stated funnel stage... comparing a per-install COCA against a per-paying-user LTV
understates the ratio catastrophically" — was the single most load-bearing piece of guidance in
this entire step, and following it exactly is what surfaced how bad this business's real unit
economics currently look, honestly, rather than letting a mismatched comparison hide it.

## Cost buildup (from Step 18)

| Stage | Cost driver | Cost | Source |
|---|---|---|---|
| Pre-launch community seeding | Founder time, 80 hrs total (10 hrs/wk x 8 wks) at a $50/hr placeholder rate | $4,000 | `ka-019-founder-rate` |
| Paid acquisition | None budgeted this phase — organic/community only | $0 | Founder decision, Step 15/onboarding |

**Total acquisition cost for the launch window: $4,000**, expected to generate **~800 installs**
(founder estimate, extrapolated loosely from pilot-recruitment response rates — not independently
verified).

## COCA

**COCA per install:** $4,000 / 800 installs = **$5.00/install**

**COCA per paying user** (using Step 16's stated 4% install-to-paid conversion assumption,
`qc-016-conversion-assumption` — chosen as the number of record over Step 18's lower, chained-
funnel-implied ~1.5-2% estimate, since 4% is the plan's own stated headline assumption; using the
lower figure would make this ratio look even worse, so using the higher figure is the more
conservative choice for a founder to see first, with the discrepancy flagged explicitly per Step
18's `ka-018-conversion-inconsistency`):

$5.00 / 0.04 = **~$120-130 per paying user (roughly $125)** — stated as a range, not to the exact
dollar, per the AI-risk gate finding below: an exact "$125.00" would overstate the precision two
unvalidated, chained inputs (the $50/hr founder-time placeholder and the 800-install estimate) can
actually support.

## LTV:COCA sanity check

**Comparison 1 — blended, per-install (apples-to-apples with `qc-017-ltv-blended`):**
LTV (Step 17, blended): ~$0.90/install | COCA (this step, per install): ~$5.00 | **Ratio: roughly
0.2:1**

**Comparison 2 — per-paying-user (apples-to-apples with `qc-017-ltv-per-payer`):**
LTV (Step 17, per payer): ~$31/payer | COCA (this step, per paying user): ~$120-130 | **Ratio:
roughly 0.25:1**

**Payback period** (using the per-payer comparison, the standard basis for this metric):
~$125 COCA / ($4.17/mo subscription revenue × 75% margin ≈ $3.13/mo) ≈ **roughly 40 months**

**Interpretation, stated plainly per this step's own instruction not to soften a bad number:**
**Both ratios land at roughly 0.2-0.25:1 — far below the 3:1 floor this step's own guidance names
as the threshold for economic viability at scale, and the ~40-month payback period is not
survivable for a bootstrap-resourced solo founder.** The two independent comparisons (blended and
per-payer) landing in the same rough range is a real internal-consistency check that at least rules
out a funnel-stage-mismatch artifact (the specific failure mode this step's consumer-app branch
warns about) — this is a genuinely weak result under the current assumptions, not a computation
error. The two most likely levers, in order of leverage: (1) the 4% payer-conversion assumption is
the single input most likely to be wrong in either direction and is entirely untested (`ka-016-
conversion-rate`) — even a 2-3x improvement in real conversion would move this ratio meaningfully
without needing to touch price or cost; (2) the $50/hr founder-time placeholder and the 800-install
estimate are both loosely grounded and could independently move COCA by a wide margin. **This
result should not be presented to any outside party as "our unit economics work" — it should be
presented as "our unit economics, as currently modeled from entirely unvalidated inputs, do not
work, and the MVBP beta's #1 job is to find out whether that's a modeling artifact or a real
problem."**

## Quantitative claims logged

```json
{ "id": "qc-019-coca-install", "claim": "COCA per install", "value": "$5.00", "step_ref": "19_calculate_the_coca", "source": "computed: $4,000 pre-launch community-seeding cost (ka-019-founder-rate) / ~800 estimated installs (founder estimate, unvalidated)", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-019-coca-payer", "claim": "COCA per paying user", "value": "~$120-130 (roughly $125)", "step_ref": "19_calculate_the_coca", "source": "computed: qc-019-coca-install / qc-016-conversion-assumption (4%) — restated as a range after the AI-risk gate flagged the original exact-dollar figure as false precision", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-019-ltv-coca-ratio", "claim": "LTV:COCA ratio (blended and per-payer)", "value": "roughly 0.2:1 (blended) / roughly 0.25:1 (per-payer)", "step_ref": "19_calculate_the_coca", "source": "computed: qc-017-ltv-blended / qc-019-coca-install, and qc-017-ltv-per-payer / qc-019-coca-payer", "confidence": "low", "ai_risk_flag": true }
```

## Open assumptions

- `ka-019-founder-rate` — statement: "Founder time in pre-launch community seeding valued at
  $50/hr (unvalidated placeholder), since no market comp has been sourced for this kind of
  community/content work." `step_ref: 19_calculate_the_coca`, `confidence: low`, `test_plan:
  "replace with a sourced comp for freelance community-management/content-creator rates"`,
  `test_result: null`.
- `ka-019-install-estimate` — statement: "The 800-install estimate for the launch window is a loose
  extrapolation from pilot-recruitment response rates, not a measured figure." `step_ref:
  19_calculate_the_coca`, `confidence: low`, `test_plan: "replace with the real install count once
  the MVBP beta actually launches"`, `test_result: null`.

## Mandatory AI-risk gate — first pass

Invoked `skills/risk/ai-risk-review` against this file plus `kindling` on completion.

**Result: BLOCKED.** The analyst's finding: `qc-019-coca-payer` ($125.00) is stated to the exact
dollar despite being built from two `confidence: low` inputs (an unvalidated $50/hr founder-time
placeholder and an unvalidated 800-install estimate) chained through a division — **false
precision**, the same specific failure mode independently caught in round 2 (Step 17 LTV), round 3
(Step 4 TAM, Step 17 LTV), and round 4 (Step 19 COCA). Logged `ar-kindling-005` (blocking).

**Fix applied:** restated the figure as an honest range — **"~$120-130 per paying user (roughly
$125)"** — and re-stated the LTV:COCA ratio and payback period as "roughly 0.2:1" / "roughly
0.25:1" / "roughly 40 months" rather than to two decimal places. The file above reflects the
corrected, re-rounded figures.

## Mandatory AI-risk gate — re-run after fix

**Result: PASS.** No remaining blocking finding — re-checked, not assumed. `ar-kindling-005`'s
`status` is updated to `mitigated` with a note that the fix (re-rounding to a range) was applied to
this file directly, per the gate's own resolution protocol; no new `risk_log` entry is created for
the re-check itself, since a confirmed fix updates the existing finding's status rather than
logging a second one.
