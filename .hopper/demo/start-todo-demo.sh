#!/usr/bin/env bash
#
# llm-hopper Todo App demo launcher.
#
# Pure prompt-only helper. Prints the next files to read and the exact
# prompt to paste into a fresh model session. Implements the Todo demo
# contract from TRD.md::todo-demo-contract.
#
# This script does NOT:
#   - install packages or run package managers
#   - call APIs or remote services
#   - start daemons, workers, or schedulers
#   - generate runtime application code
#   - read or write any project file
#
# It only echoes static text and resolves paths from the script location.

set -euo pipefail

# Resolve the repository root from the script location so the helper works
# regardless of the user's current working directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

print_section() {
    printf '\n=== %s ===\n' "$1"
}

print_files() {
    local file
    for file in "$@"; do
        printf -- '  - %s\n' "${file}"
    done
}

print_constraints() {
    cat <<'CONSTRAINTS'
Constraints applied to every step:
  - Prompt-only, zero-code bootstrap.
  - No package installs, API calls, daemons, browser automation, or runtime code.
  - Modify only the file named in the step prompt.
  - Use stable anchors of the form: Anchor: `FILE.md::section-name`.
  - End the session with the exact handoff block from TRD.md::handoff-block-schema.
CONSTRAINTS
}

usage() {
    cat <<'USAGE'
Usage: ./.hopper/demo/start-todo-demo.sh [phase]

Phases:
  (no arg)     Print intro, step list, and reference files.
  strategy     Print step 1 (strategy session) setup, files, and prompt.
  planning     Print step 2 (planning session) setup, files, and prompt.
  execution    Print step 3 (execution session) setup, files, and prompt.
  review       Print step 4 (review session) setup, files, and prompt.
  list         Print the reference file list and exit.
  -h, --help   Print this message and exit.

This helper is read-only. It prints text and never modifies any file.
USAGE
}

print_intro() {
    print_section "LLM-Hopper Todo App Demo"
    cat <<'INTRO'
This helper does not install software, call APIs, generate code, or start daemons.
It only prints the files to read and the prompt to paste into a model session.

The demo walks a hypothetical single-user Todo app (add, complete, list) through
four model sessions: strategy, planning, execution, and review. Each session
writes only its own bounded artifact, then ends with a handoff block.
INTRO

    print_section "Steps"
    cat <<'STEPS'
  1. strategy   - Open a strategy-class model and produce demo/PRODUCT.md.
  2. planning   - Open a planning-class model and produce demo/PLAN.md.
  3. execution  - Open an execution-class model and produce demo/EXECUTION.md.
  4. review     - Open a review-class model and produce demo/REVIEW.md.
STEPS

    print_section "Reference files"
    print_files \
        "${REPO_ROOT}/PROJECT.md" \
        "${REPO_ROOT}/PRD.md" \
        "${REPO_ROOT}/DECISIONS.md" \
        "${REPO_ROOT}/TRD.md" \
        "${REPO_ROOT}/ROADMAP.md" \
        "${REPO_ROOT}/.hopper/MANIFEST.md" \
        "${REPO_ROOT}/.hopper/demo/TODO-APP.md" \
        "${REPO_ROOT}/.hopper/demo/ACCEPTANCE.md" \
        "${REPO_ROOT}/.hopper/demo/REVIEW-CHECKLIST.md"

    print_section "Run a step"
    cat <<'NEXT'
Run this script again with a phase name:
  ./.hopper/demo/start-todo-demo.sh strategy
  ./.hopper/demo/start-todo-demo.sh planning
  ./.hopper/demo/start-todo-demo.sh execution
  ./.hopper/demo/start-todo-demo.sh review
NEXT
}

