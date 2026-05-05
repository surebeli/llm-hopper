# LLM-Hopper v0.2

**prompt-only、zero-code 的多角色跨进程 AI 开发框架**

让不同模型在不同终端 / IDE / CLI 会话中组成**虚拟开发团队**，通过自动 handoff 实现无缝协作。

## 核心特性

- 角色系统（以 Nickname 为主要标识）
- 自动 Handoff（完成任务后自动生成下一 block，只需复制粘贴）
- FINAL SYNC & BACKFILL（自动更新全局状态，避免断头路）
- Cost Tracking
- Skill 包支持：原生 Claude Code skill + slash commands，原生 Codex CLI prompts，一键安装（详见 `.hopper/skill-package/README.md`）

## 项目结构

```text
.hopper/
├── roles/ROLES.md                 # 角色定义
├── agents/AGENTS.md               # 所有 Agent 实例（Nickname + UUID + Model）
├── MANIFEST.md                    # 全局映射表
├── costs/COST-LOG.md              # 成本日志
├── prompts/
│   ├── README.md
│   ├── start-new-project-with-roles.md
│   ├── handoff-to-role.md
│   ├── track-cost.md
│   └── cost-report.md
├── demo/                          # Todo App 演示
└── scripts/                       # 可选快捷脚本
```

## 架构状态

- 当前版本线：v0.2 handoff kit；v0.2.1 是文档与状态一致性修复轨。
- 当前状态：Phase 4 Quality Convergence complete；Phase 5 Todo App validation pending，尚未派发 Executor task。
- 状态源头：`.hopper/MANIFEST.md` 是 phase cursor，`.planning/STATE.md` 是 GSD-compatible planning cursor。
- 角色源头：`.hopper/roles/ROLES.md` 定义权限，`.hopper/agents/AGENTS.md` 绑定本地 Nickname 和 Model。
- Prompt surface：只保留 `start-new-project-with-roles.md`、`handoff-to-role.md`、`track-cost.md`、`cost-report.md`。
- 执行纪律：Leader 定策略，Builder 拆 TDD task，Executor 只执行单 task，Builder review 后才派发下一步。

## 快速开始

### 1. 启动新项目（主入口）

```bash
cat .hopper/prompts/start-new-project-with-roles.md
```

复制 `BEGIN PROMPT`，粘贴到配置好的 Leader session（例如 `.hopper/agents/AGENTS.md` 中的 `leader-primary`），即可自动开始带角色的完整 workflow。

### 2. 继续任意 handoff（主入口）

```bash
cat .hopper/prompts/handoff-to-role.md
```

复制 `BEGIN PROMPT`，粘贴到下一角色 session。该 prompt 覆盖 FINAL SYNC、TDD task spec 与 Builder 强化验收。

### 3. 成本追踪

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
| leader-primary      | Leader      | `<leader-model>`             | gstack + GSD（决策规划）    |
| builder-primary     | Builder     | `<builder-model>`            | Superpowers + Review        |
| builder-secondary   | Builder     | `<builder-secondary-model>`  | Superpowers + Review        |
| ui-builder-primary  | UI-Builder  | `<ui-builder-model>`         | Web/前端 UI（顶级设计感）  |
| executor-primary    | Executor    | `<executor-model>`           | 纯执行                      |
| executor-secondary  | Executor    | `<executor-secondary-model>` | 纯执行                      |

### 如何手动调整角色配置（推荐做法）

1. 修改 **源头文件**（推荐）：
   - 编辑 `.hopper/agents/AGENTS.md`（添加、删除、修改角色）
   - 或直接维护 `.hopper/agents/AGENTS.md` 中的 Nickname / Role / Model 映射

2. 更新本 README.md 中的表格（只需复制粘贴最新状态）：
   - 以 `.hopper/agents/AGENTS.md` 为源头复制最新配置

3. 不同项目使用不同配置：
   - 每个新项目都可以有完全独立的角色组合（只需在该项目仓库的 .hopper/ 目录下修改即可）

## Handoff 使用规范

推荐格式：

```markdown
=== HANDOFF TO ROLE ===
Use role: ui-builder-primary
Completed phase: GSD
Next phase: Superpowers (UI implementation)
Prompt:
根据 TRD.md 中的 spec，实现 Todo App 的现代响应式界面，要求顶级设计感。
```

日常常用的简写方式：

```text
Use role: builder-primary to execute the backend logic strictly following PLAN.md
```

## Demo 演示

```bash
cd .hopper/demo
./start-todo-demo.sh kickoff
```

依次运行：

```text
kickoff -> disassemble -> execute -> builder-review
```

每一步都会自动提示使用对应角色。

## 成本追踪

- 运行 `track-cost.md` 记录本次消耗。
- 运行 `cost-report.md` 查看汇总报告。
- 所有记录保存在 `.hopper/costs/COST-LOG.md`。

## 最佳实践

- 每个项目开始时，建议先查看 `.hopper/agents/AGENTS.md` 确认角色配置是否符合当前项目需求
- 需要调整时，直接修改 `.hopper/agents/AGENTS.md`
- README.md 中的角色表格仅作为**文档参考**，以 `.hopper/agents/AGENTS.md` 为最终配置

## 扩展方式

想增加新角色：

1. 修改 `.hopper/roles/ROLES.md`。
2. 更新 `.hopper/agents/AGENTS.md` 中的 Nickname 映射。

想调整模型：

1. 更新 `.hopper/agents/AGENTS.md` 中的 Model 字段。

想增加新 Direction（如 Backend、Testing）：

1. 直接在 `.hopper/roles/ROLES.md` 扩展即可。

## 使用方法

复制本 README 中需要的 prompt 文件命令，在项目根目录执行后，将对应内容粘贴到目标模型 session。

LLM-Hopper v0.2 已就绪。你现在拥有了一个真正的 prompt-only 多角色 AI 开发团队。
