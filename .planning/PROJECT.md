# LLM-Hopper GSD Project Bridge

Anchor: `.planning/PROJECT.md::root`

## Source Of Truth

Anchor: `.planning/PROJECT.md::source-of-truth`

This `.planning` file is a GSD compatibility bridge. The public product source of truth remains:

- `PROJECT.md`
- `PRD.md`
- `DECISIONS.md`
- `TRD.md`
- `ROADMAP.md`
- `.hopper/MANIFEST.md`

## Project Summary

Anchor: `.planning/PROJECT.md::summary`

LLM-Hopper is a prompt-only multi-model development handoff kit. It uses markdown files and Git as shared memory so a human can move work across independent model sessions without hidden state, APIs, daemons, or package installs.

## Phase Boundary

Anchor: `.planning/PROJECT.md::phase-boundary`

The v0.1 milestone is complete when the artifact set supports this loop:

1. Strategy model creates product and decision files.
2. Planning model creates technical routing and roadmap files.
3. Execution model creates prompt templates and demo artifacts.
4. Review model verifies anchors, constraints, and recoverability.

## Current Planning State

Anchor: `.planning/PROJECT.md::current-state`

Phase 2 has produced the GSD planning layer. Phase 3 should create the Superpowers execution kit inside `.hopper/skill/`, `.hopper/prompts/`, and `.hopper/demo/`.
