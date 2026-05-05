# LLM-Hopper Manifest

Anchor: `.hopper/MANIFEST.md::phase-state`

## Runtime Identity

- Runtime identity: LLM-Hopper v0.2 (Superpowers Todo App build, in progress)
- Host environment: Codex CLI / Claude Code CLI (compatible)
- Requested model profile: Builder (kimi-2.6) for disassembly + review; Executor (glm-5.1) for atomic task execution
- Execution mode: prompt-only handoff kit + real apps/todo/ implementation
- Workspace: `F:\workspace\ai\llm-hopper`
- Timestamp: `2026-05-05T00:00:00+08:00`

## Phase State

- Phase 0: self-initialization complete
- Phase 1: gstack decision layer complete
- Phase 2: GSD context and roadmap layer complete
- Phase 3: Superpowers execution kit complete
- Phase 4: Quality convergence complete
- Phase 5: Superpowers Todo App Build — IN PROGRESS (spec disassembled by builder-kimi 2026-05-05; T01 dispatched to executor-glm)
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
  - `.planning/phases/05-todo-app-build/TASK-LIST.md`
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
  - `.hopper/prompts/handoff-to-role.md`
  - `.hopper/roles/ROLES.md`
  - `.hopper/agents/AGENTS.md`
  - `.hopper/costs/COST-LOG.md`
  - `.hopper/demo/TODO-APP.md`
  - `.hopper/demo/ACCEPTANCE.md`
  - `.hopper/demo/REVIEW-CHECKLIST.md`
  - `.hopper/demo/start-todo-demo.sh`
- Next phase: Phase 5 plan 05-01 — Executor builds T01 (`apps/todo/index.html`), then hands back to Builder for review

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
Completed phase: Phase 5 plan 05-00 — Builder spec disassembly (`builder-kimi`)
Next phase: Phase 5 plan 05-01 — Executor builds T01 (`apps/todo/index.html`)
Recommended model profile: Executor (`executor-glm`, model `glm-5.1`); fallback `executor-deepseek`.
Authoritative files:
- `.hopper/MANIFEST.md`
- `.hopper/roles/ROLES.md`
- `.hopper/agents/AGENTS.md`
- `.hopper/prompts/handoff-to-role.md`
- `.planning/phases/05-todo-app-build/TASK-LIST.md` (read T01 section only — out-of-scope)
- `ROADMAP.md` (Phase 5 section)
- `.planning/STATE.md`
Prompt:
See the HANDOFF TO ROLE block emitted by `builder-kimi` at the end of the spec-disassembly turn (target: `executor-glm`, scope: T01 only). The Executor must implement only `apps/todo/index.html` per T01's contract, must not introduce CSS or JS, and must hand back to Builder upon GREEN.
