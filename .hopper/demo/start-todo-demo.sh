#!/usr/bin/env bash
#
# LLM-Hopper v0.2 Todo App role workflow helper.
#
# Read-only helper: prints files and prompts for Leader, Builder,
# Executor, and Builder-review sessions. It does not edit files.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

print_section() {
    printf '\n=== %s ===\n' "$1"
}

print_files() {
    local file
    for file in "$@"; do
        printf -- '  - %s\n' "$file"
    done
}

usage() {
    cat <<'USAGE'
Usage: ./.hopper/demo/start-todo-demo.sh [step]

Steps:
  (no arg)        Print intro, role sequence, and reference files.
  kickoff         Print Leader kickoff prompt.
  disassemble     Print Builder task-disassembly prompt.
  execute         Print Executor single-task prompt.
  builder-review  Print Builder reinforced-review prompt.
  list            Print reference files.
  -h, --help      Print this message.

This helper is read-only. It prints text and never modifies files.
USAGE
}

print_common_files() {
    print_files \
        "${REPO_ROOT}/.hopper/MANIFEST.md" \
        "${REPO_ROOT}/.hopper/roles/ROLES.md" \
        "${REPO_ROOT}/.hopper/agents/AGENTS.md" \
        "${REPO_ROOT}/.hopper/prompts/handoff-to-role.md" \
        "${REPO_ROOT}/PRD.md" \
        "${REPO_ROOT}/TRD.md" \
        "${REPO_ROOT}/ROADMAP.md" \
        "${REPO_ROOT}/.planning/STATE.md" \
        "${REPO_ROOT}/.hopper/demo/TODO-APP.md" \
        "${REPO_ROOT}/.hopper/demo/ACCEPTANCE.md" \
        "${REPO_ROOT}/.hopper/demo/REVIEW-CHECKLIST.md"
}

print_intro() {
    print_section "LLM-Hopper v0.2 Todo App Demo"
    cat <<'INTRO'
This demo follows the v0.2 role workflow:
Leader kickoff -> Builder task disassembly -> Executor single task -> Builder reinforced review.

The helper only prints prompts. The prompted sessions may create the Phase 5
task list and apps/todo files when you run the validation build.
INTRO

    print_section "Steps"
    cat <<'STEPS'
  1. kickoff         Leader confirms scope and routes to Builder.
  2. disassemble     Builder creates the five-task TDD task list.
  3. execute         Executor completes exactly one assigned task.
  4. builder-review  Builder verifies the task and dispatches the next step.
STEPS

    print_section "Reference files"
    print_common_files

    print_section "Run a step"
    cat <<'NEXT'
./.hopper/demo/start-todo-demo.sh kickoff
./.hopper/demo/start-todo-demo.sh disassemble
./.hopper/demo/start-todo-demo.sh execute
./.hopper/demo/start-todo-demo.sh builder-review
NEXT
}

print_kickoff() {
    print_section "Step 1: Leader Kickoff"
    print_section "Role"
    cat <<'ROLE'
Use the configured Leader nickname from .hopper/agents/AGENTS.md.
ROLE

    print_section "Files to read"
    print_common_files

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
You are running LLM-Hopper v0.2 as the Leader role.

Read .hopper/MANIFEST.md, .hopper/roles/ROLES.md, .hopper/agents/AGENTS.md,
PRD.md, TRD.md, ROADMAP.md, .planning/STATE.md, and .hopper/demo/TODO-APP.md.

Confirm Phase 5 is pending, summarize the Todo App validation scope, and emit
a HANDOFF TO ROLE block to the configured Builder or UI-Builder nickname.

Do not implement app files. Do not mark Phase 5 execution as started.
Keep model selection role-first and configurable.
END PROMPT
PROMPT
}