print_strategy() {
    print_section "Step 1: Strategy session"

    print_section "Recommended model"
    cat <<'MODEL'
Role: Strategy
Recommended model: GPT-5.5 xhigh
Acceptable equivalents: Opus 4.7, Opus 4.6 equivalent
Source: DECISIONS.md::model-routing-table
MODEL

    print_section "Files to read in the new session"
    print_files \
        "${REPO_ROOT}/.hopper/MANIFEST.md" \
        "${REPO_ROOT}/PROJECT.md" \
        "${REPO_ROOT}/PRD.md" \
        "${REPO_ROOT}/DECISIONS.md" \
        "${REPO_ROOT}/.hopper/demo/TODO-APP.md" \
        "${REPO_ROOT}/.hopper/demo/ACCEPTANCE.md"

    print_section "Files the new session may modify"
    cat <<'FILES'
Only demo/PRODUCT.md (the strategy output of step 1).
Do not modify .hopper/skill/, .hopper/prompts/, .hopper/demo/, or top-level artifacts.
FILES

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the strategy session for a hypothetical single-user Todo app with three features (add, complete, list with active/completed filter). Read .hopper/MANIFEST.md, PROJECT.md, PRD.md, DECISIONS.md, .hopper/demo/TODO-APP.md, and .hopper/demo/ACCEPTANCE.md.

Goal: Produce a one-page Todo app product brief named demo/PRODUCT.md that mirrors the PROJECT.md structure: vision, problem, scope, success definition, and a minimal model routing recommendation. Use stable anchors of the form Anchor: `demo/PRODUCT.md::section`. End with the handoff block per TRD.md::handoff-block-schema pointing at the planning step.

Constraints:
- Prompt-only, zero-code. Do not generate runtime code.
- Modify only demo/PRODUCT.md during this session.
- Stop and ask the user if any product question is ambiguous.
END PROMPT
PROMPT

    print_section "After this step"
    cat <<'NEXT'
Verify demo/PRODUCT.md exists, read its anchors, and confirm the handoff block.
Then run: ./.hopper/demo/start-todo-demo.sh planning
NEXT

    print_section "Reminder"
    print_constraints
}

print_planning() {
    print_section "Step 2: Planning session"

    print_section "Recommended model"
    cat <<'MODEL'
Role: Planning
Recommended model: GPT-5.5 xhigh
Acceptable equivalents: Opus 4.7, Opus 4.6 equivalent
Source: DECISIONS.md::model-routing-table
MODEL

    print_section "Files to read in the new session"
    print_files \
        "${REPO_ROOT}/.hopper/MANIFEST.md" \
        "${REPO_ROOT}/TRD.md" \
        "${REPO_ROOT}/ROADMAP.md" \
        "demo/PRODUCT.md" \
        "${REPO_ROOT}/.hopper/demo/TODO-APP.md" \
        "${REPO_ROOT}/.hopper/demo/ACCEPTANCE.md"

    print_section "Files the new session may modify"
    cat <<'FILES'
Only demo/PLAN.md (the planning output of step 2).
Do not modify demo/PRODUCT.md or any LLM-Hopper top-level artifact.
FILES

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the planning session. Read .hopper/MANIFEST.md, demo/PRODUCT.md, TRD.md, ROADMAP.md, .hopper/demo/TODO-APP.md, and .hopper/demo/ACCEPTANCE.md.

Goal: Produce demo/PLAN.md with a TRD-style routing summary, a roadmap of three milestones (Add, Complete, List), and acceptance criteria per milestone. Use stable anchors. End with the handoff block per TRD.md::handoff-block-schema pointing at the execution step.

Constraints:
- Prompt-only, zero-code. Do not generate runtime code.
- Modify only demo/PLAN.md during this session.
- Do not change demo/PRODUCT.md. If the product brief is ambiguous, stop and route to a strategy session.
END PROMPT
PROMPT

    print_section "After this step"
    cat <<'NEXT'
Verify demo/PLAN.md lists three milestones traceable to demo/PRODUCT.md.
Then run: ./.hopper/demo/start-todo-demo.sh execution
NEXT

    print_section "Reminder"
    print_constraints
}

print_execution() {
    print_section "Step 3: Execution session"

    print_section "Recommended model"
    cat <<'MODEL'
Role: Execution
Recommended model: Kimi 2.6
Acceptable equivalents: DeepSeek V4 Pro Max, GLM 5.1, Mimo V2 Pro
Source: DECISIONS.md::model-routing-table
MODEL

    print_section "Files to read in the new session"
    print_files \
        "${REPO_ROOT}/.hopper/MANIFEST.md" \
        "${REPO_ROOT}/TRD.md" \
        "${REPO_ROOT}/ROADMAP.md" \
        "demo/PRODUCT.md" \
        "demo/PLAN.md" \
        "${REPO_ROOT}/.hopper/demo/TODO-APP.md" \
        "${REPO_ROOT}/.hopper/demo/ACCEPTANCE.md"

    print_section "Files the new session may modify"
    cat <<'FILES'
Only demo/EXECUTION.md (the execution output of step 3).
Do not modify demo/PRODUCT.md, demo/PLAN.md, or any LLM-Hopper top-level artifact.
FILES

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the execution session. Read .hopper/MANIFEST.md, demo/PRODUCT.md, demo/PLAN.md, TRD.md, ROADMAP.md, .hopper/demo/TODO-APP.md, and .hopper/demo/ACCEPTANCE.md.

Goal: Produce demo/EXECUTION.md that documents the bounded prompts an implementer would run for each milestone in demo/PLAN.md. Each milestone gets: required inputs, files allowed to modify, stop conditions, expected output schema, and a handoff block. Do not generate runtime code; this demo proves the workflow, not the app.

Constraints:
- Prompt-only, zero-code. Do not install packages, call APIs, or run daemons.
- Modify only demo/EXECUTION.md during this session.
- Do not change demo/PRODUCT.md or demo/PLAN.md. If a milestone is ambiguous, stop and route to a planning session per DECISIONS.md::model-routing-rules rule 4.
END PROMPT
PROMPT

    print_section "After this step"
    cat <<'NEXT'
Verify demo/EXECUTION.md contains one bounded prompt per milestone.
Then run: ./.hopper/demo/start-todo-demo.sh review
NEXT

    print_section "Reminder"
    print_constraints
}

