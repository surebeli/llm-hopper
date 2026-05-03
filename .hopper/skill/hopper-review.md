# Skill: hopper-review

Anchor: `.hopper/skill/hopper-review.md::root`

## Purpose

Anchor: `.hopper/skill/hopper-review.md::purpose`

Run quality convergence on the LLM-Hopper artifact set. The review verifies cross-artifact consistency, anchor coverage, prompt-only compliance, and release readiness. This skill is the default entry point for Phase 4 and is also used after any major artifact change.

## Required Inputs

Anchor: `.hopper/skill/hopper-review.md::required-inputs`

- A model session matched to the review role in `DECISIONS.md::model-routing-table`.
- Confirmation that the phase under review has emitted its handoff block.
- The list of artifacts to review, taken from `TRD.md::artifact-map` and `ROADMAP.md`.

## Files To Read

Anchor: `.hopper/skill/hopper-review.md::files-to-read`

1. `.hopper/MANIFEST.md` (mandatory; phase cursor and authoritative file list).
2. `PROJECT.md`, `PRD.md`, `DECISIONS.md`, `TRD.md`, `ROADMAP.md` (mandatory; cross-check anchors and scope).
3. `.planning/PROJECT.md`, `.planning/REQUIREMENTS.md`, `.planning/ROADMAP.md`, `.planning/STATE.md` (mandatory; GSD bridge consistency).
4. `.hopper/skill/*.md` (mandatory; verify the convention from `TRD.md::skill-template-convention`).
5. `.hopper/prompts/*.md` (mandatory; verify cross-process prompt schema).
6. `.hopper/demo/*.md` and `.hopper/demo/start-todo-demo.sh` (mandatory; verify the prompt-only Todo demo contract).

## Files Allowed To Modify

Anchor: `.hopper/skill/hopper-review.md::files-allowed-to-modify`

- Any artifact whose change the review explicitly justifies in writing, but only for consistency, anchor, or polish corrections.
- `.hopper/MANIFEST.md` to record the review pass and advance to the next phase.
- A new review log file under `.hopper/review/` is permitted only if the user requests it; otherwise findings are inlined into the response.

The review skill must not introduce new product requirements or new architecture decisions. Substantive product changes must be logged as a new entry in `DECISIONS.md` by a strategy model, not by the review skill.

## Stop Conditions

Anchor: `.hopper/skill/hopper-review.md::stop-conditions`

- Stop and report a defect rather than silently rewriting an artifact.
- Stop if a required anchor is missing; instruct the owning phase to add it.
- Stop if any artifact violates the prompt-only, zero-code bootstrap constraint defined in `DECISIONS.md::architecture-constraints`.
- Stop if `.hopper/MANIFEST.md` lists artifacts that do not exist on disk.
- Do not run application tests, code generators, package installers, or daemons.

## Output Format

Anchor: `.hopper/skill/hopper-review.md::output-format`

Emit a structured review report:

```text
LLM-HOPPER REVIEW
Reviewed phase: <phase name>
Artifacts checked:
- <path>: <pass | fix-needed | defect>
Anchor coverage: <count present> / <count expected>
Cross-artifact consistency: <pass | issues>
Prompt-only compliance: <pass | issues>
Release readiness: <pass | not-yet>
Findings:
- [F-1] <finding>: <fix recommendation>
- [F-2] <finding>: <fix recommendation>
Resolved during review:
- [F-1] <description of fix applied>
Deferred:
- [F-2] <reason for deferral and owner>
```

If `Release readiness` is `pass`, proceed to update the manifest and emit the handoff block.

## Required Handoff Block

Anchor: `.hopper/skill/hopper-review.md::handoff-block`

The review handoff conforms to `TRD.md::handoff-block-schema`. After a passing review, the manifest must advance the phase cursor and produce the release handoff:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase N - <name>
Next phase: <Release | Phase N+1 - name>
Recommended model profile: <role>, <model>
Authoritative files:
- <path>
- <path>
Prompt:
<exact prompt for the next session, or a release confirmation prompt for users>
```

When the review concludes with open findings, do not write a forward handoff. Instead, the response must point back to the owning phase and ask the user to rerun the appropriate skill (`hopper-execute.md` or a strategy session) before review can pass.
