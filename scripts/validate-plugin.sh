#!/usr/bin/env bash
#
# validate-plugin.sh — structural drift check for the 30-Minute Startup plugin.
#
# Checks the repo against CONVENTIONS.md without needing any tooling beyond a normal POSIX
# shell (bash, grep, awk, sed, find). Intended to be run locally by any contributor before
# opening a PR, and is a candidate for a CI job later (see docs/ARCHITECTURE-IMPLEMENTATION.md).
#
# Checks performed:
#   1. Every skills/**/SKILL.md has YAML frontmatter with non-empty `name` and `description`.
#   2. Every agents/**/*.md has YAML frontmatter with non-empty `name` and `description`.
#   3. Every commands/**/*.md has a non-empty `description`.
#   4. No two agents/skills (combined) share the same `name`.
#   5. Every `NN-slug` folder under skills/disciplined-entrepreneurship/ matches one of the
#      24 canonical slugs parsed out of docs/DE-24-STEPS.md.
#   6. Every business-state.json top-level field referenced across agents/**/*.md and
#      skills/**/SKILL.md is (heuristically) cross-checked against the top-level keys declared
#      in docs/DATA-CONTRACT.md. WARNING-level only — see the comment at that check's own section
#      below for why this is not promoted to a build-failing error.
#   7. Every agents/council/*.md file's own instructions commit to the CONVENTIONS.md §6 verdict
#      schema headings (Verdict/Score/Reviewer persona/Strengths/Risks/Required revisions).
#      ERROR-level — see the comment at that check's own section below for exactly what this
#      does and does not verify (it is a structural check on the agent's instructions, not proof
#      of the agent's actual output at runtime).
#
# Exit code: 0 if everything passes, 1 if any check fails (usable as a CI gate).

set -u
set -o pipefail

# ---------------------------------------------------------------------------
# Setup
# ---------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${1:-"$(cd "$SCRIPT_DIR/.." && pwd)"}"

SKILLS_DIR="$ROOT/skills"
AGENTS_DIR="$ROOT/agents"
COMMANDS_DIR="$ROOT/commands"
DE_DIR="$SKILLS_DIR/disciplined-entrepreneurship"
DE_STEPS_DOC="$ROOT/docs/DE-24-STEPS.md"

ERRORS=()
WARNINGS=()
CHECKED_SKILLS=0
CHECKED_AGENTS=0
CHECKED_COMMANDS=0

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
NAMES_FILE="$TMP_DIR/names.tsv"   # name<TAB>kind<TAB>path
: > "$NAMES_FILE"

fail() { ERRORS+=("$1"); }
warn() { WARNINGS+=("$1"); }

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# Prints the YAML frontmatter body (lines between the first two `---` markers) of a file
# to stdout. Returns 1 (prints nothing) if the file doesn't open with a `---` frontmatter
# block or never closes one.
extract_frontmatter() {
  local file="$1"
  local first_line
  first_line="$(sed -n '1p' "$file" 2>/dev/null | tr -d '\r')"
  if [ "$first_line" != "---" ]; then
    return 1
  fi
  local close_line
  close_line="$(awk 'NR>1 && $0 ~ /^---[[:space:]]*$/ {print NR; exit}' "$file")"
  if [ -z "$close_line" ]; then
    return 1
  fi
  sed -n "2,$((close_line - 1))p" "$file" | tr -d '\r'
  return 0
}

