cat > .hopper/skill-package/install-as-skill.sh << 'EOF'
#!/bin/bash
echo "🚀 Installing LLM-Hopper v0.2 as Skill..."

# Claude Code / Cursor / Windsurf 等常见路径
mkdir -p ~/.claude/skills/llm-hopper 2>/dev/null
mkdir -p ~/.cursor/skills/llm-hopper 2>/dev/null
mkdir -p ~/.codex/skills/llm-hopper 2>/dev/null

cp -r .hopper/skill-package/* ~/.claude/skills/llm-hopper/ 2>/dev/null
cp -r .hopper/skill-package/* ~/.cursor/skills/llm-hopper/ 2>/dev/null
cp -r .hopper/skill-package/* ~/.codex/skills/llm-hopper/ 2>/dev/null

echo "✅ LLM-Hopper Skill 安装成功！"
echo ""
echo "使用方法："
echo "1. 在 Claude Code / Cursor / Codex CLI 中输入："
echo "   /hopper start          ← 启动新项目"
echo "   /use-role builder-kimi ← 切换角色并自动生成任务"
echo "   /role-status           ← 查看角色状态"
echo ""
echo "现在你可以直接在任意支持 Skill 的工具中使用 LLM-Hopper 了！"
EOF

chmod +x .hopper/skill-package/install-as-skill.sh
echo "✅ install-as-skill.sh 已创建并赋予执行权限"