# CLAUDE.md (Template)

> **使用说明**：把本文件复制到目标项目根目录的 `CLAUDE.md`，按本项目情况填充 "Project context" 段，删除本说明。Claude Code 进入项目目录时自动加载本文件。

This project uses **llm-hopper** for multi-LLM coordination.

## Ping protocol

When the user types `ping` (or `ping <role>` / `ping --status` / `ping --dry`), **read `.hopper/PING.md` and follow it exactly** — don't paraphrase, execute its steps.

## Project context

- **What this is**: {{ 一句话描述本项目，例：Next.js 写作助手 / Rust CLI / Python 数据管道 }}
- **Current branch**: {{ feat/your-branch }}
- **Active work**: {{ 当前阶段，例：v0.2 vendor-agnostic refactor，spec at docs/plans/... }}
- **Role-LLM bindings**: `.hopper/AGENTS.md`（注：此文件 ≠ 根目录的 `AGENTS.md`，后者只是 Codex CLI bootstrap）
- **Phase cursor**: `.hopper/MANIFEST.md`
- **Task queue**: `.hopper/queue.md`

## Conventions in this repo

{{ 列出本项目特有的工程纪律，例如：}}
- 不创建 PRD/TRD 之外的 design 文档（除非 spec 明确要求）
- 模型版本只在 `.hopper/AGENTS.md` 写死，不进 PRD/TRD
- Builder PR commit message 前缀 `[T##]`
- Critic 必须用独立 session（无 Builder 历史）
