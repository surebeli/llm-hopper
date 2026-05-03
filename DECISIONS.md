# LLM-Hopper Decisions

Anchor: `DECISIONS.md::root`

## gstack Decision Summary

Anchor: `DECISIONS.md::gstack-summary`

LLM-Hopper v0.1 will be built as a prompt-only, file-backed orchestration discipline for multi-model development. The first release will prove that cross-process context loss can be reduced through explicit artifacts, model routing rules, and handoff prompts. The repo is the shared memory. The model session is disposable.

## Decision Log

Anchor: `DECISIONS.md::decision-log`

| ID | Decision | Rationale | Status |
| --- | --- | --- | --- |
| D-001 | Use markdown artifacts as the MVP substrate. | Markdown is portable, readable, Git-friendly, and works across all models without packages or APIs. | Accepted |
| D-002 | Use `.hopper/MANIFEST.md` as the phase cursor. | A new session needs one obvious place to discover current phase, authoritative files, and next command. | Accepted |
| D-003 | Separate work into gstack, GSD, Superpowers, and Quality Convergence layers. | Different phases require different reasoning profiles, cost profiles, and review standards. | Accepted |
| D-004 | End every phase with an exact handoff block. | The system must survive process boundaries and cold starts with minimal human interpretation. | Accepted |
| D-005 | Route by capability role first and model name second. | Model availability and branding change; workflow roles should remain stable. | Accepted |
| D-006 | Keep v0.1 zero-code and prompt-only. | The core risk is workflow validity, not implementation mechanics. Adding runtime code too early would blur the MVP. | Accepted |
| D-007 | Require file anchors for durable context. | Anchors let future sessions cite precise requirements and decisions without relying on transcript memory. | Accepted |

## gstack Step 3: Engineering Review

Anchor: `DECISIONS.md::engineering-review`

### High-Level Architecture

LLM-Hopper v0.1 has four conceptual components, all represented as files and prompts:

1. State layer: `.hopper/MANIFEST.md` records runtime identity, current phase, authoritative files, and next handoff.
2. Strategy layer: `PROJECT.md`, `PRD.md`, and `DECISIONS.md` define vision, requirements, decisions, and model routing.
3. Planning layer: `TRD.md` and `ROADMAP.md` will define technical requirements, milestones, effort, risks, and exit criteria.
4. Execution layer: `.hopper/skill/` and handoff templates will define simulated slash commands, Superpowers workflow prompts, review prompts, and demo instructions.

The router is not a binary or daemon. It is a natural-language protocol that tells the human which model session to start, which files to provide as context, what task boundary to enforce, and what artifacts to update.

### Cross-Process Contract

Each phase must obey this contract:

1. Read `.hopper/MANIFEST.md` first.
2. Read the authoritative phase input files named in the manifest.
3. Perform only the current phase's work.
4. Write or update only the expected artifacts for that phase.
5. Update the manifest with phase state and next handoff command.
6. End with the exact handoff block required by the current phase.

### State Reconstruction Rule

No session may depend on previous chat memory. If a fact matters, it must exist in one of the markdown artifacts and be referenced by anchor.

## Model Routing Table

Anchor: `DECISIONS.md::model-routing-table`

| Workflow Layer | Primary Job | Recommended Model | Acceptable Equivalent | Reasoning / Cost Profile | Output Artifacts |
| --- | --- | --- | --- | --- | --- |
| gstack Decision Layer | Pressure-test product, define vision, set strategy, make architecture decisions. | GPT-5.5 xhigh | Opus 4.7 / Opus 4.6 equivalent | Highest available reasoning. Cost is justified because errors here cascade. | `PROJECT.md`, `PRD.md`, `DECISIONS.md` |
| GSD / GSD-2 Context Layer | Refine requirements, decompose milestones, produce TRD and roadmap. | GPT-5.5 xhigh | Opus 4.7 / Opus 4.6 equivalent | Strong structured planning and ambiguity reduction. | `TRD.md`, `ROADMAP.md`, manifest update |
| Superpowers Execution Layer | Execute bounded plans with TDD discipline and subagent-style task simulation. | Kimi 2.6 | DeepSeek V4 Pro Max / GLM 5.1 / Mimo V2 Pro | Coding-throughput model. Optimize cost and iteration speed under strong written constraints. | `.hopper/skill/`, prompt templates, demo artifacts |
| Quality Convergence Layer | Review, polish, detect defects, align outputs to requirements. | GPT-5.4 xhigh | Opus Sonnet 4.6 | Strong review and synthesis. Lower cost than initial strategy while maintaining rigor. | Review notes, corrected artifacts, manifest update |
| Emergency Arbitration | Resolve contradictions between strategy, TRD, roadmap, and execution. | GPT-5.5 xhigh | Opus 4.7 / Opus 4.6 equivalent | Escalate only when lower layers cannot decide safely. | `DECISIONS.md` update |

## Model Routing Rules

Anchor: `DECISIONS.md::model-routing-rules`

1. Send irreversible or high-blast-radius decisions to the strongest reasoning model.
2. Send bounded implementation work to execution models only after PRD, TRD, roadmap, and acceptance criteria exist.
3. Send completed deliverables to a quality convergence model before declaring them final.
4. If an execution model discovers a requirements ambiguity, it must stop and request a GSD or gstack update rather than invent product policy.
5. If a review model finds a conflict between artifacts, `DECISIONS.md` is the tie-breaker for accepted decisions, and `PRD.md` is the tie-breaker for user-facing requirements.
6. If a model listed in the table is unavailable, choose the closest equivalent by role: strategy, planning, execution, review, or arbitration.
7. All handoffs must cite file anchors, not chat summaries.
8. Each phase must write a final handoff block with no trailing content.

## Artifact Ownership

Anchor: `DECISIONS.md::artifact-ownership`

| Artifact | Owner Layer | Purpose | Mutation Rule |
| --- | --- | --- | --- |
| `.hopper/MANIFEST.md` | All phases | Current state and next command. | Update at every phase boundary. |
| `PROJECT.md` | gstack | Product vision and pressure-test result. | Change only through gstack or arbitration. |
| `PRD.md` | gstack | Product requirements and success metrics. | Change only through gstack or GSD with explicit rationale. |
| `DECISIONS.md` | gstack / arbitration | Accepted decisions and model routing. | Append or revise with clear decision IDs. |
| `TRD.md` | GSD | Technical requirements and file-based router logic. | Created in Phase 2. |
| `ROADMAP.md` | GSD | Milestones, effort, risks, and exit criteria. | Created in Phase 2. |
| `.hopper/skill/` | Superpowers | Simulated slash-command templates and execution prompts. | Created in Phase 3. |

## Architecture Constraints

Anchor: `DECISIONS.md::architecture-constraints`

- The MVP must remain prompt-only.
- Markdown files are the source of truth.
- No package installation is required for bootstrap.
- No local daemon is required.
- No generated binary is allowed.
- No hidden state is allowed.
- All future automation must preserve the file-backed handoff contract.

## Open Questions For GSD

Anchor: `DECISIONS.md::open-questions-for-gsd`

The GSD phase should resolve the following:

1. Exact milestone boundaries for M00 through M04.
2. Exact TRD structure for router logic and state persistence.
3. Whether `.hopper/MANIFEST.md` should later gain a JSON twin such as `.hopper/state.json`.
4. Exact naming convention for `.hopper/skill/` command templates.
5. Demo Todo App acceptance criteria and review checklist.
