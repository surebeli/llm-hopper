# LLM-Hopper v0.1

**prompt-only、zero-code 的多角色跨进程 AI 开发框架**

让不同模型在不同终端 / IDE / CLI 会话中组成**虚拟开发团队**，通过自动 handoff 实现无缝协作。

## 核心特性

- 角色系统（以 Nickname 为主要标识）
- 自动 Handoff（完成任务后自动生成下一 block，只需复制粘贴）
- FINAL SYNC & BACKFILL（自动更新全局状态，避免断头路）
- Cost Tracking
- Skill 包支持（一条命令使用）

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

> **注意**：下方表格是**当前项目的角色配置**，**不是全局固定配置**。  
> 你可以随时手动修改它（甚至为不同项目使用完全不同的角色组合）。

| Nickname            | Role        | Model             | 权限说明                     |
|---------------------|-------------|-------------------|------------------------------|
| leader-opus-47      | Leader      | claude-opus-4-7   | gstack + GSD（决策规划）    |
| builder-kimi        | Builder     | kimi-2.6          | Superpowers + Review        |
| mimo                | Builder     | mimo-v2.5-pro     | Superpowers + Review        |
| ui-builder-gemini   | UI-Builder  | gemini-3.1-pro    | Web/前端 UI（顶级设计感）  |
| executor-glm        | Executor    | glm-5.1           | 纯执行                      |
| executor-deepseek   | Executor    | deepseek-v4-flash | 纯执行                      |

### 如何手动调整角色配置（推荐做法）

1. 修改 **源头文件**（推荐）：
   - 编辑 `.hopper/agents/AGENTS.md`（添加、删除、修改角色）
   - 或运行 `reconfigure-roles.md` 进行交互式调整

2. 更新本 README.md 中的表格（只需复制粘贴最新状态）：
   - 运行 `role-status.md`
   - 把输出的 Confirmation Table 复制到上面表格中即可

3. 不同项目使用不同配置：
   - 每个新项目都可以有完全独立的角色组合（只需在该项目仓库的 .hopper/ 目录下修改即可）

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

- 每个项目开始时，建议先运行 `role-status.md` 确认角色配置是否符合当前项目需求
- 需要调整时，直接修改 `.hopper/agents/AGENTS.md` 或运行 `reconfigure-roles.md`
- README.md 中的角色表格仅作为**文档参考**，以 `.hopper/agents/AGENTS.md` 为最终配置

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
