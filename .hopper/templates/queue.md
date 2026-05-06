# Hopper Queue (Template)

Anchor: `.hopper/queue.md::root`

> **使用说明**：把本文件复制到目标项目的 `.hopper/queue.md`，删除本说明段，按你项目的实际任务填表。
>
> 本文件**仅追踪状态**，任务详情由 Leader 维护在 `.hopper/handoffs/leader-tasklist.md`（或等价的 spec 文件）。

- Schema version: 1（见 `.hopper/PING.md`）
- Status 取值：`pending` / `in-progress` / `done` / `failed`
- 推送权限：仅 Leader（详见 `PING.md::push-protocol`）
- 弹出协议：见 `.hopper/PING.md`

---

## Tasks

| ID | Role | Status | Depends | Brief |
|----|------|--------|---------|-------|
| T01 | builder | pending |  | （示例）项目骨架——基础类型、registry、若干 stub 文件 |
| T02 | builder | pending | T01 | （示例）核心抽象层实装 |
| review-T01-T02 | critic | pending | T01, T02 | （示例）对 T01 / T02 PR diff 的 adversarial review |

---

## Activity log

> 每次 pop / done / failed 由 popping session 追加一行。格式见 `PING.md::step-3` 与 `step-7`。

- queue 初始化 at YYYY-MM-DDTHH:MM:SSZ by leader (model-name)
