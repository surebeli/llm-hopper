# llm-hopper

**厂商无关的 LLM 协作工具** — 自带你的 Claude / GPT / Gemini / DeepSeek / Kimi / GLM，把 Leader 角色做成可换的配置项。

> **状态：v0.2 — 实验性思想 demo。**
>
> 本仓库当前不是生产工具，而是一份**多 LLM 协作方法（discipline）** + 一组**可换 Leader 的 prompt 模板** + 跨厂商**成本观测**草图。用作思想验证与作者自己的 dogfood，不追求产品化 PMF。

---

## 为什么有这个项目

2024–2026 年密集发生过这些事：

- Anthropic 多次调整 Pro / Max 配额与工具策略
- OpenAI API 区域可用性波动 + 模型 deprecation 加速
- DeepSeek / Kimi / GLM 在中国境外有 geo-fencing
- Gemini 部分能力按地区门控
- "本地 CLI 突然不能跑"在 2026 年是常态

如果你的整套 AI 工作流绑死在某一家厂商的 CLI 或政策上，任何一次政策变化你都要重学一次。**hopper 把这种风险变成一行配置。**

```toml
# hopper.toml — v0.3 草图（当前 v0.2 仍是纯 prompt-only，下面的 toml 还未实现）
leader   = "claude-opus"     # 或 gpt-5.5 / deepseek-v4 / glm-4.6
builder  = "codex"
executor = "deepseek"
ui       = "gemini"
```

leader 这一行你今天填 Claude，明天填 GPT-5.5，后天填 DeepSeek——同一套 workflow，零代码改动。

---

## 它是什么

- 一份多 LLM 协作的**方法（discipline）**：Leader / Builder / Executor / UI-Builder 角色定义、TDD task 拆解、强化的 Builder review 等模式
- 一组**厂商无关的 prompt 模板**：每个角色的 system prompt 在不同 LLM 上都做过对齐（capability profile 进行中）
- 一份**跨厂商成本观测**的草图：把不同厂商的 token / $ 数据聚合到一份本地日志
- **思想 demo**：作者用它来实验"不绑定单一厂商的 LLM 协作"长什么样

## 它不是什么

