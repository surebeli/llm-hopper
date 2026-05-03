# LLM-Hopper PRD

Anchor: `PRD.md::root`

## 1. Overview

LLM-Hopper v0.1 is a prompt-only, zero-code orchestration kit for multi-model development inside Codex CLI-style workflows. It defines a three-layer stack:

1. gstack for decision quality and product strategy.
2. GSD / GSD-2 for context anchoring and milestone decomposition.
3. Superpowers for TDD execution and quality discipline.

The MVP is implemented entirely as markdown artifacts in the current project folder. It treats the repo as shared memory and uses explicit handoff prompts to move work between independent model sessions.

## 2. Goals

Anchor: `PRD.md::goals`

### Primary Goals

- Preserve context across model sessions using files, not chat memory.
- Route work to the model class best suited for the phase.
- Make every phase transition explicit and repeatable.
- Keep the workflow usable without APIs, packages, binaries, or background services.
- Provide enough structure for a developer to run an end-to-end sample project.

### Non-Goals

- LLM-Hopper v0.1 will not execute code on behalf of remote models.
- It will not install packages or run a daemon.
- It will not assume one vendor, one IDE, or one persistent agent process.
- It will not hide decisions inside generated logs that humans cannot read.

## 3. Users and Jobs

Anchor: `PRD.md::users-and-jobs`

### Primary Persona: Multi-Model Builder

The primary user pays for or has access to multiple models and wants to combine them deliberately:

- Strong reasoning model for strategy.
- Planning model for requirements and milestone shape.
- Low-cost coding model for bounded execution.
- Strong review model for final quality convergence.

### Jobs To Be Done

- When starting a project, I want a clear strategy and PRD so execution models do not invent product direction.
- When switching models, I want a reliable handoff prompt so I do not rewrite context manually.
- When splitting work, I want model routing rules so I can choose the cheapest acceptable model for each phase.
- When reviewing deliverables, I want the review model to see the same artifacts as the execution model.
- When resuming later, I want the manifest to tell me the current phase and the next command.

## 4. User Stories

Anchor: `PRD.md::user-stories`

### Strategy User Stories

- As a project owner, I can ask LLM-Hopper to run the gstack decision process and produce `PROJECT.md`, `PRD.md`, and `DECISIONS.md`.
- As a project owner, I can inspect decision logs and model routing rules before execution begins.
- As a project owner, I can reject or revise strategy by editing markdown, not by searching chat history.

### Planning User Stories

- As a planner, I can start a new session from the gstack handoff block and reconstruct context from files.
- As a planner, I can produce a TRD and milestone roadmap without needing the original chat.
- As a planner, I can anchor every milestone to a file and section.

### Execution User Stories

- As an execution model, I can receive a bounded phase prompt with enough context to run Superpowers-style planning and TDD.
- As an execution model, I can update markdown templates and demo artifacts without changing product decisions.
- As a reviewer, I can compare outputs against PRD, TRD, DECISIONS, and ROADMAP anchors.

### Handoff User Stories

- As a user, I can copy the exact handoff block at the end of a phase and paste it into a new Codex CLI session.
- As a user, I can see the next handoff command in `.hopper/MANIFEST.md`.
- As a user, I can recover from session loss by reopening the repository and reading the manifest.

## 5. Functional Requirements

Anchor: `PRD.md::functional-requirements`

### FR-1: Phase Manifest

LLM-Hopper must maintain `.hopper/MANIFEST.md` as the current phase cursor. The manifest must record runtime identity, host environment, requested model profile, timestamp, authoritative artifacts, current phase, and next handoff command.

### FR-2: gstack Artifacts

The gstack phase must produce:

- `PROJECT.md`: one-page vision, problem statement, pressure test, scope, and success definition.
- `PRD.md`: lean product requirements, user stories, success metrics, and non-functional requirements.
- `DECISIONS.md`: decision log, high-level architecture, model routing table, and routing rules.

### FR-3: GSD Artifacts

The GSD phase must produce:

- `TRD.md`: router logic, handoff mechanism, model routing table, state persistence rules, and technical constraints.
- `ROADMAP.md`: milestone roadmap M00 through M04, effort estimates, risks, and exit criteria.

