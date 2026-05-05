# LLM-Hopper 审查报告 — CEO / CTO / 产品总监三视角（GTM 角度）

Anchor: `REVIEW-REPORT.md::root`

- 审查日期：2026-05-05
- 审查对象：LLM-Hopper v0.1（README）/ v0.2（PRD/TRD/MANIFEST/STATE 标称值）
- 审查范围：PRD、TRD、PROJECT、DECISIONS、ROADMAP、`.hopper/`、`.planning/`、demo
- 审查视角：CEO（商业 / GTM）、CTO（技术 / 工程）、产品总监（用户与产品收敛）
- 审查方法：逐文件阅读 + 跨文件一致性审查 + GTM 可发布性 checklist

---

## 1. 执行摘要

Anchor: `REVIEW-REPORT.md::executive-summary`

| 视角 | 判定 | 一句话评价 |
|------|------|------------|
| CEO（GTM） | 🟥 **NO-GO，需重新定位** | 洞察成立，但当前形态既不是产品也不是 SDK；没有可发布的分发路径、没有付费假设、没有北极星指标 |
| CTO（工程） | 🟧 **CONDITIONAL，需修 P0** | 架构合理，但 5 个关键文件被 heredoc 外壳污染，v0.1↔v0.2 演进遗留断层，Phase 5 状态机虚假推进 |
| 产品总监（产品） | 🟧 **REWRITE PRD/收敛入口** | PRD 过薄、入口分裂（>8 种使用方式）、demo 与实际角色系统脱节、首次体验链路无法跑通 |

**整体结论**：这是一份"思维清晰、工程不达发布标准、商业未启动"的内部研究项目。优先级是先**让它能跑**（修 P0），再**让它能讲清楚**（收敛 PRD），最后才谈 **GTM**。

---

## 2. CEO 视角 — GTM 与商业可行性

Anchor: `REVIEW-REPORT.md::ceo-review`

### 2.1 命题与楔子（Wedge）

- **命题成立**：跨进程、跨订阅的多模型工作流确实存在"上下文遗失"的真实痛点。office-hours 压力测试做得很扎实（`PROJECT.md::office-hours-pressure-test`）。
- **楔子模糊**：v0.1 的"prompt-only / zero-code"约束在 MVP 阶段是优势（降低验证成本），但作为产品定位会让用户问：
  - 我为什么不直接用 README + 几个 prompt 模板？
  - 我为什么不用 GitHub repo template？
  - 这个跟 [Devin / Claude Code Subagents / Cursor Composer / Aider] 的多模型协作有什么不同？
- **没有不可替代性**：纯 markdown + 复制粘贴是最容易被任何工具内置的能力。OpenAI / Anthropic / Cursor 任何一家在两周内都能把这套"自动 handoff"内化为内置能力。

### 2.2 市场与目标用户

- 目标用户写得过窄："Solo founder / 重度 AI 用户"——这不是一个可触达的细分市场，而是一个画像。
- 没有定义任何**可量化的市场假设**：用户量级？付费意愿？替代成本？
- README 提到的多模型组合（Claude / Kimi / Gemini / DeepSeek / GLM / Mimo）暗示用户必须**已订阅 ≥3 家厂商**——这是一个极小的高频用户群。

### 2.3 GTM 准备度评分卡

| 维度 | 评分 | 证据 |
|------|------|------|
| 市场信号 | B | 痛点真实，社区有讨论 |
| 楔子清晰度 | C+ | "prompt-only"是天花板而非护城河 |
| 分发渠道 | D | 无 npm、无 brew、无 web、install 脚本本身有 P0 缺陷 |
| 首次体验（onboarding） | D | 8+ 种"快速开始"姿势，无单一入口 |
| 定价假设 | F | 完全空缺 |
| 护城河 | D- | 全部为可复制的提示词与文档，零运行时锁定 |
| 激活指标 | F | 未定义 |
| 留存指标 | F | 未定义 |

### 2.4 CEO 判定

**当前形态不能上市**。可行的三条战略路径（按推荐顺序）：

1. **方法论 / 内容产品化**："Multi-Model Development Discipline"——出书 / 在线课程 / 付费社区。文档密度足以支撑这条路径。  
2. **嵌入式 Skill / 集成产品**：把 LLM-Hopper 做成 Claude Code / Cursor / Codex 的 first-class plugin（带真实运行时校验、状态机自动同步），而不是"复制粘贴的提示词集合"。  
3. **小型 SaaS / CLI**：放弃 zero-code 约束，做一个本地 CLI（Rust / Go），状态机可读可写，提示词作为模板嵌入。

