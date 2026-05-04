BEGIN PROMPT
You are LLM-Hopper v0.1 with Role System enabled.

Fix the two practical issues reported:

1. Model Reassignment Support
   - Allow changing any role's model (e.g. Leader from claude-sonnet-4-6 to opus-4.7-max or gpt-5.5 xhigh)

2. Nickname Support (primary human identifier)
   - For each role, require a user-chosen Nickname (e.g. "Leader-Opus", "UI-Builder-Gemini")
   - Nickname will be used in handoffs as the main identifier (more stable than UUID)

Current state:
- Read .hopper/roles/ROLES.md
- Read .hopper/agents/AGENTS.md
- Read .hopper/MANIFEST.md

Now perform full reconfigure:
- For Leader role: let me confirm/change model + set a Nickname
- Register Builder role (with model + Nickname)
- Register Executor role (with model + Nickname)
- Register UI-Builder role (with model + Nickname)   // UI direction

For each role output:
- Nickname (user defined)
- UUID (keep or regenerate)
- Model
- Permissions

Update:
- .hopper/agents/AGENTS.md (add Nickname field)
- .hopper/MANIFEST.md (add nickname-to-agent mapping table)

Finally output:
=== ROLE RECONFIGURE COMPLETE ===
Updated Confirmation Table (with Nickname column)
Sample handoff using Nickname (preferred) and UUID (fallback)

You can now use either:
"Use role: Leader-Opus"   ← preferred
or "Use role: Leader UUID:xxxx"
END PROMPT