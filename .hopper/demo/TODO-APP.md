# Todo App Demo: Cross-Model Workflow Walkthrough

Anchor: `.hopper/demo/TODO-APP.md::root`

## Purpose

Anchor: `.hopper/demo/TODO-APP.md::purpose`

The Todo App demo is an artifact-only walkthrough that shows how LLM-Hopper coordinates strategy, planning, execution, and review across independent model sessions. It does not generate a runnable application. Instead, it produces a sequence of markdown artifacts under `.hopper/demo/`-style ownership rules so the user can practice the cross-process handoff exactly as defined by `TRD.md::todo-demo-contract`.

A successful run of this demo proves that a user can close a model session, open a new one with the recommended model, paste the handoff prompt, and continue without hidden chat context.

## Demo Scope

Anchor: `.hopper/demo/TODO-APP.md::demo-scope`

The hypothetical product is a single-user Todo app with three features:

1. Add a todo with a title.
2. Mark a todo as complete.
3. List todos with a filter for active or completed.

The demo asks four model sessions to produce a strategy, a plan, an execution kit, and a review for this product. Each session writes only its phase's bounded artifacts. No runtime code is generated.

## Artifact Set

Anchor: `.hopper/demo/TODO-APP.md::artifact-set`

The demo references three companion files:

- `TODO-APP.md` (this file): scenario, recommended model sequence, and step-by-step prompts.
- `ACCEPTANCE.md`: acceptance criteria for every handoff step.
- `REVIEW-CHECKLIST.md`: quality convergence checklist applied at the end.

The pure bash helper `start-todo-demo.sh` prints the file list and the next prompt for any selected step. It does not install packages, call APIs, or generate code.

## Model-Session Sequence

Anchor: `.hopper/demo/TODO-APP.md::model-session-sequence`

| Step | Phase | Recommended Role | Recommended Model | Artifact Produced |
| --- | --- | --- | --- | --- |
| 1 | Strategy | Strategy | GPT-5.5 xhigh, or Opus 4.7 equivalent | `demo/PRODUCT.md` (notional path used only as a session output reference) |
| 2 | Planning | Planning | GPT-5.5 xhigh, or Opus 4.7 equivalent | `demo/PLAN.md` (notional path used only as a session output reference) |
| 3 | Execution | Execution | Kimi 2.6, or DeepSeek V4 Pro Max equivalent | `demo/EXECUTION.md` (notional path used only as a session output reference) |
| 4 | Review | Review | GPT-5.4 xhigh, or Opus Sonnet 4.6 equivalent | `demo/REVIEW.md` (notional path used only as a session output reference) |

The `demo/*.md` paths in the table are illustrative: the demo can be run inside a throwaway directory or scratchpad. The point is the cross-session protocol, not the storage location.

## Step 1 - Strategy Session

Anchor: `.hopper/demo/TODO-APP.md::step-1-strategy`

### Setup

- Open a new Codex CLI session with a strategy-class model.
- Have `.hopper/demo/TODO-APP.md`, `.hopper/demo/ACCEPTANCE.md`, and the LLM-Hopper top-level files available in the working directory.

### Copyable Prompt

```text
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the strategy session for a hypothetical single-user Todo app with three features (add, complete, list with active/completed filter). Read .hopper/MANIFEST.md, PROJECT.md, PRD.md, DECISIONS.md, .hopper/demo/TODO-APP.md, and .hopper/demo/ACCEPTANCE.md.

Goal: Produce a one-page Todo app product brief named demo/PRODUCT.md that mirrors the PROJECT.md structure: vision, problem, scope, success definition, and a minimal model routing recommendation. Use stable anchors of the form Anchor: `demo/PRODUCT.md::section`. End with the handoff block per TRD.md::handoff-block-schema pointing at the planning step.

Constraints:
- Prompt-only, zero-code. Do not generate runtime code.
- Modify only demo/PRODUCT.md during this session.
- Stop and ask the user if any product question is ambiguous.
END PROMPT
```

### Expected Outcome

The session writes a single `demo/PRODUCT.md` file with anchored sections. It ends with a handoff block pointing the user to step 2.

## Step 2 - Planning Session

Anchor: `.hopper/demo/TODO-APP.md::step-2-planning`

### Setup

- Close the strategy session.
- Open a new Codex CLI session with a planning-class model.
- Make `demo/PRODUCT.md` available alongside the LLM-Hopper top-level files.

### Copyable Prompt

