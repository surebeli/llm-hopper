# LLM-Hopper Prompt Entry Points

Anchor: `.hopper/prompts/README.md::root`

## Overview

Anchor: `.hopper/prompts/README.md::overview`

This directory intentionally keeps only the active v0.2 prompt surface. The main workflow starts with `start-new-project-with-roles.md` and continues through `handoff-to-role.md`. Cost prompts remain separate because they can be used independently after any handoff.

## Active Prompts

Anchor: `.hopper/prompts/README.md::active-prompts`

| Prompt | Purpose |
| --- | --- |
| `start-new-project-with-roles.md` | Start a new role-based workflow, load roles, and route through Leader -> Builder -> Executor -> Builder review. |
| `handoff-to-role.md` | Continue any phase or task with final sync, role handoff, TDD task spec, and Builder reinforced review. |
| `track-cost.md` | Record token and cost notes after a session or major handoff. |
| `cost-report.md` | Summarize `.hopper/costs/COST-LOG.md`. |

## Removed Compatibility Prompts

Anchor: `.hopper/prompts/README.md::removed-prompts`

The older phase-specific prompts (`handoff-to-strategy`, `handoff-to-planning`, `handoff-to-execution`, `handoff-to-review`) and setup prompts (`setup-roles`, `reconfigure-roles`, `register-me`, `role-status`) were removed in v0.2.1 cleanup because their behavior is now covered by the two main role workflow prompts and `.hopper/agents/AGENTS.md`.

## Usage

Anchor: `.hopper/prompts/README.md::usage`

1. Start with `.hopper/MANIFEST.md` to confirm the current phase.
2. For a new project or validation run, paste `start-new-project-with-roles.md`.
3. For all later transitions, paste `handoff-to-role.md`.
4. After a major phase or handoff, optionally use `track-cost.md` and `cost-report.md`.

Prompts route by role first. Concrete model choices live in local configuration files and may be changed without changing the workflow.
