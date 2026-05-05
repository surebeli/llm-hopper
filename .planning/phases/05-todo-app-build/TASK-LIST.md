# Phase 5 — Todo App Build: Task List

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::root`

## Author & Provenance

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::provenance`

- Authored by: `builder-kimi` (Builder, model `kimi-2.6`)
- Authored at: 2026-05-05
- Source spec: `ROADMAP.md` (high-level: "实现一个简易 Todo App，支持添加任务、标记完成、删除任务、列表展示。使用现代 UI，要求响应式。")
- Phase: Superpowers — Todo App Build
- Predecessor phase: GSD (spec complete; see `TRD.md`, `ROADMAP.md`)

## Architecture Decision

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::architecture-decision`

- Stack: vanilla HTML5 + CSS3 + ES Modules JS (no build step, no frameworks, no package install)
- Rationale: aligns with `DECISIONS.md` "prompt-only, runtime-light" stance; keeps each task atomic and verifiable in a plain browser
- Persistence: `localStorage` (key `"todos"`, JSON array)
- Output directory: `apps/todo/` (separate from `.hopper/demo/` planning artifacts)
- No external dependencies, no API calls, no daemons

## Task Inventory

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::task-inventory`

| ID | Title | Files | Depends On | Owner Role |
|----|-------|-------|------------|------------|
| T01 | Project skeleton + semantic HTML | `apps/todo/index.html` | none | Executor |
| T02 | Modern responsive CSS | `apps/todo/styles.css` | T01 | Executor |
| T03 | Data model + localStorage persistence | `apps/todo/store.js` | none | Executor |
| T04 | View layer + DOM event wiring | `apps/todo/app.js`, `apps/todo/index.html` (import line) | T01, T03 | Executor |
| T05 | Polish — empty state, animations, accessibility | `apps/todo/styles.css`, `apps/todo/index.html`, `apps/todo/app.js` | T01–T04 | Executor |

## Task Details

### T01 — Project Skeleton + Semantic HTML

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::t01`

- **File(s):** `apps/todo/index.html` (new)
- **Component:** static page shell with stable hook IDs
- **Required hook IDs (immutable contract for downstream tasks):**
  - `#todo-form` — `<form>` element
  - `#todo-input` — `<input type="text">` for new todo title
  - `#todo-submit` — submit `<button>`
  - `#todo-list` — empty `<ul>` for todo items
  - `#todo-count` — `<span>` showing items-left counter
  - `#todo-empty` — empty-state `<div>` (hidden by default via inline `hidden` attr)
- **Inputs:** none (pure markup)
- **Outputs:** valid HTML5 document at `apps/todo/index.html`
- **RED:** open file in browser → page loads but is unstyled and non-interactive
- **GREEN:** W3C HTML5 validation passes; every required hook ID is present and unique; `<form>` correctly contains the input + button; `<ul id="todo-list">` is empty; document has `<meta charset>`, `<meta name="viewport" content="width=device-width, initial-scale=1">`, `<title>`
- **REFACTOR:** add ARIA labels (`aria-label` on form, `role="list"` on `<ul>` if needed for assistive tech), semantic landmarks (`<header>`, `<main>`, `<footer>`)
- **Acceptance Criteria:**
  1. `apps/todo/index.html` opens in any modern browser with **zero** console errors or warnings
  2. All six required hook IDs are queryable via `document.getElementById(...)` and return non-null
  3. The `<form>` element wraps both the `<input>` and the submit `<button>`
  4. `<ul id="todo-list">` exists and contains zero children
  5. Page is plain English text and renders at any viewport width without horizontal scroll
- **Allowed file mutations:** create `apps/todo/index.html` only
- **Forbidden:** writing CSS, writing JS, importing scripts, adding any framework or library tags
- **Stop conditions:** all five acceptance criteria met → stop and hand off back to Builder for review

### T02 — Modern Responsive CSS

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::t02`

- **File(s):** `apps/todo/styles.css` (new); update `apps/todo/index.html` only to add the `<link rel="stylesheet" href="styles.css">` tag
- **Component:** design-token-driven mobile-first stylesheet
- **Inputs:** the markup contract from T01
- **Outputs:** styled, responsive UI
- **RED:** page renders but looks unstyled / 1995-era
- **GREEN:** clean modern look at viewport widths 320, 768, 1280; `:hover` + `:focus-visible` states on interactive elements; color contrast ≥ 4.5:1 on text; focus rings visible
- **REFACTOR:** extract design tokens to `:root` (`--color-*`, `--space-*`, `--radius-*`, `--font-*`); add `@media (prefers-color-scheme: dark)` override
- **Acceptance Criteria:**
  1. No horizontal scroll at 320px viewport width
  2. Text vs background contrast ≥ 4.5:1 (WCAG AA)
  3. Keyboard focus is visible on input and button (no `outline: none` without a replacement)
  4. Layout breakpoints at 480/768/1024px produce sensible reflow
  5. Dark mode rule exists and inverts background/foreground tokens

### T03 — Data Model + LocalStorage Persistence

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::t03`

