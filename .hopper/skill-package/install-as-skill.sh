#!/bin/bash
echo "Installing LLM-Hopper v0.2 as Skill..."

# Common Claude Code / Cursor / Codex skill paths.
mkdir -p ~/.claude/skills/llm-hopper 2>/dev/null
mkdir -p ~/.cursor/skills/llm-hopper 2>/dev/null
mkdir -p ~/.codex/skills/llm-hopper 2>/dev/null

cp -r .hopper/skill-package/* ~/.claude/skills/llm-hopper/ 2>/dev/null
cp -r .hopper/skill-package/* ~/.cursor/skills/llm-hopper/ 2>/dev/null
cp -r .hopper/skill-package/* ~/.codex/skills/llm-hopper/ 2>/dev/null

echo "LLM-Hopper Skill installed."
echo ""
echo "Usage:"
echo "1. In Claude Code / Cursor / Codex CLI, use:"
echo "   /hopper start          - start a new project"
echo "   /use-role builder-kimi - switch role and generate handoff"
echo "   /role-status           - show role status"
