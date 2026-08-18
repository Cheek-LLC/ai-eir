#!/usr/bin/env python3
"""
validate_cases.py — structural validator for evals/**/case.yaml, checked against the real
`claude plugin eval` case.yaml schema as extracted from this environment's installed Claude Code
binary (v2.1.234) on 2026-08-18. See evals/README.md's "How this schema was obtained" section for
exactly how this was extracted and the honesty caveats around it (schemas can change between
Claude Code versions; this is not a substitute for the CLI's own validation).

This script does NOT invoke Claude and does NOT require the `claude plugin eval` early-access
feature to be enabled — it only checks that our own case.yaml files are well-formed against the
schema, so a structural mistake is caught immediately without spending any eval run at all.

Usage: python3 evals/lib/validate_cases.py [evals-dir]
Exit code: 0 if every case.yaml validates; 1 if any fails.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

try:
    import yaml
except ImportError:
    print("PyYAML is required (pip install pyyaml) — falling back is not implemented, since a "
          "hand-rolled YAML parser would itself be a source of false confidence here.",
          file=sys.stderr)
    sys.exit(2)

TOP_LEVEL_KEYS = {
    "schema_version", "name", "description", "tags", "plugins", "context", "execution", "runs",
    "graders", "expected_outcome",
}
CONTEXT_KEYS = {"scaffold_script", "history_file", "add_dirs"}
EXECUTION_KEYS = {
    "prompt", "max_turns", "timeout_seconds", "model", "allowed_tools", "artifact_publish",
    "growthbook_overrides", "append_system_prompt", "env",
}
GRADER_COMMON_KEYS = {"type", "name", "weight", "arm"}
GRADER_TYPE_KEYS = {
    "regex": {"target", "pattern", "flags", "match"},
    "tool_order": {"before", "after"},
    "tool_used": {"tool", "input_match", "min", "max"},
    "file_exists": {"path", "exists"},
    "llm": {"criteria", "focus"},
    "baseline": {"baseline_file", "criteria"},
}
GRADER_REQUIRED = {
    "regex": {"pattern"},
    "tool_order": {"before", "after"},
    "tool_used": {"tool"},
    "file_exists": {"path"},
    "llm": {"criteria"},
    "baseline": {"baseline_file", "criteria"},
}
VALID_ARMS = {"with-only", "both"}
VALID_TARGETS = {"trace", "last_message", "files"}
VALID_MATCH_ENUM = {"contains", "not_contains"}
COUNT_MATCH_RE = re.compile(r"^count:\d+$")
FLAGS_RE = re.compile(r"^[dgimsuvy]*$")


def err(path: Path, msg: str) -> str:
    return f"{path}: {msg}"


def check_target_or_focus(path: Path, value, field_name: str, errors: list[str]) -> None:
    if isinstance(value, str):
        if value not in VALID_TARGETS:
            errors.append(err(path, f"{field_name}: '{value}' is not one of {sorted(VALID_TARGETS)}"))
    elif isinstance(value, dict):
        if value.get("source") != "file":
            errors.append(err(path, f"{field_name}: object form must have source: file"))
        if "path" not in value or not isinstance(value.get("path"), str):
            errors.append(err(path, f"{field_name}: object form requires a string 'path'"))
        extra = set(value.keys()) - {"source", "path"}
        if extra:
            errors.append(err(path, f"{field_name}: unexpected keys {sorted(extra)}"))
    else:
        errors.append(err(path, f"{field_name}: must be a string enum or a {{source: file, path}} object"))


def check_tool_spec(path: Path, value, field_name: str, errors: list[str]) -> None:
    if isinstance(value, str):
        return
    if isinstance(value, dict):
        if "tool" not in value or not isinstance(value["tool"], str):
            errors.append(err(path, f"{field_name}: object form requires a string 'tool'"))
        extra = set(value.keys()) - {"tool", "input_match"}
        if extra:
            errors.append(err(path, f"{field_name}: unexpected keys {sorted(extra)}"))
        return
    errors.append(err(path, f"{field_name}: must be a string (tool name) or {{tool, input_match?}}"))


def validate_grader(path: Path, g: dict, errors: list[str], seen_names: set[str]) -> None:
    if "type" not in g:
        errors.append(err(path, "grader missing required 'type'"))
        return
    t = g["type"]
    if t not in GRADER_TYPE_KEYS:
        errors.append(err(path, f"grader type '{t}' is not one of {sorted(GRADER_TYPE_KEYS)}"))
        return
    if "name" not in g or not isinstance(g["name"], str) or not g["name"]:
        errors.append(err(path, f"grader (type {t}) missing required non-empty 'name'"))
    else:
        if g["name"] in seen_names:
            errors.append(err(path, f"duplicate grader name '{g['name']}'"))
        seen_names.add(g["name"])

    allowed = GRADER_COMMON_KEYS | GRADER_TYPE_KEYS[t]
    extra = set(g.keys()) - allowed
    if extra:
        errors.append(err(path, f"grader '{g.get('name', '?')}' (type {t}) has keys not valid for "
                                 f"this type (schema is .strict()): {sorted(extra)}"))

    missing = GRADER_REQUIRED[t] - set(g.keys())
    if missing:
        errors.append(err(path, f"grader '{g.get('name', '?')}' (type {t}) missing required "
                                 f"field(s): {sorted(missing)}"))

    if "weight" in g and not (isinstance(g["weight"], (int, float)) and g["weight"] > 0):
        errors.append(err(path, f"grader '{g.get('name', '?')}': weight must be a positive number"))
    if "arm" in g and g["arm"] not in VALID_ARMS:
        errors.append(err(path, f"grader '{g.get('name', '?')}': arm must be one of {sorted(VALID_ARMS)}"))

    if t == "regex":
        if "target" in g:
            check_target_or_focus(path, g["target"], f"grader '{g['name']}'.target", errors)
        if "flags" in g and not FLAGS_RE.match(g["flags"]):
            errors.append(err(path, f"grader '{g['name']}': flags must match JS RegExp flags [dgimsuvy]*"))
        if "match" in g:
            m = g["match"]
            if not (m in VALID_MATCH_ENUM or COUNT_MATCH_RE.match(str(m))):
                errors.append(err(path, f"grader '{g['name']}': match must be 'contains', "
                                         f"'not_contains', or 'count:N'"))
    elif t == "tool_order":
        check_tool_spec(path, g.get("before"), f"grader '{g['name']}'.before", errors)
        check_tool_spec(path, g.get("after"), f"grader '{g['name']}'.after", errors)
    elif t == "llm":
        if "focus" in g:
            check_target_or_focus(path, g["focus"], f"grader '{g['name']}'.focus", errors)


def validate_case(path: Path) -> list[str]:
    errors: list[str] = []
    try:
        raw = path.read_text()
    except OSError as e:
        return [err(path, f"could not read file: {e}")]

    try:
        data = yaml.safe_load(raw)
    except yaml.YAMLError as e:
        return [err(path, f"YAML parse failed: {e}")]

    if not isinstance(data, dict):
        return [err(path, "case.yaml must be a YAML object")]

    sv = data.get("schema_version")
    if not isinstance(sv, str):
        errors.append(err(path, 'missing required field schema_version (e.g. "1.0")'))
    else:
        major = sv.split(".")[0]
        if not major.isdigit():
            errors.append(err(path, f"schema_version '{sv}' is not a valid version string"))

    if "name" not in data or not isinstance(data["name"], str) or not data["name"]:
        errors.append(err(path, "missing required non-empty 'name'"))

    extra_top = set(data.keys()) - TOP_LEVEL_KEYS
    if extra_top:
        errors.append(err(path, f"unexpected top-level keys (not in schema): {sorted(extra_top)}"))

    context = data.get("context", {}) or {}
    if not isinstance(context, dict):
        errors.append(err(path, "'context' must be an object"))
    else:
        extra_ctx = set(context.keys()) - CONTEXT_KEYS
        if extra_ctx:
            errors.append(err(path, f"unexpected 'context' keys: {sorted(extra_ctx)}"))

    execution = data.get("execution", {}) or {}
    if not isinstance(execution, dict):
        errors.append(err(path, "'execution' must be an object"))
    else:
        extra_exec = set(execution.keys()) - EXECUTION_KEYS
        if extra_exec:
            errors.append(err(path, f"unexpected 'execution' keys: {sorted(extra_exec)}"))

    has_prompt = bool(execution.get("prompt"))
    has_history = bool(context.get("history_file"))
    if not has_prompt and not has_history:
        errors.append(err(path, "either execution.prompt or context.history_file is required"))

    if "runs" in data:
        r = data["runs"]
        if not (isinstance(r, int) and 1 <= r <= 50):
            errors.append(err(path, "'runs' must be an integer between 1 and 50"))

    graders = data.get("graders")
    if not isinstance(graders, list) or len(graders) == 0:
        errors.append(err(path, "'graders' must be a non-empty array"))
    else:
        seen_names: set[str] = set()
        for g in graders:
            if not isinstance(g, dict):
                errors.append(err(path, "each grader must be an object"))
                continue
            validate_grader(path, g, errors, seen_names)

    # Referenced local files (scaffold_script, baseline_file) should actually exist.
    case_dir = path.parent
    scaffold = context.get("scaffold_script") if isinstance(context, dict) else None
    if scaffold and not (case_dir / scaffold).exists():
        errors.append(err(path, f"context.scaffold_script '{scaffold}' does not exist in {case_dir}"))
    if isinstance(graders, list):
        for g in graders:
            if isinstance(g, dict) and g.get("type") == "baseline":
                bf = g.get("baseline_file")
                if bf and not (case_dir / bf).exists():
                    errors.append(err(path, f"grader '{g.get('name')}': baseline_file '{bf}' does "
                                             f"not exist in {case_dir}"))

    return errors


def main() -> int:
    evals_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parent.parent
    case_files = sorted(evals_dir.glob("**/case.yaml"))
    if not case_files:
        print(f"No case.yaml files found under {evals_dir}")
        return 1

    total_errors = 0
    for cf in case_files:
        errors = validate_case(cf)
        rel = cf.relative_to(evals_dir.parent) if evals_dir.is_absolute() else cf
        if errors:
            print(f"[FAIL] {rel}")
            for e in errors:
                print(f"        - {e}")
            total_errors += len(errors)
        else:
            print(f"[PASS] {rel}")

    print()
    if total_errors:
        print(f"FAIL — {total_errors} schema issue(s) found across {len(case_files)} case.yaml file(s).")
        return 1
    print(f"PASS — all {len(case_files)} case.yaml file(s) are structurally valid against the "
          f"extracted schema.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
