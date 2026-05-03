# LLM-Hopper Cross-Process Prompts

Anchor: `.hopper/prompts/README.md::root`

## Overview

Anchor: `.hopper/prompts/README.md::overview`

This directory contains the exact prompts a user pastes into a new Codex CLI-style session when crossing a phase boundary. Unlike `.hopper/skill/`, these files are not in-session protocols. They are the cold-start entry points: open a new session with the recommended model, paste the prompt, and the receiving model can rebuild context from files alone.

Every prompt follows `TRD.md::handoff-block-schema`. Every prompt assumes the user is in the LLM-Hopper repository working directory.

## Prompt Templates

Anchor: `.hopper/prompts/README.md::templates`

| Template | Use When | Recommended Role | Recommended Model |
| --- | --- | --- | --- |
| `handoff-to-strategy.md` | Entering Phase 1 (gstack strategy layer) or returning to strategy for arbitration. | Strategy | GPT-5.5 xhigh, Opus 4.7 equivalent |
| `handoff-to-planning.md` | Entering Phase 2 (GSD context and roadmap layer). | Planning | GPT-5.5 xhigh, Opus 4.7 equivalent |
| `handoff-to-execution.md` | Entering Phase 3 (Superpowers execution kit) or any future bounded execution phase. | Execution | Kimi 2.6, DeepSeek V4 Pro Max, GLM 5.1, Mimo V2 Pro |
| `handoff-to-review.md` | Entering Phase 4 (Quality convergence) or running a review pass after major changes. | Review | GPT-5.4 xhigh, Opus Sonnet 4.6 |

Roles and acceptable equivalents are defined in `DECISIONS.md::model-routing-table`.

## Usage

Anchor: `.hopper/prompts/README.md::usage`

1. Read `.hopper/MANIFEST.md` to confirm which phase is next.
2. Open the corresponding template file in this directory.
3. Start a new model session with the recommended role and model.
4. Paste the copyable prompt block (the section marked `BEGIN PROMPT` through `END PROMPT`).
5. The new session should respond by reading the listed files and continuing without requesting prior chat context.
6. After the phase completes, the new session must invoke `hopper-handoff.md` so `.hopper/MANIFEST.md` is updated for the next handoff.

## Constraints

Anchor: `.hopper/prompts/README.md::constraints`

- Prompts in this directory must remain prompt-only and zero-code per `DECISIONS.md::architecture-constraints`.
- Prompts must cite files by path, not by chat summary.
- Prompts must not assume API keys, package installers, daemons, or browser automation.
- If a model session needs additional context that is not yet in a file, the model must stop and request that the missing context be written to the appropriate artifact before continuing.
