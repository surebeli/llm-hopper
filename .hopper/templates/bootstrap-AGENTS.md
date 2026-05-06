# AGENTS.md (Template — Codex CLI bootstrap)

> **使用说明**：把本文件复制到目标项目根目录的 `AGENTS.md`（**不是** `.hopper/AGENTS.md`），按本项目情况填充，删除本说明。Codex CLI 进入项目目录时自动加载本文件。
>
> ⚠️ **不要与 `.hopper/AGENTS.md` 混淆**——后者是 llm-hopper 的角色-LLM 绑定表，本文件只是 Codex CLI 的项目级指令文件。

This project uses **llm-hopper** for multi-LLM coordination.

## Ping protocol

When the user types `ping` (or `ping <role>` / `ping --status` / `ping --dry`), **read `.hopper/PING.md` and follow it exactly** — don't paraphrase, execute its steps.

## Project context

- **What this is**: {{ 一句话描述本项目 }}
- **Current branch**: {{ feat/your-branch }}
- **Active work**: {{ 当前阶段 }}
- **Role-LLM bindings**: `.hopper/AGENTS.md`
- **Phase cursor**: `.hopper/MANIFEST.md`
- **Task queue**: `.hopper/queue.md`

## Likely roles for GPT-5.5 (Codex / ChatGPT) in this repo

按 `.hopper/AGENTS.md`，GPT-5.5 通常担任：

- {{ builder — 通用代码实装 }}
- {{ critic — adversarial review（**必须独立 session**）}}
- {{ ... }}

⚠️ Critic 角色硬要求：开新 chat、不带 Builder 历史。
