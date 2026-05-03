# Phase 2: GSD Context and Roadmap Layer - Research

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-RESEARCH.md::root`

## RESEARCH COMPLETE

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-RESEARCH.md::research-complete`

**Mode:** Source-only research from existing project artifacts.
**Reason:** The phase is a prompt-only artifact design task. No external package, API, library, or runtime dependency needs current technical research.

## Inputs Reviewed

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-RESEARCH.md::inputs-reviewed`

- `PROJECT.md`
- `PRD.md`
- `DECISIONS.md`
- `.hopper/MANIFEST.md`
- GSD discuss-phase workflow instructions
- GSD plan-phase workflow instructions
- GSD phase prompt template

## Findings

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-RESEARCH.md::findings`

1. Phase 2 must produce public `TRD.md` and `ROADMAP.md` artifacts because `PRD.md::functional-requirements` names them directly.
2. GSD compatibility benefits from `.planning/` bridge files even though no GSD SDK binary is available in this sandbox.
3. `DECISIONS.md::open-questions-for-gsd` resolves into five decisions: milestone boundaries, TRD shape, no JSON twin for v0.1, `.hopper/skill/` naming, and Todo demo acceptance scope.
4. The project has no runtime source tree, so plan tasks should verify markdown content, anchors, and manifest state rather than builds or tests.
5. The strongest verification strategy is deterministic file inspection: required files exist, required anchors exist, prohibited dependency language is absent, and the manifest names the next phase.

## Planning Implications

Anchor: `.planning/phases/02-gsd-context-and-roadmap-layer/02-RESEARCH.md::planning-implications`

- Plans should be documentation/artifact plans with grep-verifiable acceptance criteria.
- Phase 3 should be bounded to `.hopper/skill/`, `.hopper/prompts/`, `.hopper/demo/`, and `.hopper/MANIFEST.md`.
- Phase 4 should review anchors and cross-file consistency rather than run application tests.
