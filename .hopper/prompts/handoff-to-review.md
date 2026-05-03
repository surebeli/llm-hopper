# Handoff Prompt: Enter Review Phase

Anchor: `.hopper/prompts/handoff-to-review.md::root`

## When To Use

Anchor: `.hopper/prompts/handoff-to-review.md::when-to-use`

Paste this prompt when starting a new model session that should perform Phase 4 work: cross-artifact consistency, anchor coverage, prompt-only constraint check, and release readiness. Review work writes only consistency or anchor corrections and the manifest update; substantive product or architecture changes route back to strategy or planning.

Use this prompt when any of the following apply:

- `.hopper/MANIFEST.md` names Phase 4 as the next phase, or
- A major artifact has just been written and the user wants to verify it against `PRD.md`, `DECISIONS.md`, and `TRD.md`, or
- A release candidate needs sign-off against `ROADMAP.md::m04-quality-convergence`.

## Recommended Role

Anchor: `.hopper/prompts/handoff-to-review.md::recommended-role`

- Role: Review
- Recommended model: GPT-5.4 xhigh
- Acceptable equivalents: Opus Sonnet 4.6
- Source: `DECISIONS.md::model-routing-table`

Review is a synthesis role: lower cost than initial strategy while maintaining rigor. Escalate substantive product conflicts back to strategy per `DECISIONS.md::model-routing-rules` rule 5.

## Files The New Session Must Read

Anchor: `.hopper/prompts/handoff-to-review.md::files-to-read`

- `.hopper/MANIFEST.md`
- `PROJECT.md`
- `PRD.md`
- `DECISIONS.md`
- `TRD.md`
- `ROADMAP.md`
- `.planning/PROJECT.md`, `.planning/REQUIREMENTS.md`, `.planning/ROADMAP.md`, `.planning/STATE.md`
- `.planning/phases/**/*.md`
- `.hopper/skill/*.md`
- `.hopper/prompts/*.md`
- `.hopper/demo/*.md`
- `.hopper/demo/start-todo-demo.sh`

## Files The New Session May Modify

Anchor: `.hopper/prompts/handoff-to-review.md::files-allowed-to-modify`

- Any artifact with a justified consistency, anchor, or polish correction.
- `.hopper/MANIFEST.md` to record the review pass and advance the phase cursor.
- `.hopper/review/` if the user explicitly asks for a separate review log.

The review session must not introduce new product requirements, architecture decisions, or roadmap milestones. Substantive product changes log a new entry in `DECISIONS.md` only after a strategy session is run.

## Copyable Prompt

Anchor: `.hopper/prompts/handoff-to-review.md::copyable-prompt`

Open a new Codex CLI session with the recommended review model. Then paste exactly the block between `BEGIN PROMPT` and `END PROMPT`.

```text
BEGIN PROMPT
LLM-Hopper: enter the review phase. Read .hopper/MANIFEST.md, then read PROJECT.md, PRD.md, DECISIONS.md, TRD.md, ROADMAP.md, all .planning/ artifacts, and every file under .hopper/skill/, .hopper/prompts/, and .hopper/demo/.

Goal: Verify the v0.1 artifact set against PRD.md::release-criteria and DECISIONS.md::architecture-constraints. Apply only consistency, anchor, or polish fixes. Substantive product or architecture changes are out of scope; route them to strategy.

Constraints:
- Prompt-only, zero-code bootstrap. No package installs, API calls, daemons, browser automation, or runtime code generation.
- Modify only consistency, anchor, or polish fixes plus .hopper/MANIFEST.md. Use stable anchors: Anchor: `FILE.md::section-name`.
- Do not introduce new product requirements, architectural decisions, or roadmap milestones.

Checklist:
1. Every durable section has a stable anchor.
2. Every phase ends in an exact handoff block per TRD.md::handoff-block-schema.
3. .hopper/MANIFEST.md names the correct current and next phase.
4. ROADMAP.md milestone scope matches PRD.md::mvp-workflow.
5. No artifact instructs a package install, API call, daemon, or binary generation for v0.1 bootstrap.
6. .hopper/skill/ templates contain required inputs, files to read, files allowed to modify, stop conditions, output format, and a handoff block.
7. .hopper/prompts/ templates carry copyable prompts that cite files, not chat summaries.
8. .hopper/demo/ artifacts and the bash helper meet TRD.md::todo-demo-contract.

Steps:
1. Run the checklist and record findings.
2. Apply allowed fixes inline; defer or escalate the rest.
3. Update .hopper/MANIFEST.md to mark Phase 4 complete and declare v0.1 ready for use, or describe the gating fix.
4. End your reply with the exact handoff block from TRD.md::handoff-block-schema.

Stop and route any substantive change to a strategy session per DECISIONS.md::model-routing-rules rule 5.
END PROMPT
```

## Expected Handoff Block

Anchor: `.hopper/prompts/handoff-to-review.md::expected-handoff`

When the review session finishes successfully, it must end with:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase 4 - Quality convergence
Next phase: Release - LLM-Hopper v0.1
Recommended model profile: Strategy or Planning, only if a substantive change is needed; otherwise no further session is required.
Authoritative files:
- PROJECT.md
- PRD.md
- DECISIONS.md
- TRD.md
- ROADMAP.md
- .hopper/MANIFEST.md
- .hopper/skill/
- .hopper/prompts/
- .hopper/demo/
- .planning/
Prompt:
<release confirmation prompt for the user, or a remediation prompt that names the responsible upstream phase>
```
