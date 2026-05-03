# Phase 2: GSD Context and Roadmap Layer - Discussion Log

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::root`

> Audit trail only. Do not use as input to planning, research, or execution agents.
> Decisions are captured in `02-CONTEXT.md`.

**Date:** 2026-05-03T02:31:03+08:00
**Phase:** 02-gsd-context-and-roadmap-layer
**Areas discussed:** Artifact shape, state persistence, milestone boundaries, skill template naming, Todo demo scope

## Execution Mode Note

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::execution-mode-note`

The user requested end-to-end `discuss-phase` followed by `plan-phase`. Because this Codex runtime is in default execution mode and `gsd-sdk` is unavailable, the discussion was resolved inline from `PROJECT.md`, `PRD.md`, `DECISIONS.md`, and `.hopper/MANIFEST.md` instead of pausing for interactive menu questions.

## Artifact Shape

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::artifact-shape`

| Option | Description | Selected |
| --- | --- | --- |
| Top-level only | Create only `TRD.md` and `ROADMAP.md`. | |
| `.planning` only | Follow GSD internals but hide public artifacts. | |
| Hybrid bridge | Top-level public artifacts plus `.planning` compatibility records. | yes |

**Choice:** Hybrid bridge.
**Notes:** The PRD explicitly names `TRD.md` and `ROADMAP.md`, while GSD workflows expect `.planning` paths.

## State Persistence

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::state-persistence`

| Option | Description | Selected |
| --- | --- | --- |
| Manifest only | Use `.hopper/MANIFEST.md` as canonical state. | yes |
| Manifest plus JSON | Add `.hopper/state.json` now. | |
| JSON first | Treat machine-readable state as canonical. | |

**Choice:** Manifest only.
**Notes:** JSON is deferred because v0.1 proves the markdown protocol before automation.

## Milestone Boundaries

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::milestone-boundaries`

| Option | Description | Selected |
| --- | --- | --- |
| Four phases | Strategy, planning, execution, review. | |
| Five milestones | M00 bootstrap plus M01-M04 workflow layers. | yes |
| Many small phases | Split every artifact into its own milestone. | |

**Choice:** Five milestones.
**Notes:** M00 through M04 maps directly to `PRD.md::mvp-workflow`.

## Skill Template Naming

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::skill-template-naming`

| Option | Description | Selected |
| --- | --- | --- |
| Numbered filenames | `01-status.md`, `02-handoff.md`. | |
| Command-prefixed filenames | `hopper-status.md`, `hopper-handoff.md`. | yes |
| Freeform filenames | Let each template choose names. | |

**Choice:** Command-prefixed filenames.
**Notes:** Lowercase kebab-case names are readable and stable across tools.

## Todo Demo Scope

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::todo-demo-scope`

| Option | Description | Selected |
| --- | --- | --- |
| Artifact-only walkthrough | Markdown scenario, acceptance criteria, review checklist, bash prompt helper. | yes |
| Generated Todo app | Create actual app files. | |
| No demo | Ship only router docs. | |

**Choice:** Artifact-only walkthrough.
**Notes:** This honors the zero-code bootstrap while still proving cross-model handoff.

## the agent's Discretion

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::agent-discretion`

- Exact internal wording of Phase 3 templates.
- Whether `.hopper/prompts/` uses one file per phase or one file per model role, as long as the manifest handoff stays exact.

## Deferred Ideas

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-DISCUSSION-LOG.md::deferred-ideas`

- `.hopper/state.json`
- Plugin packaging
- API orchestration
- Browser extension automation
