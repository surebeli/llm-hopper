## 📐 仓库架构说明（供审查使用）

本仓库采用 **prompt-only + 文件状态机** 设计，所有运行时状态均通过 markdown 文件持久化。

### 核心目录
- `.hopper/`：框架本体（角色定义、prompt 模板、Skill 包、成本日志）
- `.planning/`：项目规划与执行记录（STATE.md 是全局状态机）
- `apps/`：Demo 项目输出目录

### 核心流程
1. Leader → gstack + GSD（生成 spec）
2. Builder → 拆 TDD task-spec
3. Executor → 严格执行单个 task
4. Builder → Reinforced Review + 派发下一 task
5. 每次结束 → FINAL SYNC（状态回填）

所有 handoff 均为自动生成，只需复制粘贴即可跨模型/跨 session 流转。

审查重点文件推荐顺序：
1. README.md
2. PRD.md（产品愿景）
3. TRD.md（技术架构）
4. .hopper/roles/ROLES.md（角色定义）
5. .hopper/prompts/handoff-to-role.md（核心 handoff + TDD + Builder Review）
6. .hopper/prompts/start-new-project-with-roles.md（启动流程）

欢迎任何大模型对以上文件进行审查。