- **File(s):** `apps/todo/store.js` (new ES module)
- **Component:** `createTodoStore()` factory returning `{ add, toggle, remove, getAll, clear }`
- **Data shape:** `{ id: string, title: string, completed: boolean, createdAt: number }`
- **Storage:** `localStorage` key `"todos"`, value is `JSON.stringify(arrayOfTodos)`
- **Inputs / Outputs per method:**
  - `add(title: string) → todo | null` — null when title is empty/whitespace; otherwise persists and returns the new todo
  - `toggle(id: string) → todo | null` — flips `completed`; null if not found (no throw)
  - `remove(id: string) → boolean` — true if removed; false if not found (no throw)
  - `getAll() → Todo[]` — chronological by `createdAt`
  - `clear() → void`
- **RED:** factory exists but methods throw "not implemented"
- **GREEN:** all CRUD operations round-trip through `localStorage`; closing and reopening the store recovers the same data; `id` is unique (use `Date.now().toString() + Math.random().toString(36).slice(2, 6)` or equivalent)
- **REFACTOR:** trim the title; reject empty / whitespace-only after trim
- **Acceptance Criteria:**
  1. `add("foo")` returns `{id, title: "foo", completed: false, createdAt}` and `getAll()` includes it
  2. After `localStorage` is read fresh in a new factory instance, `getAll()` returns the persisted array
  3. `add("")`, `add("   ")`, `add("\t\n")` all return `null` and do not modify storage
  4. `toggle("nonexistent-id")` returns `null` and throws nothing
  5. `remove("nonexistent-id")` returns `false` and throws nothing

### T04 — View Layer + DOM Event Wiring

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::t04`

- **File(s):** `apps/todo/app.js` (new ES module entry); minimal edit to `apps/todo/index.html` to add `<script type="module" src="app.js"></script>` before `</body>`
- **Component:** `render()` function + event listeners; uses event delegation on `#todo-list`
- **Item markup contract (rendered by `render`):**
  ```html
  <li class="todo {completed ? 'completed' : ''}" data-id="{id}">
    <input type="checkbox" data-action="toggle" {completed ? 'checked' : ''}>
    <span class="todo__title">{escapedTitle}</span>
    <button type="button" data-action="delete" aria-label="Delete">×</button>
  </li>
  ```
- **Inputs:** DOM events from form submit and clicks within `#todo-list`
- **Outputs:** updated DOM and store state
- **Required behaviour:**
  - Form submit → `store.add(input.value)`; clear `input.value`; re-render
  - Click on element with `[data-action="toggle"]` → toggle by ancestor `data-id`
  - Click on element with `[data-action="delete"]` → remove by ancestor `data-id`
  - `#todo-count` shows `"N items left"` (count of `!completed`)
  - `#todo-empty` is hidden when list is non-empty, shown when empty
- **Security:** title must be inserted as `textContent` (not `innerHTML`) to prevent XSS
- **RED:** typing and clicking "Add" does nothing visible
- **GREEN:** full add → toggle → delete → empty-state cycle works; reload preserves todos
- **REFACTOR:** ensure exactly one delegated click listener on `#todo-list` (not per-item)
- **Acceptance Criteria:**
  1. Submitting the form with a non-empty value adds a todo and clears the input
  2. Clicking the checkbox toggles the `completed` class **and** persists (verified by reload)
  3. Clicking the delete button removes the todo from both DOM and store
  4. After full reload, previously persisted todos render automatically
  5. Pasting `<img src=x onerror=alert(1)>` as a title renders as literal text, no script execution

### T05 — Polish: Empty State, Animations, Accessibility

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::t05`

- **File(s):** edits to `apps/todo/styles.css`, `apps/todo/index.html`, `apps/todo/app.js`
- **Component:** empty-state visual, slide-in / fade-out transitions, ARIA live region
- **RED:** add/delete is jarring; screen reader silent on changes; empty state empty
- **GREEN:**
  - Empty state shows "No todos yet" plus an icon (CSS-only or SVG inline) when list is empty
  - New `<li>` slides in via opacity 0→1 and translateY(-4px)→0, ≤200ms
  - Deleted `<li>` fades out before removal (≤150ms)
  - `#todo-count` has `aria-live="polite"`; form has `aria-label="Add todo"`
  - Full keyboard flow works: Tab focuses input → button → first checkbox → delete → next checkbox …
- **REFACTOR:** wrap all transitions in `@media (prefers-reduced-motion: no-preference)`
- **Acceptance Criteria:**
  1. Empty state shows iff `store.getAll().length === 0`
  2. Lighthouse Accessibility score ≥ 95 in Chrome DevTools
  3. With `prefers-reduced-motion: reduce` set in DevTools, no transition runs
  4. App is fully usable with keyboard only — no mouse required to add/toggle/delete
  5. Screen reader announces count change after add/toggle/delete

## Execution Discipline

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::execution-discipline`

- Executor takes exactly one task at a time, in dependency order
- Executor MUST NOT modify task spec, MUST NOT introduce design choices beyond the contract
- After each task, Executor hands back to Builder (`builder-kimi`) for review
- Builder may then dispatch the next task or send back fixes
- All file paths are relative to repo root `F:\workspace\ai\llm-hopper`
- Out-of-scope file edits are forbidden; if a contract gap appears, Executor MUST stop and ask Builder

## Cross-References

Anchor: `.planning/phases/05-todo-app-build/TASK-LIST.md::cross-references`

- Spec source: `TRD.md`, `ROADMAP.md`
- Role rules: `.hopper/roles/ROLES.md`
- Handoff schema: `.hopper/prompts/handoff-to-role.md`
- Cost log: `.hopper/costs/COST-LOG.md`
- State cursor: `.planning/STATE.md`, `.hopper/MANIFEST.md`