- ❌ 又一个 multi-agent harness（[OMC](https://github.com/Yeachan-Heo/oh-my-claudecode) / [OMO](https://github.com/code-yeongyu/oh-my-openagent) 已经在做，且做得比本仓库深得多）
- ❌ 一个生产就绪的 runtime（v0.x 是 prompt 驱动，没有 daemon / 进程管理）
- ❌ 一个 GUI 或 IDE 插件
- ❌ Claude Code / OpenCode 的替代品（hopper 不替代任何宿主，它**没有宿主**）

## 什么时候用它

- 你已经同时持有 ≥2 家 LLM 的订阅或 API key
- 你对厂商锁定（vendor lock-in）警觉，想保留切换 Leader 的能力
- 你接受用 prompt 模板而不是 GUI 来工作
- 你想看跨厂商真实的 token / $ 数据，而不是某家自己声称的"省 50%"

## 什么时候不用

- 想要 OMC 那种 32-agent 全自动 harness——直接用 OMC，更合适
- 单家订阅完全够用——hopper 帮不到你
- 需要团队协作 / 企业级 runtime——本仓库目前不解决
- 不想读 prompt、只想点按钮——本仓库不是产品

---

## 同类项目对照

写给同行参考，避免重复造轮子或选错工具：

| 方向 | 代表项目 | 与 hopper 的关系 |
|------|---------|------------------|
| 全自动 multi-agent harness（绑定宿主）| OMC、OMO、myclaude | 不竞争。它们做"住进某宿主把宿主变厉害"，hopper 做"不住进任何宿主，让协作可携带"。可叠加使用 |
| 单次调用 API 路由 | OpenRouter、LiteLLM | 不重叠。它们是单次调用的 API 网关，hopper 是多步 agent 协作的 orchestrator |
| 代码驱动的 agent 框架 | LangGraph、CrewAI、AutoGen | 不重叠。它们是开发者构建 agent 产品的 SDK，hopper 是用户协调自己 LLM 工作流的方法 |
| 多模型 chat UI | Cherry Studio、ChatHub、NextChat | 不重叠。它们做对话聚合，hopper 做带状态的 agent handoff |

如果你已经在用上面任何一个，hopper 不要替换它。可以**叠加**：用 OMC 把 Claude 内部 32-agent 编排做好，再用 hopper 的方法在 OMC 与其他 LLM 之间做厂商无关的协作 + 成本聚合。

---

## 状态与路线

| 版本 | 状态 | 内容 |
|------|------|------|
| v0.2 | current | Prompt-only 4 角色 framework + Skill 包（Claude Code / Codex 合规） |
| v0.2.1 | docs / state 修复轨 | PRD / TRD 错误处理矩阵、兼容矩阵、状态一致性 |
| v0.3 | in design (dogfood 进行中) | 厂商无关重定位、capability profile、cost observability、ping 协议（已落地，见 `.hopper/PING.md`）|
| v0.4+ | deferred | 可选 thin runtime（Python / Go CLI）、可选 terminal multiplexer backend |

源头文件：

- `.hopper/MANIFEST.md` — phase cursor
- `.planning/STATE.md` — GSD 兼容的 planning cursor
- `.hopper/agents/AGENTS.md` — 本地 Nickname → Role → Model 映射（**模型版本只在这里写死，不进 PRD / TRD**）

---

## 推荐阅读（待补充）

发布时回到本节挂链接：

- *Why your AI workflow is one policy change away from breaking* — 长文，作者写作中
- *Multi-LLM coordination as a discipline, not a framework* — 计划中
- *Where every multi-LLM harness in 2026 hides your money* — 计划中

---

## 项目结构（v0.2 + v0.3 部分）

```text
.hopper/
├── roles/ROLES.md              # 角色定义（厂商无关）
├── agents/AGENTS.md            # 本地 Nickname → Role → Model 映射
├── MANIFEST.md                 # phase cursor
├── costs/COST-LOG.md           # 成本日志（手动）
├── prompts/                    # 4 个主入口 prompt
│   ├── start-new-project-with-roles.md
│   ├── handoff-to-role.md
│   ├── track-cost.md
│   └── cost-report.md
├── PING.md                     # v0.3：ping 协议单一来源（dogfood 落地）
├── templates/                  # v0.3：可复用到其他项目的脚手架
│   ├── queue.md                  #   通用 queue.md 模板
│   ├── bootstrap-CLAUDE.md       #   Claude Code 自动加载文件模板
│   ├── bootstrap-GEMINI.md       #   Gemini CLI 自动加载文件模板
│   └── bootstrap-AGENTS.md       #   Codex CLI 自动加载文件模板
├── skill-package/              # Claude Code skill / Codex prompts
└── demo/                       # Todo App 演示路径
```

**v0.3 ping 协议简述**：在使用 hopper 的任意项目里输入 `ping` 即可让当前 LLM CLI 自动从 `.hopper/queue.md` pop 下一个 eligible task、执行、写盘、commit、汇报。已在 myWriteAssistant dogfood 跨 Claude Code / Codex CLI / Gemini CLI 三家验证。详见 `.hopper/PING.md`。

---

## 快速开始（v0.2 prompt-only 模式）

> 这是当前可用路径。v0.3 的 `hopper.toml` + adapter 还在草图阶段，未发布。

### 启动新项目

```bash
cat .hopper/prompts/start-new-project-with-roles.md
```

复制 `BEGIN PROMPT`，粘贴到你选定的 Leader session（任意 LLM CLI / IDE，不限 Claude）。

### 任意阶段 handoff

```bash
cat .hopper/prompts/handoff-to-role.md
```

复制 `BEGIN PROMPT`，粘贴到下一角色的 session。

### 记成本

```bash
cat .hopper/prompts/track-cost.md
cat .hopper/prompts/cost-report.md
```

记录在 `.hopper/costs/COST-LOG.md`。

---

## 角色配置（示例，可任意改）

| Nickname            | Role        | Model（示例）                        | 备注                  |
|---------------------|-------------|------------------------------------|-----------------------|
| leader-primary      | Leader      | claude-opus / gpt-5.5 / deepseek-v4 | 决策与规划，可换       |
| builder-primary     | Builder     | claude-sonnet / codex               | 拆 TDD、做 review     |
| ui-builder-primary  | UI-Builder  | gemini / claude-sonnet              | 前端实现              |
| executor-primary    | Executor    | glm-4.6 / deepseek                  | 纯执行                |

每个项目都可以有自己的角色组合。修改 `.hopper/agents/AGENTS.md` 即生效。

---

## TODO

- [ ] Day 1 实验：vendor-agnostic 视频对比（claude-leader vs gpt-leader 同任务跑一遍）—— 暂缓
- [ ] Capability profile：跨 Leader 评测 rubric + 5 个固定任务样本
- [ ] hopper.toml 草图 + 三个 adapter（claude_cli / codex_cli / openrouter）
- [ ] Cost observability v0：解析 `~/.claude/projects/*.jsonl` + Codex / API 日志聚合脚本
- [ ] English README（IP 路径主战场是英文 HN，需要英文版本）
- [ ] skill-package 集成 ping 协议（让 `install.sh` 顺带把 PING.md + 模板部署到目标项目）
- [ ] 累积 5 条以上 dogfood 通用经验后，建 `docs/common-pitfalls.md`（dogfood F2/F3 已是种子）
- [x] LICENSE 文件（MIT）
- [x] ping 协议 v2（atomic commit）落地——myWriteAssistant dogfood 验证后同步到 `.hopper/PING.md` + `templates/`

---

## License

MIT。详见 [LICENSE](./LICENSE)。

仍是单人项目。issue / PR 欢迎，但作者不保证响应时效——这是 v0.x 思想 demo，不是产品。
