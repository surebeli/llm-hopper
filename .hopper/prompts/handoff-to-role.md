BEGIN PROMPT
=== LLM-HOPPER AUTO HANDOFF + FINAL SYNC v0.2 (TDD + Builder Review Reinforced) ===

You have just completed your task as [当前角色 Nickname]。

=== FINAL SYNC & BACKFILL (必须执行) ===
1. 更新全局状态：.planning/STATE.md、ROADMAP.md、.hopper/MANIFEST.md
2. 记录成本（track-cost.md）

=== HANDOFF 规则（强制）===
- Executor 执行完毕 → **必须** handoff 回 Builder（builder-kimi / mimo）
- Builder 收到 Executor handoff → **必须** 执行强化验收步骤

=== 输出格式（严格遵守）===

=== HANDOFF TO ROLE ===
Use role: [chosen Nickname]
Completed phase: [当前阶段]
Next phase: [下一阶段]
Authoritative files: [精确列出]

Sync Summary:
- Updated STATE.md / ROADMAP.md / MANIFEST.md
- Completed artifacts: [...]

=== TASK SPEC FOR NEXT ROLE (TDD + MINIMAL CONTEXT) ===
=== TASK Txx: [简短标题] ===
Files allowed to touch: [仅列出本 task 可修改的文件]
Forbidden: [明确列出禁止内容]

RED: [初始失败状态]
GREEN: [验收标准 - 编号列表]
REFACTOR: [允许的优化范围]

Acceptance Criteria:
1. ...
2. ...

Executor Behaviour Contract (if next role is Executor):
- Strictly follow only this task spec
- No design choices, no scope creep
- Stop and hand back to Builder immediately if ambiguity

Prompt:
[给下一角色的极简、精确指令]

=== BUILDER REINFORCED REVIEW CHECKLIST (当你收到 Executor handoff 时必须执行) ===
如果你是 Builder 且收到 Executor 的 handoff，请严格按以下步骤验收：
1. 验证 TDD 三步是否完整执行（RED → GREEN → REFACTOR）
2. 逐条检查所有 Acceptance Criteria 是否 100% 通过
3. 确认是否严格遵守 Files allowed / Forbidden 范围（无任何 scope creep）
4. 检查代码质量（语义化、ARIA、可访问性、命名规范等）
5. 决定：
   - ✅ GREEN-light 通过 → 记录验收结果，生成下一个 task handoff
   - ❌ 需要修复 → 明确指出问题，handoff 回同一 Executor 进行修复
6. 更新 TASK-LIST.md 中的对应 task 状态（Completed / Needs Fix）

END PROMPT