继续 v0.2 当前方向（仅扩 prompt + 角色）只会**增加复杂度而不增加可分发性**。

---

## 3. CTO 视角 — 技术架构与实现质量

Anchor: `REVIEW-REPORT.md::cto-review`

### 3.1 架构层面（基本面良好）

- 文件锚定状态机（`.hopper/MANIFEST.md`）+ 层级化 markdown 是合理设计。
- Anchor 约定（`FILE.md::section-name`）是有价值的工程产出，建议保留。
- DECISIONS.md 的"按角色路由优先于按模型路由"是正确决策（D-005）。
- 权限分层（Leader / Builder / Executor / UI-Builder）边界划得清楚。
- TDD 强制 + Reinforced Review Checklist 是有意义的纪律性约束（`handoff-to-role.md`）。
- 单个工程产出值得点赞：`.planning/phases/05-todo-app-build/TASK-LIST.md` 拆得专业，达到 senior 工程师水准。

### 3.2 P0 缺陷（必须立即修复，否则不可发布）

#### 3.2.1 五个关键文件被 heredoc 外壳污染

以下文件的**实际内容**是 shell heredoc 的字面字符串，意味着它们从未被执行落盘，而是直接把生成命令当作文件内容写了进去：

| 文件 | 首行 | 末行 | 影响 |
|------|------|------|------|
| `PRD.md` | `cat > PRD.md << 'EOF'` | `EOF` | 任何人读 PRD 看到的是 shell 脚本头 |
| `TRD.md` | `cat > TRD.md << 'EOF'` | `EOF` | 同上 |
| `.hopper/prompts/start-new-project-with-roles.md` | `cat > .hopper/prompts/start-new-project-with-roles.md << 'EOF'` | `EOF` | 复制到 LLM session 会让模型困惑 |
| `.hopper/skill-package/SKILL.md` | `cat > .hopper/skill-package/SKILL.md << 'EOF'` | `EOF` | Skill 包根本不可被 Claude Code/Cursor 加载 |
| `.hopper/scripts/install-as-skill.sh` | `cat > .hopper/skill-package/install-as-skill.sh << 'EOF'` | `EOF` + 后续 chmod | 安装脚本"安装"的是另一个文件，自身根本不能直接 `bash` 执行预期效果 |

**根因**：上一轮模型把"如何生成此文件的命令"当作"文件内容"输出，导致第一行不是文件内容而是落盘命令。这是一个跨多个文件的系统性 LLM 失误，且**未被任何一轮 review 发现**——这本身说明 Phase 4 "Quality Convergence" 的 review checklist 是名存实亡。

#### 3.2.2 状态机虚假推进

- `STATE.md`、`MANIFEST.md`、`ROADMAP.md` 三处声称 Phase 5 / T01 已经被 `executor-glm` 接管。
- 但仓库根本不存在 `apps/` 目录，T01 产物 `apps/todo/index.html` 不存在。
- 即 **状态机自身在撒谎**——这恰恰是 LLM-Hopper 试图解决的问题（防止"断头路"），却出现在 LLM-Hopper 自己身上。

#### 3.2.3 Skill 包不可加载

- `.hopper/skill-package/` 下只有一个被污染的 `SKILL.md`，没有 `commands/`、`hooks/`、`agents/` 等 Claude Code Skill / Plugin 通常需要的子结构。
- 声称的触发器 `/hopper start`、`/use-role`、`/role-status`、`/track-cost`、`/cost-report` 没有在任何工具的 plugin schema 中实现，仅是文档描述。
- `install-as-skill.sh` 把一个 markdown 文件复制到 `~/.claude/skills/llm-hopper/`、`~/.cursor/skills/llm-hopper/`、`~/.codex/skills/llm-hopper/`，这三个路径的 schema 完全不同，且都不会自动注册任何 slash command。

### 3.3 P1 缺陷（影响发布质量但不阻断）

- **v0.1 ↔ v0.2 演进断层**：
  - README.md 标题仍写 `LLM-Hopper v0.1`；PRD/TRD/MANIFEST 写 `v0.2`。
  - `.hopper/demo/TODO-APP.md` 描述的是 v0.1 的四阶段流程（Strategy → Planning → Execution → Review），但 v0.2 的角色系统是 Leader / Builder / Executor / UI-Builder + TDD。两套架构在仓库里**并存且互不引用**。
  - `start-todo-demo.sh` 跑的是 v0.1 流程；`handoff-to-role.md` 跑的是 v0.2 流程。
