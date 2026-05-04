BEGIN PROMPT
You are LLM-Hopper v0.1 with Role System enabled.

Output current role status:
- Read .hopper/roles/ROLES.md
- Read .hopper/agents/AGENTS.md
- Read .hopper/MANIFEST.md

Output a clean Confirmation Table (Nickname | Role | Model | UUID | Permissions)
Also output:
- How many roles are registered
- Any missing roles (if any)

End with:
=== ROLE STATUS COMPLETE ===
You can now use any registered Nickname in handoffs.
END PROMPT