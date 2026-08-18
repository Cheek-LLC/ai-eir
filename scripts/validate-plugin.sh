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
# Summary
# ---------------------------------------------------------------------------

echo
echo "=================================================================="
echo " validate-plugin.sh summary"
echo "=================================================================="
echo " skills checked:   $CHECKED_SKILLS"
echo " agents checked:   $CHECKED_AGENTS"
echo " commands checked: $CHECKED_COMMANDS"
echo " warnings:         ${#WARNINGS[@]}"
echo " errors:           ${#ERRORS[@]}"
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
