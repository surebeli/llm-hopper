# Changelog

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
