# LLM-Hopper TRD

Anchor: `TRD.md::root`

## Technical Intent

Anchor: `TRD.md::technical-intent`

LLM-Hopper v0.1 is a prompt-only routing protocol, not a runtime orchestrator. Its technical design makes a Git-backed folder the durable memory layer between independent model sessions. Each phase reads known files, writes bounded markdown artifacts, updates `.hopper/MANIFEST.md`, and emits an exact handoff prompt for the next session.

The MVP deliberately avoids APIs, daemons, background workers, package installs, generated binaries, and hidden model state.

## System Contract

Anchor: `TRD.md::system-contract`

Every LLM-Hopper session must follow this contract:

1. Read `.hopper/MANIFEST.md` first.
2. Read every authoritative artifact named by the manifest.
3. Perform only the phase named by the manifest or user handoff.
4. Update only artifacts owned by the current phase.
5. Preserve stable anchors using `Anchor: ` followed by a backticked `FILE.md::section-name`.
6. Update `.hopper/MANIFEST.md` with the completed phase and next handoff.
7. End phase work with a copyable handoff prompt and no dependency on prior chat.

## Artifact Map

Anchor: `TRD.md::artifact-map`

| Artifact | Owner Phase | Purpose | Mutation Rule |
| --- | --- | --- | --- |
| `.hopper/MANIFEST.md` | All phases | Current phase cursor, authoritative files, next command. | Update at every phase boundary. |
| `PROJECT.md` | Phase 1: gstack | Vision, problem, scope, success definition. | Change only through gstack or arbitration. |
| `PRD.md` | Phase 1: gstack | Functional and non-functional requirements. | Change only through gstack/GSD with explicit rationale. |
| `DECISIONS.md` | Phase 1 plus arbitration | Accepted decisions and routing rules. | Append/revise only with decision IDs. |
| `TRD.md` | Phase 2: GSD | Router protocol, state model, handoff schema, technical constraints. | Created in Phase 2; revise through GSD/arbitration. |
| `ROADMAP.md` | Phase 2: GSD | M00 through M04 milestone boundaries, plans, risks, exit criteria. | Created in Phase 2; update when phases complete. |
| `.planning/` | Phase 2: GSD bridge | GSD-compatible planning mirror and phase records. | Top-level artifacts remain the public source of truth. |
| `.hopper/skill/` | Phase 3: Superpowers | Prompt-only command templates for execution models. | Created in Phase 3. |
| `.hopper/prompts/` | Phase 3: Superpowers | Cross-process handoff prompt templates. | Created in Phase 3. |
| `.hopper/demo/` | Phase 3: Superpowers | Todo App demo artifacts and review checklist. | Created in Phase 3. |

## State Model

Anchor: `TRD.md::state-model`

`.hopper/MANIFEST.md` is the only required state file for v0.1. It stores:

- Runtime identity.
- Host environment.
- Requested model profile.
- Execution mode.
- Workspace path.
- Timestamp.
- Completed phases.
- Current authoritative artifacts.
- Next phase.
- Next handoff command.
- Persistence rules.

No .hopper/state.json is created in v0.1. A JSON twin is deferred until the markdown-only workflow proves useful and there is a concrete parser or automation need.

## Router Protocol

Anchor: `TRD.md::router-protocol`

The router is a natural-language procedure carried in files:

1. **Inspect:** Read `.hopper/MANIFEST.md`.
2. **Load:** Read the authoritative artifacts listed for the current phase.
3. **Validate:** Confirm the phase boundary against `ROADMAP.md` and `DECISIONS.md`.
4. **Route:** Select the model role from `DECISIONS.md::model-routing-table`.
5. **Execute:** Perform the phase-specific prompt or workflow.
6. **Record:** Write the phase artifacts and update anchors.
7. **Handoff:** Update `.hopper/MANIFEST.md` with a new exact prompt.

The router never assumes a persistent agent process. The human launches each session and pastes the handoff.

## Handoff Block Schema

Anchor: `TRD.md::handoff-block-schema`

