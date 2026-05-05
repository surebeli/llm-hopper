# LLM-Hopper Roadmap

Anchor: `ROADMAP.md::root`

## Overview

Anchor: `ROADMAP.md::overview`

LLM-Hopper v0.1 ships as a prompt-only multi-model handoff kit. The milestone path starts with a manifest, locks product strategy, adds the GSD technical planning layer, creates Superpowers-style execution templates and a Todo demo, then finishes with quality convergence.

## Milestones

Anchor: `ROADMAP.md::milestones`

| Milestone | Phase | Status | Output |
| --- | --- | --- | --- |
| M00 | Phase 0: Bootstrap Manifest | Complete | `.hopper/MANIFEST.md` |
| M01 | Phase 1: gstack Strategy Layer | Complete | `PROJECT.md`, `PRD.md`, `DECISIONS.md` |
| M02 | Phase 2: GSD Context and Roadmap Layer | Complete | `TRD.md`, `ROADMAP.md`, `.planning/` |
| M03 | Phase 3: Superpowers Execution Kit | Complete | `.hopper/skill/`, `.hopper/prompts/`, `.hopper/demo/` |
| M04 | Phase 4: Quality Convergence | Complete | Review notes, polished artifacts, release checklist |
| M05 | Phase 5: Superpowers Todo App Build | In Progress | `apps/todo/` (vanilla HTML+CSS+JS, 5 atomic tasks) |

## Phase Details

Anchor: `ROADMAP.md::phase-details`

### Phase 0: Bootstrap Manifest

Anchor: `ROADMAP.md::m00-bootstrap-manifest`

**Goal:** Create the durable phase cursor for all future sessions.

**Depends on:** Nothing.

**Requirements:** `FR-1`, `NFR-1`, `NFR-4`

**Success Criteria:**

1. `.hopper/MANIFEST.md` exists.
2. The manifest names runtime identity, workspace, execution mode, phase state, authoritative artifacts, and next handoff.
3. A cold-start session can identify the next command from the manifest.

**Plans:**

- [x] 00-01: Initialize manifest and handoff prompt.

### Phase 1: gstack Strategy Layer

Anchor: `ROADMAP.md::m01-gstack-strategy`

**Goal:** Pressure-test the product, define requirements, and lock architecture decisions.

**Depends on:** Phase 0.

**Requirements:** `FR-2`, `FR-5`, `FR-6`, `FR-7`, `NFR-2`, `NFR-5`

**Success Criteria:**

1. `PROJECT.md` defines vision, problem, scope, and success.
2. `PRD.md` defines functional and non-functional requirements.
3. `DECISIONS.md` records accepted decisions and model routing rules.
4. The strategy layer confirms the prompt-only, zero-code bootstrap constraint.

**Plans:**

- [x] 01-01: Create product, requirements, and decision artifacts.

### Phase 2: GSD Context and Roadmap Layer

Anchor: `ROADMAP.md::m02-gsd-context-roadmap`

**Goal:** Convert strategy into a technical routing contract and milestone roadmap.

**Depends on:** Phase 1.

**Requirements:** `FR-1`, `FR-3`, `FR-5`, `FR-6`, `FR-7`, `NFR-1`, `NFR-2`, `NFR-6`

**Success Criteria:**

1. `TRD.md` defines router logic, handoff schema, state persistence, model routing interface, and technical constraints.
2. `ROADMAP.md` defines M00 through M04 with scope, dependencies, requirements, risks, and exit criteria.
3. `.planning/` contains GSD-compatible context and plan records for Phase 2.
4. `.hopper/MANIFEST.md` points to Phase 3 with an exact next-session prompt.

**Plans:**

- [x] 02-01: Create context, research, TRD, and planning bridge.
- [x] 02-02: Create roadmap, phase plan, and manifest handoff.

### Phase 3: Superpowers Execution Kit

Anchor: `ROADMAP.md::m03-superpowers-execution`

**Goal:** Build the prompt-only execution kit and Todo App demo artifacts.

**Depends on:** Phase 2.

**Requirements:** `FR-4`, `FR-5`, `FR-6`, `FR-7`, `NFR-1`, `NFR-4`, `NFR-5`, `NFR-6`

**Success Criteria:**

1. `.hopper/skill/` contains command templates named by `TRD.md::skill-template-convention`.
2. `.hopper/prompts/` contains cross-process handoff prompt templates for strategy, planning, execution, and review.
3. `.hopper/demo/` contains Todo App demo instructions, acceptance criteria, and review checklist.
4. The pure bash demo helper prints prompts and file paths only; it does not install packages, call APIs, or start daemons.
5. The manifest advances to Phase 4 with an exact review handoff.

