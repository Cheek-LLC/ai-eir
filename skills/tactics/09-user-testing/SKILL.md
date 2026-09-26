---
name: 09-user-testing
description: >
  Use once Tactic 8's design/prototype exists (fully or partly) to get it in front of real target
  users before a broad launch, with a structured, sample-size-honest testing methodology — not
  "we showed it to two friends." Triggers: "user testing," "usability testing," "test the
  prototype," "does this actually work for users," "tactic 9," "user testing tactic." Distinct
  from DE Step 23 (dogs eating the dog food): Step 23 measures real usage/retention/adoption of
  the already-sold, already-delivered product over time; this tactic is the earlier, structured,
  task-based test of the built or prototyped product with recruited target users, before or
  alongside early sales, meant to catch design and value-proposition problems before broad launch.
---

# Tactic 9: User Testing — Validating the Product Actually Works

## What this tactic is (and isn't)

Tactic 8 produced a design or prototype. Nobody has watched a real target user try to use it yet.
This tactic is that observation, run with the same rigor discipline this plugin applies to every
other validation claim: a real number of real target users, a real task script, and an honest,
falsifiable read of what happened — never a founder's impression that "it seemed to go fine."

**This is not DE Step 23.** Step 23 ("show that the dogs will eat the dog food") is quantitative
usage/retention evidence from customers who have already **paid** for and are living with the
MVBP over real time — login frequency, renewal, reorder rate, weeks of retained usage. It requires
a real transaction to already exist and measures behavior after the fact, passively, from logs and
outcomes. **Tactic 9 is different in kind, not just in timing**: it is an active, structured,
observed test session — recruit specific target users, sit with them (in person, on a call, or via
a remote-testing tool), give them a real task, and watch what they do and where they get stuck.
It can run on a prototype before a single dollar has changed hands, and it should — catching a
confusing onboarding flow before broad launch is cheaper than discovering it in Step 23's churn
data three months later. Run this tactic first; treat Step 23 as the longer-horizon confirmation
that what this tactic validated actually holds up in ongoing real use.

**This is not a redo of Tactic 8.** This tactic does not redesign anything itself — it produces
findings and routes them: some findings go back to Tactic 8 (a design/usability problem), and some
go further back, to Step 22's MVBP scope or even the plan's stated value proposition (Step 8), when
what's broken isn't the design but the offer itself. Distinguishing which is this tactic's central
job — see Step 3 below.

## What you read

- `.startup/<slug>/business-state.json` — `business_basics.business_type` and
  `tactics.08_design` (confirms a design/prototype actually exists to test).
- `tactics/08-design.md` — required. The specific stages and fidelity levels available to test;
  test only what's actually built to a testable fidelity, not the full spec.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — required. Recruits
  must match this persona; a test run on friends/family or an off-segment user produces findings
  that don't transfer, and this tactic exists specifically to prevent that substitution.
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — required. What the product is
  supposed to deliver; a testing session's "doesn't want this" findings get checked against this.
- `.startup/<slug>/plan/22-define-the-mvbp.md` — the current offer scope, so findings can be
  routed back to it accurately if the problem turns out to be the offer, not the design.

## What you write

- `tactics/09-user-testing.md` — the test plan, the actual sessions run, findings tagged by
  severity and by confusion-vs-rejection (template below), and explicit routing of each finding.
- This skill does **not** write `business-state.json.tactics` itself. The orchestrator confirms
  `tactics/09-user-testing.md` was written and updates `business-state.json.tactics.09_user_testing`.

## Step 1 — Recruit real target users, and enforce the sample-size discipline

**Recruiting criteria.** Every test participant must match Step 5's beachhead persona — the actual
role, context, and trigger condition the plan describes, not "someone available." If the founder
proposes testing with friends, family, coworkers outside the target segment, or anyone who already
knows the product too well to react naturally, push back directly: "That's not user testing, it's
a demo to someone who wants you to succeed. Who's an actual `<persona>` you can get 30 minutes
from?" This is the same discipline `roadmap-and-prioritization` applies to vague founder claims —
don't let convenience substitute for evidence.

**How many is enough to trust a result.** State this plainly to the founder rather than leaving it
implicit:

- A single round of qualitative, task-based usability testing on one design needs **5-8 real
  target users** to reliably surface the majority of usability problems in that design — fewer
  than 5 real target-persona sessions is not a result, it's an anecdote, and must be labeled as
  such (`confidence: low`, explicitly named as insufficient, never presented as "we tested it").
  More than roughly 8-10 in a single round has sharply diminishing returns for *this kind* of
  finding — the return on additional sessions in one round is in finding the same problems again,
  not new ones.
- This is a **per-round** minimum, not a lifetime one: after fixes land (routed per Step 3 below),
  run another round of 5-8 on the changed flow. Two friends who "loved it" is not a substitute for
  either round, and one round of five is not a substitute for a second round after changes — "we
  tested it once" does not mean the fixed version has been validated.
