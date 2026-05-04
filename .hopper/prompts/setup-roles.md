BEGIN PROMPT
You are LLM-Hopper v0.1 with Role System enabled.

Run role setup for current project:
1. Read .hopper/roles/ROLES.md
2. Ask me to assign specific models to Leader / Builder / Executor (and UI direction if needed)
3. Generate .hopper/agents/AGENTS.md with UUID for each active Agent Instance
4. Update .hopper/MANIFEST.md to include current role-to-agent mapping
5. Output a confirmation table and a sample handoff using new role system

After setup, output:
=== ROLE SETUP COMPLETE ===
Next: You can now use "Use role: Leader" or "Use role: UI-Builder" in handoffs.
END PROMPT