- **模型名称硬编码且具有时效性**：Kimi 2.6 / Gemini 3.1-pro / GLM 5.1 / DeepSeek V4-flash / Mimo v2.5-pro / GPT-5.5 xhigh 多数是当下未必稳定可用的具体版本号；DECISIONS.md::D-005 自己说"按角色路由"，但 AGENTS.md / MANIFEST.md / README 全部硬编码具体版本。
- **README 入口分裂**：README 提供 8+ 种"快速开始"路径（setup-roles / role-status / register-me / start-new-project-with-roles / track-cost / cost-report / 直接编辑 AGENTS.md / 安装 Skill），用户无法判断哪条是"主路"。
- **PRD/TRD 过薄**：合计约 40 行，缺少功能拆解、约束、非功能需求量化、性能假设、安全假设。
- **`.gitignore` 仅 9 字节**：未忽略任何敏感目录（如 OS 缓存、IDE 配置、cost 日志中可能含 token 数等）。

### 3.4 P2 缺陷（卫生与可维护性）

- 三份 ROADMAP（`ROADMAP.md`、`.planning/ROADMAP.md`、`PROJECT.md` 中嵌入的 Step 1/2/3）逻辑重叠但表述不一致。
- COST-LOG.md 仅 1 条记录，且额度为估算值，无法支撑"Cost Tracking"的产品宣传。
- Anchor 约定未在所有文件遵守（README、setup-roles.md、register-me.md、track-cost.md 等都没有 anchor）。
- Windows 项目却把 demo 主路径定在 bash 脚本上（无 PowerShell 等价物）。

### 3.5 CTO 判定

**架构 8/10，实现 4/10**。在不修复 P0 的情况下：仓库 `git clone` 后**无法跑通任何完整路径**，因为所有"快速开始"指向的核心文件（PRD / TRD / start-new-project / SKILL.md）都被 heredoc 外壳污染。

---

## 4. 产品总监视角 — PRD 一致性、用户体验、产品收敛

Anchor: `REVIEW-REPORT.md::pd-review`

### 4.1 PRD 审查（针对当前 `PRD.md`）

| 维度 | 现状 | 应该 |
|------|------|------|
| 长度 | 30 行 | 至少 PRD 应覆盖：背景 / 用户故事 / 关键场景 / 功能拆解 / 非功能需求 / 关键指标 / 风险与回退 |
| 用户画像 | 1 条："Solo founder / 重度 AI 用户" | 至少 2-3 个细分人群 + 痛点排序 + JTBD |
| 成功指标 | "稳定让多个模型协作完成 Todo App" | 这是工程内部 acceptance，不是产品成功指标。应有：激活率 / 7 日留存 / 项目完成率 / 单 token 成本节省比 |
| 用户故事 | 0 条 | 至少 5 条以"作为 X，我想 Y，以便 Z"格式 |
| 反例与边界 | 无 | 必须有"什么场景下不要用 LLM-Hopper" |
| 文件状态 | 被 heredoc 外壳污染 | 见 §3.2.1 |

### 4.2 TRD 审查（针对当前 `TRD.md`）

| 维度 | 现状 | 应该 |
|------|------|------|
| 长度 | 28 行 | 应包含：组件图 / 数据流 / 状态机 / 错误处理 / 退化路径 / 性能假设 / 安全假设 / 兼容矩阵 |
| 状态机定义 | 仅文字描述 | 应有显式 phase transition table |
| 错误处理 | 无 | 用户复制错 prompt / 模型不可用 / 状态文件被污染时的恢复路径完全缺失 |
| 兼容矩阵 | 无 | Codex CLI / Claude Code / Cursor / Windsurf / 各自版本支持情况 |
| 文件状态 | 被 heredoc 外壳污染 | 见 §3.2.1 |

### 4.3 用户旅程审查

新用户从 `git clone` 到第一次成功 handoff 的实际路径：

```text
1. 读 README.md（v0.1 措辞，提示用 setup-roles.md）
2. 读 setup-roles.md（要求把内容粘到 strategy-class 模型）
3. 但 PRD.md 是 v0.2 + heredoc 污染 → 模型困惑
4. 读 start-new-project-with-roles.md → 整个文件是 heredoc 字符串 → 模型再次困惑
5. 退一步看 demo → demo 描述的是 v0.1 四阶段，与 ROLES.md 的 v0.2 不一致
6. 用户放弃
```