**Plans:**

- [x] 03-01: Create `.hopper/skill/` command templates.
- [x] 03-02: Create cross-process handoff prompt templates.
- [x] 03-03: Create Todo App demo artifacts and pure bash helper.

### Phase 4: Quality Convergence

Anchor: `ROADMAP.md::m04-quality-convergence`

**Goal:** Review, polish, and verify the v0.1 artifact set against the PRD and decisions.

**Depends on:** Phase 3.

**Requirements:** `FR-5`, `FR-6`, `FR-7`, `NFR-1`, `NFR-2`, `NFR-3`, `NFR-4`, `NFR-5`, `NFR-6`

**Success Criteria:**

1. Every durable requirement, decision, milestone, and template has a stable anchor.
2. The artifact set is internally consistent and recoverable from files alone.
3. No artifact violates the prompt-only, zero-code bootstrap constraint.
4. Review findings are resolved or explicitly logged.
5. The final manifest declares v0.1 ready for use.

**Plans:**

- [x] 04-01: Run cross-artifact consistency and anchor review.
- [x] 04-02: Polish release checklist and final handoff.

### Phase 5: Superpowers Todo App Build

Anchor: `ROADMAP.md::m05-superpowers-todo-app-build`

**Goal:** Live test of Builder-driven spec disassembly. Take the high-level spec ("simple Todo App with add / complete / delete / list, modern responsive UI") and produce a working app via atomic Executor-grade tasks, validating the role-permission boundaries from `.hopper/roles/ROLES.md`.

**Depends on:** Phase 4 (release of the prompt-only kit).

**Requirements:** demonstrates `FR-4`, `FR-5`, `FR-6`, `FR-7` end-to-end with real implementation rather than artifact-only walkthrough.

**Success Criteria:**

1. Builder produces atomic task list at `.planning/phases/05-todo-app-build/TASK-LIST.md` with 5 tasks each carrying RED-GREEN-REFACTOR + acceptance criteria.
2. Executor implements one task at a time strictly within the task contract, hands back to Builder per task.
3. Final `apps/todo/` app supports add / mark-complete / delete / list with responsive modern UI and localStorage persistence.
4. No framework, no build step, no API calls.
5. Builder reviews each task's GREEN before dispatching the next.

**Plans:**

- [x] 05-00: Builder spec disassembly (`.planning/phases/05-todo-app-build/TASK-LIST.md`).
- [ ] 05-01: T01 — Project skeleton + semantic HTML (`apps/todo/index.html`).
- [ ] 05-02: T02 — Modern responsive CSS (`apps/todo/styles.css`).
- [ ] 05-03: T03 — Data model + localStorage (`apps/todo/store.js`).
- [ ] 05-04: T04 — View layer + DOM event wiring (`apps/todo/app.js`).
- [ ] 05-05: T05 — Polish: empty state, animations, accessibility.

## Risks

Anchor: `ROADMAP.md::risks`

| Risk | Phase Most Affected | Mitigation |
| --- | --- | --- |
| Artifact sprawl makes the kit hard to follow. | Phase 3 | Keep templates small and route users through the manifest. |
| Model names age quickly. | All phases | Route by role first, named model second. |
| Execution model invents product policy. | Phase 3 | Require anchors from `PROJECT.md`, `PRD.md`, `TRD.md`, `ROADMAP.md`, and `DECISIONS.md`. |
| Review phase is skipped. | Phase 4 | Manifest must route Phase 3 output into quality convergence. |
| Future automation breaks prompt-only trust. | Future versions | Keep v0.1 automation-free; log automation as deferred. |

## Progress

Anchor: `ROADMAP.md::progress`

| Phase | Plans Complete | Status | Completed |
| --- | --- | --- | --- |
| 0. Bootstrap Manifest | 1/1 | Complete | 2026-05-03 |
| 1. gstack Strategy Layer | 1/1 | Complete | 2026-05-03 |
| 2. GSD Context and Roadmap Layer | 2/2 | Complete | 2026-05-03 |
| 3. Superpowers Execution Kit | 3/3 | Complete | 2026-05-03 |
| 4. Quality Convergence | 2/2 | Complete | 2026-05-03 |
| 5. Superpowers Todo App Build | 1/6 | In Progress | — |
