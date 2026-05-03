# Phase 2: GSD Context and Roadmap Layer - Context

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md::root`

**Gathered:** 2026-05-03T02:31:03+08:00
**Status:** Ready for planning

<domain>

## Phase Boundary

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md::phase-boundary`

Phase 2 converts the gstack strategy artifacts into technical routing and milestone planning artifacts. It produces `TRD.md`, `ROADMAP.md`, `.planning/` compatibility records, and an updated `.hopper/MANIFEST.md` that routes the next session to Phase 3.

This phase does not create runtime code, packages, daemons, API calls, browser automation, or binary installers.

</domain>

<decisions>

## Implementation Decisions

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md::implementation-decisions`

### Artifact Shape

- **D-01:** `TRD.md` and `ROADMAP.md` are top-level public artifacts because the PRD names them as GSD outputs.
- **D-02:** `.planning/` is created as a GSD compatibility bridge, not as a replacement for the top-level source of truth.
- **D-03:** Phase 2 records both context and executable plan prompts under `.planning/phases/02-gsd-context-and-roadmap-layer/`.

### State Persistence

- **D-04:** `.hopper/MANIFEST.md` remains the only required state file for v0.1.
- **D-05:** `.hopper/state.json` is deferred until a real parser or automation workflow needs machine-readable state.

### Milestone Boundaries

- **D-06:** M00 is bootstrap manifest.
- **D-07:** M01 is gstack strategy: `PROJECT.md`, `PRD.md`, `DECISIONS.md`.
- **D-08:** M02 is GSD context and roadmap: `TRD.md`, `ROADMAP.md`, `.planning/`.
- **D-09:** M03 is Superpowers execution kit: `.hopper/skill/`, `.hopper/prompts/`, `.hopper/demo/`.
- **D-10:** M04 is quality convergence: review, anchor audit, release readiness.

### Skill Template Naming

- **D-11:** Phase 3 uses lowercase kebab-case `.hopper/skill/hopper-*.md` filenames.
- **D-12:** Required templates are `hopper-status.md`, `hopper-handoff.md`, `hopper-execute.md`, and `hopper-review.md`, plus `.hopper/skill/README.md`.

### Todo Demo Scope

- **D-13:** The Todo App demo is artifact-driven. It demonstrates handoff flow through markdown prompts, acceptance criteria, and review checklists.
- **D-14:** The demo helper may be a pure bash script that prints instructions and file paths only. It must not install packages, call APIs, generate a runtime app, or start daemons.

### the agent's Discretion

- The exact prose layout inside Phase 3 templates may be chosen by the execution model if it preserves required inputs, files to read, allowed writes, stop conditions, output format, and handoff block.
- The `.hopper/prompts/` template count may expand if each added prompt maps to one of the existing phases and stays within the prompt-only scope.

</decisions>

<canonical_refs>

## Canonical References

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md::canonical-refs`

Downstream agents MUST read these before planning or implementing.

### Strategy And Requirements

- `PROJECT.md` - Vision, problem, scope, success definition.
- `PRD.md` - Functional requirements, non-functional requirements, MVP workflow, release criteria.
- `DECISIONS.md` - Accepted decisions, artifact ownership, model routing table, routing rules, open questions for GSD.

### Current GSD Outputs

- `TRD.md` - Technical routing contract, state model, handoff schema, skill template convention, Todo demo contract.
- `ROADMAP.md` - Milestone boundaries M00 through M04 and Phase 3/4 scope.
- `.hopper/MANIFEST.md` - Current phase cursor and next handoff.

### GSD Compatibility Records

- `.planning/PROJECT.md` - GSD project bridge.
- `.planning/REQUIREMENTS.md` - Checkable requirement IDs and traceability.
- `.planning/ROADMAP.md` - GSD-readable roadmap mirror.

</canonical_refs>

<code_context>

## Existing Code Insights

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md::code-context`

### Reusable Assets

- No runtime source tree exists in this MVP. The reusable assets are the existing markdown artifacts and `.hopper/MANIFEST.md`.

### Established Patterns

- Stable anchors use `Anchor: ` followed by backticked `FILE.md::section-name`.
- The repository treats markdown as the durable memory layer.
- Each phase has bounded artifact ownership.

### Integration Points

- Phase 3 should read `TRD.md::skill-template-convention` and `ROADMAP.md::m03-superpowers-execution`.
- Phase 4 should read all top-level artifacts plus `.hopper/skill/`, `.hopper/prompts/`, and `.hopper/demo/`.

</code_context>

<specifics>

## Specific Ideas

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md::specific-ideas`

- Route by role first and model name second.
- Preserve human control at every phase transition.
- Keep v0.1 narrow enough to prove cross-session continuity before adding automation.
- Treat `DECISIONS.md` as the tie-breaker for architecture decisions and `PRD.md` as the tie-breaker for user-facing requirements.

</specifics>

<deferred>

## Deferred Ideas

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-CONTEXT.md::deferred-ideas`

- `.hopper/state.json` machine-readable state twin.
- Actual slash-command plugin packaging.
- API-based model orchestration.
- Browser extension or web subscription automation.
- Automated PR creation or Git sync.

</deferred>

---

*Phase: 02-gsd-context-and-roadmap-layer*
*Context gathered: 2026-05-03T02:31:03+08:00*
