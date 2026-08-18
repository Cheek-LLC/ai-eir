# Step 8: Quantified Value Proposition

Business-type branching used: **Consumer app** — no direct dollar figure exists for a free
hobbyist activity, so quantified via a proxy (streak length / time-in-habit), per this step's
consumer-app guidance, rather than forcing a dollar figure that doesn't reflect how Maya actually
thinks about this.

## Persona's top priority metric

From Step 5: "being someone who actually does this" — i.e., sustained practice, not skill
improvement or income. The honest proxy metric is **days of active streak before quitting.**

## As-is state

Solo, unwitnessed practice: pilot participants who did **not** join the WhatsApp accountability
group (5 of 14 who dropped by week 3) averaged **~12 days** of active streak before stopping.
Source: founder-reported pilot data, n=5, 6-week observation window.

## Possible state with product

Circle-based (accountability-group) practice: the 9 pilot participants who stayed in the WhatsApp
group averaged **34+ days** of active streak, with several still actively posting when the pilot
ended at week 6 (42 days) — meaning the true average is a floor, not a ceiling; some may have gone
materially longer. Source: same pilot, n=9.

## Quantified value proposition

Delta: **roughly 3x longer active streak** (12 days → 34+ days) attributable to circle-based
accountability versus solo practice, based on a small (n=14), informal, non-randomized pilot — this
is suggestive, not proof (no control for who self-selected into staying in the group versus
dropping out, which is itself a real confound named explicitly below).

## Comparison to next best alternative / status quo

Per the onboarding pushback, the real next-best-alternative is **posting solo to personal
Instagram** (or doing nothing) — not a competing app. Instagram provides likes but, per Maya's own
words, "no actual accountability." The switching cost from "post to Instagram sometimes" to "use
this app daily and join a circle" is low (free to install, existing artifact type is the same —
sketches), so the bar to clear is more about behavior change (forming a new daily habit + inviting
real people) than about a hard cost/effort tradeoff.

## Judgment: is the gap big enough?

**Directionally yes, but not yet rigorously shown.** A 3x streak-length difference, if it holds up
under real (not self-selected) conditions, would be a genuinely differentiated result. But the
pilot's biggest weakness — flagged honestly rather than papered over — is that people who *chose*
to stay engaged in the WhatsApp group may simply be more motivated people generally, not people
whose behavior was *caused* by the accountability mechanic. This is exactly the kind of
self-selection confound the MVBP (Step 22) and Step 21's test plan need to address with a larger,
less pre-selected cohort before this number is presented anywhere as more than a promising early
signal.

## Quantitative claims logged

```json
{ "id": "qc-008-value-delta", "claim": "Streak-length delta, circle vs. solo practice (pilot data)", "value": "~12 days (solo) -> 34+ days (circle) = roughly 3x", "step_ref": "08_quantify_the_value_proposition", "source": "founder-reported pilot data, n=14 (5 solo dropouts, 9 circle participants), 6-week informal pilot, Jan-Feb 2026 — self-selected, not randomized", "confidence": "low", "ai_risk_flag": false }
```

## Assumptions flagged

- `ka-008-selfselection` — statement: "The 3x streak-length delta may substantially overstate the
  circle mechanic's causal effect, since participants self-selected into staying in the
  accountability group rather than being randomly assigned." `step_ref:
  08_quantify_the_value_proposition`, `confidence: low`, `test_plan: "the MVBP beta (Step 22)
  should track streak length for circle-joiners vs. circle-decliners within the same cohort, which
  at least controls for 'chose this app' even if not for full self-selection"`, `test_result:
  null`.

*This is a planning aid, not financial, legal, or tax advice.*
