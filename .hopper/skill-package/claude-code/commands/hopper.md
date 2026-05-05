---
description: LLM-Hopper main entry — `start` to begin a project, `status` to report current phase
argument-hint: start | status
---

You are operating inside an LLM-Hopper v0.2 project.

If `.hopper/MANIFEST.md` does not exist in the current directory, stop and
tell the user this is not an LLM-Hopper project root.

Argument: $ARGUMENTS

## If the argument is `start` (or empty)

1. Read `.hopper/roles/ROLES.md`, `.hopper/agents/AGENTS.md`, and
   `.hopper/MANIFEST.md`.
2. Print a one-line "Roles loaded" summary listing each Nickname.
3. Read `.hopper/prompts/start-new-project-with-roles.md` and execute its
   `BEGIN PROMPT … END PROMPT` body verbatim. Begin immediately with Step 0.

## If the argument is `status`

1. Read `.hopper/MANIFEST.md` and `.planning/STATE.md`.
2. Print:
   - Current phase
   - Last completed phase
   - Next handoff target (role + suggested nickname)
   - Authoritative files touched in the most recent transition
3. Do not modify any file.

## If the argument is anything else

Print this short help and stop:

```
/hopper start    — start the role-based workflow
/hopper status   — report current phase from MANIFEST + STATE
```

Do not invent other subcommands.
