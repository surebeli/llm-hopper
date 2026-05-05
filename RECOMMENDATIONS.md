# LLM-Hopper 改进建议 — 按 GTM 优先级排序

Anchor: `RECOMMENDATIONS.md::root`

- 配套审查报告：`REVIEW-REPORT.md`
- 适用版本：v0.2 → v0.2.1（修复轨）→ v0.3（GTM 启动轨）
- 优先级标注：**P0 = 24h 内必修**；**P1 = 1-2 周内**；**P2 = 1 个月内**；**P3 = 战略层（季度）**

---

## 1. P0 — 立刻修复（不修则仓库不可发布、不可分享）

Anchor: `RECOMMENDATIONS.md::p0-immediate`

### 1.1 清理 heredoc 外壳污染

修复以下 5 个文件，删除首行 `cat > ... << 'EOF'` 与末行 `EOF`，保留中间内容。

```text
PRD.md
TRD.md
.hopper/prompts/start-new-project-with-roles.md
.hopper/skill-package/SKILL.md
.hopper/scripts/install-as-skill.sh
```

**验收**：每个文件首行是合法的 markdown 标题（或 sh shebang），末行不是 `EOF`。

### 1.2 修正状态机谎报

`STATE.md` / `MANIFEST.md` / `ROADMAP.md` 三处都声称"Phase 5 / T01 已 dispatch 给 executor-glm"，但 `apps/` 不存在。三选一：

- **方案 A（推荐）**：把 Phase 5 状态回退为 `pending`，明确 v0.2 spec 期未真正进入执行。
- **方案 B**：实际跑通 T01，让 `apps/todo/index.html` 落盘，使状态成立。
- **方案 C**：完全删除 Phase 5，把 Todo App build 移出 v0.2 范围（更符合 PRD 的 prompt-only 立场）。

**验收**：`grep "T01"` 与 `ls apps/todo/` 的真值一致。

### 1.3 SKILL 包要么修对、要么删掉

**强烈建议先删掉** `.hopper/skill-package/` 与 `.hopper/scripts/install-as-skill.sh`，它们目前是宣传词、不是产品。

如果要保留：
- 调研 Claude Code Skill / Cursor Plugin / Codex Skill 三家**实际**的 manifest schema（差异巨大，不能共用一个目录结构）。
- 至少为 Claude Code 提供合规的 skill plugin（`commands/`、`agents/`、`hooks/`）。
- `install-as-skill.sh` 必须是真实可执行脚本，不是 heredoc 字符串；并加 `--dry-run`、`--uninstall`、`--platform=claude|cursor|codex` 参数。

**验收**：在干净环境 `bash install-as-skill.sh --dry-run` 输出每一步将复制的目标路径，并能真正在 Claude Code 中触发 `/hopper start`。

### 1.4 README 与 PRD 对齐到统一版本号

把 `README.md` 标题改为 `LLM-Hopper v0.2`（或把 PRD/TRD 改回 v0.1，二选一）。`README.md` 的"扩展方式 / 使用方法"段落删掉。

**验收**：`grep -RIn "v0\." -- *.md .hopper/` 全部指向同一版本号。

### 1.5 删除或改写 `.hopper/demo/` 中过时的四层流程

demo 描述的 Strategy/Planning/Execution/Review 与当前 ROLES.md 的 Leader/Builder/Executor/UI-Builder + TDD 完全不同。两选一：

- **方案 A（推荐）**：删除整个 `.hopper/demo/`，因为它代表的是 v0.1 的"artifact-only walkthrough"，与 v0.2 的"真实 Todo App build"思路冲突。
- **方案 B**：重写 demo 为 v0.2 角色 + TDD + Reinforced Review 形式，并让 `start-todo-demo.sh` 调用 v0.2 的 prompt 集合。

**验收**：仓库内只存在一种主路径，要么 v0.1 demo 路径，要么 v0.2 角色路径，不并存。

---

## 2. P1 — 1-2 周内（让 v0.2.1 可发布）

Anchor: `RECOMMENDATIONS.md::p1-short-term`

### 2.1 重写 PRD 到产品标准

