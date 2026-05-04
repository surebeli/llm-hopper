# LLM-Hopper v0.1

**prompt-only、zero-code 的多角色跨进程 AI 开发框架**

让不同模型（Claude、Kimi、Gemini、DeepSeek、GLM 等）在不同终端、IDE、CLI 会话中组成**虚拟开发团队**，严格按角色（Leader / Builder / Executor / UI-Builder）协作。

## 核心特性

- **角色系统**：以 Nickname 为主标识。
  - **Leader**：仅负责 gstack + GSD 阶段（战略、规划、spec）。
  - **Builder**：全面执行 Superpowers + Review。
  - **Executor**：纯执行，只严格遵循指令（零创意）。
  - **UI-Builder**：专精 Web / 前端 UI（顶级设计感）。
- **跨进程 / 多模型 / 多 session**：支持不同窗口、不同模型协同。
- **Cost Tracking**：自动成本记录与报告。
- **Handoff 机制**：标准化、清晰、可追溯。
- **完全 prompt-only**：无需安装任何包或二进制。
- **Todo App Demo**：提供完整演示。

## 项目结构

```text
.hopper/
├── roles/ROLES.md                 # 角色定义
├── agents/AGENTS.md               # 所有 Agent 实例（Nickname + UUID + Model）
├── MANIFEST.md                    # 全局映射表
├── costs/COST-LOG.md              # 成本日志
├── prompts/
│   ├── setup-roles.md
│   ├── reconfigure-roles.md
│   ├── register-me.md
│   ├── role-status.md
│   ├── handoff-to-role.md
│   ├── track-cost.md
│   ├── cost-report.md
│   └── start-new-project-with-roles.md
├── demo/                          # Todo App 演示
└── scripts/                       # 可选快捷脚本
```

## 快速开始

### 1. 角色初始化（只需做一次）

首次设置：

```bash
LLM-Hopper: run role setup
```

或使用文件：

```bash
cat .hopper/prompts/setup-roles.md
```

复制 `BEGIN PROMPT` 内容并粘贴到目标 session。

### 2. 随时查看角色状态

```bash
cat .hopper/prompts/role-status.md
```

复制整个 `BEGIN PROMPT`，粘贴到任意 session。

### 3. 新 session 注册自己（推荐）

在任意模型 session 中运行：

```bash
cat .hopper/prompts/register-me.md
```

### 4. 启动新项目（推荐方式）

```bash
cat .hopper/prompts/start-new-project-with-roles.md
```

复制 `BEGIN PROMPT`，粘贴到 Leader session（例如 `leader-opus-47`），即可自动开始带角色的完整 workflow。

### 5. 成本追踪

每次 handoff 结束后运行：

```bash
cat .hopper/prompts/track-cost.md
```

随时查看报告：

```bash
cat .hopper/prompts/cost-report.md
```

所有记录保存在：

```text
.hopper/costs/COST-LOG.md
```

## 角色一览（当前配置）

| Nickname | Role | Model | 主要职责 |
| --- | --- | --- | --- |
| `leader-opus-47` | Leader | `claude-opus-4-7` | gstack + GSD（决策规划） |
| `builder-kimi` | Builder | `kimi-2.6` | Superpowers + Review |
| `mimo` | Builder | `mimo-v2.5-pro` | Superpowers + Review |
| `ui-builder-gemini` | UI-Builder | `gemini-3.1-pro` | Web / 前端 UI（顶级设计感） |
| `executor-glm` | Executor | `glm-5.1` | 纯执行（严格遵循指令） |
| `executor-deepseek` | Executor | `deepseek-v4-flash` | 纯执行（严格遵循指令） |

## Handoff 使用规范

推荐格式：

```markdown
=== HANDOFF TO ROLE ===
Use role: ui-builder-gemini
Completed phase: GSD
Next phase: Superpowers (UI implementation)
Prompt:
根据 TRD.md 中的 spec，实现 Todo App 的现代响应式界面，要求顶级设计感。
```

日常常用的简写方式：

```text
Use role: builder-kimi to execute the backend logic strictly following PLAN.md
```

## Demo 演示

```bash
cd .hopper/demo
./start-todo-demo.sh strategy
```

依次运行：

```text
strategy -> planning -> execution -> review
```

每一步都会自动提示使用对应角色。

## 成本追踪

- 运行 `track-cost.md` 记录本次消耗。
- 运行 `cost-report.md` 查看汇总报告。
- 所有记录保存在 `.hopper/costs/COST-LOG.md`。

## 最佳实践

- **Leader** 永远负责早期决策（gstack + GSD）。
- **UI 相关任务** 优先交给 `ui-builder-gemini`。
- **纯代码执行** 交给 Executor，避免模型乱加功能。
- 每次重要 handoff 后记录成本。
- 多窗口并行：一个窗口跑 Leader，另一个窗口跑 Builder / Executor。
- 定期运行 `role-status` 查看团队状态。

## 扩展方式

想增加新角色：

1. 修改 `.hopper/roles/ROLES.md`。
2. 运行 `.hopper/prompts/reconfigure-roles.md`。

想调整模型：

1. 运行 `.hopper/prompts/reconfigure-roles.md`。

想增加新 Direction（如 Backend、Testing）：

1. 直接在 `.hopper/roles/ROLES.md` 扩展即可。

## 使用方法

复制本 README 中需要的 prompt 文件命令，在项目根目录执行后，将对应内容粘贴到目标模型 session。

LLM-Hopper v0.1 已就绪。你现在拥有了一个真正的 prompt-only 多角色 AI 开发团队。
