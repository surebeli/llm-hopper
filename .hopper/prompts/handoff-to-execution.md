# Handoff Prompt: Enter Execution Phase

Anchor: `.hopper/prompts/handoff-to-execution.md::root`

## When To Use

Anchor: `.hopper/prompts/handoff-to-execution.md::when-to-use`

Paste this prompt when starting a new model session that should perform Phase 3 work: build the prompt-only execution kit, the cross-process prompt templates, and the Todo App demo artifacts. Execution work is owned by the Superpowers layer and writes only `.hopper/skill/`, `.hopper/prompts/`, `.hopper/demo/`, and the bash demo helper.

Use this prompt when any of the following apply:

- `.hopper/MANIFEST.md` names Phase 3 as the next phase, or
- A future phase requires a new skill template or prompt template, or
- The Todo App demo artifacts need an update that does not change product or planning decisions.

## Recommended Role

Anchor: `.hopper/prompts/handoff-to-execution.md::recommended-role`

- Role: Execution
- Recommended model: Kimi 2.6
- Acceptable equivalents: DeepSeek V4 Pro Max, GLM 5.1, Mimo V2 Pro
- Source: `DECISIONS.md::model-routing-table`

Optimize cost and iteration speed under written constraints. Reasoning-heavy decisions should be deferred back to a strategy or planning session.

## Files The New Session Must Read

Anchor: `.hopper/prompts/handoff-to-execution.md::files-to-read`

- `.hopper/MANIFEST.md`
- `PROJECT.md`
- `PRD.md`
- `DECISIONS.md`
- `TRD.md`
- `ROADMAP.md`
- `.planning/phases/<current-phase>/*.md` if present
- Existing files under `.hopper/skill/`, `.hopper/prompts/`, and `.hopper/demo/` so duplicates are not created

## Files The New Session May Modify

Anchor: `.hopper/prompts/handoff-to-execution.md::files-allowed-to-modify`

- `.hopper/skill/`
- `.hopper/prompts/`
- `.hopper/demo/`
- `.hopper/MANIFEST.md` only via `hopper-handoff.md`

The session must not modify `PROJECT.md`, `PRD.md`, `DECISIONS.md`, `TRD.md`, `ROADMAP.md`, or `.planning/`. If a requirement is ambiguous or contradicted, stop and route to a strategy or planning session per `DECISIONS.md::model-routing-rules` rule 4.

## Copyable Prompt

Anchor: `.hopper/prompts/handoff-to-execution.md::copyable-prompt`

Open a new Codex CLI session with the recommended execution model. Then paste exactly the block between `BEGIN PROMPT` and `END PROMPT`.

```text
BEGIN PROMPT
LLM-Hopper: enter the execution phase. Read .hopper/MANIFEST.md, then read PROJECT.md, PRD.md, DECISIONS.md, TRD.md, ROADMAP.md, and any .planning/phases/<current-phase>/*.md files. Inspect existing files under .hopper/skill/, .hopper/prompts/, and .hopper/demo/ before writing new ones.

Goal: Produce or update the prompt-only execution kit for the current phase. For Phase 3 this is .hopper/skill/ command templates, .hopper/prompts/ cross-process handoff prompt templates, .hopper/demo/ Todo App demo artifacts, and a pure bash demo start script. For later phases the goal is the bounded artifact set named in TRD.md::phase-mutation-rules.

Constraints:
- Prompt-only, zero-code bootstrap. The bash helper must only print files and prompts. No package installs, API calls, daemons, browser automation, or runtime code generation.
- Use stable anchors: Anchor: `FILE.md::section-name`.
- Modify only the directories owned by the current phase per TRD.md::phase-mutation-rules. Update .hopper/MANIFEST.md only at the phase boundary using .hopper/skill/hopper-handoff.md.
- Do not change PROJECT.md, PRD.md, DECISIONS.md, TRD.md, ROADMAP.md, or .planning/. If a requirement is ambiguous or contradicted, stop and route to a strategy or planning session per DECISIONS.md::model-routing-rules rule 4.

Steps:
1. List the artifacts the current phase owns and confirm none are duplicated.
2. Create or update each required artifact with stable anchors.
3. Verify every template includes required inputs, files to read, files allowed to modify, stop conditions, output format, and a handoff block per TRD.md::skill-template-convention.
4. Verify the Todo demo helper is pure bash and only prints files and prompts per TRD.md::todo-demo-contract.
5. Update .hopper/MANIFEST.md with the next handoff to the review phase.
6. End your reply with the exact handoff block from TRD.md::handoff-block-schema.

Stop and route to a planning session if the roadmap does not list a plan for the current phase.
END PROMPT
```

## Expected Handoff Block

Anchor: `.hopper/prompts/handoff-to-execution.md::expected-handoff`

When the execution session finishes, it must end with:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase 3 - Superpowers execution kit
Next phase: Phase 4 - Quality convergence
Recommended model profile: Review, GPT-5.4 xhigh (or Opus Sonnet 4.6 equivalent)
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
Prompt:
<exact prompt that points the next session at the review phase>
```
