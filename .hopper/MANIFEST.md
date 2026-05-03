# LLM-Hopper Manifest

Anchor: `.hopper/MANIFEST.md::phase-state`

## Runtime Identity

- Runtime identity: LLM-Hopper v0.1
- Host environment: Codex CLI
- Requested model profile: GPT-5.5 xhigh
- Execution mode: prompt-only, zero-code, markdown-artifact-only
- Workspace: `F:\workspace\ai\llm-hopper`
- Timestamp: `2026-05-03T03:14:00+08:00`

## Phase State

- Phase 0: self-initialization complete
- Phase 1: gstack decision layer complete
- Phase 2: GSD context and roadmap layer complete
- Phase 3: Superpowers execution kit complete
- Phase 4: Quality convergence complete
- Current authoritative artifacts:
  - `PROJECT.md`
  - `PRD.md`
  - `DECISIONS.md`
  - `TRD.md`
  - `ROADMAP.md`
  - `.planning/PROJECT.md`
  - `.planning/REQUIREMENTS.md`
  - `.planning/ROADMAP.md`
  - `.planning/STATE.md`
  - `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md`
  - `.planning/phases/02-gsd-context-and-roadmap-layer/02-01-PLAN.md`
  - `.planning/phases/02-gsd-context-and-roadmap-layer/02-02-PLAN.md`
  - `.hopper/MANIFEST.md`
  - `.hopper/skill/README.md`
  - `.hopper/skill/hopper-status.md`
  - `.hopper/skill/hopper-handoff.md`
  - `.hopper/skill/hopper-execute.md`
  - `.hopper/skill/hopper-review.md`
  - `.hopper/prompts/README.md`
  - `.hopper/prompts/handoff-to-strategy.md`
  - `.hopper/prompts/handoff-to-planning.md`
  - `.hopper/prompts/handoff-to-execution.md`
  - `.hopper/prompts/handoff-to-review.md`
  - `.hopper/demo/TODO-APP.md`
  - `.hopper/demo/ACCEPTANCE.md`
  - `.hopper/demo/REVIEW-CHECKLIST.md`
  - `.hopper/demo/start-todo-demo.sh`
- Next phase: Release - LLM-Hopper v0.1

## Persistence Rules

- This manifest is the phase cursor.
- Product and strategy context lives in `PROJECT.md`, `PRD.md`, and `DECISIONS.md`.
- Future phases must update this file instead of relying on chat memory.
- No generated app runtime code, packages, binaries, or external dependencies are allowed during the prompt-only bootstrap.

## Next Handoff Command

LLM-HOPPER HANDOFF
Completed phase: Phase 4 - Quality convergence
Next phase: Release - LLM-Hopper v0.1
Recommended model profile: Strategy or Planning, only if a substantive change is needed; otherwise no further model session is required.
Authoritative files:
- PROJECT.md
- PRD.md
- DECISIONS.md
- TRD.md
- ROADMAP.md
- .planning/ (all files)
- .hopper/MANIFEST.md
- .hopper/skill/ (all files)
- .hopper/prompts/ (all files)
- .hopper/demo/ (all files including start-todo-demo.sh)
Prompt:
LLM-Hopper v0.1 is ready for use. The artifact set has passed quality convergence. To start a new project, open a fresh Codex CLI session with a strategy-class model, clone or fork this repository, and paste the prompt from .hopper/prompts/handoff-to-strategy.md. To run the Todo App demo, run ./.hopper/demo/start-todo-demo.sh. No package installs, API keys, daemons, or binary artifacts are required.
