# TRD - LLM-Hopper v0.2

## 技术架构概述
- **核心机制**：prompt-only + 文件锚定状态（.hopper/ + .planning/）
- **角色系统**：Nickname 为主标识，UUID 为备用
- **Handoff 机制**：自动生成 + FINAL SYNC
- **执行流程**：Builder 拆 TDD task → Executor 严格执行 → Builder 验收 → 派发下一 task
- **状态同步**：每次任务结束强制更新 STATE.md / ROADMAP.md / MANIFEST.md / COST-LOG.md

## 关键目录说明
- `.hopper/`：框架核心（roles、agents、prompts、costs、skill-package）
- `.planning/`：项目规划与 task 拆分（STATE.md、ROADMAP.md、phases/）
- `apps/`：Demo 项目输出目录（Todo App）

## 主要技术决策
- TDD 强制执行（RED → GREEN → REFACTOR）
- Builder 负责最终质量验收（Reinforced Review Checklist）
- Executor 严格限定文件范围 + 行为合同
- Skill 包实现一条命令跨工具调用

## 未来扩展点
- 支持更多 Direction（Backend、Testing 等）
- 成本 dashboard 可视化
- 持久化 Agent 记忆

**当前版本**：v0.2（2026-05-05）
