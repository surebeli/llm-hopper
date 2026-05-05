#!/usr/bin/env bash
#
# LLM-Hopper skill installer (Claude Code + Codex CLI).
#
# Usage:
#   bash .hopper/skill-package/install.sh --target {claude-code|codex|all} \
#        [--scope {project|user}] [--dry-run] [--uninstall]
#
# Defaults: --target all --scope project (project scope only applies to
# claude-code; codex installs are user-scoped).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="${SCRIPT_DIR}"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

TARGET="all"
SCOPE="project"
DRY_RUN=0
UNINSTALL=0

usage() {
    cat <<'USAGE'
LLM-Hopper skill installer.

Usage:
  install.sh --target {claude-code|codex|all} [--scope {project|user}] [--dry-run] [--uninstall]

Options:
  --target    Which agent to install for. Default: all.
  --scope     project (default) installs into ./.claude/. user installs into
              ~/.claude/. Codex CLI is always user-scoped (~/.codex/prompts/).
  --dry-run   Print every action without executing it.
  --uninstall Remove previously installed files instead of installing.
  -h, --help  Print this message.
USAGE
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --target) TARGET="${2:-}"; shift 2 ;;
        --scope) SCOPE="${2:-}"; shift 2 ;;
        --dry-run) DRY_RUN=1; shift ;;
        --uninstall) UNINSTALL=1; shift ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'Unknown argument: %s\n\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
done

case "$TARGET" in
    claude-code|codex|all) ;;
    *) printf 'Invalid --target: %s (expected claude-code|codex|all)\n' "$TARGET" >&2; exit 2 ;;
esac

case "$SCOPE" in
    project|user) ;;
    *) printf 'Invalid --scope: %s (expected project|user)\n' "$SCOPE" >&2; exit 2 ;;
esac

run() {
    if [[ $DRY_RUN -eq 1 ]]; then
        printf '[dry-run] %s\n' "$*"
    else
        eval "$@"
    fi
}

copy_file() {
    local src="$1" dst="$2"
    run "mkdir -p \"$(dirname "$dst")\""
    if [[ $UNINSTALL -eq 1 ]]; then
        run "rm -f \"$dst\""
        [[ $DRY_RUN -eq 0 ]] && printf -- '- removed %s\n' "$dst"
    else
        run "cp \"$src\" \"$dst\""
        [[ $DRY_RUN -eq 0 ]] && printf -- '- installed %s\n' "$dst"
    fi
}

install_claude_code() {
    local skill_root commands_root
    if [[ "$SCOPE" == "project" ]]; then
        skill_root="${REPO_ROOT}/.claude/skills/llm-hopper"
        commands_root="${REPO_ROOT}/.claude/commands"
    else
        skill_root="${HOME}/.claude/skills/llm-hopper"
        commands_root="${HOME}/.claude/commands"
    fi

    printf '\n=== Claude Code (%s scope) ===\n' "$SCOPE"
    copy_file "${PKG_DIR}/claude-code/SKILL.md" "${skill_root}/SKILL.md"
    for f in "${PKG_DIR}/claude-code/commands/"*.md; do
        copy_file "$f" "${commands_root}/$(basename "$f")"
    done
}

install_codex() {
    local prompts_root="${HOME}/.codex/prompts"
    printf '\n=== Codex CLI (user scope) ===\n'
    for f in "${PKG_DIR}/codex/prompts/"*.md; do
        copy_file "$f" "${prompts_root}/$(basename "$f")"
    done
}

if [[ $UNINSTALL -eq 1 ]]; then
    printf 'LLM-Hopper skill: UNINSTALL (target=%s, scope=%s)\n' "$TARGET" "$SCOPE"
else
    printf 'LLM-Hopper skill: install (target=%s, scope=%s)\n' "$TARGET" "$SCOPE"
fi

case "$TARGET" in
    claude-code) install_claude_code ;;
    codex) install_codex ;;
    all) install_claude_code; install_codex ;;
esac

printf '\nDone.\n'
if [[ $UNINSTALL -eq 0 ]]; then
    printf 'Restart your Claude Code or Codex CLI session in this directory.\n'
    printf 'Type /help to confirm /hopper, /use-role, /role-status, /track-cost, /cost-report appear.\n'
fi
