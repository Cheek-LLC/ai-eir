# Step 21: Test Key Assumptions

## Test plans and outcomes

### ka-008-target-unproven — 8-minute time-to-cover / 70% late-opening reduction
- Test method: Instrument actual time-to-cover during the Step 22 MVBP pilot; compare against
  Jordan's stated 45-minute baseline.
- Success metric / threshold: Median time-to-cover under 15 minutes across the first 20 real
  broadcasts (relaxed from the 8-minute target to a testable threshold).
- Cost / timeline: No direct cost; requires the MVBP to exist and at least one pilot location live.
- **Outcome: Deferred until the MVBP pilot (Step 22) has run for at least 20 real call-out events.**
- If invalidated: Step 8's value proposition and Step 16's pricing both need rework.

### ka-018-channel-scalability / ka-019-ratio-not-representative — warm-network-only COCA
- Test method: Run one real cold/paid outbound test batch (e.g., a small LinkedIn outbound
  campaign to Directors of Operations outside Maria's existing network) and measure actual
  conversion and cost.
- Success metric / threshold: A cold-channel COCA within 3x of the warm-network COCA ($3,213)
  would suggest the ratio is directionally defensible at scale; anything higher needs the plan's
  unit economics section rewritten before any external use.
- Cost / timeline: Requires real ad/outbound spend — not yet budgeted. Estimated $500-1,000 test
  budget, 4-6 weeks.
- **Outcome: Deferred until MVBP has at least 3 warm-network customers and founder has budget to
  run a real cold-channel test.**

### ka-006-onboarding-adoption — will GMs actually use it, not revert to the call list
- Test method: Direct observation/usage-log review during the pilot; specifically watch whether
  Jordan (or an equivalent pilot GM) uses the broadcast tool for her next 5 real call-outs.
- Success metric / threshold: At least 4 of the next 5 real call-outs at a pilot location go
  through ShiftCover, not the old call list.
- Cost / timeline: No direct cost; requires the MVBP pilot to be live.
- **Outcome: Deferred until Step 22's MVBP pilot is live.**

### ka-onboarding-cross-location-pool — will backup workers accept a shared cross-location pool
- Test method: Direct question in the next 10 backup-worker conversations (as originally planned
  during onboarding).
- Success metric / threshold: At least 6 of 10 backup workers say they'd accept being on a
  shared cross-location list, with no strong objection.
- Cost / timeline: Zero cost, can run this week — no product dependency.
- **Outcome: Not yet run.** This is the one leap-of-faith assumption on this list that could be
  tested *today*, at zero cost, and has not been — flagged plainly as a founder-side execution
  gap, not a product or data blocker.

### ka-016-price-point — $149/location/month untested
- Test method: State the price directly in the next 5 real sales conversations (Step 9 prospects).
- Success metric / threshold: At least 3 of 5 prospects don't treat the price itself as a
  dealbreaker (may still negotiate, but don't walk away on price alone).
- Cost / timeline: Zero cost, blocked only on actually having those 5 conversations.
- **Outcome: Deferred until Step 9's prospects move from "in conversation" to a real pricing
  discussion (Step 13, Stage 5).**

### ka-017-churn — 25-month expected lifetime (4%/mo churn) benchmark
- Test method: Cannot be tested pre-launch by definition; requires real cohort data.
- Success metric / threshold: N/A until 6+ months of paying-customer data exists.
- Cost / timeline: N/A.
- **Outcome: Deferred until 6+ months of real cohort data exists** — explicitly not testable
  earlier, stated as an acceptable order of operations rather than an evasion.

### ka-012-franchisor-veto — franchisor IT/brand-standards veto risk
- Test method: Ask directly in the first real sales conversation (prospect #1, Alex Torres,
  Copperline Burgers) whether their franchise agreement requires franchisor sign-off.
- Success metric / threshold: A clear yes/no answer, plus (if yes) an understanding of what that
  approval process requires.
- Cost / timeline: Zero cost, one conversation.
- **Outcome: Deferred until that conversation happens** — not yet scheduled as of this plan.

### ka-018-conversion — Step 18's funnel conversion rates
- Test method: Track real conversion at each Step 13/18 stage as the Step 9 pipeline actually
  advances.
- Success metric / threshold: N/A — this is an ongoing measurement, not a pass/fail test.
- Cost / timeline: No direct cost; requires the pipeline to actually move.
- **Outcome: Deferred, ongoing** — recompute Step 18 once 5+ real prospects have moved through at
  least the first two stages.

## Unresolved risk carried forward
Every leap-of-faith assumption above remains `deferred` — **none has been validated or
invalidated**, which is an honest reflection of this business's idea-only stage (per
`business_basics.venture_stage`), not a failure of this step. The one item that stands out as an
avoidable gap rather than a genuine blocker is `ka-onboarding-cross-location-pool`: it requires no
product, no pilot, and no budget to test, and simply has not been done yet. This should be called
out explicitly to the founder as the highest-leverage, lowest-cost next action.
