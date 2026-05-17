# Changelog

## v0.3-unreleased

- **Dispatch Template family** (2026-05-18): 4 templates at
  `.hopper/templates/dispatch-*.md` for Strategy→Leader / Leader→Builder /
  Leader→Pair (sidecar) / Builder→Pair (embedded sidecar prompt). Each
  enforces the Dispatcher Empathy principle (uniform quality bar, content
  scaled by role gradient). USAGE-GUIDE.md §3.3 documents the principle
  and the 5-question dispatcher self-check. Templates are scaffolding,
  not PING.md primitives — PING.md unchanged (freeze v5 through
  2026-11-15). Origin: P0 double-rework retro 2026-05-17 in
  myWriteAssistant dogfood — both reworks were dispatcher empathy
  failures, not executor failures. INPUT-side complement to PING v3
  output artifact schema (which is OUTPUT-side closure).
- **USAGE-GUIDE.md** (2026-05-17): comprehensive companion to PING.md v5
  documenting all inter-role communication patterns (PING protocol
  primitives, scattered conventions, dogfood-emergent patterns). Includes
  role catalog, primitive matrix, filename master table, ASCII lifecycle
  diagrams, 7 common-scenario recipes, and known-gap list (deferred to
  v0.6 per protocol freeze through 2026-11-15). Source: completeness
  audit during myWriteAssistant Round 2 dogfood.
- **Strategy role formalized in `roles/ROLES.md` and `agents/AGENTS.md`**
  (2026-05-17): documents the dogfood-emergent observer/supervisor layer
  above Leader. Communicates via `strategy-<dated>-<purpose>.md` push and
  consumes `leader-ping-strategy-<dated>.md` escalations. Marked optional
  layer; small projects can omit. PING.md unchanged (frozen v5);
  `MANIFEST.md` role-to-agent table refresh deferred to v0.6 unification
  pass.
- **PING protocol schema v5** (2026-05-07): eliminates ~80% of out-of-band
  Leader→Worker prose dispatch observed during T02-rework cycle. Four
  changes:
  - Step 0.5 also re-reads `.hopper/PING.md` (not just `queue.md`) —
    fixes "schema bumped, please re-read" prose
  - `ping <task-id>` / `ping --task=<id>` form for task-level override —
    replaces "do X next not lex default Y" prose (P4 promoted to A-class)
  - Leader Feedback Channel via `.hopper/handoffs/<task-id>-leader-feedback.md`
    file — replaces manual-verify diagnosis-via-chat with structured
    file-based audit trail
  - queue.md gets optional `Priority` column (`high`/`normal`/`low`);
    Step 2 sort by priority desc then lex
  Mitigations for HOPPER-FEEDBACK O8/O9/O10/P4/P9 from myWriteAssistant
  dogfood T02-rework 3-round manual verify cycle. The cycle exposed real
  production bugs (Doubao /responses endpoint mismatch + AI SDK 6.x
  toDataStreamResponse missing) that mock tests + Critic + Leader review
  all missed; live smoke against real upstream caught them.
- **PING protocol schema v4** (2026-05-07): added **Step 0.5 (refresh
  shared state)** to force fresh re-read of `.hopper/queue.md` and other
  shared files before each ping cycle, plus **Step 6 acceptance
  scope-qualify** restricting tsc/lint checks to task-touched files
  (full-repo checks too easily polluted by sibling sessions' WIP).
  Concurrency notes expanded with WIP-file-leakage mitigations and
  worktree advice. Mitigations for F5 (queue concurrent-write) and P7
  (WIP leakage) found in myWriteAssistant dogfood; both bugs were
  caught by Critic batch review (HOPPER-FEEDBACK O7) — single Leader
  review missed them.
- **PING protocol schema v3** (2026-05-06): added Step 7.5 (mandatory
  `.hopper/handoffs/<task-id>-output.md` artifact) + Leader Review Protocol
  (`review <task-id>` / `review` / `review --pending`). Closes the
  Worker → Leader feedback loop that previously required manual
  copy-paste from the worker's CLI.
- Added `.hopper/templates/builder-output.md` — structured output template
  for Builder / Builder-UI / Executor roles (Step 7.5 artifact).
- Added `.hopper/PING.md` — ping protocol schema v2 (atomic commit step
  enforced; 10-step lifecycle). Sourced from myWriteAssistant dogfood.
- Added `.hopper/templates/queue.md` — generic queue board template.
- Added `.hopper/templates/bootstrap-CLAUDE.md`, `bootstrap-GEMINI.md`,
  `bootstrap-AGENTS.md` — per-CLI auto-load entries that point at
  `.hopper/PING.md`. Each is a stand-alone file at target project's repo
  root (note: root `AGENTS.md` ≠ `.hopper/AGENTS.md`).
- README updated to document ping protocol and new templates dir.

## v0.2.1 - 2026-05-05

- Removed heredoc wrappers from PRD, TRD, prompt, skill, and installer artifacts.
- Corrected Phase 5 state back to pending across manifest, roadmap, and planning state.
- Aligned active docs to the v0.2 release line.
- Reworked the Todo demo around Leader, Builder, Executor, and Builder reinforced review.
- Rewrote PRD and TRD into standard product and technical structures.
- Reduced prompt surface to the two main workflow prompts plus cost prompts.
- Replaced hard-coded model names with configurable role/model placeholders.
- Repaired anchor drift in `.hopper/skill/` templates that pointed at the
  removed `TRD.md::phase-mutation-rules` section; references now use
  `TRD.md::data-and-state-files` and `TRD.md::role-contracts`.
- Repackaged `.hopper/skill-package/` to ship native Claude Code skill +
  slash commands and Codex CLI custom prompts with a real bash/PowerShell
  installer (`--target`, `--scope`, `--dry-run`, `--uninstall`).
- Expanded `.gitignore` to cover OS metadata, common IDE/editor state,
  logs, and local env files.
- Added `TRD.md::error-handling-matrix` (10 failure classes with detection
  and recovery paths) and `TRD.md::compatibility-matrix` (host support
  tiers from Claude Code Tier 1 down to generic web chat Tier 3).
