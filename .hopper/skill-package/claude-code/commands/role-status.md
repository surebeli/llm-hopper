---
description: Show the current LLM-Hopper role-to-agent mapping
---

You are operating inside an LLM-Hopper v0.2 project.

If `.hopper/agents/AGENTS.md` does not exist, stop and tell the user this is
not an LLM-Hopper project root.

## Steps

1. Read `.hopper/agents/AGENTS.md`.
2. Render its "Active Agent Instances" table verbatim (Nickname / Role /
   Model / Permissions). Preserve the order.
3. Read `.hopper/MANIFEST.md` and append one line stating which nickname is
   currently designated by the manifest's "Next Handoff Command", if any.
4. If any Model field is still a placeholder like `<leader-model>`, add a
   one-line warning that the user must set local model IDs in
   `.hopper/agents/AGENTS.md` before running `/hopper start`.

Do not modify any file.
