# KPI Dashboard — Vantage Point Search

_Last revised: 2026-09-15. Revise this file (re-run `skills/ops/kpi-dashboard-setup`) whenever the
business model or pricing changes materially — do not let it go stale against
`plan/15-design-a-business-model.md`/`plan/16-set-your-pricing-framework.md`._

Produced by `skills/ops/kpi-dashboard-setup`, delegated from `agents/ops/growth-analyst.md` as part
of `agents/ops/operations-manager.md`'s first post-launch check-in sequencing.

## Business model classification

Business type: `services` | Step 15 archetype: **Fee-for-service / project-based** (retained
search, 30% of first-year base salary, 3 installments — explicitly not a retainer; that model was
considered and deferred, see Step 15) | Pricing metric (Step 16): % of placed candidate's first-year
base salary, scales with the actual comp band, average $70,500/engagement across 8 real signed
engagements to date.

## KPI set

| KPI | Definition / formula | Data source | Target / reference band | Currently trackable? |
|---|---|---|---|---|
| Billable utilization | Delivery hours on active searches ÷ available capacity hours (period) | Founder-reported (no time-tracking tool yet — see `ka-016-delivery-hours-estimate`) | No plan baseline yet — Step 19's ~90 hrs/engagement is a per-engagement estimate, not a period-level utilization target | Recommended, not yet trackable precisely (founder can estimate, not log) |
| Realized project margin | Fee collected − delivery cost (founder time × placeholder rate + direct costs) per completed engagement | Founder-reported, computed from Step 17's method | Step 17: $61,500 conservative / $81,800 repeat-adjusted margin per engagement | Yes (founder can report per completed engagement) |
| Pipeline coverage ratio | Open, not-yet-closed opportunity value currently being worked ÷ this period's close target | Founder-reported, from the Step 9/outbound-sales-playbook tracker | No plan baseline yet | Yes (the tracker in `gtm/outbound-sales-playbook.md` §1 already has this) |
| Client renewal/repeat-engagement rate | Distinct clients with 2+ engagements ÷ distinct clients total | Founder-reported | Step 17: 1.33 observed repeat-engagements-per-client (small sample, n=6 clients) | Yes |
| Referral rate | New engagements sourced via referral ÷ total new engagements | Founder-reported | Step 9: 6 of 8 historical (75%) — also the direct measure of `ka-009-referral-concentration` | Yes |

## Universal (every business tracks these)

- **Actual COCA vs. plan** (Step 19: `qc-019-coca`, ~$5,200, range $4,900-$5,400).
- **Actual LTV vs. plan** (Step 17: `qc-017-ltv`, $61,500 conservative / $81,800 repeat-adjusted),
  once enough retention/repeat-engagement data exists.

## Notes

This business's KPI set deliberately does not include MRR/ARR, logo churn %, or trial→paid
conversion — none of those map to a project-based fee-for-service model with no subscription
relationship. Billable utilization is the single most important KPI given the plan's own central
finding (delivery capacity, not customer acquisition, is the real constraint) but is currently the
least precisely trackable one, since Jordan has no time-tracking tool in place yet
(`ka-016-delivery-hours-estimate`) — flagged here as a real, standing gap rather than an
approximated number.
