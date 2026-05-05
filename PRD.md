# PRD - LLM-Hopper v0.2

Anchor: `PRD.md::root`

## Background

Anchor: `PRD.md::background`

LLM-Hopper is a prompt-only, file-backed workflow router for developers who use multiple AI coding tools and model sessions. The product treats the repository as shared memory: durable markdown artifacts hold strategy, requirements, role definitions, handoff prompts, state, and review evidence.

The v0.2 release adds a role-based workflow on top of the original phase handoff kit. Users work through Leader, Builder, Executor, and optional direction-specific roles such as UI-Builder. Builder-owned TDD task disassembly and reinforced review prevent low-context execution sessions from inventing product policy.

## Target Users

Anchor: `PRD.md::target-users`

- Solo builders who switch between several model providers to balance reasoning quality, coding throughput, and cost.
- AI-heavy engineers who need cold-start continuity across CLI, IDE, and web model sessions.
- Small teams that want a lightweight written protocol before investing in custom orchestration or API infrastructure.

## Jobs To Be Done

Anchor: `PRD.md::jtbd`

1. When starting or resuming a project, I want one source of truth for current state so that a fresh model session can continue without hidden chat history.
2. When moving work between models, I want exact role and handoff instructions so that each model only owns work appropriate to its capability.
3. When delegating implementation, I want Builder-created TDD task specs so that Executors can work safely without making product or architecture decisions.
4. When a task finishes, I want a reinforced review loop so that acceptance, scope, and state are checked before the next handoff.
5. When models or subscriptions change, I want routing to remain configurable by role rather than locked to one provider or version.

## User Stories

Anchor: `PRD.md::user-stories`

- As a user, I can read `.hopper/MANIFEST.md` and know the current phase, authoritative files, and next handoff command.
- As a Leader, I can define product and technical direction without also executing low-level tasks.
- As a Builder, I can convert a plan into atomic RED/GREEN/REFACTOR tasks and review Executor output before dispatching more work.
- As an Executor, I can receive a minimal task spec with allowed files, forbidden changes, acceptance criteria, and stop conditions.
- As a maintainer, I can update role-to-model mappings without rewriting the workflow.
- As a reviewer, I can trace each completed phase or task back to anchored requirements and decisions.

## Functional Requirements

Anchor: `PRD.md::functional-requirements`

| ID | Requirement | Acceptance |
| --- | --- | --- |
| FR-1 | Maintain a durable phase cursor. | `.hopper/MANIFEST.md` and `.planning/STATE.md` identify current phase, next phase, authoritative files, and next handoff. |
| FR-2 | Capture product strategy. | `PROJECT.md`, `PRD.md`, and `DECISIONS.md` define vision, users, requirements, scope, risks, and accepted decisions. |
| FR-3 | Capture technical planning. | `TRD.md`, `ROADMAP.md`, and `.planning/` define architecture, state transitions, milestones, and task boundaries. |
| FR-4 | Support role-based execution. | Leader, Builder, Executor, and UI-Builder responsibilities are documented and prompts route work through those roles. |
| FR-5 | Emit exact handoff blocks. | Handoff prompts name completed phase, next phase, owning role, authoritative files, sync summary, and next task spec. |
| FR-6 | Keep model routing configurable. | Documentation routes by role first and treats concrete model names as editable examples or local configuration. |
| FR-7 | Enforce review and final sync. | Builder review checks TDD evidence, acceptance criteria, file scope, and state updates before task progression. |

## Non-Functional Requirements

Anchor: `PRD.md::non-functional-requirements`

| ID | Requirement | Acceptance |
| --- | --- | --- |
| NFR-1 | Prompt-only bootstrap. | The kit is usable from markdown files without a daemon, API key, package install, or generated binary. |
| NFR-2 | Cold-start recoverability. | A new session can reconstruct state from repository files without reading prior chat. |
| NFR-3 | Auditability. | Durable artifacts use stable anchors and Git-readable diffs. |
| NFR-4 | Tool portability. | Prompts work across common CLI, IDE, and web model sessions with copy/paste. |
| NFR-5 | Human control. | The user explicitly starts sessions, pastes handoffs, and decides when to accept phase transitions. |
| NFR-6 | Low artifact sprawl. | Main entry points are few, named clearly, and linked from README and MANIFEST. |

## In Scope

Anchor: `PRD.md::scope-in`

- Markdown PRD, TRD, roadmap, decisions, manifest, roles, agent registry, prompts, and demo guide.
- Role-based handoff workflow with TDD task specs and Builder review.
- Cost tracking prompts and cost log format.
- Skill package metadata and install helper.
- Todo App validation demo prompts.

## Out Of Scope

Anchor: `PRD.md::scope-out`

- Autonomous background orchestration.
- API calls to model providers.
- Package-managed runtime.
- Browser automation.
- Database-backed state.
- Claims that a model complied without human or Builder review evidence.

## KPIs

Anchor: `PRD.md::kpis`

| KPI | Target |
| --- | --- |
| Cold-start handoff success | A fresh session can identify next action from `.hopper/MANIFEST.md` in under 2 minutes. |
| Prompt entry point count | Main workflow can be started from 2 primary prompts. |
| Role-boundary compliance | Executor task prompts always include allowed files, forbidden changes, and Builder return handoff. |
| Version consistency | README, PRD, TRD, ROADMAP, and MANIFEST report the same release version. |
| Demo traceability | Each Todo demo step traces to role, authoritative files, and acceptance criteria. |

## Risks

Anchor: `PRD.md::risks`

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Artifact sprawl makes the workflow hard to follow. | Users abandon the kit. | Keep `start-new-project-with-roles.md` and `handoff-to-role.md` as primary entry points. |
| Model names age quickly. | Docs become misleading. | Route by role and make model names local configuration. |
| Executor invents product policy. | Scope creep and inconsistent app behavior. | Require Builder-authored task specs and Builder review before next dispatch. |
| State files drift from reality. | Cold starts resume incorrectly. | Final sync must update manifest, roadmap, and planning state only after verified progress. |
| Prompt-only workflow is mistaken for automation. | User expectations diverge from product behavior. | State clearly that the kit routes humans across model sessions; it does not run background agents. |

## Release Criteria

Anchor: `PRD.md::release-criteria`

v0.2 is releasable when:

1. Primary docs agree on version, phase state, and role-based workflow.
2. Phase 5 is pending until a real Builder disassembly and Executor task run occur.
3. Demo files describe the same Leader/Builder/Executor/Builder-review path as the prompts.
4. Hard-coded model names are not required to operate the workflow.
5. Handoff and review prompts preserve TDD and final-sync requirements.

**Current version:** v0.2
