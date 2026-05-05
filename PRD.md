cat > PRD.md << 'EOF'
# PRD - LLM-Hopper v0.2

## 产品愿景
LLM-Hopper 是一个 **prompt-only、zero-code** 的多角色跨进程 AI 开发框架，让不同大模型在不同终端/IDE/CLI 会话中组成真正的虚拟开发团队，实现可靠、可控、可追溯的代码交付。

## 核心价值
- 解决传统 AI 编码“快但不可靠”的问题
- 通过严格角色分工 + 自动 handoff + FINAL SYNC 实现团队级协作
- 支持多模型并行工作（Claude、Kimi、Gemini、DeepSeek、GLM 等）

## 目标用户
- Solo founder / 重度 AI 用户
- 希望让多个模型组成虚拟团队的开发者

## 核心特性（v0.2）
- 角色系统（Leader / Builder / Executor / UI-Builder + Nickname）
- 自动 Handoff（完成即生成下一 block，只需复制粘贴）
- TDD 强制 + Builder Reinforced Review（Builder 负责最终验收）
- FINAL SYNC & BACKFILL（自动更新 STATE/ROADMAP/MANIFEST，避免断头路）
- Cost Tracking（token 消耗 + 费用记录）
- Skill 包支持（/hopper start、/use-role 等命令）
- Todo App Demo 完整演示

## 非功能需求
- 100% prompt-only（zero-code）
- 跨工具兼容（Claude Code / Cursor / Codex CLI 等）
- 状态持久化（markdown 文件锚定）
- 可手动调整角色配置

**成功指标**：能稳定让多个模型协作完成一个完整 Todo App 项目，且状态始终同步、无断头路。
EOF