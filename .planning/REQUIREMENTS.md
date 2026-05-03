# Requirements: LLM-Hopper v0.1

Anchor: `.planning/REQUIREMENTS.md::root`

**Defined:** 2026-05-03
**Core Value:** Preserve multi-model development context across independent sessions using file-backed handoffs.

## v0.1 Requirements

Anchor: `.planning/REQUIREMENTS.md::v0-1-requirements`

### State And Handoff

- [x] **FR-1**: LLM-Hopper maintains `.hopper/MANIFEST.md` as the current phase cursor.
- [x] **FR-5**: Every phase ends with an exact handoff block.

### Strategy

- [x] **FR-2**: The gstack phase produces `PROJECT.md`, `PRD.md`, and `DECISIONS.md`.

### Planning

- [x] **FR-3**: The GSD phase produces `TRD.md`, `ROADMAP.md`, and a manifest update.

### Execution Kit

- [x] **FR-4**: The Superpowers phase produces `.hopper/skill/` templates, handoff prompt templates, Todo App demo artifacts, and a pure bash demo helper.

### Constraints

- [x] **FR-6**: Durable requirements, decisions, milestones, and templates include stable anchors.
- [x] **FR-7**: The MVP remains prompt-only with no package, binary, daemon, or API dependency.
- [x] **NFR-1**: A new model session can recover from repository files alone.
- [x] **NFR-2**: Major product, architecture, routing, and quality decisions are human-readable.
- [x] **NFR-3**: Routing rules remain portable across model vendors.
- [x] **NFR-4**: Setup requires only a Git checkout and Codex CLI-style sessions.
- [x] **NFR-5**: The human operator remains responsible for launching sessions and approving phase changes.
- [x] **NFR-6**: Each phase updates only its expected artifact set.

## Out Of Scope

Anchor: `.planning/REQUIREMENTS.md::out-of-scope`

| Feature | Reason |
| --- | --- |
| API orchestration | Violates prompt-only v0.1 wedge. |
| Local daemon | Adds hidden state and setup friction. |
| Browser extension | Premature before artifact protocol is proven. |
| Generated app runtime | The Todo demo is artifact-driven in v0.1. |
| Guaranteed model compliance | Human review remains the control point. |

## Traceability

Anchor: `.planning/REQUIREMENTS.md::traceability`

| Requirement | Phase | Status |
| --- | --- | --- |
| FR-1 | Phase 0, Phase 2 | Complete |
| FR-2 | Phase 1 | Complete |
| FR-3 | Phase 2 | Complete |
| FR-4 | Phase 3 | Complete |
| FR-5 | Phases 1-4 | Complete |
| FR-6 | Phases 1-4 | Complete |
| FR-7 | Phases 0-4 | Complete |
| NFR-1 | Phases 0-4 | Complete |
| NFR-2 | Phases 1-4 | Complete |
| NFR-3 | Phase 1, Phase 2 | Complete |
| NFR-4 | Phases 0-4 | Complete |
| NFR-5 | Phases 0-4 | Complete |
| NFR-6 | Phases 0-4 | Complete |

**Coverage:**

- v0.1 requirements: 13 total
- Mapped to phases: 13
- Unmapped: 0
