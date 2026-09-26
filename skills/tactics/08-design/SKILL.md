---
name: 08-design
description: >
  Use once Tactic 7's first roadmap names the near-term build and the founder needs to actually
  design the MVBP (DE Step 22) as a real, usable product experience — wireframes/flows, not a
  feature list. Triggers: "design the MVBP," "wireframe this," "what should the UX be," "how do we
  design the product," "tactic 8," "product design tactic." This is **product/UX design** — the
  actual user-facing experience of the thing being built. It is a different discipline from
  Tactic 4 (Assets), which builds brand/visual-marketing assets like the website and marketing
  graphics — do not conflate the two or treat one as covering the other.
---

# Tactic 8: Design — Minimum Viable Business Product Design

## What this tactic is (and isn't)

Step 22 defined the MVBP as a business decision: what's sold, at what price, delivered how. It
did not design the actual experience of using it. A founder can have a precisely scoped MVBP offer
and still hand a customer something confusing, poorly sequenced, or badly organized — and no
amount of correct scoping fixes bad usability. This tactic's job is the design pass Step 22 assumes
happens next: turn the MVBP's offer and delivery process into a real, usable, intuitive experience
a first-time user can actually get through without hand-holding beyond what Step 22 already
declared manual/concierge.

**This is not Tactic 4 (Assets).** Tactic 4 builds visual/brand assets — the marketing website,
graphics, pitch video — things a prospect sees *before* they buy, meant to establish identity and
credibility. Tactic 8 designs what a customer *uses* after they buy: the screens, flows, forms,
physical unboxing sequence, or service touchpoints that make up the actual product experience. A
beautiful landing page (Tactic 4) sitting in front of a confusing onboarding flow (Tactic 8's
failure) is exactly the trap this distinction exists to prevent. If asked to "make the product
look good," clarify which one is actually meant before starting.

**This is not a redo of Step 22.** Step 22 already decided *what's* included and excluded and at
what price. This tactic does not reopen those business decisions — it designs the experience of
the scope Step 22 already fixed. If a design constraint genuinely can't be met without changing
Step 22's scope, say so explicitly and flag it back rather than silently expanding scope through
design decisions.

## What you read

- `.startup/<slug>/business-state.json` — `business_basics.business_type` (design shape differs
  sharply by type, see below) and `tactics.07_product_roadmap` (confirms a roadmap exists and what
  it prioritized first).
- `.startup/<slug>/plan/22-define-the-mvbp.md` — required, the scope source. Every included/
  excluded item from the MVBP's offer must show up somewhere in this tactic's design, or be
  explicitly called out as descoped further at the design stage (rare, and must be justified).
- `.startup/<slug>/plan/06-full-life-cycle-use-case.md` — required. The intended end-to-end usage
  pattern this design must actually walk a user through, start to finish.
- `.startup/<slug>/plan/07-high-level-product-specification.md` if present — the full intended
  product; useful context for what's deliberately not being designed yet.
- `tactics/07-product-roadmap.md` — what the first roadmap actually prioritized to build; design
  effort should follow that sequencing, not the founder's most recent idea.

## What you write

- `tactics/08-design.md` — the design spec (template below): user flow, per-screen/touchpoint
  wireframe description, scope-cut discipline, fidelity recommendation, and a usability checklist.
- This skill does **not** write `business-state.json.tactics` itself. The orchestrator confirms
  `tactics/08-design.md` was written and updates `business-state.json.tactics.08_design`.

## Step 1 — Map the user flow from Step 6, not from imagination

Take Step 6's full life-cycle use case and break it into discrete stages a real user moves
through: discovery/entry, first setup, the core job-to-be-done, completion/output, and any
recurring-use loop. For each stage, name:

- The single primary action the user must take to move forward.
- What happens if they don't take it (abandonment risk) — is there a nudge, a timeout, a follow-up?
- What information the user needs at that moment to proceed confidently, and where it comes from.

Do not start wireframing before this flow is written down stage by stage — a wireframe built
before the flow is mapped almost always designs the founder's mental model of the product, not the
user's actual path through it.

## Step 2 — Wireframe/prototype each stage at the right fidelity

For each stage from Step 1, produce a concrete, textual wireframe description — not a visual file
(this plugin's skills produce markdown), but specific enough that someone could actually build or
mock up the screen/touchpoint from it:

- **Layout** — what's on the screen/page/form/physical package, in what visual hierarchy (primary
  action always more prominent than secondary options).
