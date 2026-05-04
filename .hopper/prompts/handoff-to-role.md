BEGIN PROMPT
=== LLM-HOPPER AUTO HANDOFF + FINAL SYNC v0.2 ===

You have just completed your task as [当前角色 Nickname]。

=== FINAL SYNC & BACKFILL (必须执行) ===
在输出 handoff 之前，先完成以下同步步骤：

1. 更新全局状态文件（防止断头路）：
   - Read .planning/STATE.md (如果不存在则创建)
   - Read .planning/ROADMAP.md
   - Read .hopper/MANIFEST.md
   - 更新当前 phase 的完成状态、completed tasks、traceability
   - 记录本次任务产出的关键 artifact（文件列表）

2. 记录成本（必须）
   - 提醒或自动调用 track-cost.md 逻辑

3. 决定下一角色和下一阶段（严格遵守角色规则）：
   - Leader → 只能 handoff 给 Leader（gstack/GSD）
   - Builder / UI-Builder → 可 handoff 给 Builder / Executor / UI-Builder
   - Executor → 必须 handoff 回 Builder（做 final review）

4. 生成下一阶段的**详细任务 Prompt**

=== 最终输出格式（必须严格遵守）===

=== HANDOFF TO ROLE ===
Use role: [chosen Nickname]
Completed phase: [当前阶段]
Next phase: [下一阶段]
Authoritative files: [列出需要读取的文件]

Sync Summary:
- Updated STATE.md / ROADMAP.md / MANIFEST.md
- Completed artifacts: [列出本次产出文件]
- Cost tracked: [是/否]

Prompt:
[详细、具体的任务指令，让下一角色可以直接开工]

END PROMPT