# has_inline_or_block_value <frontmatter-text> <key>
# True if `key:` appears as a top-level frontmatter line and carries either an inline value
# on the same line, or a block-scalar (`>`/`|`) followed by at least one indented body line.
has_inline_or_block_value() {
  local fm="$1" key="$2"
  local line
  line="$(printf '%s\n' "$fm" | grep -E "^${key}:" | head -n1)"
  [ -z "$line" ] && return 1

  local rest
  rest="$(printf '%s' "$line" | sed -E "s/^${key}:[[:space:]]*//" | sed -E 's/[[:space:]]+$//')"

  case "$rest" in
    "" | ">" | "|" | ">-" | "|-" | ">+" | "|+")
      # block scalar or nothing inline — require at least one non-empty, indented line
      # immediately following the key within the frontmatter block.
      local after first_body
      after="$(printf '%s\n' "$fm" | awk -v k="^${key}:" '$0 ~ k {found=1; next} found')"
      first_body="$(printf '%s\n' "$after" | grep -m1 -E '.')"
      [ -z "$first_body" ] && return 1
      case "$first_body" in
        " "*|$'\t'*) return 0 ;;
        *) return 1 ;;
      esac
      ;;
    *)
      return 0
      ;;
  esac
}

# get_inline_value <frontmatter-text> <key>
# Extracts a single-line value for `key:` (used only for `name`, which is always inline
# per CONVENTIONS.md). Strips surrounding quotes.
get_inline_value() {
  local fm="$1" key="$2"
  printf '%s\n' "$fm" | grep -E "^${key}:" | head -n1 \
    | sed -E "s/^${key}:[[:space:]]*//" \
    | sed -E 's/[[:space:]]+$//' \
    | sed -E "s/^['\"]//; s/['\"]\$//"
}

# ---------------------------------------------------------------------------
# 1. skills/**/SKILL.md — frontmatter must have non-empty name + description
# ---------------------------------------------------------------------------

echo "== Checking skills/**/SKILL.md =="

if [ -d "$SKILLS_DIR" ]; then
  while IFS= read -r skill_file; do
    CHECKED_SKILLS=$((CHECKED_SKILLS + 1))
    rel="${skill_file#"$ROOT"/}"

    if ! fm="$(extract_frontmatter "$skill_file")"; then
      fail "[skill] $rel: no valid '---' YAML frontmatter block found"
      continue
    fi

    if ! has_inline_or_block_value "$fm" "name"; then
      fail "[skill] $rel: frontmatter missing a non-empty 'name'"
    else
      name_val="$(get_inline_value "$fm" "name")"
      printf '%s\t%s\t%s\n' "$name_val" "skill" "$rel" >> "$NAMES_FILE"
    fi

    if ! has_inline_or_block_value "$fm" "description"; then
      fail "[skill] $rel: frontmatter missing a non-empty 'description'"
    fi
  done < <(find "$SKILLS_DIR" -type f -name 'SKILL.md' | sort)
else
  warn "skills/ directory does not exist"
fi

echo "   checked $CHECKED_SKILLS SKILL.md file(s)"

# ---------------------------------------------------------------------------
# 2. agents/**/*.md — frontmatter must have non-empty name + description
# ---------------------------------------------------------------------------

echo "== Checking agents/**/*.md =="

if [ -d "$AGENTS_DIR" ]; then
  while IFS= read -r agent_file; do
    CHECKED_AGENTS=$((CHECKED_AGENTS + 1))
    rel="${agent_file#"$ROOT"/}"

    if ! fm="$(extract_frontmatter "$agent_file")"; then
      fail "[agent] $rel: no valid '---' YAML frontmatter block found"
      continue
    fi

    if ! has_inline_or_block_value "$fm" "name"; then
      fail "[agent] $rel: frontmatter missing a non-empty 'name'"
    else
      name_val="$(get_inline_value "$fm" "name")"
      printf '%s\t%s\t%s\n' "$name_val" "agent" "$rel" >> "$NAMES_FILE"
    fi

    if ! has_inline_or_block_value "$fm" "description"; then
      fail "[agent] $rel: frontmatter missing a non-empty 'description'"
    fi
  done < <(find "$AGENTS_DIR" -type f -name '*.md' | sort)
else
  warn "agents/ directory does not exist"
fi

echo "   checked $CHECKED_AGENTS agent file(s)"

