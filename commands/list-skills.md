---
description: Walk the plugin's actual directories and print a categorized summary of every skill, agent, and command currently available.
---

The user wants a full picture of the plugin's current capability surface — every skill, agent,
and command that actually exists on disk right now, not a remembered or hardcoded list.

Arguments given (may be empty): `$ARGUMENTS` — if non-empty, treat it as a filter (a category
name like `gtm` or a keyword to match against names/descriptions); if empty, list everything.

This plugin is built by many parallel contributors and grows continuously, so **never answer this
from memory or from anything resembling a fixed list you recall from a previous run**. Re-walk the
directories every time, in this session, before responding.

## 1. Discover the files

- Skills: every `skills/**/SKILL.md` in the plugin, at any depth (most categories are
  `skills/<category>/<skill-slug>/SKILL.md`; `disciplined-entrepreneurship` is one level deeper —
  `skills/disciplined-entrepreneurship/NN-slug/SKILL.md`).
- Agents: every `agents/**/*.md` in the plugin, at any depth. Some agent files live directly under
  `agents/` (e.g. the orchestrator); others live under a category subfolder (e.g.
  `agents/council/`, `agents/gtm/`).
- Commands: every `commands/*.md` in the plugin (this file included — list it too).

Use your file tools to actually enumerate the directory trees now. Do not assume any category
folder exists or is empty — some categories named below may have zero entries today (this repo is
mid-build) and some may not exist as a folder yet at all; both are fine to report as "none yet,"
not an error.

## 2. Parse each file

For each file found, read its YAML frontmatter (the block between the first two `---` lines):

- Skills and agents: pull `name` and the first sentence (or first ~25 words) of `description`.
- Commands: pull the `description` (commands have no `name` field per CONVENTIONS.md §4 — use the
  filename, e.g. `list-skills`, as its identifier).

If a file's frontmatter is missing entirely, malformed, or missing a required key, don't silently
skip it — list it under a **Drift / needs attention** section instead of dropping it, and mention
that `scripts/validate-plugin.sh` is the authoritative check for this class of problem and should
be run for the full picture.

## 3. Categorize

Group skills and agents by their top-level folder under `skills/` and `agents/` respectively:
`disciplined-entrepreneurship`, `business-plan`, `gtm`, `ops`, `risk`, `qa`, `connectors`,
`design`, `interview` (skills), and the equivalent category subfolders under `agents/` (e.g.
`council`, `gtm`, `ops`, `risk`, `qa`, `connectors`). Agent files that live directly under
`agents/` with no subfolder (like the orchestrator) form their own "core agents" group. Within
`disciplined-entrepreneurship`, sort entries numerically by their `NN-` prefix, not alphabetically
(so `02-...` sorts before `10-...`).

If `$ARGUMENTS` was given as a filter, apply it now — restrict to the matching category or to
entries whose name/description contains the keyword (case-insensitive) — and say plainly that
you're showing a filtered view and how to see everything (`/list-skills` with no arguments).

## 4. Present the summary

Produce a clear, scannable categorized report:

- A one-line total at the top: counts of skills, agents, and commands found.
- One section per category (skills, then agents, then commands), each with its subcategory
  groups as sub-headers, each entry as `**name** — description` (or `NN-slug` for DE steps).
- Explicitly call out empty categories that are part of the plugin's designed shape but have no
  entries yet (per CONVENTIONS.md's directory layout) — a founder or maintainer should be able to
  tell "not built yet" apart from "doesn't exist in the design."
- A closing **Drift / needs attention** section for any parsing failures from step 2 (omit this
  section entirely if there were none — don't print an empty header).

Keep it to the data — no marketing language, no padding about how impressive the count is.
</content>
