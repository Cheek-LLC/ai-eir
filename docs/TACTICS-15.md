# The 15 Tactics — canonical list

Source: Paul Cheek, *Disciplined Entrepreneurship: Startup Tactics — 15 Tactics to Turn Your
Business Plan into a Business* (Wiley, 2024), the companion volume to Bill Aulet's *Disciplined
Entrepreneurship: 24 Steps to a Successful Startup*. Confirmed directly against
[startuptactics.net](https://startuptactics.net) and the book's own published material — this
document is the authoritative list every `skills/tactics/NN-slug/SKILL.md` file and every
`business-state.json.tactics` key must match exactly, the same role `docs/DE-24-STEPS.md` plays
for the 24 steps.

**How the two frameworks relate** (per startuptactics.net's own framing, load-bearing for how AI
EIR sequences work): the 24 Steps take a founder from an idea to a complete, rigorous business
plan. The 15 Tactics take that plan and turn it into a real, running business — customers,
product, funding, and a team. They are tightly integrated but do not map one-to-one: specific
steps inform specific tactics (two confirmed, named examples: Step 11's competitive position
informs Tactic 6's sales messaging; Step 19's COCA informs how Tactic 12's financial model is
built). They are meant to be **learned in order but executed iteratively, in harmony** — not
strictly sequentially like the 24 steps.

## Foundations (Tactics 1–2)

| # | Slug | Title | What it covers |
|---|---|---|---|
| 01 | `goals` | **Goals** — Operational Goals and KPIs: Charting the Course to Major Milestones | Setting the operational goals and KPIs that turn the plan's milestones into something trackable week to week. |
| 02 | `systems` | **Systems** — Startup Tooling and Systems | Standing up the tooling/systems backbone (the connectors layer this plugin already models) before scaling execution on top of it. |

## Market Testing (Tactics 3–6)

| # | Slug | Title | What it covers |
|---|---|---|---|
| 03 | `market-research` | **Market Research** — Advanced Primary & Secondary Market Research | Going beyond the plan-stage research (DE Steps 1–5) with deeper primary/secondary research, qualitative first, shifting to quantitative. |
| 04 | `assets` | **Assets** — Developing Startup Visual Assets | Building the visual assets (website, graphics, video) that establish brand identity and are needed before real marketing/sales outreach. |
| 05 | `marketing` | **Marketing** — Proving Persona Assumptions with Digital Advertising | Using targeted digital advertising to test — not assume — that the plan's stated persona (DE Step 5) actually responds the way the plan predicts. |
| 06 | `sales` | **Sales** — Early Customer Demand Generation | Generating and closing early customer demand. Informed directly by DE Step 11 (competitive position), which shapes the sales messaging. |

## Product Development (Tactics 7–10)

| # | Slug | Title | What it covers |
|---|---|---|---|
| 07 | `product-roadmap` | **Product Roadmap** — Building Your Product's Roadmap | Turning the plan's product spec (DE Steps 6–8) into a real, prioritized roadmap once customers exist. |
| 08 | `design` | **Design** — Minimum Viable Business Product Design | Designing the actual MVBP (DE Step 22) for a genuinely usable, intuitive experience, not just a feature list. |
| 09 | `user-testing` | **User Testing** — Validating the Product Actually Works | Getting the product in front of real users before a broad launch, to catch what the plan alone couldn't. |
| 10 | `engineering` | **Engineering** — Transitioning From Product Design to Development | Moving from validated design to real engineering/build — prototyping discipline before full production investment. |

## Resource Acquisition (Tactics 11–15)

| # | Slug | Title | What it covers |
|---|---|---|---|
| 11 | `legal` | **Legal** — Incorporation and Legal Documents for Your Startup | Entity formation, finding legal representation, and the baseline legal documents a real company needs. |
| 12 | `finance` | **Finance** — Path to Greatness: Building the Financial Model and Setting Up the Piggy Bank | Building the real operating financial model and cash management, informed directly by DE Step 19 (COCA). |
| 13 | `pitch-deck-design` | **Pitch Deck Design** — Pitch Decks for Startups | Building the actual investor pitch deck once fundraising is real, not hypothetical. |
| 14 | `fundraising` | **Fundraising** — Executing Your Venture's Fundraising Plan | Running the real fundraising process end to end, not just preparing materials for it. |
| 15 | `hiring` | **Hiring** — Finding and Onboarding Your First Ten Employees | Building the team — sourcing, hiring, and onboarding the first real hires. |

## Conventions for `skills/tactics/NN-slug/SKILL.md` authors

- Follow the identical numbering/slug convention `docs/DE-24-STEPS.md` established for the 24
  steps: two-digit zero-padded number, kebab-case slug, exactly as listed above.
- Each tactic skill is **execution guidance for a founder who already has an approved plan** — it
  is not a redo of the corresponding DE step's planning work, and it should say so explicitly
  where relevant (e.g. Tactic 7's roadmap builds *on* DE Steps 6–8, it doesn't re-derive the
  product spec from scratch).
- Several tactics overlap with skills this plugin already had before the tactics framework was
  added (e.g. Tactic 6/Sales overlaps `skills/gtm/outbound-sales-playbook`; Tactic 12/Finance
  overlaps `skills/ops/runway-and-burn-tracking` and `skills/ops/pricing-and-monetization-
  optimization`; Tactic 15/Hiring overlaps `skills/ops/hiring-and-org-design`). **Cross-reference
  the existing skill by name and defer the mechanics to it rather than duplicating them** — the
  tactic skill's own distinct job is framing the work as this specific, named tactic in Paul
  Cheek's sequence and tracking it in `business-state.json.tactics`, not re-writing content that
  already exists elsewhere in the plugin.
- Do not reproduce the book's own text at length — these are original instructions in this
  plugin's own voice, informed by and citing the tactic's real name/theme, not a transcription of
  copyrighted material.
