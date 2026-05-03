# Todo Demo Acceptance Criteria

Anchor: `.hopper/demo/ACCEPTANCE.md::root`

## Purpose

Anchor: `.hopper/demo/ACCEPTANCE.md::purpose`

This file lists the acceptance criteria for each step in `.hopper/demo/TODO-APP.md`. Each step is owned by a different model session. A step is accepted only when every criterion in its block is satisfied. Failures route back to the responsible phase per `DECISIONS.md::model-routing-rules`.

## Global Acceptance Criteria

Anchor: `.hopper/demo/ACCEPTANCE.md::global`

These apply to every step in the demo:

- [ ] The session was opened with a model from the recommended role in `DECISIONS.md::model-routing-table` or an acceptable equivalent.
- [ ] The session read only the files listed by the step prompt before writing.
- [ ] The session wrote only the artifact named in the step prompt.
- [ ] The session preserved every existing anchor in the files it touched.
- [ ] The session ended with the exact handoff block from `TRD.md::handoff-block-schema`.
- [ ] The session did not install packages, call APIs, run daemons, or generate runtime code.

If any global criterion fails, the step is not accepted. The user must restart the step or route to the upstream phase.

## Step 1 - Strategy Acceptance

Anchor: `.hopper/demo/ACCEPTANCE.md::step-1-strategy`

The strategy step produces `demo/PRODUCT.md`.

- [ ] `demo/PRODUCT.md` contains a section anchored as `demo/PRODUCT.md::vision`.
- [ ] `demo/PRODUCT.md` contains a section anchored as `demo/PRODUCT.md::scope`.
- [ ] `demo/PRODUCT.md` contains a section anchored as `demo/PRODUCT.md::success-definition`.
- [ ] The product description names exactly the three features: add a todo, mark a todo as complete, list todos with an active/completed filter.
- [ ] The recommended model routing references `DECISIONS.md::model-routing-table`.
- [ ] The handoff block names Phase 2 (or the planning step) as next.
- [ ] No runtime code, schema, or executable file is created.

## Step 2 - Planning Acceptance

Anchor: `.hopper/demo/ACCEPTANCE.md::step-2-planning`

The planning step produces `demo/PLAN.md`.

- [ ] `demo/PLAN.md` contains an anchor of the form `demo/PLAN.md::milestones`.
- [ ] `demo/PLAN.md` defines exactly three milestones aligned to the three features in `demo/PRODUCT.md`.
- [ ] Every milestone lists goal, dependencies, requirements, success criteria, and acceptance.
- [ ] `demo/PLAN.md` references `TRD.md::router-protocol` or `TRD.md::handoff-block-schema` as the routing source.
- [ ] No milestone introduces a feature absent from `demo/PRODUCT.md`.
- [ ] The handoff block names the execution step as next.
- [ ] No runtime code, package install, API call, or daemon is described as a setup requirement.

## Step 3 - Execution Acceptance

Anchor: `.hopper/demo/ACCEPTANCE.md::step-3-execution`

The execution step produces `demo/EXECUTION.md`.

- [ ] `demo/EXECUTION.md` contains an anchor of the form `demo/EXECUTION.md::milestone-prompts`.
- [ ] Each milestone in `demo/PLAN.md` has a matching bounded prompt block in `demo/EXECUTION.md`.
- [ ] Each prompt block lists required inputs, files allowed to modify, stop conditions, output format, and a handoff block.
- [ ] No prompt asks for package installs, API calls, daemons, or generated runtime code.
- [ ] Every prompt cites at least one file by anchor.
- [ ] The handoff block names the review step as next.
- [ ] The session does not modify `demo/PRODUCT.md` or `demo/PLAN.md`.

## Step 4 - Review Acceptance

Anchor: `.hopper/demo/ACCEPTANCE.md::step-4-review`

The review step produces `demo/REVIEW.md`.

- [ ] `demo/REVIEW.md` contains an anchor of the form `demo/REVIEW.md::checklist-results`.
- [ ] Every item in `.hopper/demo/REVIEW-CHECKLIST.md` is recorded with one of `pass`, `fix-applied`, `defer`, or `escalate`.
- [ ] Each `fix-applied` lists the file changed and the rationale.
- [ ] Each `escalate` names the responsible upstream phase per `DECISIONS.md::model-routing-rules`.
- [ ] No new product requirement, architecture decision, or roadmap milestone is introduced.
- [ ] The final handoff block declares the demo complete (`Next phase: Demo complete`) or names the gating fix.

## Cross-Step Trace

Anchor: `.hopper/demo/ACCEPTANCE.md::cross-step-trace`

After all four steps run, the user must be able to:

- [ ] Trace each milestone from `demo/PLAN.md` back to a feature in `demo/PRODUCT.md`.
- [ ] Trace each execution prompt in `demo/EXECUTION.md` back to a milestone in `demo/PLAN.md`.
- [ ] Trace each review finding in `demo/REVIEW.md` back to the file it cites.
- [ ] Open `.hopper/MANIFEST.md` and find no unresolved references to the demo session that owns the next step.

If any trace fails, the demo did not satisfy `TRD.md::todo-demo-contract` and the user re-runs the failing step from a fresh session.