### FR-4: Superpowers Artifacts

The Superpowers phase must produce:

- `.hopper/skill/` markdown templates for router commands.
- Cross-process handoff prompt templates.
- A simple Todo App demo described entirely through workflow artifacts.
- A pure bash start script plus prompt instructions, with no package or binary dependency assumptions.

### FR-5: Handoff Blocks

Every phase must end with an exact handoff block and no trailing content. Handoff blocks must name the completed phase, the next Codex CLI model recommendation, and the prompt to paste into the new session.

### FR-6: File Anchoring

Every durable requirement, decision, milestone, and template must include a stable file anchor using the format:

```text
Anchor: `FILE.md::section-name`
```

### FR-7: Prompt-Only Constraint

All MVP deliverables must be markdown or plain-text prompt instructions. No external code, packages, binaries, or generated app runtime files are required for the initial bootstrap.

## 6. Non-Functional Requirements

Anchor: `PRD.md::non-functional-requirements`

### NFR-1: Recoverability

A new model session must be able to continue from the repository files without access to prior chat context.

### NFR-2: Auditability

Every major product, architecture, routing, and quality decision must be written in a human-readable artifact.

### NFR-3: Model Portability

Routing rules must describe model roles and recommended models while allowing equivalent replacements.

### NFR-4: Minimal Setup

The MVP must run with a Git checkout and Codex CLI-style sessions only.

### NFR-5: Human Control

The human operator must remain responsible for launching new model sessions, pasting handoffs, and approving major phase changes.

### NFR-6: Bounded Output

Each phase must update only its expected artifact set unless a later phase explicitly expands the scope.

## 7. Success Metrics

Anchor: `PRD.md::success-metrics`

### Activation Metrics

- A first-time user can identify the current phase and next command from `.hopper/MANIFEST.md` in under one minute.
- A first-time user can run the gstack to GSD handoff without needing unstated chat context.

### Workflow Quality Metrics

- Every phase produces all required artifacts with stable anchors.
- Every phase ends in an exact handoff block.
- No required step depends on an API key, package install, daemon, or binary artifact.

### Outcome Metrics

- The Todo App demo can be followed end-to-end by starting separate sessions for strategy, planning, execution, and quality review.
- A reviewer can trace each deliverable back to PRD or DECISIONS anchors.
- The route from strategy to execution to review is clear enough that a user can swap model vendors without rewriting the process.

## 8. MVP Workflow

Anchor: `PRD.md::mvp-workflow`

1. Phase 0 initializes `.hopper/MANIFEST.md`.
2. Phase 1 runs gstack and creates product and decision artifacts.
3. Phase 2 starts from a new session and runs GSD discuss-phase and plan-phase.
4. Phase 3 starts from a coding-oriented model and runs Superpowers execution.
5. Phase 4 starts from a quality-oriented model and reviews/polishes major deliverables.
6. The manifest is updated at each phase boundary.

## 9. Risks and Mitigations

Anchor: `PRD.md::risks`

### Risk: Users Treat Routing As Automation

Mitigation: Position LLM-Hopper as a handoff and discipline system, not as an autonomous runtime.

### Risk: Artifacts Become Too Heavy

Mitigation: Use a small required artifact set and stable anchors. Expand only when a phase requires it.

### Risk: Model Names Become Outdated

Mitigation: Store model roles and fallbacks in `DECISIONS.md`; route by capability first and specific model second.

### Risk: Execution Models Drift From Strategy

Mitigation: Require every execution prompt to cite `PROJECT.md`, `PRD.md`, `TRD.md`, `ROADMAP.md`, and `DECISIONS.md` anchors.

### Risk: Quality Review Is Skipped

Mitigation: Make Phase 4 an automatic convergence loop after every major deliverable and record it in the manifest.

## 10. Release Criteria

Anchor: `PRD.md::release-criteria`

The v0.1 MVP is releasable when:

- Phase 0 and Phase 1 artifacts exist and are internally consistent.
- GSD can continue from the Phase 1 handoff without extra context.
- Superpowers can continue from the Phase 2 handoff without extra context.
- Quality convergence can review artifacts using file anchors.
- No required deliverable violates the prompt-only, zero-code bootstrap constraint.
