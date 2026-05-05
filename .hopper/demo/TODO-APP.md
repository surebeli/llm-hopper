# Todo App Demo: v0.2 Role + TDD Workflow

Anchor: `.hopper/demo/TODO-APP.md::root`

## Purpose

Anchor: `.hopper/demo/TODO-APP.md::purpose`

This demo shows the LLM-Hopper v0.2 path for a Todo App validation build. It uses the configured roles from `.hopper/roles/ROLES.md` and `.hopper/agents/AGENTS.md`, then moves work through automatic handoff blocks.

The helper script is read-only: it prints prompts and file paths. The prompted sessions may create the Phase 5 planning file and `apps/todo/` implementation files when the user chooses to run the validation build.

## Demo Scope

Anchor: `.hopper/demo/TODO-APP.md::demo-scope`

The validation app is a single-user Todo app with five expected capabilities:

1. Add a todo with a title.
2. Mark a todo complete or active.
3. Delete a todo.
4. List active, completed, and all todos.
5. Persist todos in browser localStorage.

## Role Sequence

Anchor: `.hopper/demo/TODO-APP.md::role-sequence`

| Step | Command | Owning Role | Output |
| --- | --- | --- | --- |
| 1 | `kickoff` | Leader | Product frame and Phase 5 handoff |
| 2 | `disassemble` | Builder or UI-Builder | `.planning/phases/05-todo-app-build/TASK-LIST.md` |
| 3 | `execute` | Executor | One scoped task under `apps/todo/` |
| 4 | `builder-review` | Builder | Reinforced review result and next handoff |

Role nicknames are loaded from `.hopper/agents/AGENTS.md`; model choices remain configurable.

## Step 1 - Leader Kickoff

Anchor: `.hopper/demo/TODO-APP.md::step-1-kickoff`

Use a Leader role to confirm the product frame and route Phase 5 into Builder disassembly.

```text
BEGIN PROMPT
You are running LLM-Hopper v0.2 as the Leader role.

Read:
- .hopper/MANIFEST.md
- .hopper/roles/ROLES.md
- .hopper/agents/AGENTS.md
- PRD.md
- TRD.md
- ROADMAP.md
- .hopper/demo/TODO-APP.md
- .hopper/demo/ACCEPTANCE.md

Goal:
Confirm the Phase 5 Todo App validation scope and emit a HANDOFF TO ROLE block for Builder disassembly.

Constraints:
- Do not implement app files.
- Do not mark Phase 5 execution as started.
- Keep model selection role-first and configurable.

Handoff target:
Use the configured Builder or UI-Builder nickname from .hopper/agents/AGENTS.md.
END PROMPT
```

## Step 2 - Builder Task Disassembly

Anchor: `.hopper/demo/TODO-APP.md::step-2-disassemble`

Use a Builder or UI-Builder role to create the Executor-grade task list.

```text
BEGIN PROMPT
You are running LLM-Hopper v0.2 as a Builder role.

Read:
- .hopper/MANIFEST.md
- .hopper/roles/ROLES.md
- .hopper/agents/AGENTS.md
- PRD.md
- TRD.md
- ROADMAP.md
- .hopper/prompts/handoff-to-role.md
- .hopper/demo/TODO-APP.md
- .hopper/demo/ACCEPTANCE.md

Goal:
Create .planning/phases/05-todo-app-build/TASK-LIST.md with five atomic tasks for apps/todo/.

Each task must include:
- Task id and title.
- Files allowed to touch.
- Forbidden changes.
- RED condition.
- GREEN acceptance criteria.
- REFACTOR allowance.
- Exact Executor handoff block.

Required task sequence:
T01 Project skeleton and semantic HTML.
T02 Responsive CSS and visual states.
T03 Todo store and localStorage.
T04 DOM rendering and events.
T05 Accessibility, empty states, and polish.

After writing the task list, emit a HANDOFF TO ROLE block for the configured Executor role with T01 only.
END PROMPT
```

## Step 3 - Executor Task Execution

Anchor: `.hopper/demo/TODO-APP.md::step-3-execute`

Use an Executor role to complete exactly one task from the Builder task list.

```text
BEGIN PROMPT
You are running LLM-Hopper v0.2 as an Executor role.

Read:
- .hopper/roles/ROLES.md
- .hopper/agents/AGENTS.md
- .planning/phases/05-todo-app-build/TASK-LIST.md
- The specific task section named in the handoff block

Goal:
Execute only the assigned task. Touch only files listed in "Files allowed to touch".

Required behavior:
- Follow RED -> GREEN -> REFACTOR.
- Do not choose architecture beyond the task spec.
- Do not edit ROADMAP.md, .planning/STATE.md, .hopper/MANIFEST.md, PRD.md, or TRD.md.
- If the task is ambiguous, stop and hand back to Builder.

At completion:
Emit a HANDOFF TO ROLE block back to the configured Builder role with verification evidence.
END PROMPT
```

## Step 4 - Builder Reinforced Review

Anchor: `.hopper/demo/TODO-APP.md::step-4-builder-review`

Use a Builder role to verify the Executor result before any next task starts.

```text
BEGIN PROMPT
You are running LLM-Hopper v0.2 as a Builder role receiving an Executor handoff.

Read:
- .hopper/prompts/handoff-to-role.md
- .planning/phases/05-todo-app-build/TASK-LIST.md
- The files touched by the Executor
- .hopper/demo/REVIEW-CHECKLIST.md

Goal:
Run the Builder Reinforced Review Checklist for the completed task.

Required checks:
1. Verify RED -> GREEN -> REFACTOR evidence.
2. Verify every GREEN acceptance criterion.
3. Verify the Executor touched only allowed files.
4. Verify no product, roadmap, manifest, or role policy was changed.
5. Decide GREEN-light or needs-fix.

If GREEN-light:
- Mark the task review result in TASK-LIST.md.
- Emit the next Executor handoff.

If needs-fix:
- Emit a fix handoff to the same Executor with exact failing criteria.
END PROMPT
```

## Helper Usage

Anchor: `.hopper/demo/TODO-APP.md::helper-usage`

```bash
./.hopper/demo/start-todo-demo.sh
./.hopper/demo/start-todo-demo.sh kickoff
./.hopper/demo/start-todo-demo.sh disassemble
./.hopper/demo/start-todo-demo.sh execute
./.hopper/demo/start-todo-demo.sh builder-review
```

## Success Definition

Anchor: `.hopper/demo/TODO-APP.md::success-definition`

The demo is successful when:

1. The role sequence uses Leader -> Builder/UI-Builder -> Executor -> Builder.
2. Builder creates a TDD task list before Executor work begins.
3. Executor completes only one scoped task at a time.
4. Builder reviews each Executor result before the next task is dispatched.
5. State files are updated only during explicit final sync, not by Executor task work.