**首次激活完成率（估算）：< 5%**。这不是 PMF 之前的产品，这是 PMF 之前的 demo。

### 4.4 入口收敛建议

当前 prompt 入口共 **13 个文件**：

```
.hopper/prompts/setup-roles.md
.hopper/prompts/reconfigure-roles.md
.hopper/prompts/register-me.md
.hopper/prompts/role-status.md
.hopper/prompts/handoff-to-role.md
.hopper/prompts/track-cost.md
.hopper/prompts/cost-report.md
.hopper/prompts/start-new-project-with-roles.md
.hopper/prompts/handoff-to-strategy.md
.hopper/prompts/handoff-to-planning.md
.hopper/prompts/handoff-to-execution.md
.hopper/prompts/handoff-to-review.md
.hopper/prompts/README.md
```

新用户面对 13 个入口文件 + 4 个 skill 文件（`.hopper/skill/*.md`） + 1 个 SKILL.md + 2 个 sh 脚本 + 5 个根 markdown，决策疲劳爆表。

### 4.5 产品总监判定

**PRD 必须重写**，TRD 必须扩写。入口收敛到 **2 个 prompt**（一个"启动新项目"，一个"角色 handoff"），其他全部降级为引用。

---

## 5. PRD / TRD 详细审查（按字段）

Anchor: `REVIEW-REPORT.md::prd-trd-line-by-line`

### 5.1 PRD 字段质量

| 字段 | 评分 | 备注 |
|------|------|------|
| 产品愿景 | 6/10 | 表述清晰，但"组成真正的虚拟开发团队"是宣传语，不是可验证命题 |
| 核心价值 | 5/10 | "解决 AI 编码快但不可靠的问题"过宽；应限定在"跨进程上下文遗失" |
| 目标用户 | 3/10 | 仅 2 行 |
| 核心特性 | 6/10 | 列举完整但缺少"必须 / 应当 / 可选"分级 |
| 非功能需求 | 4/10 | 4 行，未量化 |
| 成功指标 | 2/10 | 工程 acceptance，不是产品指标 |
| 文件健康度 | 0/10 | heredoc 外壳污染 |

### 5.2 TRD 字段质量

| 字段 | 评分 | 备注 |
|------|------|------|
| 技术架构概述 | 7/10 | 清晰但浅 |
| 关键目录 | 8/10 | 描述准确 |
| 技术决策 | 6/10 | 决策列出但未论证 |
| 未来扩展 | 5/10 | 三条均为空话 |
| 错误处理 | 0/10 | 完全缺失 |
| 文件健康度 | 0/10 | heredoc 外壳污染 |

---

## 6. 实现质量审查

Anchor: `REVIEW-REPORT.md::implementation-quality`

### 6.1 文件级问题清单

| 文件 | 严重度 | 问题 |
|------|--------|------|
| `PRD.md` | P0 | heredoc 外壳污染（首尾各一行无效内容） |
| `TRD.md` | P0 | heredoc 外壳污染 |
| `.hopper/prompts/start-new-project-with-roles.md` | P0 | heredoc 外壳污染 |
| `.hopper/skill-package/SKILL.md` | P0 | heredoc 外壳污染 + skill 包结构不完整 |
| `.hopper/scripts/install-as-skill.sh` | P0 | 内层 heredoc 实际生成的是另一脚本，自身行为与命名不一致 |
| `STATE.md` / `MANIFEST.md` / `ROADMAP.md` | P0 | 状态机虚假推进（Phase 5 T01 在 `apps/` 不存在的前提下被标记为 dispatched） |
| `README.md` | P1 | 标题 v0.1，与 PRD/TRD 的 v0.2 矛盾；入口分裂 |
| `.hopper/demo/TODO-APP.md` | P1 | 描述 v0.1 四层流程，与 v0.2 角色系统脱节 |
| `.hopper/demo/start-todo-demo.sh` | P1 | 描述 v0.1 流程，且 Windows 用户无 PowerShell 等价物 |
| `DECISIONS.md` | P2 | 模型路由表写的"GPT-5.5 xhigh / Kimi 2.6"等均为版本敏感字符串 |
| `.hopper/agents/AGENTS.md` | P2 | 同上 |
| `.hopper/costs/COST-LOG.md` | P2 | 仅 1 行估算数据 |
| `.gitignore` | P2 | 仅 9 字节，未忽略任何 IDE / OS 元数据 |
| `.planning/phases/05-todo-app-build/TASK-LIST.md` | ✅ | 高质量产出，可作为模板 |

