# LLM-Hopper Manifest

Anchor: `.hopper/MANIFEST.md::phase-state`

## Runtime Identity

- Runtime identity: LLM-Hopper v0.2 (Phase 4 complete, Phase 5 pending)
- Host environment: Codex CLI / Claude Code CLI (compatible)
- Requested model profile: Builder (kimi-2.6) for disassembly + review; Executor (glm-5.1) for atomic task execution
- Execution mode: prompt-only handoff kit; Phase 5 validation build not started
- Workspace: `F:\workspace\ai\llm-hopper`
- Timestamp: `2026-05-05T00:00:00+08:00`

## Phase State

- Phase 0: self-initialization complete
- Phase 1: gstack decision layer complete
- Phase 2: GSD context and roadmap layer complete
- Phase 3: Superpowers execution kit complete
- Phase 4: Quality convergence complete
- Phase 5: Superpowers Todo App Build validation — PENDING (no Executor task dispatched)
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
  - `.hopper/prompts/handoff-to-role.md`
  - `.hopper/roles/ROLES.md`
  - `.hopper/agents/AGENTS.md`
  - `.hopper/costs/COST-LOG.md`
  - `.hopper/demo/TODO-APP.md`
  - `.hopper/demo/ACCEPTANCE.md`
  - `.hopper/demo/REVIEW-CHECKLIST.md`
  - `.hopper/demo/start-todo-demo.sh`
- Next phase: Phase 5 plan 05-00 — Builder starts Todo App task disassembly, then dispatches the first Executor task only after the task list is reviewed

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
Completed phase: Phase 4 — Quality Convergence
Next phase: Phase 5 plan 05-00 — Builder Todo App task disassembly
Recommended model profile: Builder role; choose the current configured Builder agent.
Authoritative files:
- `.hopper/MANIFEST.md`
- `.hopper/roles/ROLES.md`
- `.hopper/agents/AGENTS.md`
- `.hopper/prompts/handoff-to-role.md`
- `ROADMAP.md` (Phase 5 section)
- `.planning/STATE.md`
Prompt:
Use `.hopper/prompts/start-new-project-with-roles.md` or `.hopper/prompts/handoff-to-role.md` to start Phase 5. The Builder must first produce a reviewed task list with RED/GREEN/REFACTOR acceptance criteria before any Executor receives implementation scope.
