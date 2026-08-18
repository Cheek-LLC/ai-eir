# Step 3: End User Profile

> **Marketplace note on this file's structure:** Step 3's own SKILL.md instructs writing two full
> profiles for a marketplace ("write two profiles, not one, and carry both forward into Steps 4
> and 5") but its `Write plan/03-...md` template only provides a single "Profile dimensions"
> table with no second slot. Unlike Step 12 (DMU), whose template explicitly says "for a
> marketplace, complete one full table per side," this step's template gives no equivalent
> scaffold. I've duplicated the table structure myself below (supply-side, then demand-side) to
> follow the prose instruction — flagging this as a real gap between instruction and template; see
> QA notes for detail.

## Research basis
Supply side: 8 real conversations (of Derek's ~12 known pilots) specifically about marketplace
dispatch, not just general acquaintance. Demand side: 6 real conversations — all of Derek's
existing Osei Aerial direct clients, re-interviewed specifically about whether they'd use a
marketplace instead of booking Derek personally. Method: founder-conducted interviews, informal
(phone/in-person), not a structured survey instrument.

## Supply-side profile
| Dimension | Detail |
|---|---|
| Firmographic/demographic anchor | FAA Part 107-certified, owns own equipment (DJI Mavic 3 Enterprise-class or better), based within ~60 miles of a TX/OK Hail Alley metro, drone work is secondary/side income for most (not sole livelihood), age skews 28-50 |
| Behavioral characteristics | Currently finds clients via personal network, Facebook drone-operator groups, and word of mouth; no dedicated booking/dispatch software today — invoices manually per job; already carries commercial liability insurance (a real filter — several otherwise-qualified pilots in Derek's network do not, and decline roof work specifically because of it) |
| Psychographic characteristics | Values scheduling flexibility over commitment; several (3 of 8 interviewed) expressed explicit distrust of "gig platforms" that race prices to the bottom — this surfaced unprompted and is treated as a real signal, not dismissed; motivated by filling idle-capacity gaps, not building a full-time income stream around this |
| Distinguishing/trigger characteristic | Willingness to fly close-proximity, steep-pitch roof work — this is the real filter, not the Part 107 certificate itself. Several pilots in Derek's broader network are certified but decline roof-specific jobs due to the closer obstacle-avoidance risk and the higher insurance bar it implies |

## Demand-side profile
| Dimension | Detail |
|---|---|
| Firmographic/demographic anchor | Storm-restoration roofing contractor, 10-50 crews, TX/OK Hail Alley corridor, revenue typically $3-15M/year, business is majority insurance-claim-driven (not retail reroofs) |
| Behavioral characteristics | Today either keeps one in-house drone-certified estimator (a bottleneck the moment two storms hit different areas in the same week) or ladders every roof manually; buys reactively/urgently around a specific storm event, not on a planned sales cycle; several have been burned by CRM/estimating software sold to them before and are skeptical of "another software tool" framing |
| Psychographic characteristics | Deeply risk-averse about documentation quality — a report that doesn't hold up to a carrier's adjuster is worse than no report at all; decision speed during a storm surge is treated as existential (a contractor who can't document damage inside the claim window loses jobs to a faster competitor) |
| Distinguishing/trigger characteristic | The trigger event is a specific hailstorm hitting their operating area — demand is spiky and event-driven, not steady-state. This is a structural fact about this segment's buying rhythm, not an incidental detail, and it drives the liquidity/surge-capacity question carried into Steps 4, 15, and 19 |

## Narrative profile
**Supply side:** "This person is a working drone pilot who already has a small business or side
income around real estate/media photography, or runs a 2-5 person drone shop, and currently
struggles with inconsistent gig volume between their existing work. They have the certification
and equipment but are cautious about platforms that feel like they'll be raced to the bottom on
price or forced into commitments that eat their flexibility."

**Demand side:** "This person runs or manages field operations at a mid-size storm-restoration
roofing company and currently struggles with a hard capacity ceiling — one in-house drone
estimator (or none) — the moment a storm creates 10-50x normal inspection demand overnight. They
need documentation fast enough to matter inside an insurance claim window, and they need to trust
that documentation will actually hold up to the carrier."

## In-profile vs. out-of-profile
**Supply:** IN — a Part 107 pilot with commercial insurance who is *willing* to fly roof-specific
work. OUT (superficial lookalike) — a Part 107-certified real-estate photographer with no
commercial insurance and no stated willingness to do close-proximity structure work; certificate
alone does not qualify someone for this profile.

**Demand:** IN — a 10-50 crew contractor whose revenue is majority insurance-claim-driven. OUT
(superficial lookalike) — a similarly-sized roofing contractor that does mostly retail/new-
construction reroofs with no storm-claim urgency; same size and industry, structurally different
buying trigger and urgency.

## Relationship to the economic buyer
**Supply:** the pilot is both end user and (almost always) their own economic buyer — no separate
approval needed to accept a gig, with one noted exception (2-3 person shops where a business
partner sometimes weighs in). Full DMU mapping is Step 12.

**Demand:** the day-to-day end user (an ops manager who books jobs) is frequently *not* the
economic buyer (an owner/GM who approves new vendor relationships) — noted here, resolved fully
in Step 12.

## Assumptions flagged
- `ka-003-thin-supply-sample`: "Supply-side profile is based on 8 conversations, all sourced from
  Derek's own pre-existing network — no supply-side conversations yet exist with a pilot Derek
  did *not* already know before starting this pivot, so the profile may be systematically biased
  toward 'people who already like Derek' rather than the broader addressable pilot population."
  `step_ref`: `03_build_an_end_user_profile`, `confidence`: `low`, `test_plan`: "Recruit and
  interview at least 5 pilots with no prior relationship to Derek (e.g., via a cold post in a
  regional drone-operator group) before treating this profile as validated beyond his existing
  network," `test_result`: `null`.
- `ka-003-demand-sample-is-existing-clients`: "Demand-side profile is based entirely on Derek's 6
  existing direct clients — people who already trust him personally as a solo operator. Whether a
  roofing contractor with *no* prior relationship to Derek would trust a marketplace (vs. trusting
  Derek the person) is untested." `step_ref`: `03_build_an_end_user_profile`, `confidence`: `low`,
  `test_plan`: "Interview at least 5 roofing contractors with no prior Osei Aerial relationship,
  sourced via the trade association, before treating demand-side trust dynamics as understood
  beyond Derek's existing book of business," `test_result`: `null`.
