BEGIN PROMPT
=== LLM-HOPPER AUTO HANDOFF v0.2 ===

You have just finished your task as [当前角色 Nickname]。

Now automatically generate the next handoff:

1. Decide the most appropriate next role (from registered nicknames in .hopper/agents/AGENTS.md)
   - Prefer Builder/ UI-Builder for design+execution
   - Use Executor only for strict code execution after a Builder has prepared task-spec
   - Leader only for gstack/GSD

2. Decide next phase and write a **detailed, self-contained task prompt** for the next role.

Output **exactly** this format (no extra text before or after):

=== HANDOFF TO ROLE ===
Use role: [chosen Nickname]
Completed phase: [当前阶段]
Next phase: [下一阶段]
Authoritative files: [列出需要读取的关键文件，如 TRD.md、PLAN.md、.planning/STATE.md]

Prompt:
[在这里写一段详细、清晰、具体的任务指令，让下一角色可以直接开始工作]

After this handoff, remind the next role to run track-cost.md at the end of its work.
END PROMPT