### 6.2 跨文件一致性

- README v0.1 vs PRD v0.2：**冲突未解**
- demo 四层流程 vs ROLES 三角色系统：**冲突未解**
- STATE/MANIFEST 标记 T01 dispatched vs 实际无 `apps/`：**状态欺骗**
- DECISIONS 模型表 vs AGENTS/MANIFEST 实际模型：**两份硬编码各自漂移**

### 6.3 安全与合规

- COST-LOG.md 可能记录用户使用模式，未在 README 中声明数据采集与分享边界。
- 多处提到将仓库内容"粘贴到云端模型 session"，未提示"勿粘贴含密钥的环境变量 / 私有客户数据"。
- install-as-skill.sh 写入用户 `~/.claude/`、`~/.cursor/`、`~/.codex/`，无 dry-run、无回滚。

---

## 7. GTM 维度专项审查

Anchor: `REVIEW-REPORT.md::gtm-deep-dive`

### 7.1 分发渠道清单

| 渠道 | 是否就绪 | 障碍 |
|------|----------|------|
| GitHub README | 否 | 标题 v0.1 / 入口分裂 / heredoc 污染 |
| Claude Code Skill marketplace | 否 | SKILL.md 污染 + skill 包结构不合规 |
| Cursor / Windsurf 插件市场 | 否 | 无插件 manifest |
| npm / cargo / pip | 否 | 非代码项目 |
| Hacker News / X 内容首发 | 部分就绪 | 思想稿可发；产品稿不可发 |
| 在线课程 / 书籍 | 部分就绪 | 内容密度足够；商业模式未定 |

### 7.2 关键 GTM 假设缺失

- 用户付费意愿假设：缺
- 单用户每月使用频次假设：缺
- 与现有 Anthropic / OpenAI 内置多模型协作 feature 的差异化护城河：缺
- 国际化 / 中文市场 vs 英文市场的优先级：缺（仓库中英混杂，无定位声明）

### 7.3 竞品对照（CEO 视角）

| 竞品 | 重叠度 | LLM-Hopper 能否赢？ |
|------|--------|---------------------|
| Claude Code Subagents | 高 | 现状不能。对方有运行时、有官方 skills 市场 |
| Cursor Composer / Windsurf Cascade | 中 | 部分能。LLM-Hopper 的"跨订阅 / 跨进程"是 Cursor 不做的事 |
| Devin / Cognition | 低 | 在不同象限 |
| Aider + 自定义脚本 | 高 | 平局；Aider 用户群更明确 |
| GitHub Copilot Workspace | 中 | 现状不能 |

**唯一可能的差异化护城河**：跨订阅、跨厂商、跨进程的 vendor-neutral 编排——这是大厂不会做的事。但当前实现没有把这一点变成产品价值（user-facing），仅在文档里声明。

---

## 8. 综合判定矩阵

Anchor: `REVIEW-REPORT.md::overall-verdict`

| 项 | 评分 | 主要拉低项 |
|----|------|------------|
| 思想质量 | 8.5 / 10 | 命题成立，office-hours 严谨 |
| 架构质量 | 7.5 / 10 | 文件锚定状态机 + 角色权限分层是好设计 |
| 实现质量 | 4 / 10 | 5 个 P0 文件污染 + 状态机欺骗 + skill 不可加载 |
| 文档质量 | 5 / 10 | 文件多但不一致；PRD/TRD 过薄 |
| 用户体验 | 3 / 10 | 13+ 入口、首次激活不可能完成 |
| GTM 准备度 | 2 / 10 | 全维度未启动 |
| **综合发布判定** | **DO NOT SHIP** | 必须修 P0 + 收敛入口 + 重写 PRD/TRD 后才考虑发布 |

---

## 9. 给三位决策者的一句话

Anchor: `REVIEW-REPORT.md::one-liner-per-role`

- **CEO**：思想是对的，产品形态是错的；要么收敛成方法论 / 内容，要么放弃 zero-code 约束做真产品，不要继续在中间地带堆 prompt。
- **CTO**：先把 5 个被 heredoc 污染的文件修了，把状态机和实际产物对齐，再谈下一阶段；当前仓库未达发布卫生标准。
- **产品总监**：把 13 个 prompt 入口收敛到 2 个，把 README 改写为单一首次体验链路，把 PRD 重写到能回答"我为什么用它，不用什么替代，怎么衡量是否成功"。

---

详细修复与改进路径见同目录 `RECOMMENDATIONS.md`。
