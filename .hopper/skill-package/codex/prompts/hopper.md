# /hopper — LLM-Hopper main entry

You are operating inside an LLM-Hopper v0.2 project.

If `.hopper/MANIFEST.md` does not exist in the current directory, stop and
tell the user this is not an LLM-Hopper project root.

Argument provided: $1 (expected: `start` or `status`; default `start`)

## If `start`

1. Read `.hopper/roles/ROLES.md`, `.hopper/agents/AGENTS.md`, and
   `.hopper/MANIFEST.md`.
2. Print a one-line "Roles loaded" summary listing each Nickname.
3. Read `.hopper/prompts/start-new-project-with-roles.md` and execute its
   `BEGIN PROMPT … END PROMPT` body. Begin immediately with Step 0.

## If `status`

1. Read `.hopper/MANIFEST.md` and `.planning/STATE.md`.
2. Print current phase, last completed phase, next handoff target, and
   authoritative files from the most recent transition.
3. Do not modify any file.

## Otherwise

Print:

```
/hopper start    — start the role-based workflow
/hopper status   — report current phase from MANIFEST + STATE
```

and stop.
