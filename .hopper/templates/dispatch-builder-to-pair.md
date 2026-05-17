# Dispatch Template: Builder → Builder-pair (Embedded Sidecar Prompt)

Anchor: `.hopper/templates/dispatch-builder-to-pair.md::root`

> **Principle**: Dispatcher Empathy + Uniform Quality, Scaled Content. See `.hopper/USAGE-GUIDE.md` §3.3.
> **When to use**: Substantive Builder finished a task and wants to queue a Pair polish. The sidecar prompt is **embedded** in the substantive task's `<task-id>-output.md` so Leader can copy it into a new queue row + handoff. Builder is NOT pushing to queue directly (Leader privilege).
> **Output filename convention**: this template body goes INSIDE the substantive task's output.md as a `## Sidecar handoff prompt` section.
> **Expected size**: 30-80 lines (the prompt section only; the full output.md is longer).

---

## How to use this template

1. Builder completes substantive task, writes `<task-id>-output.md` per `.hopper/templates/builder-output.md`.
2. At the END of that output.md, before `## Next recommendation`, add a `## Sidecar handoff prompt` section using this template body.
3. Leader reads the substantive output.md, decides whether to queue the polish, copies/adapts this section into queue + (optionally) a separate Leader→Pair dispatch.
4. Run §6 self-check before considering output.md done.

---

## (Insert this block into `<task-id>-output.md`)

```markdown
## Sidecar handoff prompt

> **For Leader**: copy adapted version into queue + dispatch-leader-to-pair handoff. Builder is recommending — Leader decides.

### What I just did
<2-3 sentences summarizing the substantive task's actual changes — concrete files + behaviors, not just task title>

### Why polish is worth queueing
<1-2 sentences justifying the polish — e.g. "I made multi-file refactor; metadata or lint hygiene check would catch what I missed">

### Suggested mode for Pair
- [ ] **review-only** — recommend if substantive task is sensitive (architectural) and Pair should only verify, not touch
- [ ] **code-change-allowed (light)** — recommend if substantive task is fresh + small fixes (lint, metadata, EOF, unused imports) are likely

### Specific concerns I'd want a fresh pair of eyes on
1. <concern 1, concrete>
2. <concern 2, concrete>
3. <concern 3, concrete>
<3-5 items typically>

### Files Pair should focus on (priority order)
1. <path> — <why>
2. <path> — <why>

### Files Pair should explicitly NOT touch
- <path> — <why>
- <path> — <why>

### Acceptance hint (what Pair's output should contain)
- Verdict: PASS / PASS_WITH_CHANGES / REWORK
- Checks: <list machine checks Builder thinks should pass>
- If code-change-allowed: paste actual commands + outputs

### Estimated effort
S (hours, not half-day). Budget ≤ $<X>.
```

---

## 6. Dispatcher self-check (substantive Builder runs before output.md done)

Answer YES to all 5:

1. **If I were the Pair with zero context, could I find my substantive work + know what to check?** (Q: §What I just did + §Specific concerns are concrete?)
2. **Does the Pair know whether they may edit code?** (Q: §Suggested mode is picked, not blank?)
3. **Does the Pair know which checks to run if code-change-allowed?** (Q: §Acceptance hint lists commands?)
4. **Does the Pair know what's off-limits?** (Q: §Files Pair should NOT touch is filled?)
5. **Is my recommendation respectful of Leader's authority?** (Q: Phrased as "recommending", not "do this"? Leader gets final call on queueing?)

---

## Notes on the Builder→Pair vs Leader→Pair distinction

- Builder writing this prompt = **recommendation** + draft spec. Builder does NOT add to queue.md.
- Leader reading the substantive output.md = **decision**. Leader may:
  - Adopt Builder's suggestion as-is + queue
  - Adapt the spec (tighten scope, change mode, switch Pair builder)
  - Reject (no polish needed; or polish at later phase)
- The full Leader→Pair dispatch (see `dispatch-leader-to-pair.md`) supersedes this Builder-suggested prompt if Leader expands the spec.

This template ensures Builder hands Leader a **complete recommendation** instead of vague "polish would be nice". Builder did the substantive work and knows what to check; that context shouldn't be lost.
