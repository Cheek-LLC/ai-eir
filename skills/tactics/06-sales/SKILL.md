---
name: 06-sales
description: >
  Use once assets exist and the business needs to generate and close real early customer demand
  — runs Tactic 6, Early Customer Demand Generation. Broader than outbound alone: frames the
  full demand-generation portfolio (outbound, inbound conversion, warm network, community) and
  tracks it against DE Step 9's next-10-customers target. Its distinct, concrete job is turning
  DE Step 11's competitive position into the actual rebuttal a rep uses against each named
  alternative. Triggers: "generate early demand," "close our first customers," "turn our
  competitive position into sales messaging," "demand-gen plan." Cross-references
  `skills/gtm/outbound-sales-playbook` for outbound mechanics rather than duplicating them.
---

# Tactic 6: Sales — Early Customer Demand Generation

## Role in the 15 tactics

Last of the four Market Testing tactics, and the one where Tactics 3-5's work turns into actual
signed or paying customers. Outbound mechanics — sequences, scripts, DMU-mapped messaging, costed
weekly activity targets — already live in `skills/gtm/outbound-sales-playbook`; this tactic does
not re-derive or duplicate them. Its distinct job is two things: (1) frame demand generation as
a portfolio wider than outbound alone (inbound conversion, warm network, community), and (2) make
concrete a specific, confirmed integration point from `docs/TACTICS-15.md`: DE Step 11's
competitive position directly informs this tactic's sales messaging. That connection is made
here as an actual worked table, not just asserted.

## What you read

- `.startup/<slug>/plan/09-identify-your-next-10-customers.md` — **required**. The concrete
  target this tactic's funnel tracks against.
