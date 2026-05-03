# LLM-Hopper Skill Templates

Anchor: `.hopper/skill/README.md::root`

## Overview

Anchor: `.hopper/skill/README.md::overview`

This directory contains prompt-only command templates that guide a model session through bounded LLM-Hopper operations. There is no plugin, no slash-command runtime, and no installer. A user copies the body of a template into the active model session, and the model follows the protocol declared by the template.

These templates implement the convention defined in `TRD.md::skill-template-convention`. They obey the cross-process contract from `DECISIONS.md::engineering-review` and the phase mutation rules from `TRD.md::phase-mutation-rules`.

## Templates

Anchor: `.hopper/skill/README.md::templates`

| Template | Purpose | Owner Phase | Output |
| --- | --- | --- | --- |
| `hopper-status.md` | Read `.hopper/MANIFEST.md` and report current phase, authoritative artifacts, and next handoff. | All phases | Status block, no file changes |
| `hopper-handoff.md` | Produce or refresh the next-phase handoff block from manifest and roadmap state. | All phases | Updated `.hopper/MANIFEST.md` handoff block |
| `hopper-execute.md` | Run bounded execution work for the current phase and only the listed artifacts. | Phase 3 (and future execution phases) | Phase artifacts and summary |
| `hopper-review.md` | Run quality convergence: anchor audit, cross-file consistency, prompt-only constraint check, release readiness. | Phase 4 | Review notes, corrected artifacts, manifest update |

## Required Template Sections

Anchor: `.hopper/skill/README.md::required-sections`

Per `TRD.md::skill-template-convention`, every template in this directory must include:

1. Required inputs.
2. Files to read.
3. Files allowed to modify.
4. Stop conditions.
5. Output format.
6. Required handoff block.

## Usage

Anchor: `.hopper/skill/README.md::usage`

1. The user opens a new Codex CLI-style session with a model that matches the role from `DECISIONS.md::model-routing-table`.
2. The user pastes the contents of the relevant skill template as the system or first prompt.
3. The model reads only the listed files, writes only the allowed files, and stops at the listed conditions.
4. The model emits the output block and, if applicable, the updated handoff block.
5. The user verifies that `.hopper/MANIFEST.md` reflects the new state before starting the next session.

## Constraints

Anchor: `.hopper/skill/README.md::constraints`

- These templates are markdown only. They do not execute code, install packages, call APIs, or start daemons.
- Templates may not invent product policy. If a requirement is ambiguous, the template instructs the model to stop and request a strategy or planning update.
- All durable outputs must include stable anchors using `Anchor: ` followed by a backticked `FILE.md::section-name`.
