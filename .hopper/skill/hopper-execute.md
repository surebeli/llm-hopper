# Skill: hopper-execute

Anchor: `.hopper/skill/hopper-execute.md::root`

## Purpose

Anchor: `.hopper/skill/hopper-execute.md::purpose`

Run bounded execution work for the current phase. This skill takes a phase plan and produces only the artifacts that the phase owns, then triggers the manifest handoff. It is the default entry point for Phase 3 (Superpowers execution kit) and any future phase that follows the plan-and-execute pattern.

## Required Inputs

Anchor: `.hopper/skill/hopper-execute.md::required-inputs`

- The current phase name from `.hopper/MANIFEST.md`.
- A plan reference, either:
  - The bullet list under the matching `ROADMAP.md::m0N-...` entry, or
  - A `.planning/phases/<phase>/<plan>.md` file when one exists.
- A model session matching the role from `DECISIONS.md::model-routing-table` for the current phase.

If the manifest names a phase whose plan list is empty, stop and request a planning pass before executing.

## Files To Read

Anchor: `.hopper/skill/hopper-execute.md::files-to-read`

1. `.hopper/MANIFEST.md` (mandatory; phase cursor).
2. `PROJECT.md` (mandatory; vision and scope guardrails).
3. `PRD.md` (mandatory; functional and non-functional requirements).
4. `DECISIONS.md` (mandatory; routing rules and architecture constraints).
5. `TRD.md` (mandatory; phase mutation rules and skill conventions).
6. `ROADMAP.md` (mandatory; current phase scope and success criteria).
7. The plan file or roadmap bullet list for the current phase.
8. Existing artifacts in the directories the phase owns, so this skill does not create duplicates.

## Files Allowed To Modify

Anchor: `.hopper/skill/hopper-execute.md::files-allowed-to-modify`

The current phase's owned directories per `TRD.md::phase-mutation-rules`. For Phase 3 this is:

- `.hopper/skill/`
- `.hopper/prompts/`
- `.hopper/demo/`
- `.hopper/MANIFEST.md` (only via `hopper-handoff.md` semantics at the phase boundary).

Do not modify `PROJECT.md`, `PRD.md`, `DECISIONS.md`, `TRD.md`, `ROADMAP.md`, or `.planning/` from this skill. If a contradiction is discovered, stop and route the issue to a strategy or planning model per `DECISIONS.md::model-routing-rules` rule 4.

## Stop Conditions

Anchor: `.hopper/skill/hopper-execute.md::stop-conditions`

- Stop when every required artifact for the current phase exists and contains the required anchors.
- Stop and request a strategy update if a requirement in `PRD.md` is ambiguous.
- Stop and request a planning update if `ROADMAP.md` does not list a plan for the current phase.
- Stop without modifying any file if the manifest's current phase does not match the phase the user named.
- Never install packages, run code generators, call APIs, or start daemons. Violating this aborts the skill.

## Output Format

Anchor: `.hopper/skill/hopper-execute.md::output-format`

After all phase artifacts are written, emit:

```text
LLM-HOPPER EXECUTION SUMMARY
Phase: <phase name>
Plan: <plan id or roadmap bullet>
Artifacts created or updated:
- <path>
- <path>
Anchors verified: <count>
Constraints respected:
- prompt-only
- file-anchored
- bounded-write
Open follow-ups:
- <none, or specific deferred item>
```

If any acceptance criterion from the plan is not yet met, list it under `Open follow-ups` and do not call `hopper-handoff.md` yet.

## Required Handoff Block

Anchor: `.hopper/skill/hopper-execute.md::handoff-block`

When all acceptance criteria are met, invoke `hopper-handoff.md` against `.hopper/MANIFEST.md` so the next phase prompt is written. The emitted handoff block must conform to `TRD.md::handoff-block-schema`:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase N - <name>
Next phase: Phase N+1 - <name>
Recommended model profile: <role>, <model name>
Authoritative files:
- <path>
- <path>
Prompt:
<exact prompt for the next session>
```

The prompt must cite files by path and name only the directories the next phase is allowed to write. Do not embed chat history or transient state.
