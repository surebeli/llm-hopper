# LLM-Hopper Project Vision

Anchor: `PROJECT.md::vision`

## Product Vision

LLM-Hopper is a prompt-only workflow router for people who use multiple large language models across separate Codex CLI sessions or web subscriptions. The product turns a Git-backed project folder into the stable handoff point between strategy, planning, execution, and quality review models. The MVP does not ship runtime code. It ships clear markdown artifacts, command prompts, routing rules, and phase handoffs that let a human reliably move work between models without losing context.

The long-term vision is a lightweight operating discipline for multi-model development: use the strongest model for high-stakes decisions, use cheaper or faster coding models for bounded execution, and use a review model for quality convergence. The repo becomes the memory layer. The human remains in control of session starts and approvals.

## Problem Statement

Multi-LLM development is powerful but fragile. Users manually copy requirements, partial plans, code review notes, and session summaries between tools. Context drifts. Decisions get lost. Expensive models are used for cheap execution work, while cheap models are asked to make architectural decisions they should not own. Existing agent workflows also assume a single process, a persistent runtime, or API access, which excludes users who operate through CLI sessions and subscription-based model access.

LLM-Hopper solves the coordination problem by making every model handoff explicit, file-backed, and phase-bound.

## Target User

The first user is a developer or builder who already switches between Claude, GPT, Gemini, Kimi, DeepSeek, GLM, Mimo, or similar systems to control cost and quality. They are comfortable with Git and command-line workflows but do not want to write custom orchestration code, maintain API keys, or trust hidden agent state.

## MVP Promise

Given a project folder, LLM-Hopper will produce and maintain a small set of markdown artifacts that define:

- The product vision and decision rationale.
- The PRD, TRD, roadmap, and execution plan.
- The exact model routing rules for each work phase.
- The handoff prompts needed to continue in a new Codex CLI session.
- The quality loop that brings completed work back to a stronger reviewer.

## gstack Step 1: Office-Hours Pressure Test

Anchor: `PROJECT.md::office-hours-pressure-test`

### Core Thesis

The thesis is credible: cross-process LLM workflows fail less because models are weak and more because coordination state is implicit. A file-backed workflow can improve reliability without requiring APIs or persistent daemons.

### Pressure Points

- The product must not pretend to automate what it cannot control. It can route, anchor, and instruct. It cannot guarantee that a separate model follows instructions unless the output is reviewed.
- The MVP must be narrow. A prompt-only router should first prove that phase handoffs, artifacts, and quality loops reduce context loss.
- The workflow must be legible. If the artifact set grows too large, users will abandon it and return to copy-paste.
- The model routing table must be advisory and replaceable. Model availability changes quickly, and the router should preserve roles rather than hard-code vendors as assumptions.
- The handoff mechanism must survive a cold start. A new session must be able to reconstruct the current state from files alone.

### Office-Hours Verdict

Proceed with a markdown-only MVP. The strongest wedge is not general automation. The strongest wedge is disciplined cross-session continuity: every session starts from anchored files, performs one phase, updates the manifest, and ends with an exact handoff block.

## gstack Step 2: CEO Review

Anchor: `PROJECT.md::ceo-review`

LLM-Hopper should be positioned as a "multi-model development handoff kit" rather than an autonomous agent platform. The MVP is valuable if it gives users confidence that expensive reasoning, cheap execution, and final review can cooperate without hidden infrastructure. The product should optimize for trust, reproducibility, and low setup friction.

The first release should avoid API integrations, background workers, package installation, browser plugins, or generated binaries. Those would distract from the core insight: a structured repo can be the durable shared memory between models.

## Scope

Anchor: `PROJECT.md::scope`

In scope for MVP:

- Markdown artifacts for strategy, requirements, technical design, roadmap, execution prompts, and quality review.
- `.hopper/MANIFEST.md` as the phase cursor.
- SpecTeam/GSD-style anchors for every durable decision and deliverable.
- Explicit Codex CLI handoff commands.
- A prompt-only demo workflow.

Out of scope for MVP:

- API orchestration.
- Local daemons or background sync.
- Binary installers.
- Package dependencies.
- Automated browser control.
- Guaranteed model compliance without human review.

## Success Definition

Anchor: `PROJECT.md::success-definition`

The MVP succeeds when a user can close one model session, open a new one with the recommended model, paste the handoff prompt, and continue the same project phase with no missing critical context.
