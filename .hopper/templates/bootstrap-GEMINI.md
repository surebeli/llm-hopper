# GEMINI.md (Template)

> **使用说明**：把本文件复制到目标项目根目录的 `GEMINI.md`，按本项目情况填充 "Project context" 与 "Likely roles" 段，删除本说明。Gemini CLI 进入项目目录时自动加载本文件。

This project uses **llm-hopper** for multi-LLM coordination.

## Ping protocol

When the user types `ping` (or `ping <role>` / `ping --status` / `ping --dry`), **read `.hopper/PING.md` and follow it exactly** — don't paraphrase, execute its steps.

## Project context

- **What this is**: {{ 一句话描述本项目 }}
- **Current branch**: {{ feat/your-branch }}
- **Active work**: {{ 当前阶段 }}
- **Role-LLM bindings**: `.hopper/AGENTS.md`（注：此文件 ≠ 根目录的 `AGENTS.md`）
- **Phase cursor**: `.hopper/MANIFEST.md`
- **Task queue**: `.hopper/queue.md`

## Likely roles for Gemini in this repo

按 `.hopper/AGENTS.md`，本项目 Gemini 通常担任：

- {{ researcher — 大上下文调研角色 }}
- {{ builder-ui — 前端实装 }}
- {{ ... }}

如不确定本 session 当哪个角色，向用户确认。
