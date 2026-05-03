# Skill: hopper-status

Anchor: `.hopper/skill/hopper-status.md::root`

## Purpose

Anchor: `.hopper/skill/hopper-status.md::purpose`

Read `.hopper/MANIFEST.md` and the supporting roadmap and report the current phase, authoritative artifacts, recommended model role, and next handoff command. This skill is read-only: it inspects state and echoes it. It does not advance the phase.

## Required Inputs

Anchor: `.hopper/skill/hopper-status.md::required-inputs`

- A model session attached to the LLM-Hopper repository working directory.
- Read access to `.hopper/MANIFEST.md`, `ROADMAP.md`, and `DECISIONS.md`.
- No human input beyond invoking this template.

## Files To Read

Anchor: `.hopper/skill/hopper-status.md::files-to-read`

1. `.hopper/MANIFEST.md` (mandatory).
2. `ROADMAP.md` to confirm the named next phase still exists.
3. `DECISIONS.md::model-routing-table` if the manifest does not name a recommended model.

## Files Allowed To Modify

Anchor: `.hopper/skill/hopper-status.md::files-allowed-to-modify`

- None. This skill is strictly read-only.

## Stop Conditions

Anchor: `.hopper/skill/hopper-status.md::stop-conditions`

- Stop after producing the status block and the verbatim handoff echo.
- Do not execute any phase work, even if the manifest says it is pending.
- Do not modify the manifest, roadmap, or any artifact.
- Do not invent state that is not present in the manifest.
- If `.hopper/MANIFEST.md` is missing or unreadable, stop and report the missing file as the only output.

## Output Format

Anchor: `.hopper/skill/hopper-status.md::output-format`

Emit a single fenced text block in the form:

```text
LLM-HOPPER STATUS
Workspace: <path from manifest>
Last updated: <timestamp from manifest>
Completed phases:
- Phase 0: <state>
- Phase 1: <state>
- Phase 2: <state>
- Phase 3: <state>
Current phase: <phase name from manifest>
Authoritative artifacts:
- <path>
- <path>
Next phase: <phase name>
Recommended model role: <role>
Recommended model: <model name from routing table or manifest>
```

If a field has no value in the manifest, write `unspecified` rather than guessing.

## Required Handoff Block

Anchor: `.hopper/skill/hopper-status.md::handoff-block`

After the status block, echo the existing handoff block from `.hopper/MANIFEST.md` exactly as it appears. Do not rewrite it. The format is defined by `TRD.md::handoff-block-schema`:

```text
LLM-HOPPER HANDOFF
Completed phase: <verbatim>
Next phase: <verbatim>
Recommended model profile: <verbatim>
Authoritative files:
- <verbatim>
Prompt:
<verbatim prompt>
```

If the manifest does not contain a handoff block, write `LLM-HOPPER HANDOFF\n(none recorded in manifest)` and stop without inventing one.
