# LLM-Hopper Agent Instances

Generated: 2026-05-04T02:03:40+08:00
Role System: v0.1
UI Direction: enabled (Builder only)

## Active Agent Instances

| Nickname | UUID | Role | Model | Permissions |
|----------|------|------|-------|-------------|
| `leader-opus-47` | `2620cc7a-25e6-4059-999e-17af54bdcaf4` | Leader | `claude-opus-4-7` | gstack + GSD phases (decision & planning); full capability, may substitute Builder/Executor |
| `builder-kimi` | `6c5ac7fa-7a5e-40b4-920a-b4fe1d562876` | Builder | `kimi-2.6` | Superpowers + Review; full design + execution from Leader spec |
| `executor-glm` | `820cba1c-80de-45fc-a514-2f5de38fd804` | Executor | `glm-5.1` | Superpowers execution only; strict instruction-follow, no design, no plan changes |
| `ui-builder-gemini` | `bbf6602d-13c0-42d3-a1fc-59cbe7424b49` | UI-Builder | `gemini-3.1-pro` | Builder permissions, scoped to UI direction (Web/frontend, components, Tailwind/CSS, React/Vue) |
| `mimo` | `6db17b47-ba7f-4a16-8890-832ce18c43cb` | Builder | `mimo-v2.5-pro` | Superpowers + Review; full design + execution from Leader spec |
| `executor-deepseek` | `b35ea656-1833-40b0-81cd-99c3a533da1a` | Executor | `deepseek-v4-flash` | Superpowers execution only; strict instruction-follow, no design, no plan changes |

## Nickname is the Primary Identifier

- **Preferred:** reference by Nickname (`Use role: leader-opus-47`)
- **Fallback:** reference by UUID when nickname collisions occur (`Use role: Leader UUID:2620cc7a-...`)

## Role Permissions Summary

- **Leader** — Strategy, architecture, spec authoring, review. Full coverage.
- **Builder** — Receives Leader spec; owns design + execution; may run review.
- **Executor** — Pure execution. No design, no scope drift, no plan edits.
- **UI-Builder** — Builder behavior scoped to UI direction. Output targets modern, accessible, visually consistent web frontends.

## Reassignment

To change a role's model or nickname, re-run the role setup prompt or edit this file directly and update `.hopper/MANIFEST.md`. UUIDs persist across model changes; nicknames may be swapped freely.
