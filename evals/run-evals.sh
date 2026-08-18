#!/usr/bin/env bash
#
# run-evals.sh — entry point for this plugin's Layer 2 behavioral eval suite.
#
# What this actually does, in order:
#   1. Always runs the deterministic, non-LLM council-aggregation self-check
#      (evals/lib/verify_council_aggregation.py). This needs no `claude plugin eval` access at
#      all and should always pass.
#   2. Always runs the structural validator (evals/lib/validate_cases.py) against every
#      evals/**/case.yaml, checked against the real case.yaml schema this suite was built
#      against (see README.md's "How this schema was obtained" section). This also needs no
#      `claude plugin eval` access.
#   3. Checks whether `claude plugin eval` is actually usable in this environment (it is a real
#      subcommand of the installed CLI, but was gated behind an early-access flag in the
#      environment this suite was built in — see README.md). If it's usable, it hands off to it
#      for the real thing. If not, it says so plainly and stops there — it does NOT fake a result.
#
# This script deliberately does not try to work around an unavailable `claude plugin eval` by
# reimplementing an LLM-judged grading loop itself — see README.md for why.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

pass=0
fail=0

echo "=================================================================="
echo " 1. Deterministic council-aggregation self-check (no LLM required)"
echo "=================================================================="
if python3 "$SCRIPT_DIR/lib/verify_council_aggregation.py"; then
  pass=$((pass + 1))
else
  fail=$((fail + 1))
fi

echo
echo "=================================================================="
echo " 2. Structural validation of evals/**/case.yaml (no LLM required)"
echo "=================================================================="
if python3 "$SCRIPT_DIR/lib/validate_cases.py" "$SCRIPT_DIR"; then
  pass=$((pass + 1))
else
  fail=$((fail + 1))
fi

echo
echo "=================================================================="
echo " 3. claude plugin eval (real behavioral runs — requires LLM calls)"
echo "=================================================================="

if ! command -v claude >/dev/null 2>&1; then
  echo "No 'claude' CLI found on PATH — cannot attempt the real eval runs from here."
  echo "Install/enable Claude Code, then re-run this script, or run the command in the"
  echo "'To run for real' section of evals/README.md yourself."
elif ! claude plugin eval --help >/dev/null 2>&1; then
  echo "'claude plugin eval' is not available on this installation of Claude Code"
  echo "(no such subcommand). See evals/README.md for the schema this suite targets and how to"
  echo "adapt it if your installation's interface differs."
else
  echo "Found 'claude plugin eval'. Attempting a real run against this plugin..."
  echo "(If this prints '\`plugin eval\` is currently in early access', that means the"
  echo " subcommand exists in this build but is feature-flagged off for this account/environment"
  echo " — see evals/README.md's 'Honest status' section. That is not a failure of this suite;"
  echo " it is an environment limitation this suite could not work around.)"
  echo
  set +e
  claude plugin eval "$REPO_ROOT" \
    --scaffold \
    --no-publish \
    --report "$SCRIPT_DIR/results/report.html" \
    --output-dir "$SCRIPT_DIR/results" \
    "$@"
  eval_exit=$?
  set -e
  if [ "$eval_exit" -eq 0 ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    echo
    echo "'claude plugin eval' exited non-zero (code $eval_exit) — see its own output above for"
    echo "which case(s)/grader(s) failed, or whether it declined to run at all (e.g. early access)."
  fi
fi

echo
echo "=================================================================="
echo " Summary: $pass check group(s) passed, $fail did not run cleanly"
echo "=================================================================="

[ "$fail" -eq 0 ]
