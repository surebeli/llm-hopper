---
description: Switch active role and emit the next LLM-Hopper handoff block
argument-hint: <nickname> (e.g. builder-primary, executor-primary, ui-builder-primary)
---

You are operating inside an LLM-Hopper v0.2 project.

If `.hopper/MANIFEST.md` does not exist, stop and tell the user this is not
an LLM-Hopper project root.

Target role nickname: $ARGUMENTS

## Steps

1. Read `.hopper/agents/AGENTS.md`. Confirm `$ARGUMENTS` matches an active
   Nickname. If not, list all available Nicknames and stop.
2. Read `.hopper/MANIFEST.md`, `.hopper/roles/ROLES.md`, and
   `.planning/STATE.md` to identify the current phase and authoritative files.
3. Read `.hopper/prompts/handoff-to-role.md` and execute its `BEGIN PROMPT …
   END PROMPT` body. Replace `[当前角色 Nickname]` with the agent that just
   finished, and target the handoff to `$ARGUMENTS`.
4. The emitted handoff block must follow `TRD.md::handoff-block-schema` and
   must include the FINAL SYNC reminder, TDD task spec, and Builder
   Reinforced Review Checklist sections from the prompt.

Do not modify state files in this command. Final sync is performed by the
session that owns the next phase, not by the handoff emitter.