- `.startup/<slug>/plan/11-chart-your-competitive-position.md` — **required**. Read this file
  itself, in full — the chosen axes, every plotted alternative (including status quo/"do
  nothing"), the product's own plotted position, and the stated defensibility judgment. This is
  the direct input to §1 below, not a file to skim for a one-line pull.
- `.startup/<slug>/plan/12-determine-the-dmu.md` and
  `.startup/<slug>/plan/13-map-the-process-to-acquire-a-paying-customer.md`, if present — for
  what "closed" means and who else needs to be convinced (feeds §3, doesn't re-derive it).
- `.startup/<slug>/gtm/outbound-sales-playbook.md`, if it exists — the actual outbound mechanics
  in force; read its objection-handling bank specifically (see §2).
- `.startup/<slug>/gtm/positioning.md`, if it exists — general messaging register to stay
  consistent with.
- `.startup/<slug>/business-state.json` `gtm.artifacts` — to see what demand-gen assets (landing
  page, ad creative from Tactic 5) already exist and can feed inbound conversion (§4).

If `plan/11-chart-your-competitive-position.md` doesn't exist or isn't at least `drafted`, stop
and say so plainly — this tactic without Step 11 loses its most concrete, named lever, and
producing sales messaging without it would just be generic positioning restated.

## 1. Turn Step 11's chart into actual sales lines — the concrete link

For every alternative plotted in Step 11 (every named competitor, and always the status quo/
"do nothing" option), write the specific rebuttal a rep would say out loud when a prospect brings
that alternative up — grounded in the exact axis where Step 11 plotted this product ahead of it.

Work directly from Step 11's own structure:

1. Pull the two chosen axes and *why* they were chosen (Step 11 ties this to Steps 5/8's
   persona priorities) — restate them here so the sales line is traceable to real research, not
   invented positioning.
2. For each plotted alternative, read where it sits relative to the product on those same two
   axes, and read Step 11's own defensibility judgment for whether that gap is real and durable
   (tied to Step 10's Core) or a temporary/contestable edge.
3. Write the rebuttal as a single, usable sentence a rep can actually say — not a restatement of
   the chart's axis labels. Example shape: if Step 11's axes are "ease of setup" vs. "depth of
   integration" and status quo (spreadsheets) plots easy-but-shallow while the product plots
   easy-and-deep, the line is "you don't have to trade setup time for integration depth the way
   you do with a spreadsheet today" — not "we score higher on both axes."
4. Where Step 11 flagged a position as "estimated — unverified" or only contestable (not clearly
   defensible), the sales line must be honest about that too — don't manufacture false confidence
   a rep will get caught overstating in a live deal.

```markdown
| Alternative (from Step 11) | Axis where we win | Defensibility (from Step 11) | Sales line |
```

## 2. Reconcile with the existing objection-handling bank — don't duplicate it

If `gtm/outbound-sales-playbook.md` exists, check its objection-handling section against the
table in §1. If the playbook's objections don't yet incorporate the Step-11-grounded rebuttal for
a plotted alternative, that's a gap in the playbook to flag back (to whoever owns it — typically
`agents/gtm/sales-lead.md`) for that file to absorb, not a reason to maintain a second, parallel
objection-handling list here. This tactic's table in §1 is the source; the playbook's bank is
where it should actually live for a rep to use day to day.

## 3. The demand-generation portfolio — broader than outbound

State explicitly, for each motion, whether it's active/planned/not applicable for this business
and why — never assume outbound is the whole answer:

- **Outbound** — defer entirely to `skills/gtm/outbound-sales-playbook` for the actual sequence,
  scripts, and targets; this tactic only tracks its results in the funnel below (§5).
- **Inbound conversion** — the real pipeline from Tactic 5's ad-test landing-page signups (and
  any organic traffic to Tactic 4's landing page) through to a closed customer. This is
  frequently under-tracked: a founder celebrates ad clicks or signups without following them
  through to an actual close. State the current conversion rate at each stage if data exists, or
  flag that it isn't being tracked yet if it isn't.
- **Warm network / referral** — has the founder actually worked their own network per any named
  contacts in Step 9, before or alongside colder motions; this is often the fastest real path to
  the first few customers and is worth stating explicitly even when it feels too informal to
  write down.
- **Community / content-led** — coordinate with, don't duplicate, `skills/gtm/content-calendar`'s
  cadence; note only whether a community/content motion is contributing real leads, not the
  calendar itself.
- **Named channel from Step 9** — a marketplace listing, a vertical event, a platform partnership
  the plan specifically called out; track it as its own row if the plan named one.

## 4. Funnel tracker against the Step 9 target

Build a simple funnel table so progress toward the plan's actual next-10-customers goal is
visible, not just activity volume:

```markdown
| Source (motion) | Leads generated | Qualified | In active conversation | Closed/won | Closed/lost |
```

Roll up to a single line: "X of the target 10 customers closed, Y in active conversation, from
[the leading motion by volume]." If one motion is clearly outperforming the others, say so and
recommend shifting effort toward it rather than maintaining even effort across all motions by
default.

## 5. What "closed" means for this business

State explicitly what counts as a close for this specific business — a signed contract, first
payment, or a trial converting to paid — pulling from Step 13/18's process stages if they exist
rather than inventing a new definition. This keeps the funnel's "closed/won" column meaning the
same thing every time it's updated.

## What you write

Write `.startup/<slug>/tactics/06-sales.md`:

```markdown
# Tactic 6: Sales — Early Customer Demand Generation

## Target (from plan step 9)

## Step 11 -> sales messaging
### Chosen axes and why (from Step 11)
### Rebuttal table
| Alternative | Axis where we win | Defensibility | Sales line |

## Reconciliation with gtm/outbound-sales-playbook.md
(gaps flagged, if any)

## Demand-generation portfolio
| Motion | Active/planned/N-A | Why |

## Funnel tracker
| Source | Leads | Qualified | In conversation | Closed/won | Closed/lost |

## What "closed" means for this business

## Done means
```

This skill does not write to `business-state.json` itself — not the `tactics.06_sales` entry.
State plainly in your report to whoever invoked you: the recommended `tactics.06_sales`
status/summary, and any objection-handling gap flagged in §2 for `outbound-sales-playbook.md`'s
owner to absorb. The orchestrator applies the `tactics.06_sales` update to `business-state.json`
after confirming `tactics/06-sales.md` exists and is complete — the same handoff pattern the
Disciplined Entrepreneurship step skills use for their own plan files.

## Done means

- Step 11 was read in full, not skimmed — the rebuttal table names every alternative it plotted,
  including status quo, with a real sales line grounded in the actual axis and defensibility
  judgment, not a generic "we're better."
- Any gap between that table and the existing outbound playbook's objection-handling bank is
  named as a gap for that file to absorb, not silently duplicated here.
- The demand-generation portfolio names every motion this business is actually running or could
  run, not outbound alone.
- The funnel tracker rolls up to a single, honest line against the real Step 9 target.
- "Closed" is defined concretely for this business, tied to Step 13/18 if they exist.
