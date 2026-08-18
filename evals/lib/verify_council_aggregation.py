#!/usr/bin/env python3
"""
verify_council_aggregation.py — deterministic, non-LLM reference implementation of the
"harshest non-outlier" aggregate-verdict rule specified in
skills/business-plan/run-review-council/SKILL.md §6, checked against that SKILL.md's own two
hand-verified worked examples (the Track B worked example, and the Track A floor-rule example).

Why this exists: docs/TESTING.md Layer 2 is about behavioral eval of agents/skills that require a
live model turn. The council aggregation *rule itself*, though, is a precise deterministic
algorithm stated in prose in the SKILL.md — precise enough to encode directly and check for
internal self-consistency without spending an LLM call at all. This script is that check. It is
useful two ways:

  1. On its own: run it (`python3 evals/lib/verify_council_aggregation.py`) any time
     run-review-council/SKILL.md's §6 prose changes, to confirm a rewrite of the algorithm's
     wording still produces the same answers on its own worked examples — a cheap regression guard
     against the algorithm silently changing meaning during an edit.
  2. As the oracle behind evals/02-council-verdict-aggregation/case.yaml: that case asks a live
     agent to apply the same rule to the same Track B scenario and checks the agent's answer
     against the same expected result this script asserts.

This script does NOT invoke Claude, does NOT require network access, and has no dependencies
beyond the Python 3 standard library. Exit code 0 = both worked examples reproduced correctly;
non-zero = a mismatch (see stderr for which one and how).
"""

from __future__ import annotations

import sys
from dataclasses import dataclass, field

SEVERITY = {"REJECT": 4, "REVISE": 3, "APPROVE_WITH_NOTES": 2, "APPROVE": 1}


@dataclass
class Verdict:
    name: str
    verdict: str
    score: int
    tags: frozenset[str] = field(default_factory=frozenset)


@dataclass
class AggregationResult:
    verdict: str
    score: int
    discarded: list[str]
    floor_rule_invoked: bool


def aggregate(blocking_set: list[Verdict]) -> AggregationResult:
    """Implements SKILL.md §6 Steps A-D exactly (Step A — track weighting — is assumed already
    applied by the caller; this function receives the blocking set as-is)."""
    if not blocking_set:
        raise ValueError("blocking set must not be empty")

    original = list(blocking_set)  # fixed comparison set, per §6's explicit instruction
    remaining = list(blocking_set)
    discarded: list[str] = []
    floor_rule_invoked = False

    while True:
        harshest = max(SEVERITY[v.verdict] for v in remaining)
        at_harshest = [v for v in remaining if SEVERITY[v.verdict] == harshest]

        if len(at_harshest) != 1:
            # Test 1 fails for every verdict at this severity: not alone. Stop — this severity
            # is the aggregate.
            break

        candidate = at_harshest[0]

        # Test 2: tag overlap against every OTHER verdict in the ORIGINAL blocking set, including
        # already-discarded ones — never just the remaining set.
        others = [v for v in original if v is not candidate]
        tag_overlap = any(candidate.tags & o.tags for o in others)
        if tag_overlap:
            break  # not discardable — current harshest severity stands

        # Test 3 (floor rule): discarding must leave at least one verdict still under
        # consideration.
        if len(remaining) - 1 < 1:
            floor_rule_invoked = True
            break  # cannot discard the last verdict standing

        # Passes all three tests — discard and recompute.
        discarded.append(candidate.name)
        remaining = [v for v in remaining if v is not candidate]

    final_severity = harshest
    at_final = [v for v in remaining if SEVERITY[v.verdict] == final_severity]
    agg_score = min(v.score for v in at_final)
    agg_verdict = next(k for k, val in SEVERITY.items() if val == final_severity)
    return AggregationResult(agg_verdict, agg_score, discarded, floor_rule_invoked)


