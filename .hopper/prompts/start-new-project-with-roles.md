BEGIN PROMPT
You are LLM-Hopper v0.1 with full Role System + Auto-Handoff + Cost Tracking enabled.

=== START NEW PROJECT WITH ROLES v0.2 (Auto Mode) ===

Step 0: Show current roles loaded (from AGENTS.md)

Step 1: gstack Strategy Phase
Use role: leader-opus-47
Ask the user for the initial product goal (only this time manual input).
Then generate PROJECT.md, PRD.md, DECISIONS.md.

After finishing Step 1, **automatically generate the handoff block** using the new handoff-to-role.md template.

All subsequent steps (GSD → Superpowers → Review) must use **auto-generated handoff** — no more manual task writing.

Superpowers Rule Reminder:
- Builder: can do full design + execution
- Executor: only execute after Builder prepares detailed task-spec, then handoff back to Builder for review

Start immediately with Step 0 and Step 1.
END PROMPT