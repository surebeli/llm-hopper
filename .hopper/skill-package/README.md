# LLM-Hopper Skill Package

Anchor: `.hopper/skill-package/README.md::root`

This directory contains tool-specific packaging of the LLM-Hopper v0.2 prompt
surface. The repository remains the single source of truth; these files only
re-expose the existing prompts in `.hopper/prompts/` as native slash commands
and skills for two coding agents.

## Contents

| Path | Target | What it provides |
|------|--------|------------------|
| `claude-code/SKILL.md` | Claude Code (Agent Skill) | Auto-loaded skill that introduces LLM-Hopper to the agent and points it at the in-repo prompts. |
| `claude-code/commands/*.md` | Claude Code (Slash Commands) | `/hopper`, `/use-role`, `/role-status`, `/track-cost`, `/cost-report` as project-level or user-level slash commands. |
| `codex/prompts/*.md` | Codex CLI (Custom Prompts) | Same five commands, packaged as Codex custom prompts. |
| `install.sh` | Both | Cross-platform installer with `--target` flag. |
| `install.ps1` | Both (Windows) | PowerShell equivalent of `install.sh`. |

## Install

### Claude Code (project-level, recommended)

Project-scoped install — the slash commands and skill only activate inside this
repo.

```bash
bash .hopper/skill-package/install.sh --target claude-code --scope project
```

This copies:

- `claude-code/SKILL.md` → `.claude/skills/llm-hopper/SKILL.md`
- `claude-code/commands/*.md` → `.claude/commands/`

Restart the Claude Code session in this directory; type `/help` to confirm
`/hopper`, `/use-role`, `/role-status`, `/track-cost`, `/cost-report` are
listed.

### Claude Code (user-level)

User-scoped install — available across every Claude Code session for your user
account.

```bash
bash .hopper/skill-package/install.sh --target claude-code --scope user
```

This copies into `~/.claude/skills/llm-hopper/` and `~/.claude/commands/`.

### Codex CLI

Codex CLI custom prompts are user-scoped only.

```bash
bash .hopper/skill-package/install.sh --target codex
```

This copies `codex/prompts/*.md` → `~/.codex/prompts/`. Each file becomes
invokable as a slash command of the same name in any Codex CLI session.

### Both at once

```bash
bash .hopper/skill-package/install.sh --target all
```

### Windows / PowerShell

```powershell
.\.hopper\skill-package\install.ps1 -Target claude-code -Scope project
.\.hopper\skill-package\install.ps1 -Target codex
.\.hopper\skill-package\install.ps1 -Target all
```

### Dry run

```bash
bash .hopper/skill-package/install.sh --target all --dry-run
```

Prints every file copy without performing it.

### Uninstall

```bash
bash .hopper/skill-package/install.sh --target all --uninstall
```

Removes the installed files but leaves your `~/.claude/` and `~/.codex/`
directories otherwise untouched.

## What Each Command Does

| Command | Behavior |
|---------|----------|
| `/hopper start` | Loads roles + manifest, then runs the v0.2 start workflow from `.hopper/prompts/start-new-project-with-roles.md`. |
| `/hopper status` | Reports current phase from `.hopper/MANIFEST.md`. |
| `/use-role <nickname>` | Switches active role to the named nickname and emits the next handoff block from `.hopper/prompts/handoff-to-role.md`. |
| `/role-status` | Lists the current role-to-agent mapping from `.hopper/agents/AGENTS.md`. |
| `/track-cost` | Runs `.hopper/prompts/track-cost.md`. |
| `/cost-report` | Runs `.hopper/prompts/cost-report.md`. |

All commands route through the in-repo prompts so the workflow stays consistent
across Claude Code, Codex CLI, and any future target.

## Notes

- The package is a thin shim over `.hopper/prompts/`. Editing the prompt files
  changes command behavior; no reinstall needed if commands reference the files
  by path.
- Role and model bindings still come from `.hopper/agents/AGENTS.md`. Update
  that file with your locally available models before running `/hopper start`.
- These commands assume the current working directory is an LLM-Hopper project
  root. Outside that context they will print a hint instead of failing
  silently.
