# Handoff Prompt: Enter Strategy Phase

Anchor: `.hopper/prompts/handoff-to-strategy.md::root`

## When To Use

Anchor: `.hopper/prompts/handoff-to-strategy.md::when-to-use`

Paste this prompt when starting a new model session that should perform Phase 1 work or arbitrate a strategy-level conflict between artifacts. Strategy work is owned by the gstack layer and writes only `PROJECT.md`, `PRD.md`, and `DECISIONS.md`.

Use this prompt when any of the following apply:

- The repository contains `.hopper/MANIFEST.md` and Phase 1 is the next phase, or
- An execution or review session has stopped because of an ambiguous requirement, or
- A decision in `DECISIONS.md` is contradicted by a downstream artifact.

## Recommended Role

Anchor: `.hopper/prompts/handoff-to-strategy.md::recommended-role`

- Role: Strategy
- Recommended model: GPT-5.5 xhigh
- Acceptable equivalents: Opus 4.7, Opus 4.6 equivalent
- Source: `DECISIONS.md::model-routing-table`

## Files The New Session Must Read

Anchor: `.hopper/prompts/handoff-to-strategy.md::files-to-read`

- `.hopper/MANIFEST.md`
- `PROJECT.md` (if present)
- `PRD.md` (if present)
- `DECISIONS.md` (if present)
- Any planning records under `.planning/phases/` named in the manifest

If `PROJECT.md` does not exist, the session should treat the work as a Phase 1 cold start and create it.

## Files The New Session May Modify

Anchor: `.hopper/prompts/handoff-to-strategy.md::files-allowed-to-modify`

- `PROJECT.md`
- `PRD.md`
- `DECISIONS.md`
- `.hopper/MANIFEST.md` (only via the `hopper-handoff.md` skill at the phase boundary)

The session must not modify `TRD.md`, `ROADMAP.md`, `.planning/`, `.hopper/skill/`, `.hopper/prompts/`, or `.hopper/demo/`. If a downstream artifact must change, the session ends with a handoff that names the responsible phase.

## Copyable Prompt

Anchor: `.hopper/prompts/handoff-to-strategy.md::copyable-prompt`

Open a new Codex CLI session with the recommended model. Then paste exactly the block between `BEGIN PROMPT` and `END PROMPT`.

```text
BEGIN PROMPT
LLM-Hopper: enter the strategy phase. Read .hopper/MANIFEST.md, then read PROJECT.md, PRD.md, and DECISIONS.md if they exist. If they do not exist, you are starting Phase 1 (gstack strategy layer) and you must create them per PRD.md::functional-requirements FR-2.

Constraints:
- Prompt-only, zero-code bootstrap. No package installs, API calls, daemons, browser automation, or runtime code generation.
- Use stable anchors of the form: Anchor: `FILE.md::section-name`.
- Modify only PROJECT.md, PRD.md, and DECISIONS.md during this session. Update .hopper/MANIFEST.md only at the phase boundary using the .hopper/skill/hopper-handoff.md protocol.

Steps:
1. Pressure-test the product idea, define vision, write PRD, and record accepted decisions plus the model routing table.
2. Verify every durable section has a stable anchor.
3. Update .hopper/MANIFEST.md with the next handoff to the planning phase.
4. End your reply with the exact handoff block from TRD.md::handoff-block-schema.

Stop and ask the user instead of guessing if any user-facing requirement is ambiguous.
END PROMPT
```

## Expected Handoff Block

Anchor: `.hopper/prompts/handoff-to-strategy.md::expected-handoff`

When the strategy session finishes, it must end with:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase 1 - gstack strategy layer
Next phase: Phase 2 - GSD context and roadmap layer
Recommended model profile: Planning, GPT-5.5 xhigh (or Opus 4.7 equivalent)
Authoritative files:
- PROJECT.md
- PRD.md
- DECISIONS.md
- .hopper/MANIFEST.md
Prompt:
<exact prompt that points the next session at the planning phase>
```
