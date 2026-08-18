# Step 7: High-Level Product Specification

## Traceability
| FLCUC stage | Required capability | Priority |
|---|---|---|
| Supply: Trigger/search | Job board showing nearby open jobs with pay shown up front | Must |
| Supply: Decision & purchase | One-tap job accept | Must |
| Supply: Onboarding/first use | Photo/report upload flow | Must |
| Supply: Support/service | Fast, trackable payout | Must |
| Demand: Search/discovery, Evaluation | Booking flow + real-time pilot-availability display | Must |
| Demand: Decision & purchase | Job-posting flow with clear pricing | Must |
| Demand: Onboarding/first use | Insurance-ready report delivery (format matters — see Step 12 veto-holder) | Must |
| Demand: Support/service | Dispute/backup-pilot reassignment process | Should |
| Both: Ongoing use | Ratings/reputation system on both sides | Should |
| Both: Renewal | Off-season re-engagement (job digest, readiness reminders) | Could |
| Speculative | Automated storm-alert-triggered surge job broadcasting | Could (flagged — not validated as needed vs. manual posting) |

## Prioritized capability list
### Must have
1. Supply-side job board (nearby jobs, pay visible, one-tap accept)
2. Report/photo upload flow for pilots
3. Demand-side booking flow with real-time pilot-availability display
4. Insurance-ready report template/delivery (see Step 12 — the carrier-acceptance veto-holder risk)
5. Payment processing: demand pays marketplace, marketplace remits pilot payout minus take rate

### Should have
6. Dispute/backup-pilot reassignment when a job goes unfilled or a report is rejected
7. Basic ratings/reputation on both sides

### Could have
8. Off-season re-engagement prompts
9. Automated storm-alert-triggered surge broadcasting to available pilots

### Won't have (this version)
- Native mobile app (web-responsive only for v1)
- Automated flight-path planning/piloting assistance
- Direct carrier/insurance-system integration (report delivery is a downloadable PDF/link, not an
  API push into a carrier's claims system)
- In-app messaging beyond job-specific notes (parties coordinate details by phone if needed)

## Core user flow ("moment of value")
For demand: Ray's ops manager posts a job → sees 3 available pilots within 15 miles → picks one →
gets a report back within the stated window → uses it in an insurance claim. For supply: Marcus
opens the job board on a slow Saturday → sees a $175 job 20 minutes away → accepts → flies →
uploads → gets paid within days instead of chasing an invoice.

## Explicit out-of-scope items
No native mobile app, no carrier-system API integration, and no automated dispatch/matching
algorithm for v1 — matching is manual (see Step 22's MVBP, which is explicitly concierge/hand-
matched for the first real transactions).

## Assumptions flagged
- `ka-007-report-format`: "Assumes a downloadable PDF/link report format is sufficient for
  contractors to submit to insurance carriers — not yet confirmed with a real carrier or adjuster."
  `step_ref`: `07_high_level_product_specification`, `confidence`: `low`, `test_plan`: "Show the
  report format to 2-3 of Derek's existing contractor clients and ask directly whether their
  carriers have ever rejected a report for formatting reasons," `test_result`: `null`.
