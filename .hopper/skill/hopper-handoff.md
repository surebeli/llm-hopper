# Skill: hopper-handoff

Anchor: `.hopper/skill/hopper-handoff.md::root`

## Purpose

Anchor: `.hopper/skill/hopper-handoff.md::purpose`

Compose or refresh the next-phase handoff block in `.hopper/MANIFEST.md` so a new model session can continue from files alone. This skill is invoked at a phase boundary, after the phase work is verified and the artifacts have been written.

## Required Inputs

Anchor: `.hopper/skill/hopper-handoff.md::required-inputs`

- The completed phase name (for example, `Phase 3 - Superpowers execution kit`).
- The next phase name (for example, `Phase 4 - Quality convergence`).
- Confirmation that all artifacts owned by the completed phase exist and have stable anchors.

If any of those inputs are missing, stop and ask the user. Do not infer phase progress from chat memory.

## Files To Read

Anchor: `.hopper/skill/hopper-handoff.md::files-to-read`

1. `.hopper/MANIFEST.md` (mandatory; current phase cursor).
2. `ROADMAP.md` (mandatory; confirm the next phase boundary and required artifacts).
3. `DECISIONS.md::model-routing-table` (mandatory; pick the correct role for the next phase).
4. `TRD.md::handoff-block-schema` (mandatory; format contract).
5. The artifact set declared by the completed phase in `TRD.md::phase-mutation-rules`.

## Files Allowed To Modify

Anchor: `.hopper/skill/hopper-handoff.md::files-allowed-to-modify`

- `.hopper/MANIFEST.md` only.

No other file may be created or edited by this skill. Phase artifacts must already be in place before this skill runs.

## Stop Conditions

Anchor: `.hopper/skill/hopper-handoff.md::stop-conditions`

- Stop and ask the user if the completed phase is missing any artifact named in its mutation rule.
- Stop if the next phase is not defined in `ROADMAP.md`.
- Stop if the routing table does not name a role for the next phase.
- Do not perform the next phase's work. This skill only updates the manifest.
- Do not silently overwrite an existing handoff block; preserve the prior block under a `## Previous Handoff` heading if the user asks for an audit trail, otherwise replace it cleanly and explain the change in the response.

## Output Format

Anchor: `.hopper/skill/hopper-handoff.md::output-format`

After updating `.hopper/MANIFEST.md`, emit a short summary of the change:

```text
HANDOFF UPDATED
Completed phase: <name>
Next phase: <name>
Recommended model profile: <role and model>
Manifest path: .hopper/MANIFEST.md
Sections updated:
- Phase State
- Next Handoff Command
```

The manifest sections must follow the structure already used by `.hopper/MANIFEST.md`: `Runtime Identity`, `Phase State`, `Persistence Rules`, and `Next Handoff Command`. Update only the fields that change. Preserve all anchors.

## Required Handoff Block

Anchor: `.hopper/skill/hopper-handoff.md::handoff-block`

The handoff block written into `.hopper/MANIFEST.md` must follow `TRD.md::handoff-block-schema`:

```text
LLM-HOPPER HANDOFF
Completed phase: Phase N - <name>
Next phase: Phase N+1 - <name>
Recommended model profile: <role>, <model name from DECISIONS.md::model-routing-table>
Authoritative files:
- <path from completed phase>
- <path from completed phase>
Prompt:
<exact prompt for the next session, citing files by anchor and naming the bounded scope>
```

The prompt section must:

- Name every authoritative file the next session must read.
- State the exact directories or files the next session is allowed to create or modify.
- Cite the relevant `TRD.md::phase-mutation-rules` entry for that phase.
- End without trailing commentary so the user can copy and paste it as a single block.