print_disassemble() {
    print_section "Step 2: Builder Task Disassembly"
    print_section "Role"
    cat <<'ROLE'
Use a configured Builder or UI-Builder nickname from .hopper/agents/AGENTS.md.
ROLE

    print_section "Files to read"
    print_common_files

    print_section "Files the session may modify"
    print_files "${REPO_ROOT}/.planning/phases/05-todo-app-build/TASK-LIST.md"

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
You are running LLM-Hopper v0.2 as a Builder role.

Read .hopper/MANIFEST.md, .hopper/roles/ROLES.md, .hopper/agents/AGENTS.md,
PRD.md, TRD.md, ROADMAP.md, .hopper/prompts/handoff-to-role.md,
.hopper/demo/TODO-APP.md, and .hopper/demo/ACCEPTANCE.md.

Create .planning/phases/05-todo-app-build/TASK-LIST.md with exactly five
atomic tasks for apps/todo/: T01 HTML skeleton, T02 responsive CSS, T03 store
and localStorage, T04 DOM rendering and events, T05 accessibility and polish.

Each task must include files allowed, forbidden changes, RED, GREEN, REFACTOR,
acceptance criteria, and an exact Executor handoff block.

Emit a HANDOFF TO ROLE block for the configured Executor role with T01 only.
END PROMPT
PROMPT
}

print_execute() {
    print_section "Step 3: Executor Single Task"
    print_section "Role"
    cat <<'ROLE'
Use the configured Executor nickname named by the Builder handoff.
ROLE

    print_section "Files to read"
    print_files \
        "${REPO_ROOT}/.hopper/roles/ROLES.md" \
        "${REPO_ROOT}/.hopper/agents/AGENTS.md" \
        "${REPO_ROOT}/.planning/phases/05-todo-app-build/TASK-LIST.md"

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
You are running LLM-Hopper v0.2 as an Executor role.

Read .hopper/roles/ROLES.md, .hopper/agents/AGENTS.md, and only the assigned
task section in .planning/phases/05-todo-app-build/TASK-LIST.md.

Execute only the assigned task. Touch only files listed in "Files allowed to
touch". Follow RED -> GREEN -> REFACTOR. Do not make design choices outside
the task spec.

Do not edit PRD.md, TRD.md, ROADMAP.md, .planning/STATE.md, or
.hopper/MANIFEST.md. If the task is ambiguous, stop and hand back to Builder.

At completion, emit a HANDOFF TO ROLE block back to Builder with verification
evidence.
END PROMPT
PROMPT
}

print_builder_review() {
    print_section "Step 4: Builder Reinforced Review"
    print_section "Role"
    cat <<'ROLE'
Use a configured Builder nickname from .hopper/agents/AGENTS.md.
ROLE

    print_section "Files to read"
    print_files \
        "${REPO_ROOT}/.hopper/prompts/handoff-to-role.md" \
        "${REPO_ROOT}/.planning/phases/05-todo-app-build/TASK-LIST.md" \
        "${REPO_ROOT}/.hopper/demo/REVIEW-CHECKLIST.md" \
        "Files touched by the Executor"

    print_section "Copyable prompt"
    cat <<'PROMPT'
BEGIN PROMPT
You are running LLM-Hopper v0.2 as a Builder role receiving an Executor handoff.

Read .hopper/prompts/handoff-to-role.md,
.planning/phases/05-todo-app-build/TASK-LIST.md,
.hopper/demo/REVIEW-CHECKLIST.md, and the files touched by the Executor.

Run the Builder Reinforced Review Checklist:
1. Verify RED -> GREEN -> REFACTOR evidence.
2. Verify every GREEN acceptance criterion.
3. Verify the Executor touched only allowed files.
4. Verify no product, roadmap, manifest, or role policy was changed.
5. Decide GREEN-light or needs-fix.

If GREEN-light, mark review result in TASK-LIST.md and emit the next Executor
handoff. If needs-fix, emit a fix handoff to the same Executor with exact
failing criteria.
END PROMPT
PROMPT
}

print_list() {
    print_section "LLM-Hopper Todo Demo Reference Files"
    print_common_files
}

main() {
    local arg="${1:-}"
    case "$arg" in
        ""|intro)
            print_intro
            ;;
        kickoff)
            print_kickoff
            ;;
        disassemble)
            print_disassemble
            ;;
        execute)
            print_execute
            ;;
        builder-review)
            print_builder_review
            ;;
        list)
            print_list
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            printf 'Unknown step: %s\n\n' "$arg" >&2
            usage >&2
            exit 1
            ;;
    esac
}

main "$@"
