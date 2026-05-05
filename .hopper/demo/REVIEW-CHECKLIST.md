# Todo Demo Review Checklist

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::root`

## Purpose

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::purpose`

This checklist is used by the Builder after each Executor handoff in the v0.2 Todo App validation workflow.

Each item is recorded as one of:

- `pass`: criterion satisfied.
- `fix-required`: Executor must repair the task.
- `builder-fix`: Builder applied a limited task-list or handoff correction.
- `escalate`: Leader must resolve a product or architecture ambiguity.

## Role Boundary

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::role-boundary`

- [ ] Executor touched only files allowed by the assigned task.
- [ ] Executor did not edit product, roadmap, manifest, role, or planning policy files.
- [ ] Executor did not dispatch the next task.
- [ ] Builder owns the review decision.

## TDD Evidence

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::tdd-evidence`

- [ ] RED state is named clearly.
- [ ] GREEN evidence maps to each acceptance criterion.
- [ ] REFACTOR changes stay inside the task's allowed scope.
- [ ] Verification commands or manual checks are recorded in the handoff.

## Acceptance Coverage

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::acceptance-coverage`

- [ ] Every GREEN criterion from the task list is checked.
- [ ] Any failed criterion has an exact fix handoff.
- [ ] Any ambiguity is escalated to Leader instead of guessed.
- [ ] No extra product feature is accepted as part of the task.

## Handoff Quality

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::handoff-quality`

- [ ] The handoff names completed phase, next phase, authoritative files, and prompt.
- [ ] The handoff is minimal enough for a fresh session.
- [ ] The handoff names exactly one next owning role.
- [ ] Cost tracking is requested after major phase or handoff completion.

## Release Gate

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::release-gate`

- [ ] Phase 5 remains pending until all five tasks pass Builder review.
- [ ] Phase 5 complete requires updating `.planning/STATE.md`, ROADMAP.md, and `.hopper/MANIFEST.md`.
- [ ] The final app supports add, complete, delete, list filters, and localStorage persistence.
- [ ] The final review records any known deferrals before declaring completion.