# ---------------------------------------------------------------------------------------------
# Fixture 1 — the Track B "Worked example" from SKILL.md §6 (verbatim scenario; scores are this
# script's own reasonable construction, since the SKILL.md prose worked example names verdicts,
# reviewers, and tags precisely but does not print literal numeric scores for each seat).
# ---------------------------------------------------------------------------------------------

TRACK_B_WORKED_EXAMPLE = [
    Verdict("vc-panel", "REJECT", 2, frozenset({"VENTURE-FIT"})),
    Verdict("customer-discovery-skeptic", "REVISE", 4, frozenset({"EVIDENCE-GAP"})),
    Verdict("expert-entrepreneur-panel", "APPROVE_WITH_NOTES", 7, frozenset({"EXECUTION-RISK"})),
    Verdict("financial-modeling-reviewer", "APPROVE_WITH_NOTES", 6, frozenset({"UNIT-ECONOMICS"})),
    Verdict("competitive-strategy-reviewer", "APPROVE", 9, frozenset()),
]

EXPECTED_TRACK_B = AggregationResult(
    verdict="APPROVE_WITH_NOTES",
    score=6,  # lower of the two APPROVE_WITH_NOTES scores (6 and 7)
    discarded=["vc-panel", "customer-discovery-skeptic"],
    floor_rule_invoked=False,
)

# ---------------------------------------------------------------------------------------------
# Fixture 2 — the Track A "Floor-rule example" from SKILL.md §6 (verbatim scenario; again, scores
# are this script's own reasonable construction consistent with the stated verdicts).
# ---------------------------------------------------------------------------------------------

TRACK_A_FLOOR_RULE_EXAMPLE = [
    Verdict("customer-discovery-skeptic", "REJECT", 2, frozenset({"EVIDENCE-GAP"})),
    Verdict("financial-modeling-reviewer", "REVISE", 4, frozenset({"FINANCIAL-ARITHMETIC"})),
    Verdict("expert-entrepreneur-panel", "APPROVE_WITH_NOTES", 6, frozenset({"EXECUTION-RISK"})),
    Verdict("contextual-seat", "APPROVE", 8, frozenset()),
]

EXPECTED_TRACK_A = AggregationResult(
    verdict="APPROVE",
    score=8,
    discarded=["customer-discovery-skeptic", "financial-modeling-reviewer", "expert-entrepreneur-panel"],
    floor_rule_invoked=True,
)


def _check(label: str, scenario: list[Verdict], expected: AggregationResult) -> bool:
    actual = aggregate(scenario)
    ok = (
        actual.verdict == expected.verdict
        and actual.score == expected.score
        and actual.discarded == expected.discarded
        and actual.floor_rule_invoked == expected.floor_rule_invoked
    )
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {label}")
    print(f"         expected: verdict={expected.verdict} score={expected.score} "
          f"discarded={expected.discarded} floor_rule_invoked={expected.floor_rule_invoked}")
    print(f"         actual:   verdict={actual.verdict} score={actual.score} "
          f"discarded={actual.discarded} floor_rule_invoked={actual.floor_rule_invoked}")
    return ok


def main() -> int:
    print("verify_council_aggregation.py — checking the §6 algorithm against its own worked examples\n")
    ok1 = _check(
        "Track B worked example (SKILL.md §6, 'Worked example')",
        TRACK_B_WORKED_EXAMPLE,
        EXPECTED_TRACK_B,
    )
    print()
    ok2 = _check(
        "Track A floor-rule example (SKILL.md §6, 'Floor-rule example')",
        TRACK_A_FLOOR_RULE_EXAMPLE,
        EXPECTED_TRACK_A,
    )
    print()
    if ok1 and ok2:
        print("PASS — the harshest-non-outlier algorithm reproduces both documented worked examples.")
        return 0
    print("FAIL — the algorithm as encoded here does not reproduce one or both worked examples. "
          "Either this script has a bug, or SKILL.md §6's prose has drifted from its own worked "
          "examples — read both closely before trusting either.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