```text
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the planning session. Read .hopper/MANIFEST.md, demo/PRODUCT.md, TRD.md, ROADMAP.md, .hopper/demo/TODO-APP.md, and .hopper/demo/ACCEPTANCE.md.

Goal: Produce demo/PLAN.md with a TRD-style routing summary, a roadmap of three milestones (Add, Complete, List), and acceptance criteria per milestone. Use stable anchors. End with the handoff block per TRD.md::handoff-block-schema pointing at the execution step.

Constraints:
- Prompt-only, zero-code. Do not generate runtime code.
- Modify only demo/PLAN.md during this session.
- Do not change demo/PRODUCT.md. If the product brief is ambiguous, stop and route to a strategy session.
END PROMPT
```

### Expected Outcome

The session writes `demo/PLAN.md` with three milestones and acceptance criteria. It ends with a handoff block pointing to step 3.

## Step 3 - Execution Session

Anchor: `.hopper/demo/TODO-APP.md::step-3-execution`

### Setup

- Close the planning session.
- Open a new Codex CLI session with an execution-class model.
- Make `demo/PRODUCT.md` and `demo/PLAN.md` available alongside the LLM-Hopper top-level files.

### Copyable Prompt

```text
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the execution session. Read .hopper/MANIFEST.md, demo/PRODUCT.md, demo/PLAN.md, TRD.md, ROADMAP.md, .hopper/demo/TODO-APP.md, and .hopper/demo/ACCEPTANCE.md.

Goal: Produce demo/EXECUTION.md that documents the bounded prompts an implementer would run for each milestone in demo/PLAN.md. Each milestone gets: required inputs, files allowed to modify, stop conditions, expected output schema, and a handoff block. Do not generate runtime code; this demo proves the workflow, not the app.

Constraints:
- Prompt-only, zero-code. Do not install packages, call APIs, or run daemons.
- Modify only demo/EXECUTION.md during this session.
- Do not change demo/PRODUCT.md or demo/PLAN.md. If a milestone is ambiguous, stop and route to a planning session per DECISIONS.md::model-routing-rules rule 4.
END PROMPT
```

### Expected Outcome

The session writes `demo/EXECUTION.md` with one bounded prompt per milestone. It ends with a handoff block pointing to step 4.

## Step 4 - Review Session

Anchor: `.hopper/demo/TODO-APP.md::step-4-review`

### Setup

- Close the execution session.
- Open a new Codex CLI session with a review-class model.
- Make `demo/PRODUCT.md`, `demo/PLAN.md`, and `demo/EXECUTION.md` available alongside the LLM-Hopper top-level files.

### Copyable Prompt

```text
BEGIN PROMPT
LLM-Hopper Todo Demo: act as the review session. Read .hopper/MANIFEST.md, demo/PRODUCT.md, demo/PLAN.md, demo/EXECUTION.md, .hopper/demo/TODO-APP.md, .hopper/demo/ACCEPTANCE.md, and .hopper/demo/REVIEW-CHECKLIST.md.

Goal: Produce demo/REVIEW.md that records the result of each item in REVIEW-CHECKLIST.md against the three earlier demo artifacts. Apply only consistency, anchor, or polish fixes inline; defer or escalate substantive changes back to strategy or planning. End with the handoff block per TRD.md::handoff-block-schema declaring the demo complete or naming the gating fix.

Constraints:
- Prompt-only, zero-code. Do not generate runtime code.
- Modify only demo/REVIEW.md during this session, plus minor consistency or anchor fixes in the earlier demo files when the change is justified in writing.
- Do not introduce new product requirements or planning milestones.
END PROMPT
```

### Expected Outcome

The session writes `demo/REVIEW.md`. It either declares the demo complete or names the gating fix and the responsible upstream phase.

## How To Run The Helper

Anchor: `.hopper/demo/TODO-APP.md::run-helper`

The helper script `.hopper/demo/start-todo-demo.sh` is a pure bash printer. It does not install software, call APIs, generate code, or start daemons.

```bash
./.hopper/demo/start-todo-demo.sh           # prints intro and step list
./.hopper/demo/start-todo-demo.sh strategy  # prints step 1 setup, files, and prompt
./.hopper/demo/start-todo-demo.sh planning  # prints step 2 setup, files, and prompt
./.hopper/demo/start-todo-demo.sh execution # prints step 3 setup, files, and prompt
./.hopper/demo/start-todo-demo.sh review    # prints step 4 setup, files, and prompt
```

The user opens the recommended model session, copies the prompt, runs the step, then re-runs the helper for the next step.

## Demo Success Definition

Anchor: `.hopper/demo/TODO-APP.md::success-definition`

The demo is successful when:

1. Each step is run in a separate model session matched to the recommended role.
2. Each step ends with the exact handoff block from `TRD.md::handoff-block-schema`.
3. No step relies on chat history, API access, package installs, daemons, or generated runtime code.
4. The review step closes with a pass against every item in `REVIEW-CHECKLIST.md` or names the responsible upstream phase to fix.