# ---------------------------------------------------------------------------
# 3. commands/**/*.md — frontmatter must have a non-empty description
# ---------------------------------------------------------------------------

echo "== Checking commands/**/*.md =="

if [ -d "$COMMANDS_DIR" ]; then
  while IFS= read -r cmd_file; do
    CHECKED_COMMANDS=$((CHECKED_COMMANDS + 1))
    rel="${cmd_file#"$ROOT"/}"

    if ! fm="$(extract_frontmatter "$cmd_file")"; then
      fail "[command] $rel: no valid '---' YAML frontmatter block found"
      continue
    fi

    if ! has_inline_or_block_value "$fm" "description"; then
      fail "[command] $rel: frontmatter missing a non-empty 'description'"
    fi
  done < <(find "$COMMANDS_DIR" -type f -name '*.md' | sort)
else
  warn "commands/ directory does not exist"
fi

echo "   checked $CHECKED_COMMANDS command file(s)"

# ---------------------------------------------------------------------------
# 4. No two agents/skills share the same `name`
# ---------------------------------------------------------------------------

echo "== Checking for duplicate agent/skill names =="

dupe_names="$(cut -f1 "$NAMES_FILE" | sort | uniq -d)"
if [ -n "$dupe_names" ]; then
  while IFS= read -r dup; do
    [ -z "$dup" ] && continue
    offenders="$(awk -F'\t' -v n="$dup" '$1 == n {printf "%s%s (%s)", sep, $3, $2; sep=", "}' "$NAMES_FILE")"
    fail "[name-collision] name '$dup' is used by more than one agent/skill: $offenders"
  done <<< "$dupe_names"
else
  echo "   no duplicate names found"
fi

# ---------------------------------------------------------------------------
# 5. skills/disciplined-entrepreneurship/NN-slug/ folders must match a canonical slug
# ---------------------------------------------------------------------------

echo "== Checking disciplined-entrepreneurship step slugs against docs/DE-24-STEPS.md =="

if [ ! -f "$DE_STEPS_DOC" ]; then
  fail "[de-steps] $DE_STEPS_DOC not found — cannot validate canonical step slugs"
