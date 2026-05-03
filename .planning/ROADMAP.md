# Roadmap: LLM-Hopper

Anchor: `.planning/ROADMAP.md::root`

## Compatibility Note

Anchor: `.planning/ROADMAP.md::compatibility-note`

This file mirrors `ROADMAP.md` in GSD-readable form. The public roadmap is `ROADMAP.md`; this bridge exists because GSD workflows expect `.planning/ROADMAP.md`.

## Phases

Anchor: `.planning/ROADMAP.md::phases`

- [x] **Phase 0: Bootstrap Manifest** - Create `.hopper/MANIFEST.md`.
- [x] **Phase 1: gstack Strategy Layer** - Create `PROJECT.md`, `PRD.md`, and `DECISIONS.md`.
- [x] **Phase 2: GSD Context and Roadmap Layer** - Create `TRD.md`, `ROADMAP.md`, and `.planning/` records.
- [x] **Phase 3: Superpowers Execution Kit** - Create prompt-only command templates, handoff prompts, and Todo demo artifacts.
- [x] **Phase 4: Quality Convergence** - Review, polish, and verify release readiness.

## Phase Details

Anchor: `.planning/ROADMAP.md::phase-details`

### Phase 0: Bootstrap Manifest

**Goal**: Create the durable phase cursor for all future sessions.
**Depends on**: Nothing.
**Requirements**: [FR-1, NFR-1, NFR-4]
**Success Criteria**:

1. `.hopper/MANIFEST.md` exists.
2. Manifest names current artifacts and next handoff.

**Plans**: 1 plan

Plans:

- [x] 00-01: Initialize manifest and first handoff.

### Phase 1: gstack Strategy Layer

**Goal**: Lock vision, PRD, decisions, and model routing rules.
**Depends on**: Phase 0.
**Requirements**: [FR-2, FR-5, FR-6, FR-7, NFR-2, NFR-5]
**Success Criteria**:

1. `PROJECT.md`, `PRD.md`, and `DECISIONS.md` exist.
2. Model routing table and prompt-only scope are accepted.

**Plans**: 1 plan

Plans:

- [x] 01-01: Create strategy artifacts.

### Phase 2: GSD Context and Roadmap Layer

**Goal**: Convert strategy into technical routing and roadmap artifacts.
**Depends on**: Phase 1.
**Requirements**: [FR-1, FR-3, FR-5, FR-6, FR-7, NFR-1, NFR-2, NFR-6]
**Success Criteria**:

1. `TRD.md` defines router logic, state persistence, handoff schema, and template conventions.
2. `ROADMAP.md` defines M00 through M04.
3. `.planning/phases/02-gsd-context-and-roadmap-layer/` contains context and plans.
4. `.hopper/MANIFEST.md` points to Phase 3.

**Plans**: 2 plans

Plans:

- [x] 02-01: Create context, research, TRD, and planning bridge.
- [x] 02-02: Create roadmap, plans, and manifest handoff.

### Phase 3: Superpowers Execution Kit

**Goal**: Create prompt-only execution templates and Todo demo artifacts.
**Depends on**: Phase 2.
**Requirements**: [FR-4, FR-5, FR-6, FR-7, NFR-1, NFR-4, NFR-5, NFR-6]
**Success Criteria**:

1. `.hopper/skill/` contains the required `hopper-*.md` templates.
2. `.hopper/prompts/` contains strategy, planning, execution, and review handoff prompts.
3. `.hopper/demo/` contains Todo demo scenario, acceptance criteria, review checklist, and pure bash helper.

**Plans**: 3 plans

Plans:

- [x] 03-01: Create `.hopper/skill/` command templates.
- [x] 03-02: Create cross-process prompt templates.
- [x] 03-03: Create Todo demo artifacts and helper.

### Phase 4: Quality Convergence

**Goal**: Verify v0.1 artifacts against PRD, decisions, anchors, and prompt-only constraints.
**Depends on**: Phase 3.
**Requirements**: [FR-5, FR-6, FR-7, NFR-1, NFR-2, NFR-3, NFR-4, NFR-5, NFR-6]
**Success Criteria**:

1. All durable artifacts have stable anchors.
2. The repository is recoverable from files alone.
3. The final manifest declares v0.1 ready.

**Plans**: 2 plans

Plans:

- [x] 04-01: Run consistency and anchor review.
- [x] 04-02: Polish release checklist and final handoff.

## Progress

Anchor: `.planning/ROADMAP.md::progress`

| Phase | Plans Complete | Status | Completed |
| --- | --- | --- | --- |
| 0. Bootstrap Manifest | 1/1 | Complete | 2026-05-03 |
| 1. gstack Strategy Layer | 1/1 | Complete | 2026-05-03 |
| 2. GSD Context and Roadmap Layer | 2/2 | Complete | 2026-05-03 |
| 3. Superpowers Execution Kit | 3/3 | Complete | 2026-05-03 |
| 4. Quality Convergence | 2/2 | Complete | 2026-05-03 |