- If the founder cannot get 5 real target users this cycle, say so honestly: run what's actually
  achievable, mark the round's confidence accordingly, and name the gap rather than rounding up to
  make the record look more rigorous than it was.

## Step 2 — Run structured sessions, not open-ended demos

For each session:

1. **Give a real task, not a tour.** "Show me how you'd sign up and get to your first result" —
   never "let me walk you through it." The founder narrating removes the exact friction this test
   exists to find.
2. **Use think-aloud.** Ask the participant to narrate what they're thinking/expecting as they go;
   don't interrupt to explain or correct — a moment of confusion is data, not an error to fix live.
3. **Record the objective outcomes** per task: completed unassisted / completed with a hint /
   abandoned; time on task; the specific point of confusion or error, described concretely (not
   "they got confused" — "they clicked the logo instead of the 'Continue' button, twice, looking
   for a way forward").
4. **Ask the value question directly, separately from the usability tasks**, after the task
   portion: "If this existed today at `<Step 16 price>`, would you actually pay for it? Why or why
   not?" This is what lets Step 3 distinguish a usability problem from a value problem — don't
   skip it because the task portion "went fine."

## Step 3 — Distinguish "confused" from "doesn't want this"

This is the tactic's central analytical job, and the two require entirely different fixes:

| Signal | Looks like | Routes to |
|---|---|---|
| **User is confused** | Hesitates, misclicks, asks "what does this button do," completes the task eventually with effort, but says the underlying idea is useful when asked directly | Tactic 8 (design) — a flow, layout, or copy problem, fixable without touching the offer |
| **User doesn't want this** | Completes the task easily with no confusion, but answers the value question with genuine hesitation, a lower price than Step 16's, or "I could see using this if it also did X" naming something outside the MVBP's core value driver | DE Step 22 (MVBP scope) or Step 8 (value proposition) — the design isn't the problem, the offer or its value framing is |
| **Both at once** | Confused *and* unenthusiastic even once they understand it | The more serious case — flag it as such explicitly; don't let a design fix alone be presented as resolving it |

Never default to treating every negative finding as a design fix — that's the easiest, least
threatening conclusion for a founder to hear, which is exactly why it must be checked against the
table above rather than assumed. If more than roughly a third of a round's participants land in
the "doesn't want this" or "both" rows, say so plainly: that's a signal serious enough to route back
to Step 22 or Step 8, not just note as a couple of one-off comments.

## Step 4 — Synthesize and route every finding

For every finding across all sessions in a round:

- Give it a short id, a severity (`blocking` — can't complete the core task at all; `major` —
  completes with real friction/hint; `minor` — completes easily, small annoyance), and the
  confusion-vs-rejection tag from Step 3.
- State exactly where it routes: Tactic 8 (with the specific stage from that tactic's output file),
  Step 22 (MVBP scope), or Step 8 (value proposition) — never leave a finding un-routed.
- Do not silently fix anything in this tactic's own output — findings get handed to the tactic/step
  that owns the fix; this tactic's job ends at a clear, routed finding.

## Output file: `tactics/09-user-testing.md`

```markdown
# Tactic 9: User Testing — Validating the Product Actually Works

## Round <N> — <date>
Recruits: <n> real target users matching Step 5's persona (state how recruited)
Sample-size read: sufficient (5-8+) | thin — treat as anecdote (state honestly)

## Sessions
| Participant | Task outcome | Time on task | Confusion point (specific) | Value-question answer |
|---|---|---|---|---|
| P1 | completed / hint / abandoned | ... | ... | ... |

## Findings
| ID | Description | Severity | Confusion or rejection (or both) | Routed to |
|---|---|---|---|---|
| ut-01 | ... | blocking/major/minor | ... | Tactic 8 stage X / Step 22 / Step 8 |

## Honest read
Overall: <ready for broad launch as designed | needs a design fix round | needs an offer/value
rethink | needs both>
Fraction of this round in "doesn't want this"/"both": <state explicitly if ≥ ~1/3>

## Next round needed?
Yes/No — <if yes, on what changed flow, and when>
```

## Never fabricate

A round with fewer than 5 real target-persona participants is labeled as thin evidence, explicitly,
every time — never presented as if it carries the same weight as a full round. A finding with no
specific description ("some confusion") is not a finding; describe exactly what happened.

## Done means

- Recruits matched the actual beachhead persona (Step 5), not convenience contacts — stated
  explicitly, with the honest sample size and its confidence read.
- Every finding is routed to a specific tactic/step (Tactic 8, Step 22, or Step 8) — none left
  un-routed or described only as "make it better."
- The confusion-vs-rejection distinction was applied to every negative finding, not defaulted to
  "design problem" without checking.
- `tactics/09-user-testing.md` written with the round(s) run, findings, routing, and an explicit
  call on whether another round is needed before broad launch.
- `business-state.json.tactics` was **not** written by this skill — left to the orchestrator.