else
  declare -A CANON_SLUGS
  canon_count=0
  while IFS= read -r slug; do
    [ -z "$slug" ] && continue
    CANON_SLUGS["$slug"]=1
    canon_count=$((canon_count + 1))
  done < <(grep -oE '`[0-9]{2}-[a-z0-9-]+`' "$DE_STEPS_DOC" | tr -d '`' | sort -u)

  if [ "$canon_count" -eq 0 ]; then
    fail "[de-steps] could not parse any canonical NN-slug entries out of docs/DE-24-STEPS.md"
  elif [ "$canon_count" -ne 24 ]; then
    warn "[de-steps] parsed $canon_count canonical slug(s) out of docs/DE-24-STEPS.md, expected 24 — check the doc hasn't drifted from its own format"
  fi

  if [ -d "$DE_DIR" ]; then
    found_count=0
    for entry in "$DE_DIR"/*/; do
      [ -d "$entry" ] || continue
      folder="$(basename "$entry")"
      found_count=$((found_count + 1))
      if [ -z "${CANON_SLUGS[$folder]:-}" ]; then
        fail "[de-steps] skills/disciplined-entrepreneurship/$folder does not match any of the 24 canonical slugs in docs/DE-24-STEPS.md"
      fi
    done
    if [ "$found_count" -eq 0 ]; then
      warn "[de-steps] no step folders found yet under skills/disciplined-entrepreneurship/"
    else
      echo "   checked $found_count step folder(s) against $canon_count canonical slug(s)"
    fi
  else
    warn "skills/disciplined-entrepreneurship/ directory does not exist"
  fi
fi

# ---------------------------------------------------------------------------
# 6. business-state.json field references vs. docs/DATA-CONTRACT.md (heuristic, WARNING-only)
# ---------------------------------------------------------------------------
#
# Goal (docs/ROADMAP.md v0.2 priority 3 / CONVENTIONS.md §5): catch a new business-state.json
# field that got used somewhere in the corpus but never declared in docs/DATA-CONTRACT.md in the
# same change.
#
# This is a heuristic, not a JSON-schema-level check — doing this precisely would mean parsing
# every agent/skill's prose into an actual field-access AST, which is real complexity a bash
# script has no business attempting. Instead it looks for two patterns this repo's own files
# actually use (confirmed by reading real files before writing this check, not assumed):
#   (a) an explicit dotted path with the literal `business-state.json.` prefix
#       (e.g. `business-state.json.cadence.check_in_frequency`), and
#   (b) a backtick-wrapped dotted-path or array token (`` `foo.bar` ``, `` `foo[]` ``) appearing
#       inside a section whose own heading mentions business-state.json — this repo's dominant
#       convention is a `## Update business-state.json` (or `## Update \`business-state.json\``)
#       heading per skill, immediately followed by the fields that skill writes.
# Only the FIRST path segment (the top-level field name) is checked against the top-level keys
# parsed out of docs/DATA-CONTRACT.md's own "## Top-level shape" block — nested shapes are
# explicitly out of scope, per the task's own "top-level key at minimum" bar.
#
# Why WARNING, not ERROR: both patterns above produce real false positives this script cannot
# fully rule out — a bare word backtick-adjacent to a business-state.json heading, a stray
# `e.g.` or version string that happens to contain a dot, a legitimate nested-only field name
# (e.g. `status`) written without its parent prefix in prose. A single false positive turning
# into a hard CI failure would train contributors to silence this check rather than trust it,
# which defeats the point. Promoting this to ERROR would need either a real JSON/markdown parser
# or a much narrower, hand-maintained pattern list — both bigger than this script should take on
# right now. Treat a warning here as "go look", not "go fix blindly".

echo
echo "== Checking business-state.json field references against docs/DATA-CONTRACT.md (heuristic) =="

DATA_CONTRACT_DOC="$ROOT/docs/DATA-CONTRACT.md"
FIELD_CANDIDATES_FILE="$TMP_DIR/field-candidates.tsv"   # topkey<TAB>path
: > "$FIELD_CANDIDATES_FILE"

if [ ! -f "$DATA_CONTRACT_DOC" ]; then
  warn "[data-contract] $DATA_CONTRACT_DOC not found — cannot cross-check business-state.json field references"
else
  # Top-level keys sit at exactly 2-space indentation inside the outer `{ }` of the canonical
  # "## Top-level shape" fenced ```json block; nested keys sit at 4+ spaces. Anchoring on exactly
  # two leading spaces before the opening quote separates the two without a real JSON parser.
  documented_keys_raw="$(awk '
    /^## Top-level shape/ { seen_heading=1 }
    seen_heading && /^```json/ && !injson { injson=1; next }
    injson && /^```/ { exit }
    injson
  ' "$DATA_CONTRACT_DOC" | grep -oE '^  "[A-Za-z_][A-Za-z0-9_]*":' | tr -d ' ":')"

  declare -A DOCUMENTED_KEYS
  doc_key_count=0
  while IFS= read -r k; do
    [ -z "$k" ] && continue
    DOCUMENTED_KEYS["$k"]=1
    doc_key_count=$((doc_key_count + 1))
  done <<< "$documented_keys_raw"

  if [ "$doc_key_count" -eq 0 ]; then
    warn "[data-contract] could not parse any top-level keys out of docs/DATA-CONTRACT.md's '## Top-level shape' block — skipping the field cross-check this run"
  else
    while IFS= read -r target_file; do
      [ -f "$target_file" ] || continue
      rel="${target_file#"$ROOT"/}"

      # (a) explicit "business-state.json.X..." references anywhere in the file.
      while IFS= read -r topkey; do
        [ -z "$topkey" ] && continue
        [ "${#topkey}" -lt 3 ] && continue
        printf '%s\t%s\n' "$topkey" "$rel" >> "$FIELD_CANDIDATES_FILE"
      done < <(grep -oE 'business-state\.json\.[A-Za-z_][A-Za-z0-9_]*' "$target_file" 2>/dev/null \
                 | sed -E 's/^business-state\.json\.//')

      # (b) backtick-wrapped dotted-path/array tokens inside a "...business-state.json..."
      # heading's own section (from that heading up to the next heading of any level).
      section_text="$(awk '
        /^#+.*business-state\.json/ { insection=1; next }
        /^#+/ { insection=0 }
        insection
      ' "$target_file" 2>/dev/null)"

      while IFS= read -r topkey; do
        [ -z "$topkey" ] && continue
        [ "${#topkey}" -lt 3 ] && continue
        printf '%s\t%s\n' "$topkey" "$rel" >> "$FIELD_CANDIDATES_FILE"
      done < <(printf '%s\n' "$section_text" \
                 | grep -oE '`[a-z_][a-z0-9_]*(\.[A-Za-z0-9_]+|\[\])' \
                 | tr -d '`' \
                 | sed -E 's/(\[\])?(\..*)?$//')
    done < <(find "$AGENTS_DIR" -type f -name '*.md' 2>/dev/null; find "$SKILLS_DIR" -type f -name 'SKILL.md' 2>/dev/null)

    if [ -s "$FIELD_CANDIDATES_FILE" ]; then
      undoc_keys="$(cut -f1 "$FIELD_CANDIDATES_FILE" | sort -u)"
      undoc_count=0
      while IFS= read -r topkey; do
        [ -z "$topkey" ] && continue
        if [ -z "${DOCUMENTED_KEYS[$topkey]:-}" ]; then
          offenders="$(awk -F'\t' -v k="$topkey" '$1 == k {print $2}' "$FIELD_CANDIDATES_FILE" | sort -u | paste -sd', ' -)"
          warn "[business-state-field] '$topkey' is referenced as a business-state.json top-level field in: $offenders — not found among the top-level keys declared in docs/DATA-CONTRACT.md's '## Top-level shape' block. If this is a real new field, declare it there in the same change (CONVENTIONS.md §5); if it's a false positive from this heuristic (see comment above), no action needed."
          undoc_count=$((undoc_count + 1))
        fi
      done <<< "$undoc_keys"
      if [ "$undoc_count" -eq 0 ]; then
        echo "   every referenced business-state.json top-level field matches docs/DATA-CONTRACT.md ($doc_key_count documented top-level key(s))"
      else
        echo "   $undoc_count possibly-undocumented top-level field name(s) found — see warnings below (non-fatal; heuristic, not a proof — see script comment)"
      fi
    else
      echo "   no business-state.json field references found to check"
    fi
  fi
fi

# ---------------------------------------------------------------------------
# 7. agents/council/*.md — commitment to the CONVENTIONS.md §6 verdict schema
# ---------------------------------------------------------------------------
#
# What this check CAN verify: that each council agent's own instructions actually spell out the
# CONVENTIONS.md §6 schema's required markers as the shape its persona must return — the exact
# same "## Output format — exactly this shape (CONVENTIONS.md §6)" fenced example every existing
# agents/council/*.md file uses today (confirmed by reading real council files before writing
# this check, not assumed from the schema's prose description). Concretely, per file:
#   - a `## Verdict:` heading line that names all four verdict values
#     (APPROVE / APPROVE_WITH_NOTES / REVISE / REJECT), not just the word "Verdict"
#   - a `**Score:**` line
#   - a `**Reviewer persona:**` line
#   - a `### Strengths` heading
#   - a `### Risks` heading (CONVENTIONS.md §6 writes it as "### Risks / gaps"; the suffix is
#     allowed to vary, the "Risks" heading itself is not optional)
#   - a `### Required revisions` heading
#
# What this check CANNOT verify: whether a council agent's ACTUAL output, the day it actually
# runs, uses this shape correctly, scores honestly, or fills in real content rather than
# boilerplate. That requires executing the agent and inspecting a real response — this script
# never invokes Claude and never will; that's docs/TESTING.md Layer 2 (behavioral eval), owned by
# `claude plugin eval` / skill-doctor, explicitly out of this script's scope. A file can pass this
# check and still misbehave at runtime, and a file failing this check is a real, fixable defect in
# the agent's own instructions, not a false positive — that asymmetry is why this check IS
# error-level (unlike check 6 above): it greps for literal text the file's author controls
# directly, not a fuzzy inference about intent.

echo
echo "== Checking agents/council/*.md commit to the CONVENTIONS.md §6 verdict schema =="

COUNCIL_DIR="$AGENTS_DIR/council"
CHECKED_COUNCIL=0

if [ -d "$COUNCIL_DIR" ]; then
  while IFS= read -r council_file; do
    CHECKED_COUNCIL=$((CHECKED_COUNCIL + 1))
    rel="${council_file#"$ROOT"/}"
    missing=()

    verdict_line="$(grep -E '^##[[:space:]]*Verdict:' "$council_file" | head -n1)"
    if [ -z "$verdict_line" ]; then
      missing+=("a '## Verdict:' heading")
    else
      for token in APPROVE APPROVE_WITH_NOTES REVISE REJECT; do
        case "$verdict_line" in
          *"$token"*) : ;;
          *) missing+=("the '$token' option on its '## Verdict:' line") ;;
        esac
      done
    fi

    grep -qE '\*\*Score:\*\*' "$council_file" || missing+=("a '**Score:**' line")
    grep -qE '\*\*Reviewer persona:\*\*' "$council_file" || missing+=("a '**Reviewer persona:**' line")
    grep -qE '^###[[:space:]]*Strengths' "$council_file" || missing+=("a '### Strengths' heading")
    grep -qE '^###[[:space:]]*Risks' "$council_file" || missing+=("a '### Risks' heading")
    grep -qE '^###[[:space:]]*Required revisions' "$council_file" || missing+=("a '### Required revisions' heading")

    if [ "${#missing[@]}" -gt 0 ]; then
      joined="$(printf '%s; ' "${missing[@]}")"
      fail "[council-verdict-schema] $rel: does not commit to the CONVENTIONS.md §6 verdict schema in its own instructions — missing: ${joined%; }"
    fi
  done < <(find "$COUNCIL_DIR" -type f -name '*.md' | sort)

  if [ "$CHECKED_COUNCIL" -eq 0 ]; then
    warn "[council-verdict-schema] no agents/council/*.md files found to check"
  else
    echo "   checked $CHECKED_COUNCIL council agent file(s) for §6 schema commitment (structural check on instructions only — see comment above this check)"
  fi
else
  warn "agents/council/ directory does not exist"
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------

echo
echo "=================================================================="
echo " validate-plugin.sh summary"
echo "=================================================================="
echo " skills checked:          $CHECKED_SKILLS"
echo " agents checked:          $CHECKED_AGENTS"
echo " commands checked:        $CHECKED_COMMANDS"
echo " council files checked:   $CHECKED_COUNCIL"
echo " warnings:                ${#WARNINGS[@]}"
echo " errors:                  ${#ERRORS[@]}"
echo

if [ "${#WARNINGS[@]}" -gt 0 ]; then
  echo "Warnings (non-blocking):"
  for w in "${WARNINGS[@]}"; do
    echo "  - $w"
  done
  echo
fi

if [ "${#ERRORS[@]}" -gt 0 ]; then
  echo "FAIL — ${#ERRORS[@]} error(s):"
  for e in "${ERRORS[@]}"; do
    echo "  - $e"
  done
  exit 1
fi

echo "PASS — no structural drift from CONVENTIONS.md detected."
exit 0
</content>