- **Key elements** — every input, button, piece of copy, or physical component that stage needs,
  named specifically (not "a form" — "an email field, a password field, a single 'Start free
  trial' button, no third option competing with it").
- **Primary action** — the one thing this stage wants the user to do; if there are two equally
  prominent calls to action, that's a design defect, not a feature.
- **Error/edge states** — what the user sees when something goes wrong (bad input, a failed
  payment, a step they can't complete) — these are not optional polish, they're part of "minimum
  viable," see Step 3.

**Fidelity recommendation.** State explicitly, per stage, whether it needs a real clickable
prototype (Figma, an interactive mock, an actual coded screen) or whether a low-fidelity sketch/
paper description is enough for Tactic 9's testing purposes. The rule: any stage where the MVBP's
"automated today" (per Step 22) is real software gets at least a clickable prototype before Tactic
9; any stage that's manual/concierge per Step 22 can be described as a process (a script, a
checklist, a physical sequence) rather than wireframed as software, since there's no interface to
prototype — don't invent screens for a step the MVBP explicitly does by hand.

## Step 3 — What "minimum viable" means in design terms

The single most common design failure at this stage is confusing "cut scope" with "cut usability"
— they are not the same operation, and only one of them is acceptable:

| Acceptable scope cut | Unacceptable usability cut |
|---|---|
| Fewer screens/features than the full spec (Step 7) | Removing error states or feedback so the user doesn't know if something worked |
| A manual step behind the scenes standing in for automation (per Step 22) | Removing the primary-action clarity so the user doesn't know what to do next |
| Deferring a nice-to-have flow (e.g. account settings) to a later roadmap item | Removing onboarding guidance for a step the MVBP itself made more manual/unusual |
| One supported path through the flow instead of many configurable options | Silently failing instead of showing a real error message |
| Deferring visual polish (exact colors, animation) — that's Tactic 4/4's territory, not this one | Making the user guess whether a required action is required |

State explicitly, for every scope cut from Step 22 reflected in this design, which side of that
table it falls on. If a founder proposes cutting something on the right column to save time, push
back directly: "That's not trimming scope, that's making the product harder to use — is that
really what you want to ship to a paying customer?"

## Step 4 — Usability checklist (run against every stage from Step 2)

Apply this concrete checklist, not a vague "make it intuitive" instruction:

1. Can a first-time user identify the single next action within a few seconds of arriving at this
   stage, with no explanation from the founder?
2. Is there visible feedback for every action (a confirmation, a state change, a loading
   indicator) — no action that produces silence?
3. Can the user recover from an obvious mistake (wrong input, wrong click) without starting over?
4. Does the language match how the Step 5 beachhead persona actually talks about their problem,
   not internal product jargon?
5. Is the path to the MVBP's core value (Step 8's quantified driver) the shortest, most prominent
   path through the flow — not buried behind secondary features?

Any "no" answer is a named finding in the output file, not a silent gap.

## Business-type design shapes

- **SaaS:** Web-app UI — the core workflow's screens, forms, and states. Prioritize the shortest
  path to first value (activation), since Step 24's SaaS branching already flags weak activation as
  the most common near-term roadmap driver.
- **Physical product:** Industrial/product design of the physical item itself (form, materials,
  ergonomics) plus packaging and unboxing sequence, and any companion digital experience (app,
  instructions, registration) as a separate, explicitly named flow.
- **Marketplace:** Design **both sides separately** — supply-side listing/onboarding flow and
  demand-side discovery/purchase flow are different user flows with different primary actions;
  never wireframe them as one flow with two labels.
- **Services:** A service blueprint, not a screen-based UI — map the client-facing touchpoints
  (intake, kickoff, delivery checkpoints, handoff) the same way Step 1's flow-mapping discipline
  applies, even though nothing here may be software at all.
- **Consumer app:** Mobile-first patterns — design for interruption/short sessions, and treat the
  first-session experience (the first 60 seconds) as its own stage with more design scrutiny than
  any other, since consumer retention curves are won or lost there.
- **Other:** Ask the founder what the actual user-facing touchpoints are before assuming a UI-based
  shape (per `docs/UX-INTERVIEW-DESIGN.md` §4).

## Output file: `tactics/08-design.md`

```markdown
# Tactic 8: Design — Minimum Viable Business Product Design

## Scope source
MVBP offer (Step 22): <what's included/excluded, cited>

## User flow (from Step 6)
| Stage | Primary action | Info needed | Abandonment risk/nudge |
|---|---|---|---|
| ... | ... | ... | ... |

## Per-stage design
### Stage: <name>
- Layout: ...
- Key elements: ...
- Primary action: ...
- Error/edge states: ...
- Fidelity needed: low-fidelity sketch | clickable prototype | process description (manual step)

(repeat per stage)

## Scope-cut discipline
| Item cut from full spec | Acceptable scope cut or usability cut? | Justification |
|---|---|---|
| ... | ... | ... |

## Usability checklist results
1. Next action identifiable in seconds: Yes/No — <note if No>
2. Feedback on every action: Yes/No — <note if No>
3. Mistake recovery without restart: Yes/No — <note if No>
4. Language matches beachhead persona: Yes/No — <note if No>
5. Shortest path to quantified value driver: Yes/No — <note if No>

## Handoff
To Tactic 9 (user testing): <which stages are prototype-ready to test>
To Tactic 10 (engineering): <which stages require real build vs. remain manual/process>
```

## Done means

- Every stage of Step 6's full life-cycle use case has a concrete, per-stage design description —
  not a single vague "design the app" paragraph.
- Every scope cut from Step 22 is classified against the acceptable/unacceptable table and
  justified — no silent usability cuts.
- The usability checklist was actually run and any "No" answer is named as a finding.
- `tactics/08-design.md` written with an explicit handoff to Tactic 9 (what's testable now) and
  Tactic 10 (what needs real engineering vs. stays manual).
- `business-state.json.tactics` was **not** written by this skill — left to the orchestrator.