print_review() {
    print_section "Step 4: Review session"

    print_section "Recommended model"
    cat <<'MODEL'
Role: Review
Recommended model: GPT-5.4 xhigh
Acceptable equivalents: Opus Sonnet 4.6
Source: DECISIONS.md::model-routing-table
MODEL

    print_section "Files to read in the new session"
    print_files \
        "${REPO_ROOT}/.hopper/MANIFEST.md" \
        "demo/PRODUCT.md" \
        "demo/PLAN.md" \
        "demo/EXECUTION.md" \
        "${REPO_ROOT}/.hopper/demo/TODO-APP.md" \
        "${REPO_ROOT}/.hopper/demo/ACCEPTANCE.md" \
        "${REPO_ROOT}/.hopper/demo/REVIEW-CHECKLIST.md"

    print_section "Files the new session may modify"
    cat <<'FILES'
Only demo/REVIEW.md (the review output of step 4), plus minor consistency or
anchor fixes in the earlier demo files when justified in writing.
Do not modify any LLM-Hopper top-level artifact.
FILES

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the review session. Read .hopper/MANIFEST.md, demo/PRODUCT.md, demo/PLAN.md, demo/EXECUTION.md, .hopper/demo/TODO-APP.md, .hopper/demo/ACCEPTANCE.md, and .hopper/demo/REVIEW-CHECKLIST.md.

Goal: Produce demo/REVIEW.md that records the result of each item in REVIEW-CHECKLIST.md against the three earlier demo artifacts. Apply only consistency, anchor, or polish fixes inline; defer or escalate substantive changes back to strategy or planning. End with the handoff block per TRD.md::handoff-block-schema declaring the demo complete or naming the gating fix.

Constraints:
- Prompt-only, zero-code. Do not generate runtime code.
- Modify only demo/REVIEW.md during this session, plus minor consistency or anchor fixes in the earlier demo files when the change is justified in writing.
- Do not introduce new product requirements or planning milestones.
END PROMPT
PROMPT

    print_section "After this step"
    cat <<'NEXT'
Verify demo/REVIEW.md records every checklist item with pass, fix-applied,
defer, or escalate. Confirm the final handoff block declares the demo complete
or names the responsible upstream phase.
NEXT

    print_section "Reminder"
    print_constraints
}

print_list() {
    print_section "LLM-Hopper Todo Demo - reference files"
    print_files \
        "${REPO_ROOT}/PROJECT.md" \
        "${REPO_ROOT}/PRD.md" \
        "${REPO_ROOT}/DECISIONS.md" \
        "${REPO_ROOT}/TRD.md" \
        "${REPO_ROOT}/ROADMAP.md" \
        "${REPO_ROOT}/.hopper/MANIFEST.md" \
        "${REPO_ROOT}/.hopper/demo/TODO-APP.md" \
        "${REPO_ROOT}/.hopper/demo/ACCEPTANCE.md" \
        "${REPO_ROOT}/.hopper/demo/REVIEW-CHECKLIST.md"
}

main() {
    local arg="${1:-}"
    case "${arg}" in
        ""|intro)
            print_intro
            ;;
        strategy)
            print_strategy
            ;;
        planning)
            print_planning
            ;;
        execution)
            print_execution
            ;;
        review)
            print_review
            ;;
        list)
            print_list
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            printf 'Unknown phase: %s\n\n' "${arg}" >&2
            usage >&2
            exit 1
            ;;
    esac
}

main "$@"