新 PRD 必须包含：

```markdown
1. 背景与问题陈述（含 1 段竞品对比）
2. 目标用户分层（至少 3 个：Solo Indie Dev / 多模型订阅重度用户 / 教育与教练）
3. JTBD（Jobs-To-Be-Done）3-5 条
4. 用户故事 5-8 条（GIVEN-WHEN-THEN 格式）
5. 功能需求（FR-x，必须 / 应当 / 可选三档）
6. 非功能需求（NFR-x，含可量化指标：首次激活时长 < N 分钟，handoff 失败率 < N%）
7. 关键 KPI（4 个：激活、留存、跨模型使用率、token 节省比）
8. Out-of-scope（v0.x 期不做的东西）
9. 关键假设与可证伪条件（What would change my mind?）
10. 风险登记（含触发条件与回退路径）
```

PRD 总长 ≥ 200 行（不是越长越好，是必须覆盖以上字段）。

### 2.2 扩写 TRD 到工程标准

新 TRD 必须包含：

```markdown
1. 组件图（角色 / 文件 / handoff block 之间的关系，文字版即可）
2. 状态机（phase transition table，列出所有合法迁移与回退）
3. 错误处理矩阵（10 种典型失败场景 + 处理路径）
4. 兼容矩阵（Claude Code x.y / Cursor a.b / Codex CLI / 等）
5. 性能假设（一次 handoff 复制粘贴的人工耗时上限）
6. 安全假设（用户不应粘贴的内容 / cost 日志数据敏感性）
7. 测试策略（如何在不跑真实模型的情况下验证 handoff block 合规）
```

### 2.3 入口收敛：从 13 个 prompt 减到 2 个

最终用户面向的"主入口"只保留 2 个：

| 入口 | 用途 | 文件 |
|------|------|------|
| `/hopper start` 或 `cat .hopper/prompts/start.md` | 启动新项目（包含角色注册 / spec 生成 / 首次 handoff） | `.hopper/prompts/start.md`（合并自 setup-roles + register-me + start-new-project） |
| `/hopper handoff` 或 `cat .hopper/prompts/handoff.md` | 任意阶段切换角色（包含 FINAL SYNC + cost track + builder review） | `.hopper/prompts/handoff.md`（合并自 handoff-to-role + track-cost） |

其余 11 个 prompt 文件移入 `.hopper/prompts/internal/`，README 不再引用。

### 2.4 消除模型版本硬编码

DECISIONS.md / AGENTS.md / MANIFEST.md 不再写 `kimi-2.6` 这种具体版本，改写为：

```markdown
| 角色 | 推荐能力档 | 当前可用候选（按推荐顺序） |
|------|------------|----------------------------|
| Leader | reasoning-tier-1 | (用户在 setup 时填写) |
| Builder | coding-tier-1 | (用户在 setup 时填写) |
| Executor | coding-tier-2 | (用户在 setup 时填写) |
```

具体模型名只出现在用户本地的 `.hopper/agents/AGENTS.md` 中（这本来就是设计意图，但全仓未贯彻）。

### 2.5 加 Windows 一等支持

- 把 `start-todo-demo.sh` 同步出 `start-todo-demo.ps1`。
- README 在 Quick Start 区加 PowerShell / cmd 等价命令。

### 2.6 加最小 .gitignore

```text
.DS_Store
Thumbs.db
.idea/
.vscode/
*.log
.env
.env.local
```

### 2.7 仓库根加 CHANGELOG.md / VERSION

至少：

```text
# CHANGELOG

## v0.2.1 — 2026-05-XX
- 修复 PRD/TRD/SKILL.md 等 5 处 heredoc 外壳污染
- 状态机回退至 Phase 5 pending
- 入口收敛为 2 个 prompt
- 移除模型版本硬编码
```

---

## 3. P2 — 1 个月内（启动 GTM 实验）

Anchor: `RECOMMENDATIONS.md::p2-gtm-launch`

### 3.1 选择并 commit 一条战略路径

CEO 必须从下面三选一并落地：

#### 路径 A — 方法论与内容产品

