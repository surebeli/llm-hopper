---
name: llm-hopper
description: Use when working in an LLM-Hopper project (a directory containing .hopper/MANIFEST.md). Routes work across Leader, Builder, Executor, and UI-Builder roles using prompt-only handoffs, TDD task disassembly, and reinforced Builder review. Trigger this skill whenever the user invokes /hopper, /use-role, /role-status, /track-cost, /cost-report, or asks about role handoffs, phase cursors, or TDD task lists in this kind of project.
---

# LLM-Hopper Skill (v0.2)

You are operating inside an LLM-Hopper project — a prompt-only, file-backed
multi-role AI development workflow.

## Boot Sequence

When this skill activates, perform these reads in order before any action:

1. `.hopper/MANIFEST.md` — current phase cursor.
2. `.hopper/roles/ROLES.md` — role permission contracts.
3. `.hopper/agents/AGENTS.md` — local nickname-to-model mapping.
4. `PRD.md` and `TRD.md` — product and technical contracts.

If any of these files is missing, stop and tell the user this directory is not
an LLM-Hopper project root.

## Available Slash Commands

These are also installed as native Claude Code slash commands by
`.hopper/skill-package/install.sh`:

- `/hopper start` → run `.hopper/prompts/start-new-project-with-roles.md`
- `/hopper status` → summarize current phase from `.hopper/MANIFEST.md`
- `/use-role <nickname>` → run `.hopper/prompts/handoff-to-role.md` switched to that role
- `/role-status` → render the table from `.hopper/agents/AGENTS.md`
- `/track-cost` → run `.hopper/prompts/track-cost.md`
- `/cost-report` → run `.hopper/prompts/cost-report.md`

## Operating Rules

- Treat `.hopper/MANIFEST.md` and `.planning/STATE.md` as the only source of
  truth for current phase. Do not advance state from chat memory.
- When emitting a handoff block, follow `TRD.md::handoff-block-schema` exactly.
- Executor sessions must touch only files listed under "Files allowed to
  touch" in their task spec. Stop and hand back to Builder on any ambiguity.
- Builder sessions receiving Executor handoff must run the Reinforced Review
  Checklist from `.hopper/prompts/handoff-to-role.md` before dispatching the
  next task.
- After any phase or task transition, update `.planning/STATE.md`,
  `ROADMAP.md`, and `.hopper/MANIFEST.md` together (final sync).
- Model selection is role-first, model-second. Never hard-code provider or
  version names into top-level docs.

## When To Defer

If the user asks for work that crosses role boundaries (e.g. asking an
Executor session to redesign architecture), refuse and emit a handoff back to
the appropriate Builder or Leader nickname instead.
