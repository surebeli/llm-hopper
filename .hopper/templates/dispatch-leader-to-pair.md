# Dispatch Template: Leader → Builder-pair (Sidecar)

Anchor: `.hopper/templates/dispatch-leader-to-pair.md::root`

> **Principle**: Dispatcher Empathy + Uniform Quality, Scaled Content. See `.hopper/USAGE-GUIDE.md` §3.3.
> **When to use**: Leader dispatches a sidecar polish review on a just-completed substantive task. **Mode must be explicit** (review-only vs code-change-allowed) — this is the gate that prevented P0.1 from cleanly closing on first try.
> **Output filename convention**: spec embedded in `leader-tasklist.md` task row OR in substantive task's `<substantive-id>-output.md` "Sidecar handoff prompt" section.
> **Expected size**: 40-100 lines.

---

## How to use this template

1. Add task row to `.hopper/queue.md`: ID `<substantive-id>-polish` (or `<substantive-id>-polish-rework-N` if rework), Role `builder-pair`, Status `pending`, Depends `<substantive-id>`.
2. Fill in §1-§9 below.
3. Embed result in either `leader-tasklist.md` row OR substantive task's output.md `Sidecar handoff prompt` section.
4. Run §10 self-check.

---

## Sidecar dispatch: **<substantive-id>-polish** (or `-polish-rework-N`)

- **Role**: `builder-pair`
- **Depends**: `<substantive-id>` (must be `done`)
- **Estimated effort**: S (hours, not half-day)
- **Estimated budget**: ≤ $<X> (typically $1-3)

---

### 1. Substantive task being polished

- **Task ID**: `<substantive-id>`
- **Output file**: `.hopper/handoffs/<substantive-id>-output.md`
- **Commit SHA**: `<short-sha>`
- **What it did**: <one-sentence summary>

---

### 2. Mode declaration (PICK ONE — explicit, not assumed)

- [ ] **review-only**: Pair reads diff + output.md + key files; produces verdict ONLY. **No code edits.** No file modifications outside `<substantive-id>-polish-output.md`.
- [ ] **code-change-allowed**: Pair may apply small fixes (typos, lint, EOF whitespace, metadata repair, unused imports). **Upgraded acceptance gate auto-applies** (§5). Architectural changes still forbidden — escalate to Leader if found.

(Default if uncertain: review-only. Switching to code-change-allowed should be deliberate.)

---

### 3. Specific concerns to verify

Numbered list of what Pair should check. Each should be concrete and testable:

1. <concern 1, e.g. "Verify queue.md table integrity — no blank lines inside Tasks table">
2. <concern 2, e.g. "Verify output.md Commit field contains real short SHA, not `(pending)`">
3. <concern 3, e.g. "Verify Next recommendation respects MANIFEST cursor (currently: <cursor>)">
4. <concern 4, e.g. "Verify no architectural deviation from spec section X">

---

### 4. Acceptance criteria (Pair's own output)

Pair must produce `.hopper/handoffs/<substantive-id>-polish-output.md` containing:

- **Verdict**: `PASS` | `PASS_WITH_CHANGES` | `REWORK`
  - PASS: substantive done as spec'd, no surgical fixes needed
  - PASS_WITH_CHANGES: minor fixes applied (only valid in code-change-allowed mode)
  - REWORK: substantive task must be redone or a new rework task queued
- **Files reviewed**: list
- **Files modified** (if code-change-allowed): list, with reason per file
- **Checks run**: `git diff --check` / scoped eslint / focused tests — pass/fail each
- **Concerns mapped**: each numbered concern from §3 → addressed/unaddressed/n-a
- **Next recommendation**: cursor-aware (see USAGE-GUIDE §3.3)

---

### 5. Upgraded acceptance gate (auto-applies if mode = code-change-allowed)

If Pair edited any code file, before mark done:

```bash
git diff --check <base>^ <pair-commit>     # no whitespace errors
npx eslint <touched-files>                  # scoped lint, not full repo
npm test -- <focused-tests>                 # focused, not full suite
```

Paste actual commands + outputs into output.md `Checks` section.

If Pair edited only doc / metadata files, just verify queue.md table integrity + output.md schema.

---

### 6. Files Pair MUST NOT modify

- Substantive task's `<substantive-id>-output.md` — Leader writes review section there, not Pair
- Spec files (`docs/plans/*`, `.hopper/handoffs/leader-tasklist.md`)
- PING.md / MANIFEST.md / AGENTS.md
- Files outside the substantive task's scope

(Exception in code-change-allowed mode: Pair may edit substantive task's `<substantive-id>-output.md` ONLY to fix metadata — Commit SHA, Verdict field — and must note this in §4 "Files modified".)

---

### 7. Closure mechanism

- Pair writes `<substantive-id>-polish-output.md`
- Pair flips queue.md row `pending` → `in-progress` → `done`
- Pair commits with prefix `[<substantive-id>-polish]`
- Leader picks up via `review <substantive-id>-polish`

If Leader verdict is `rework`, a new task `<substantive-id>-polish-rework-N` is queued; loop until accept or accept-with-note.

---

### 8. Escalation path

- **Found architectural issue beyond polish scope**: STOP, write `.hopper/handoffs/leader-ping-strategy-<dated>-pair-finding.md` to Leader (or Strategy if Leader is unavailable); do NOT silently expand scope
- **Substantive task's verdict is unclear from output.md**: ping Leader before continuing
- **Mode mismatch** (you find code-change is needed but mode was review-only): ping Leader to upgrade mode, do not unilaterally cross modes

---

### 9. Negative space

- ❌ Do NOT rewrite the substantive task's code architecture
- ❌ Do NOT add new features
- ❌ Do NOT touch the substantive output.md's verdict / acceptance sections (except metadata in code-change-allowed)
- ❌ Do NOT skip the §5 acceptance gate if you edited code
- ❌ Do NOT recommend `Next` outside MANIFEST cursor

---

### 10. Dispatcher self-check (Leader runs before pushing)

Answer YES to all 5:

1. **If I were the Pair with zero context, could I find the substantive task + know what to check?** (Q: §1 + §3 are concrete?)
2. **Does Pair know whether they may edit code or not?** (Q: §2 mode is explicit, not "well, you'll see"?)
3. **Does Pair know which upgraded gates apply if they edit code?** (Q: §5 commands are stated?)
4. **Does Pair know the verdict shape Leader expects?** (Q: §4 verdict options are spelled?)
5. **Does Pair know what to do if they find issues beyond polish scope?** (Q: §8 escalation is explicit?)