Each phase handoff must be copyable as plain text:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase N - <name>
Next phase: Phase N+1 - <name>
Recommended model profile: <role and model>
Authoritative files:
- <path>
- <path>
Prompt:
<exact prompt to paste into the next Codex CLI-style session>
```

When this schema appears inside `.hopper/MANIFEST.md`, the surrounding manifest may include explanatory headings. The prompt itself must remain exact and self-contained.

## Model Routing Interface

Anchor: `TRD.md::model-routing-interface`

Routing is capability-first:

| Role | Use For | Primary Source |
| --- | --- | --- |
| Strategy | Product pressure tests, irreversible decisions, arbitration. | `DECISIONS.md::model-routing-table` |
| Planning | GSD context, TRD, roadmap, execution plan decomposition. | `DECISIONS.md::model-routing-table` |
| Execution | Bounded prompt-template and demo artifact creation. | `ROADMAP.md::m03-superpowers-execution` |
| Review | Cross-artifact consistency, anchor audit, release readiness. | `ROADMAP.md::m04-quality-convergence` |

If a named model is unavailable, choose the closest role equivalent rather than changing the workflow.

## Phase Mutation Rules

Anchor: `TRD.md::phase-mutation-rules`

- Phase 0 may create `.hopper/MANIFEST.md`.
- Phase 1 may create or revise `PROJECT.md`, `PRD.md`, and `DECISIONS.md`.
- Phase 2 may create `TRD.md`, `ROADMAP.md`, and `.planning/` records.
- Phase 3 may create `.hopper/skill/`, `.hopper/prompts/`, `.hopper/demo/`, and a pure bash demo start script.
- Phase 4 may revise artifacts for consistency, anchors, and release readiness, but must log any substantive product change in `DECISIONS.md`.

## Skill Template Convention

Anchor: `TRD.md::skill-template-convention`

Phase 3 must use lowercase kebab-case filenames under `.hopper/skill/`:

| Template | Purpose |
| --- | --- |
| `.hopper/skill/README.md` | Explains the local prompt-only command set. |
| `.hopper/skill/hopper-status.md` | Reads manifest and reports current phase. |
| `.hopper/skill/hopper-handoff.md` | Produces the next handoff block. |
| `.hopper/skill/hopper-execute.md` | Guides bounded execution from a plan file. |
| `.hopper/skill/hopper-review.md` | Runs quality convergence against anchors and acceptance criteria. |

Each template must include:

- Required inputs.
- Files to read.
- Files allowed to modify.
- Stop conditions.
- Output format.
- Required handoff block.

## Todo Demo Contract

Anchor: `TRD.md::todo-demo-contract`

The Todo App demo is an artifact-only walkthrough. It demonstrates cross-model handoff without requiring a generated application runtime.

Phase 3 should create:

- `.hopper/demo/TODO-APP.md`: Demo scenario and model-session sequence.
- `.hopper/demo/ACCEPTANCE.md`: Acceptance criteria for each handoff step.
- `.hopper/demo/REVIEW-CHECKLIST.md`: Quality convergence checklist.
- `.hopper/demo/start-todo-demo.sh`: Pure bash helper that prints the next files and prompt to read. It must not install packages, call APIs, start daemons, or generate an app.

The demo is successful when a user can follow the artifact sequence from strategy to planning to execution to review without hidden chat context.

## Verification Contract

Anchor: `TRD.md::verification-contract`

Before a phase is considered complete:

1. Every new durable section has an anchor.
2. The manifest names the correct current and next phase.
3. Roadmap phase boundaries match `PRD.md::mvp-workflow`.
4. No required deliverable depends on API keys, package installs, daemons, or binaries.
5. Handoff prompts cite files, not chat summaries.
6. New files stay inside the phase's ownership boundary.

## Deferred Technical Ideas

Anchor: `TRD.md::deferred-technical-ideas`

- `.hopper/state.json` as a machine-readable twin.
- Actual slash-command plugin packaging.
- Model API orchestration.
- Automated git sync or PR creation.
- Browser extension handoff capture.

These are intentionally excluded from v0.1.
