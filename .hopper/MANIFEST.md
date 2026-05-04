# LLM-Hopper Manifest

Anchor: `.hopper/MANIFEST.md::phase-state`

## Runtime Identity

- Runtime identity: LLM-Hopper v0.1
- Host environment: Codex CLI
- Requested model profile: GPT-5.5 xhigh
- Execution mode: prompt-only, zero-code, markdown-artifact-only
- Workspace: `F:\workspace\ai\llm-hopper`
- Timestamp: `2026-05-04T02:03:40+08:00`

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

## Role-to-Agent Mapping

Primary identifier: **Nickname** (UUID is fallback).

| Nickname | Role | Model | UUID | Activated |
|----------|------|-------|------|-----------|
| `leader-opus-47` | Leader | `claude-opus-4-7` | `2620cc7a-25e6-4059-999e-17af54bdcaf4` | 2026-05-03 |
| `builder-kimi` | Builder | `kimi-2.6` | `6c5ac7fa-7a5e-40b4-920a-b4fe1d562876` | 2026-05-04 |
| `executor-glm` | Executor | `glm-5.1` | `820cba1c-80de-45fc-a514-2f5de38fd804` | 2026-05-03 |
| `ui-builder-gemini` | UI-Builder | `gemini-3.1-pro` | `bbf6602d-13c0-42d3-a1fc-59cbe7424b49` | 2026-05-03 |
| `mimo` | Builder | `mimo-v2.5-pro` | `6db17b47-ba7f-4a16-8890-832ce18c43cb` | 2026-05-04 |
| `executor-deepseek` | Executor | `deepseek-v4-flash` | `b35ea656-1833-40b0-81cd-99c3a533da1a` | 2026-05-04 |

- UI Direction: enabled (Builder only — UI-Leader / UI-Executor unassigned)
- Agents file: `.hopper/agents/AGENTS.md`
- Reassignment: update both this table and `AGENTS.md` together; UUIDs are stable across model swaps.

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
