# Handoff Prompt: Enter Planning Phase

Anchor: `.hopper/prompts/handoff-to-planning.md::root`

## When To Use

Anchor: `.hopper/prompts/handoff-to-planning.md::when-to-use`

Paste this prompt when starting a new model session that should perform Phase 2 work: convert the gstack strategy layer into the technical routing contract and milestone roadmap. Planning work is owned by the GSD layer and writes only `TRD.md`, `ROADMAP.md`, and `.planning/`.

Use this prompt when any of the following apply:

- `.hopper/MANIFEST.md` names Phase 2 as the next phase, or
- An execution session has stopped because the roadmap or technical contract is missing or ambiguous, or
- A new milestone needs to be added to `ROADMAP.md`.

## Recommended Role

Anchor: `.hopper/prompts/handoff-to-planning.md::recommended-role`

- Role: Planning
- Recommended model: GPT-5.5 xhigh
- Acceptable equivalents: Opus 4.7, Opus 4.6 equivalent
- Source: `DECISIONS.md::model-routing-table`

## Files The New Session Must Read

Anchor: `.hopper/prompts/handoff-to-planning.md::files-to-read`

- `.hopper/MANIFEST.md`
- `PROJECT.md`
- `PRD.md`
- `DECISIONS.md`
- `TRD.md` (if present from a prior pass)
- `ROADMAP.md` (if present from a prior pass)
- `.planning/PROJECT.md`, `.planning/REQUIREMENTS.md`, `.planning/ROADMAP.md`, `.planning/STATE.md` if present
- All files under `.planning/phases/` for the active phase

## Files The New Session May Modify

Anchor: `.hopper/prompts/handoff-to-planning.md::files-allowed-to-modify`

- `TRD.md`
- `ROADMAP.md`
- `.planning/PROJECT.md`
- `.planning/REQUIREMENTS.md`
- `.planning/ROADMAP.md`
- `.planning/STATE.md`
- `.planning/phases/<phase>/` records for the current phase
- `.hopper/MANIFEST.md` only via `hopper-handoff.md`

The session must not modify `PROJECT.md`, `PRD.md`, `DECISIONS.md`, `.hopper/skill/`, `.hopper/prompts/`, or `.hopper/demo/`. If a strategy decision must change, stop and route to a strategy session per `DECISIONS.md::model-routing-rules` rule 4.

## Copyable Prompt

Anchor: `.hopper/prompts/handoff-to-planning.md::copyable-prompt`

Open a new Codex CLI session with the recommended model. Then paste exactly the block between `BEGIN PROMPT` and `END PROMPT`.

```text
BEGIN PROMPT
LLM-Hopper: enter the planning phase. Read .hopper/MANIFEST.md, then read PROJECT.md, PRD.md, and DECISIONS.md. Read TRD.md, ROADMAP.md, and .planning/ artifacts if they exist.

Goal: Produce or refine TRD.md and ROADMAP.md so the technical routing contract and milestone roadmap match PRD.md::functional-requirements and DECISIONS.md::model-routing-table. Mirror them under .planning/ for GSD compatibility.

Constraints:
- Prompt-only, zero-code bootstrap. No package installs, API calls, daemons, browser automation, or runtime code generation.
- Use stable anchors: Anchor: `FILE.md::section-name`.
- Modify only TRD.md, ROADMAP.md, and .planning/. Update .hopper/MANIFEST.md only at the phase boundary using .hopper/skill/hopper-handoff.md.
- Do not change PROJECT.md, PRD.md, or DECISIONS.md. If a strategy decision must change, stop and request a strategy session per DECISIONS.md::model-routing-rules rule 4.

Steps:
1. Define or refresh TRD.md sections: technical intent, system contract, artifact map, state model, router protocol, handoff block schema, model routing interface, phase mutation rules, skill template convention, Todo demo contract, verification contract, deferred technical ideas.
2. Define or refresh ROADMAP.md milestones M00 through M04 with goals, dependencies, requirements, success criteria, and plans.
3. Update .planning/ bridge files and the current .planning/phases/ records.
4. Update .hopper/MANIFEST.md with the next handoff to the execution phase.
5. End your reply with the exact handoff block from TRD.md::handoff-block-schema.

Stop and route to a strategy session if any architectural decision is ambiguous.
END PROMPT
```

## Expected Handoff Block

Anchor: `.hopper/prompts/handoff-to-planning.md::expected-handoff`

When the planning session finishes, it must end with:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase 2 - GSD context and roadmap layer
Next phase: Phase 3 - Superpowers execution kit
Recommended model profile: Execution, Kimi 2.6 (or DeepSeek V4 Pro Max, GLM 5.1, Mimo V2 Pro equivalent)
Authoritative files:
- PROJECT.md
- PRD.md
- DECISIONS.md
- TRD.md
- ROADMAP.md
- .hopper/MANIFEST.md
- .planning/ files for the current phase
Prompt:
<exact prompt that points the next session at the execution phase>
```