- 把 LLM-Hopper 重新定位为 "Multi-Model Development Discipline"。
- 第一步产出：1 篇 8000 字的长文 + 1 个 30 分钟视频。
- 商业模式：付费 newsletter / 课程 / 工作坊。
- 仓库定位：开源参考实现，永远免费。
- 12 周指标：1000 newsletter 订阅 / 100 付费学员 / 5 个企业咨询。

#### 路径 B — 嵌入式 Skill / 集成产品

- 把 LLM-Hopper 重写为 Claude Code 一等 skill（合规 manifest + 真实 commands）。
- 放弃"prompt-only / zero-code"约束（这是天花板），改为"thin runtime + state machine"。
- 商业模式：免费开源 skill + 增值云端状态同步服务。
- 12 周指标：marketplace 安装 5000+ / DAU 200+ / Discord 活跃 50+。

#### 路径 C — 独立 CLI / SaaS

- 用 Rust / Go 重写为 `llm-hopper` CLI；prompt 模板嵌入二进制。
- 添加：状态机 lint、handoff block 校验、cost 自动捕获（hook 进 Claude Code / Cursor 的日志）。
- 商业模式：CLI 免费 + 团队 / 企业版（多人 handoff、审计日志、权限）。
- 12 周指标：1000 GitHub stars / 200 周活跃用户 / 10 个企业试用。

### 3.2 定义北极星指标（NSM）

候选三选一：

1. **Cross-Model Sessions per User per Week**（每周每用户跨模型 handoff 次数）— 衡量"真在用"。
2. **Project Completion Rate**（启动后 14 天内完成 ≥1 个 milestone 的比例）— 衡量"真有用"。
3. **Token Cost Savings vs Single-Model Baseline**（相对单模型基线的 token 成本节省比）— 衡量"价值有多大"。

CEO + 产品总监应在 1 周内 commit 一个，并把它写进 PRD 的成功指标段。

### 3.3 GTM 第一波

- 在 GitHub README 顶部加一段"Why this exists"（非技术读者也能 30 秒读懂的痛点叙事）。
- 在 Hacker News / X / 知乎 / 即刻发首发帖；先用思想稿（office-hours-style 长文）打开，不要先发产品稿。
- Demo 视频：录一个真实跑通 Leader → Builder → Executor → Builder review 的全过程，3 分钟以内。
- 为前 100 个 star 用户提供 30 分钟一对一 onboarding（强制做用户访谈）。

### 3.4 为 Cost Tracking 找真实数据来源

当前的"用户自己报 token 数"几乎没人会做。改为：

- Claude Code 日志解析（hook 进 `~/.claude/projects/<...>/logs`）。
- Cursor 日志解析。
- Codex CLI 输出捕获。

这才是 GTM 上能讲故事的功能。

---

## 4. P3 — 战略层（季度）

Anchor: `RECOMMENDATIONS.md::p3-strategic`

### 4.1 选定主战场国家与语言

- 仓库当前中英混杂（README 中 / PRD 中 / DECISIONS 英 / TRD 中 / 内部命令英）。
- 中文市场（Kimi / GLM / DeepSeek / Mimo 用户密集）和英文市场（Claude / GPT / Gemini）两边都做不可能不分裂。
- 建议：v0.3 之前 commit 一个主战场。

### 4.2 想清楚护城河

prompt-only 不是护城河。可能的护城河选项：

1. **状态机正确性（lint / verify）**：用代码确保 handoff block 合规、anchor 不漂移。这一层别人复制不了。
2. **跨厂商 cost / quality benchmark 数据库**：用户在你的工具里跑得越多，数据越有价值；任何竞品起步时没数据。
3. **企业版审计 / 权限**：单人工具没护城河，企业团队工具有。
4. **教学品牌**：methodology 流派一旦立住，复制门槛是写作能力 + 时间。

### 4.3 想清楚要放弃什么

为了 GTM 跑通，必须放弃以下"看起来很美但拉低速度"的东西：

