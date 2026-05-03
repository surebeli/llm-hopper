# Todo Demo Review Checklist

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::root`

## Purpose

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::purpose`

This checklist is used by the review step in `.hopper/demo/TODO-APP.md`. The reviewing model walks through every item against the three earlier demo artifacts (`demo/PRODUCT.md`, `demo/PLAN.md`, `demo/EXECUTION.md`) and records the result in `demo/REVIEW.md`. The checklist mirrors `TRD.md::verification-contract` and `DECISIONS.md::architecture-constraints`, scoped to the demo.

Each item is recorded as one of:

- `pass`: criterion satisfied, no change.
- `fix-applied`: a small consistency, anchor, or polish fix was applied; record the file and the rationale.
- `defer`: criterion not satisfied but a fix is deferred to a future review pass; record the reason.
- `escalate`: criterion not satisfied because of a substantive product, architecture, or planning change; route to the responsible upstream phase per `DECISIONS.md::model-routing-rules`.

## Anchor Coverage

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::anchor-coverage`

- [ ] `demo/PRODUCT.md` includes anchors for vision, scope, and success definition.
- [ ] `demo/PLAN.md` includes anchors for milestones and per-milestone acceptance.
- [ ] `demo/EXECUTION.md` includes anchors for milestone prompts and a final handoff block.
- [ ] No new file lacks at least one stable anchor.

## Cross-Artifact Consistency

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::cross-artifact-consistency`

- [ ] Every milestone in `demo/PLAN.md` traces to exactly one feature in `demo/PRODUCT.md`.
- [ ] Every prompt block in `demo/EXECUTION.md` traces to exactly one milestone in `demo/PLAN.md`.
- [ ] No artifact contradicts the model routing roles in `DECISIONS.md::model-routing-table`.
- [ ] No artifact references a file or anchor that does not exist.

## Prompt-Only Compliance

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::prompt-only-compliance`

- [ ] No artifact instructs a package install.
- [ ] No artifact instructs an API call or remote service registration.
- [ ] No artifact instructs starting a daemon, worker, or scheduler.
- [ ] No artifact requires a binary, generated executable, or browser extension.
- [ ] No artifact assumes the user has API keys.
- [ ] The bash helper `start-todo-demo.sh` only prints text; it does not perform any of the above.

## Handoff Schema

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::handoff-schema`

- [ ] Every demo step ends with a handoff block matching `TRD.md::handoff-block-schema`.
- [ ] Each handoff block names: completed phase, next phase, recommended model profile, authoritative files, and an exact prompt.
- [ ] No handoff block references chat history.
- [ ] The final review handoff either declares the demo complete or names the responsible upstream phase.

## Boundary Enforcement

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::boundary-enforcement`

- [ ] The strategy step modified only `demo/PRODUCT.md`.
- [ ] The planning step modified only `demo/PLAN.md`.
- [ ] The execution step modified only `demo/EXECUTION.md`.
- [ ] The review step modified only `demo/REVIEW.md`, plus any small consistency or anchor fixes recorded explicitly.
- [ ] No step modified `.hopper/skill/`, `.hopper/prompts/`, `.hopper/demo/` (other files), or top-level LLM-Hopper artifacts.

## Recoverability

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::recoverability`

- [ ] A new reader can reconstruct the full demo flow from the four `demo/*.md` files plus `.hopper/demo/TODO-APP.md` without reading any chat transcript.
- [ ] Each artifact names every file it depends on.
- [ ] The bash helper still prints the correct file list and prompt for each step.

## Release Decision

Anchor: `.hopper/demo/REVIEW-CHECKLIST.md::release-decision`

- [ ] If every checklist item is `pass` or `fix-applied`, record the demo as `complete` in `demo/REVIEW.md` and emit the final handoff with `Next phase: Demo complete`.
- [ ] If any item is `defer`, record the reason and the future trigger in `demo/REVIEW.md`. The demo may still be marked `complete-with-deferrals`.
- [ ] If any item is `escalate`, record the responsible upstream phase. Do not declare the demo complete. The handoff block names the escalation target.
