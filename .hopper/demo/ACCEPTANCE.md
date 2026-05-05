# Todo Demo Acceptance Criteria

Anchor: `.hopper/demo/ACCEPTANCE.md::root`

## Purpose

Anchor: `.hopper/demo/ACCEPTANCE.md::purpose`

This file defines acceptance for the v0.2 Todo App role workflow. The demo is accepted only when the role order, TDD task format, file boundaries, and reinforced Builder review are all followed.

## Global Criteria

Anchor: `.hopper/demo/ACCEPTANCE.md::global`

- [ ] Every session reads `.hopper/roles/ROLES.md` and `.hopper/agents/AGENTS.md` before selecting a role.
- [ ] Role selection is by nickname and role, not by hard-coded model name.
- [ ] Every handoff uses `.hopper/prompts/handoff-to-role.md` schema.
- [ ] Each step lists exact authoritative files.
- [ ] No step relies on prior chat history.
- [ ] The helper script only prints text and does not mutate files.

## Step 1 - Leader Kickoff

Anchor: `.hopper/demo/ACCEPTANCE.md::step-1-kickoff`

- [ ] The Leader confirms Phase 5 is pending before work starts.
- [ ] The Leader defines the Todo App validation scope without implementing app files.
- [ ] The Leader handoff targets a configured Builder or UI-Builder nickname.
- [ ] The handoff names PRD.md, TRD.md, ROADMAP.md, `.hopper/MANIFEST.md`, and `.planning/STATE.md` as authoritative context.

## Step 2 - Builder Disassembly

Anchor: `.hopper/demo/ACCEPTANCE.md::step-2-disassemble`

- [ ] `.planning/phases/05-todo-app-build/TASK-LIST.md` is created or refreshed.
- [ ] The task list contains exactly five tasks: T01 through T05.
- [ ] Each task has files allowed, forbidden changes, RED, GREEN, REFACTOR, and acceptance criteria.
- [ ] T01 is the only task dispatched to Executor after disassembly.
- [ ] The Builder does not mark T01 complete before receiving Executor evidence.

## Step 3 - Executor Execution

Anchor: `.hopper/demo/ACCEPTANCE.md::step-3-execute`

- [ ] The Executor reads only the assigned task section and required role files.
- [ ] The Executor touches only files listed in the task's allowed scope.
- [ ] The Executor records RED -> GREEN -> REFACTOR evidence in its handoff.
- [ ] The Executor does not edit PRD.md, TRD.md, ROADMAP.md, `.planning/STATE.md`, or `.hopper/MANIFEST.md`.
- [ ] The Executor hands back to Builder instead of dispatching another task.

## Step 4 - Builder Review

Anchor: `.hopper/demo/ACCEPTANCE.md::step-4-builder-review`

- [ ] The Builder verifies each GREEN acceptance criterion.
- [ ] The Builder verifies file-scope compliance.
- [ ] The Builder marks the task as GREEN-light or needs-fix.
- [ ] GREEN-light dispatches the next task; needs-fix routes back to the same Executor.
- [ ] The Builder records review status in the task list before dispatching more work.

## Cross-Step Trace

Anchor: `.hopper/demo/ACCEPTANCE.md::cross-step-trace`

- [ ] Every Executor task traces back to the Todo App scope in `.hopper/demo/TODO-APP.md`.
- [ ] Every task has a single owning role at a time.
- [ ] Every state update is attributable to a Leader or Builder final sync.
- [ ] Phase 5 is not considered complete until all five tasks pass Builder review.