- ❌ 全仓库的 anchor 一致性（保留概念，停止形式审查）
- ❌ "prompt-only / zero-code" 教条（已成为天花板）
- ❌ 同时支持 Claude Code / Cursor / Codex / Windsurf 的承诺（先做 Claude Code，跑通后再扩）
- ❌ 三种角色 + UI-Direction + Builder Review + Executor Contract 的复杂度（v0.3 收敛到 Leader / Worker 两层）
- ❌ 在 README 暴露 13 个 prompt 文件（隐藏到 internal/）

### 4.4 关键决策提示

| 决策 | 推荐 | 决策窗口 |
|------|------|----------|
| 是否放弃 prompt-only 约束 | 是 | 4 周内 |
| 是否合并 Builder + UI-Builder 为一个角色 + 多 Direction | 是 | 2 周内 |
| 是否把 .planning/ 与 ROADMAP.md 合并 | 是 | 1 周内 |
| 是否选定主战场（中英文 / 集成厂商） | 是 | 4 周内 |
| 是否引入 runtime（Rust/Go CLI） | 取决于战略路径选 B 或 C | 8 周内 |

---

## 5. 修复执行顺序（建议）

Anchor: `RECOMMENDATIONS.md::execution-sequence`

```text
Day 0 (今天)
├─ §1.1 修复 5 个 heredoc 文件
├─ §1.2 状态机回退到诚实状态（推荐方案 A）
└─ §1.4 README/PRD 版本对齐

Day 1-2
├─ §1.3 删除 SKILL 包（或决定真做）
└─ §1.5 删除/重写 demo

Week 1
├─ §2.1 PRD 重写
├─ §2.2 TRD 扩写
└─ §2.3 入口收敛到 2 个 prompt

Week 2
├─ §2.4 移除模型版本硬编码
├─ §2.5 Windows 支持
├─ §2.6 .gitignore + CHANGELOG
└─ §3.2 commit 北极星指标

Week 3-4
├─ §3.1 选定战略路径（A / B / C）
├─ §3.3 GTM 首波内容
└─ §3.4 cost tracking 真实数据源

Quarter
├─ §4.1 主战场决策
├─ §4.2 护城河 commit
└─ §4.3 砍枝

```

---

## 6. 关键 Trade-off 矩阵（给 CEO/CTO/产品总监一起看）

Anchor: `RECOMMENDATIONS.md::tradeoffs`

| Trade-off | 选 A 的代价 | 选 B 的代价 | 推荐 |
|-----------|-------------|-------------|------|
| Prompt-only 守 vs 破 | 守：天花板低，不可分发 | 破：失去原教旨光环，但赢得 GTM | **破**（v0.3） |
| 入口数 13 vs 2 | 13：表达力强 | 2：用户可学 | **2** |
| 角色 4 + Direction vs 2 层 | 4 层：表达精确 | 2 层：可上手 | **2 层 + Direction tag** |
| Claude/Cursor/Codex 全做 vs 先 Claude Code | 全做：分散精力 | 先 Claude：放弃 70% 用户 | **先 Claude Code 三个月** |
| 中文优先 vs 英文优先 | 中：竞争少但天花板低 | 英：竞争多但天花板高 | **英文优先 + 中文同步**（仓库以英文为主） |

---

## 7. 一页纸 TL;DR

Anchor: `RECOMMENDATIONS.md::tldr`

> **今天**：修 5 个 heredoc 文件 + 状态机回退 + 版本号对齐 + 删 demo（或重写）。  
> **2 周内**：重写 PRD（200 行）+ 扩写 TRD（错误处理 / 状态机 / 兼容矩阵）+ 入口从 13 收敛到 2 + 移除模型版本硬编码。  
> **1 个月内**：选定战略路径（方法论 / 集成 Skill / 独立 CLI 三选一）+ commit 北极星指标 + 发首波内容。  
> **1 个季度内**：放弃 prompt-only 教条 + 选定主战场 + 砍掉 70% 复杂度 + 决定护城河。

> 当前仓库的核心矛盾是：**思想已成熟到 0.7，工程只到 0.4，产品只到 0.2，GTM 是 0**。继续在思想层加东西不会让产品上市，必须把工程拉到 0.8、产品拉到 0.6、GTM 启动。
