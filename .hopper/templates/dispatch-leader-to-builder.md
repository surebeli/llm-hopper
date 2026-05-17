# Dispatch Template: Leader → Builder

Anchor: `.hopper/templates/dispatch-leader-to-builder.md::root`

> **Principle**: Dispatcher Empathy + Uniform Quality, Scaled Content. See `.hopper/USAGE-GUIDE.md` §3.3.
> **When to use**: Leader spec'd a single Builder/Builder-UI/Executor task and is pushing it to `queue.md`. This template is the **spec source** (lives in `.hopper/handoffs/leader-tasklist.md` row or as a referenced section).
> **Output filename convention**: spec is referenced FROM `leader-tasklist.md` (immutable spec); cursor is `queue.md` (mutable status). Worker `ping` pops queue row → reads spec here.
> **Expected size**: 80-200 lines per task.

---

## How to use this template

1. Add a task row to `.hopper/queue.md` with `Status: pending`.
2. Add a `**<task-id>**` section to `.hopper/handoffs/leader-tasklist.md` using this template body.
3. Worker `ping` pops queue row → reads spec section in `leader-tasklist.md`.
4. Run §10 self-check before pushing. Answer YES to all 5.

---

## **<task-id>** — <one-line purpose>

- **Role**: <builder / builder-ui / executor / critic>
- **Priority**: <high / normal / low> (queue.md Priority column)
- **Depends**: <task IDs, comma-separated>
- **Estimated effort**: <S / M / L> (S=hours, M=half-day, L=day+)
- **Estimated budget**: ≤ $<X>

---

### 1. Context (read these first)

- `<spec file>::<anchor>` — <why this section>
- `<related task output>` — <why this matters>
- `<existing code / file path>` — <relevant baseline>

<1-2 paragraphs explaining WHY this task exists in this phase. Worker shouldn't have to infer.>

---

### 2. Scope (what to build)

<Bullet list or numbered list of concrete deliverables. Reference specific files / interfaces / behaviors.>

- <item 1>: <files touched, behavior expected>
- <item 2>: <files touched, behavior expected>

---

### 3. Acceptance criteria (TDD red/green/refactor where applicable)

**RED**: <failing state before; e.g. "test X currently fails because Y">

**GREEN**: each criterion must be machine-checkable:

1. ✓ <criterion> — verifier: `<command or grep pattern>` returns <expected>
2. ✓ <criterion> — verifier: `<command>` exits 0
3. ✓ <criterion> — verifier: file `<path>` contains `<pattern>` at line <N>
4. ✓ <criterion> — manual verification needed: <describe what user checks>

**REFACTOR** (optional): <any cleanup expected after green>

---

### 4. Files Worker is allowed to modify

- <path>
- <path>
- <path>
- `.hopper/queue.md` (status flip per PING Step 3 / 7)
- `.hopper/COST-LOG.md` (Step 8 append)
- `.hopper/handoffs/<task-id>-output.md` (Step 7.5 artifact)

---

### 5. Files Worker MUST NOT modify

- <explicit prohibitions, e.g. `.hopper/PING.md` (frozen)>
- <areas outside scope>
- <files belonging to sibling concurrent tasks>

---

### 6. Mode declaration (if applicable for sidecar / polish tasks)

- [ ] **review-only**: no code edits, only verdict + output artifact
- [ ] **code-change-allowed**: code edits permitted; **upgraded acceptance gate applies** (see §3 + run `git diff --check`, scoped eslint, focused tests)

(Default for substantive Builder tasks: code-change-allowed. Default for Critic: review-only.)

---

### 7. Closure mechanism

- Worker writes `.hopper/handoffs/<task-id>-output.md` per `.hopper/templates/builder-output.md` schema
- Worker flips queue.md row `in-progress` → `done`
- Worker commits with prefix `[<task-id>]`
- Leader picks up via `review <task-id>`

**Required output fields** (per Builder Output Template):
- Summary / Files touched / Acceptance verification / Decisions / Open questions / Commit / Verdict / Checks / Next recommendation

**Next recommendation constraint**: must respect `.hopper/MANIFEST.md` Current cursor. If lex-next-eligible task is outside cursor scope, state `out of current cursor scope (currently: <cursor>)` + list in-scope alternatives or `nothing further in scope`.

---

### 8. Escalation path

- **Blocker** (acceptance can't be met): Status → `failed`, write `.hopper/handoffs/blocker-<task-id>.md`, do NOT advance
- **Spec ambiguity**: write Open questions in output.md draft, ping Leader before continuing
- **Mid-task issue Leader should patch**: Leader writes `.hopper/handoffs/<task-id>-leader-feedback.md` (PING v5 §Leader Feedback Channel); Worker reads + folds in

---

### 9. Edge cases / known gotchas

<bulleted list of "watch out for X" notes — concurrency, dep behavior, environment quirks>

- <gotcha 1>
- <gotcha 2>

---

### 10. Dispatcher self-check (Leader runs before pushing to queue)

Answer YES to all 5:

1. **If I were the Worker with zero context, could I start without questions?** (Q: Context section names specific files/anchors?)
2. **Can Worker know when done without pinging me?** (Q: Every acceptance criterion has a verifier command?)
3. **Can Worker distinguish "spec deviation OK to record" from "must-stop blocker"?** (Q: §8 escalation path is explicit?)
4. **Does Worker know exactly which files to touch / not touch?** (Q: §4 + §5 are both filled?)
5. **Does Worker know current MANIFEST cursor, so Next recommendation stays in scope?** (Q: §7 closure mechanism mentions cursor check?)

---

### 11. (Optional) Sidecar follow-up

If a Builder-pair polish is expected after this Worker completes, embed a `Sidecar handoff prompt` section in the Worker's output.md (see `dispatch-builder-to-pair.md` template).
