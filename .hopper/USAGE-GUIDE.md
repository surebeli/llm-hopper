# llm-hopper Usage Guide

Anchor: `.hopper/USAGE-GUIDE.md::root`

> **Doc status**: 2026-05-17 first cut. Companion to `.hopper/PING.md` v5. PING.md is the **canonical protocol spec** (frozen through 2026-11-15). This guide documents existing-but-scattered patterns + dogfood-emergent conventions so a new user can pick hopper up in one read.
>
> **Reading order for newcomers**: §1 → §2 → §3 → §6 (skim) → §7. Use §4/§5 as reference.

---

## 1. Mental model — who talks to whom

```
              ┌─────────────────────────────┐
              │  Strategy / Supervisor       │  ← convention, not in PING v5
              │  (optional layer above Leader)│
              └──────────────┬───────────────┘
                             │ handoff file (push)
                             │ ping-strategy file (escalation pull)
                             ▼
              ┌─────────────────────────────┐
              │  Leader                      │
              │  (push queue / review done)  │
              └──────────────┬───────────────┘
                             │ queue.md (push)
                             │ leader-feedback file (mid-task push)
                             ▼
       ┌────────────────────┴────────────────────┐
       │                    │                    │
       ▼                    ▼                    ▼
  ┌─────────┐         ┌──────────┐         ┌──────────┐
  │ Builder │         │ Executor │         │ Critic   │
  │ Builder-│         │          │         │          │
  │  pair   │         │          │         │          │
  │ Builder-│         │          │         │          │
  │  UI     │         │          │         │          │
  │ Researcher        │          │         │          │
  └─────────┘         └──────────┘         └──────────┘
       │                    │                    │
       │  ping (pull)        │                    │
       │  output.md (push back to Leader for review)
       ▼                    ▼                    ▼
              ┌─────────────────────────────┐
              │  Source-of-truth files       │
              │  .hopper/queue.md            │
              │  .hopper/handoffs/*.md       │
              │  .hopper/COST-LOG.md         │
              │  .hopper/HOPPER-FEEDBACK.md  │
              └─────────────────────────────┘
```

**Key invariants**:

1. **File system is the source of truth**. Chat prose is ephemeral. Every protocol-level event has a corresponding file change (queue row, output.md, feedback file, commit).
2. **Pull-based by default**. Receivers (Workers) call `ping` to fetch their next task. Senders (Leader) don't push tasks "into" sessions; they edit `queue.md` and the next `ping` finds the work.
3. **No live runtime**. There's no daemon, no IPC, no message bus. Coordination = file edits + atomic git commits.
4. **One repo, many sessions**. Multiple CLI sessions (Claude Code, Codex CLI, Gemini CLI, etc.) operate on the same `.hopper/` directory. PING v5's Step 0.5 enforces fresh-reads to keep them coherent.

---

## 2. Role catalog (extended)

Three sources contribute to role definition: `.hopper/PING.md` (verbs each role uses), `.hopper/roles/ROLES.md` (permissions), `.hopper/agents/AGENTS.md` (nickname-to-model binding). They are intentionally separate.

### 2.1 Strategy *(convention, not in PING v5)*

- **Origin**: Emerged during myWriteAssistant dogfood when Claude Opus stepped out of operational Leader role and into observer/supervisor.
- **Role**: Above Leader. Sets multi-task plans, defines escalation triggers, evaluates Round-level outcomes, owns long-horizon decisions (essay timing, Round transitions, protocol freeze policies).
- **Tools**: Two file conventions only — `strategy-<dated>-<purpose>.md` (push) and consume `leader-ping-strategy-<dated>.md` (pull).
- **NOT**: Strategy does not pop tasks. Strategy does not write code. Strategy does not modify `queue.md`. Strategy delegates everything operational to Leader.
- **When to skip**: For small projects with one Leader and ≤3 tasks, skip the Strategy layer. Spin it up when (a) you're running multi-Round dogfood, (b) you want a different model on long-horizon decisions than on operational work, (c) you need an audit trail of "why we decided X" separate from "how we executed Y".

### 2.2 Leader

- **Authority**: Push tasks to `queue.md`; review done tasks; mid-task feedback; dispatch Builders/Executors/Critics; manage `MANIFEST.md` cursor.
- **Tools**: `ping <role>` (rarely — usually Workers self-pop), `review <task-id>` / `review` / `review --pending`. Edits `queue.md` directly to push.
- **Forbidden**: Don't write product code yourself unless you're the only role (single-LLM bootstrap). Don't push without Critic having reviewed the spec.

### 2.3 Builder

- **Permission**: Full design + execution from Leader spec.
- **Tools**: `ping` family. Produces `<task-id>-output.md`.
- **Subtypes**:
  - `Builder` — backend / general
  - `Builder-UI` — frontend, scoped to UI direction
  - `Builder-pair` *(convention)* — sidecar reviewer, runs after substantive Builder; produces same output.md format but verdict-style content

### 2.4 Executor

- **Permission**: Pure execution. No design, no spec edits.
- **Tools**: `ping` family. Same output.md format.
- **Use case**: Highly bounded mechanical work (rename refactors, JSDoc additions, file moves). When a task says "do exactly X, no thinking required", give it to Executor.

### 2.5 Critic

- **Permission**: Read-only on product code; writes review docs only.
- **Tools**: `ping` family (queue Role column = `critic`); produces `critic-<task-id>.md` instead of `<task-id>-output.md`.
- **Distinction from Leader review**: Critic is **adversarial** (looks for bugs, edge cases, missing tests). Leader review is **acceptance** (does the work meet spec). Both can exist on the same task.

### 2.6 Researcher

- **Permission**: Read-only on product code; writes one researcher output per "day"/round.
- **Tools**: `ping` family. Filename convention: `<day>-researcher-output.md` (e.g. `day1-researcher-output.md`).
- **Use case**: Domain audits, library evaluation, prior-art surveys. Fed into spec drafting.

### 2.7 Role naming — three vocabularies coexist

This is a known wart. Don't be confused:

| Context | Vocabulary used | Example |
|---|---|---|
| `PING.md` (queue Role column) | lowercase, hyphenated | `builder` / `builder-ui` / `executor-1` / `critic` / `researcher` |
| `ROLES.md` (permissions) | TitleCase, no instance suffix | `Builder` / `UI-Builder` / `Executor` |
| `AGENTS.md` (nickname binding) | nickname slug | `builder-primary` / `builder-secondary` / `executor-secondary` |

Future v0.6 may unify. For now: PING.md's queue Role column is the runtime authority — match its strings exactly when pushing to `queue.md`.

---

## 3. Communication primitives — quick reference

### 3.1 Who can use what (matrix)

| Primitive | Sender | Receiver | Mechanism | Doc |
|---|---|---|---|---|
| **Push task** | Leader | Worker (any) | Edit `queue.md` row | PING.md §Push protocol |
| **Pull task** | Worker | (self) | `ping` keyword | PING.md §Procedure Step 1-3 |
| **Pull specific task** | Worker | (self) | `ping <task-id>` *(v5)* | PING.md §Forms |
| **Worker → Leader feedback** | Worker | Leader | Write `<task-id>-output.md` | PING.md §Step 7.5 |
| **Leader → Worker review** | Leader | (consumes output) | `review <task-id>` | PING.md §Leader Review |
| **Leader → Worker mid-task** | Leader | Worker | Write `<task-id>-leader-feedback.md` *(v5)* | PING.md §Leader Feedback Channel |
| **Worker → Leader blocker** | Worker | Leader | Write `blocker-<task-id>.md` | PING.md §Step 7 |
| **Strategy → Leader dispatch** *(convention)* | Strategy | Leader | Write `strategy-<dated>-<purpose>.md` | This guide §4.3 |
| **Leader → Strategy escalation** *(convention)* | Leader | Strategy | Write `leader-ping-strategy-<dated>.md` | This guide §4.4 |
| **Critic → Leader review** | Critic | Leader | Write `critic-<task-id>.md` | PING.md §Step 7.5 + §Step 9 |
| **Implicit ack ("pong")** | Worker | Anyone reading queue | Status flip `pending` → `in-progress` *(Step 3 lock)* | PING.md §Step 3 |

### 3.2 The "pong" question

There is **no `pong` keyword**. The semantic equivalent is the `pending` → `in-progress` status flip in `queue.md` at Step 3 (the lock). Any sibling session reading queue.md sees who's working on what.

**Why no separate pong**:
- Adding a chat-level "pong" wouldn't survive session switches (chat is ephemeral)
- The queue.md flip is durable, audit-trailable, and visible to other sessions
- For long tasks, the missing piece is **heartbeat / progress**, not ack — and that's a real v0.6 gap (§9)

**If you want explicit ack**: the convention is for Worker to commit Step 3 (lock) as its own commit (`[<task-id>] start`) before doing Step 5 work. This makes the start visible in `git log` without protocol change. Not standardized; project-by-project choice.

### 3.3 Dispatcher Empathy + Uniform Quality, Scaled Content *(2026-05-18 principle)*

Protocol-level rule for handoff quality:

> **If I myself were the recipient with zero prior context, could I execute and know when done — without pinging the dispatcher back?**

Content scales by role gradient (Strategy → Leader → Builder → Builder-pair, analogous to CEO → CTO → engineer). **Quality standard is uniform across all gradient levels**: same required sections, same machine-checkability bar, just scaled granularity.

**Five-question dispatcher self-check** — answer YES to all before sending any handoff:

1. If I were the recipient with zero context, could I start?
2. Can I know when done without pinging dispatcher back?
3. Can I distinguish "in-scope deviation" from "must-escalate blocker"?
4. Do I know output shape, location, and verdict format?
5. Do I know current MANIFEST cursor so my Next recommendation stays in scope?

**Dispatch Template family** at `.hopper/templates/dispatch-*.md`:

| Template | Recipient role | Scope | Typical size |
|---|---|---|---|
| `dispatch-strategy-to-leader.md` | Leader | Multi-task phase, authority transfer, escalation contract | 200-700 lines |
| `dispatch-leader-to-builder.md` | Builder/Builder-UI/Executor | Single task spec with TDD acceptance | 80-200 lines |
| `dispatch-leader-to-pair.md` | Builder-pair (sidecar) | Polish review with **explicit mode declaration** | 40-100 lines |
| `dispatch-builder-to-pair.md` | Builder-pair (embedded) | Sidecar prompt inside substantive output.md | 30-80 lines |

Each template enforces the same section shape; recipient role determines content depth.

**Why this matters (origin story)**: P0 double-rework retro 2026-05-17 found both reworks (T-CLIENT-RUNTIME-polish + T-COSTLOG-REORG) were **dispatcher empathy failures**, not executor failures. The handoffs under-specified closure criteria. Stronger model wouldn't fix it; better handoff template would. See `myWriteAssistant/.hopper/handoffs/leader-retro-2026-05-17-double-rework.md`.

**Not retroactively applied**: active handoffs are NOT modified to fit new templates. Preserves audit trail. New dispatches use templates going forward.

**Relationship to PING v3 output schema**: This is the INPUT-side complement. PING v3's `<task-id>-output.md` schema tightens what comes BACK from executor; this principle tightens what goes OUT to executor. Together = closed loop: clear input → clear output → easy review → less rework.

---

## 4. Keyword reference (verbatim from PING.md)

### 4.1 Worker pull — `ping` family

| Form | Effect | When to use |
|---|---|---|
| `ping` | Pop next eligible task for session's role | Default Worker action when ready to work |
| `ping <role>` | Pop with role override | One CLI session covering multiple roles |
| `ping <task-id>` *(v5)* | Pop specific task by ID, bypass sort order | When Leader explicitly says "do T07 next" |
| `ping --task=<id>` *(v5)* | Same as above, explicit form | Same |
| `ping --status` | Show queue summary, no modification | Quick state check |
| `ping --dry` | Show "would pop X", no modification | Verify next pop before committing |

All forms run Steps 0-10 in PING.md. `--status` and `--dry` stop at Step 2.

### 4.2 Leader review — `review` family

| Form | Effect | When to use |
|---|---|---|
| `review <task-id>` | Read output.md + commit + diff, give verdict | Specific task review |
| `review` | Auto-pick latest `done` with no `## Leader review` section | Batch through pending reviews |
| `review --pending` | List all unreviewed-done tasks | Triage before review session |

Verdicts: `accept` / `accept-with-note` / `rework` / `revert`. See PING.md §Leader Review Step 4.

### 4.3 Strategy → Leader dispatch — file convention *(not in PING v5)*

**Filename**: `.hopper/handoffs/strategy-<YYYY-MM-DD>-<purpose-slug>.md`

**Example**: `strategy-2026-05-15-p0-dispatch.md`

**Required sections** (recommended template, not enforced):

```markdown
# Strategy → Leader handoff: <purpose> (<date>)

Anchor: `.hopper/handoffs/strategy-<dated>-<purpose>.md::root`

**From**: Strategy Advisor (<model name>)
**To**: <Leader nickname>
**Re**: <one-line summary>
**Anchor refs**: <list of files Leader must read>

## 1. Background
<context Leader needs but doesn't need to act on>

## 2. Authority transfer
### Leader fully authorized for:
- <list>
### Strategy retains decision on:
- <list — when Leader must ping back>

## 3. Task list
<P0/P1/P2 breakdown, each with: status / source / builder candidates / scope / deliverable / verification / budget>

## 4. Escalation triggers
<numbered list of "stop and ping Strategy" conditions>

## 5. Reporting cadence
<what Leader writes when, even without escalation>

## 6. Do-not list
<reverse list: things Leader should NOT do>

## 7. Phase cursor proposal
<text Leader can paste into MANIFEST.md if accepted>

**Acknowledge**: <required ack line Leader writes in HOPPER-FEEDBACK>
```

See `.hopper/handoffs/strategy-2026-05-15-p0-dispatch.md` (in myWriteAssistant dogfood) for a working example.

### 4.4 Leader → Strategy escalation — file convention *(not in PING v5)*

**Filename**: `.hopper/handoffs/leader-ping-strategy-<YYYY-MM-DDTHHMM>.md`

**Required sections** (enforced format — Strategy rejects ambiguous pings):

```markdown
# Leader ping Strategy: <dated, slug>

Anchor: `.hopper/handoffs/leader-ping-strategy-<dated>.md::root`

**Trigger**: <which numbered escalation trigger fired>
**Context**: <2-4 sentences>
**What I tried / decided so far**: <if any>
**What I need from Strategy**: <specific question, YES/NO preferred>
**Suggested options (if applicable)**:
- A) ...
- B) ...
**Cost impact**: <$X spent, $Y projected>
**Time impact**: <blocks which tasks for how long>
```

---

## 5. Filename conventions — master table

All paths relative to project root. The `.hopper/handoffs/` directory is the primary inter-role communication surface.

| Pattern | Writer | Reader | Purpose |
|---|---|---|---|
| `.hopper/queue.md` | Leader (push) + Workers (status flips) | All | Task state cursor |
| `.hopper/MANIFEST.md` | Leader / Strategy | All | Phase cursor + role-to-agent map |
| `.hopper/PING.md` | (frozen) | All | Protocol spec |
| `.hopper/HOPPER-FEEDBACK.md` | Any role | All | Durable insight log + acks |
| `.hopper/COST-LOG.md` | Workers (Step 8) | All (essay material) | Cost tracking |
| `.hopper/handoffs/<task-id>-output.md` | Builder / Builder-UI / Executor | Leader | Step 7.5 task output |
| `.hopper/handoffs/critic-<task-id>.md` | Critic | Leader | Critic review verdict |
| `.hopper/handoffs/<day>-researcher-output.md` | Researcher | Leader | Research audit |
| `.hopper/handoffs/<task-id>-leader-feedback.md` | Leader | Worker (mid-task) | v5 Leader→Worker push |
| `.hopper/handoffs/blocker-<task-id>.md` | Worker (Step 7 fail) | Leader | Worker can't complete task |
| `.hopper/handoffs/<task-id>-rework-N.md` | Leader (verdict=rework) | Worker | Spec for rework iteration |
| `.hopper/handoffs/strategy-<dated>-<purpose>.md` | Strategy | Leader | Strategy→Leader dispatch *(convention)* |
| `.hopper/handoffs/leader-ping-strategy-<dated>.md` | Leader | Strategy | Leader→Strategy escalation *(convention)* |
| `.hopper/handoffs/<task-id>-polish-output.md` | Builder-pair | Leader | Sidecar polish verdict *(convention)* |
| `.hopper/handoffs/leader-tasklist.md` | Leader (only) | All | Immutable task spec (queue.md = cursor on this) |
| `.hopper/handoffs/leader-status-<date>-<event>.md` | Leader | Strategy | Periodic digest *(convention)* |
| `.hopper/templates/dispatch-strategy-to-leader.md` | (template) | Strategy → Leader dispatchers | Multi-task phase handoff template |
| `.hopper/templates/dispatch-leader-to-builder.md` | (template) | Leader → Builder dispatchers | Single task spec template |
| `.hopper/templates/dispatch-leader-to-pair.md` | (template) | Leader → Builder-pair dispatchers | Sidecar with explicit mode declaration |
| `.hopper/templates/dispatch-builder-to-pair.md` | (template) | Builder → Builder-pair dispatchers | Embedded sidecar prompt template |

**Naming rules**:

1. **Dates in filenames** use `YYYY-MM-DD` (date-only) for daily/coarse events; `YYYY-MM-DDTHHMM` for sub-day events (multiple pings same day)
2. **Task IDs** are uppercase or hyphenated (`T01`, `T-CLIENT-RUNTIME`, `critic-v1`)
3. **No spaces** in filenames; use hyphens
4. **Anchor required** in first non-frontmatter line: `Anchor: \`.hopper/path/file.md::root\``
5. **Don't reuse a filename** — every event creates a new file. Multi-round things append within one file (e.g. leader-feedback.md gets `## Round N` sections), but a new file per task ID.

---

## 6. Lifecycle examples

### 6.1 Normal Builder task

```
Leader              queue.md          Builder session     output.md         git
  │                    │                   │                  │              │
  │── push row T07 ────►│                   │                  │              │
  │   pending           │                   │                  │              │
  │                    │                   │                  │              │
  │                    │◄─── ping ─────────│                  │              │
  │                    │ Step 0.5 fresh-read│                  │              │
  │                    │ Step 1-2 find T07  │                  │              │
  │                    │── pop ────────────►│                  │              │
  │                    │ Status: in-progress│                  │              │
  │                    │                   │                  │              │
  │                    │                   │── Step 4-5 ──────┤              │
  │                    │                   │ execute          │              │
  │                    │                   │                  │              │
  │                    │                   │── Step 6 ────────┤              │
  │                    │                   │ sanity check     │              │
  │                    │                   │                  │              │
  │                    │◄── Step 7 ────────│                  │              │
  │                    │ Status: done      │                  │              │
  │                    │                   │── Step 7.5 ─────►│              │
  │                    │                   │ write output.md  │              │
  │                    │                   │                  │              │
  │                    │                   │── Step 8 ────────│              │
  │                    │                   │ append COST-LOG  │              │
  │                    │                   │                  │              │
  │                    │                   │── Step 9 ────────┴─────────────►│
  │                    │                   │ atomic commit                   │
  │                    │                   │                                 │
  │── review T07 ──────┴───────────────────┴─────────────────►│              │
  │   verdict written to output.md                                           │
  │── commit [review:T07] ──────────────────────────────────────────────────►│
```

### 6.2 Builder-pair sidecar lifecycle *(convention)*

```
Builder (substantive)                    Builder-pair (sidecar)
   │                                        │
   │── Step 7.5 ──────►  output.md          │
   │   includes "Sidecar handoff prompt" section
   │                                        │
   │                                        │◄── ping ──────
   │                                        │   pop "<task-id>-polish"
   │                                        │   (Leader added this row after substantive done)
   │                                        │
   │                                        │── read sidecar prompt from substantive output.md
   │                                        │   scope = diff/safety/metadata only
   │                                        │
   │                                        │── write <task-id>-polish-output.md
   │                                        │   verdict: PASS / PASS_WITH_CHANGES / REWORK
   │                                        │
   │                                        │── commit [<task-id>:polish] ...
   │                                        │
   │◄─── Leader review reads BOTH files ────│
        substantive output.md + polish output.md
```

### 6.3 Strategy → Leader → Worker dispatch *(convention)*

```
Strategy                  Leader                    Worker
   │                        │                          │
   │── write strategy-      │                          │
   │   <dated>-<purpose>.md │                          │
   │                        │                          │
   │── tell user "Leader     │                          │
   │   should pop this"      │                          │
   │                        │                          │
   │                        │── read strategy file     │
   │                        │── ack in HOPPER-FEEDBACK │
   │                        │── update MANIFEST cursor │
   │                        │── push new tasks to queue│
   │                        │                          │
   │                        │── (Worker session opens) ◄
   │                        │                          │
   │                        │                          │── ping
   │                        │                          │── normal Builder lifecycle
   │                        │                          │
   │                        │── review                 │
   │                        │                          │
   │                        │── write leader-status-   │
   │                        │   <date>-<event>.md      │
   │◄────────── digest ─────│                          │
   │                        │                          │
   │── next dispatch ──────►│                          │
```

### 6.4 Leader → Strategy escalation *(convention)*

```
Leader                                Strategy
   │                                     │
   │── escalation trigger fires          │
   │   (e.g. AC18 fail, scope creep)     │
   │                                     │
   │── stop work                         │
   │── write leader-ping-strategy-       │
   │   <dated>.md per 5-field schema     │
   │                                     │
   │── tell user "pinged Strategy"       │
   │                                     │
   │                                     │── read ping file
   │                                     │── decide
   │                                     │── write reply (could be new
   │                                     │   strategy-<dated>-<purpose>.md
   │                                     │   or short edit to MANIFEST)
   │                                     │
   │◄────────────────────── reply ───────│
   │                                     │
   │── resume per Strategy direction     │
```

### 6.5 Worker hits blocker

```
Worker                            Leader
   │                                │
   │── Step 5 execute fails or       │
   │   Step 6 acceptance unverifiable│
   │                                │
   │── Step 7: Status → failed       │
   │── write blocker-<task-id>.md    │
   │   describing the obstacle       │
   │── commit                        │
   │                                │
   │── tell user "blocked, escalate" │
   │                                │
   │                                │── read blocker file
   │                                │── decide: spec change /
   │                                │   different role / drop task
   │                                │── if needed write
   │                                │   leader-feedback / new task
   │                                │
   │◄─── new push or feedback ──────│
```

---

## 7. Onboarding recipe — new project picks up hopper

### 7.1 Files to copy from `llm-hopper/.hopper/templates/`

```bash
mkdir -p <new-project>/.hopper/handoffs
cp llm-hopper/.hopper/PING.md           <new-project>/.hopper/PING.md
cp llm-hopper/.hopper/templates/queue.md            <new-project>/.hopper/queue.md
cp llm-hopper/.hopper/templates/builder-output.md   <new-project>/.hopper/templates/builder-output.md
cp llm-hopper/.hopper/templates/bootstrap-CLAUDE.md <new-project>/CLAUDE.md
cp llm-hopper/.hopper/templates/bootstrap-GEMINI.md <new-project>/GEMINI.md
cp llm-hopper/.hopper/templates/bootstrap-AGENTS.md <new-project>/AGENTS.md
```

Then create `<new-project>/.hopper/MANIFEST.md` and `<new-project>/.hopper/AGENTS.md` for the project (don't copy from llm-hopper templates — these are project-specific).

### 7.2 Minimum required files for first ping to work

- `.hopper/PING.md`
- `.hopper/queue.md` (at least one row with `Status: pending`)
- `CLAUDE.md` or `GEMINI.md` or `AGENTS.md` at root (bootstrap pointer to PING.md)

`MANIFEST.md` is **recommended** but not strictly required for `ping`. It becomes load-bearing when Strategy → Leader handoff starts happening or multiple roles need to find current phase.

### 7.3 First-week recipe (single-Builder, no Strategy)

1. **Day 0**: Researcher session, produces `.hopper/handoffs/day1-researcher-output.md` (manually dispatched, no queue row needed yet)
2. **Day 1**: Leader session reads researcher output + writes `docs/plans/<spec>.md` + `.hopper/handoffs/leader-tasklist.md` + populates `queue.md` with first wave of tasks
3. **Day 1**: Critic session, `ping` → produces `critic-day1-spec.md` with PASS / FAIL / PASS_WITH_CHANGES
4. **Day 1 (afternoon)**: Leader applies Critic surgical fixes, marks spec ready, queue.md updated with first Builder tasks
5. **Day 2-N**: Builder session(s), `ping` → execute → `<task-id>-output.md` → commit
6. **Day 2-N**: Leader session intermittently, `review` to consume done tasks, `review --pending` to triage
7. **Round close**: Leader writes summary digest (if multi-Round dogfood), updates MANIFEST cursor

### 7.4 When to layer in Strategy

Add Strategy when:
- You want a different model (typically larger / more expensive) on long-horizon decisions than on operational work
- You're running 2+ Rounds with explicit phase transitions
- You want an audit trail of "why we chose this approach" separate from "how we executed it"
- You're dogfooding hopper itself and the protocol may evolve during the project

Don't add Strategy when:
- One person + one model is doing everything
- Project is < 1 week
- No multi-Round structure

---

## 8. Common scenarios with prescribed actions

### 8.1 "Worker crashed mid-task — queue says in-progress, but session is dead"

PING.md §Concurrency note 5: if `in-progress` timestamp > 30 min and no commit yet, the task may be stalled. **Don't auto-take-over**. Report to user with the timestamp + role. User decides whether to:
- Revert queue row to `pending` and let next Worker pick up (clean restart)
- Investigate the crashed session's working tree before discarding
- Manually mark `failed` and dispatch as a new task with notes from crash

### 8.2 "Critic verdict is REWORK — what next?"

1. Original task **stays `done`** in queue.md (don't revert — preserves history)
2. Leader writes `<original-task-id>-rework-1.md` with spec for the rework
3. Leader pushes new queue row `<original-task-id>-rework-1` with `Role: builder` (usually same role as original)
4. Next `ping` pops the rework; Worker executes; produces new `<original-task-id>-rework-1-output.md`
5. If second rework needed: increment to `-rework-2`. By `-rework-3` Leader should escalate to Strategy if running multi-Round.

### 8.3 "Two sessions both type `ping` at the same time"

PING.md §Concurrency note 1: don't do this. Both sessions will race to lock the same queue row; one will fail Edit's staleness check. **Recovery**: the one that failed re-reads queue.md and finds the next eligible task. The lock is the source of truth.

### 8.4 "Leader needs to push a fix mid-Worker-task"

Use Leader Feedback Channel (PING.md §Leader Feedback Channel, v5):
1. Leader writes `<task-id>-leader-feedback.md` with Diagnosis / Required fix / Re-verify sections
2. Leader tells user "feedback file written, ask Worker to read"
3. Worker (still in Step 5) reads the file, applies fix, **appends** `## Round N response` section to the same file
4. Worker resumes Step 6-10

Do NOT have Leader paste diagnosis in chat — that breaks audit trail (v5 fix for HOPPER-FEEDBACK P9).

### 8.5 "Manual verify needed but Worker session ended"

PING.md §Step 6 manual verification rule: Worker leaves Status `in-progress` and states explicitly "manual verification needed: <X>". The user runs the manual check, reports result to a new session (could be same Worker model, or Leader). That session updates the queue row.

For substantial manual checks (like AC18 Tauri smoke), promote to its own task with `Role: executor` (or `executor` + blocked-on-user-manual note). See myWriteAssistant `T-AC18-SMOKE` for an example.

### 8.6 "User wants to switch Leader to a different model mid-Round"

1. Update `.hopper/agents/AGENTS.md`: change `leader-primary` model column (keep UUID stable)
2. Update `.hopper/MANIFEST.md` role-to-agent table
3. New Leader session reads MANIFEST → AGENTS → queue → continues
4. Add row to MANIFEST 修改记录 documenting the swap and reason
5. Don't change nickname — nicknames persist across model swaps; UUIDs are the fallback identifier

### 8.7 "Builder produces output.md but never commits"

PING.md §Step 9: if commit fails, Worker must NOT mark Step 7 done. Recovery:
- If Worker forgot Step 9 entirely: have them commit retroactively `git add` + `git commit -m "[<task-id>] ..."` then mark Step 9 complete
- If commit failed at pre-commit hook: per Step 9 "If commit fails" — fix and re-commit; after 3 failures, revert Status to `in-progress` and escalate

---

## 9. Known gaps (v0.6 candidates, frozen for now)

These are real protocol gaps observed in dogfood. **Not fixing during freeze** (through 2026-11-15). Documented here so users know what's NOT in v5.

| Gap | Workaround in v5 | Candidate v0.6 fix |
|---|---|---|
| No "pong" / explicit start-ack keyword | Step 3 lock is implicit ack; can commit start as separate commit | Optional `ping --ack` form that emits a `<task-id>-start.md` heartbeat |
| No heartbeat for long-running tasks | None; 30-min stalled heuristic only | Periodic Worker write to `<task-id>-progress.md` every N minutes |
| Strategy role not in PING.md / ROLES.md | This guide §2.1 documents the convention | Promote Strategy to first-class role |
| Critic dispatch identical to Builder dispatch (only Role column differs) | Currently works via queue Role column | Optional `critique <task-id>` keyword for Critic-specific semantics |
| Builder-pair sidecar not a primitive | Documented as convention in §6.2 | Optional `ping --pair=<substantive-task-id>` form |
| No "assignee" column in queue.md | Concurrency note 1 says "don't race"; UUID-based assignee would solve | Add Assignee column to queue.md v2 schema |
| Three role-naming vocabularies | Match `queue.md` Role column at runtime | Unify in v0.6 |
| MANIFEST.md template severely outdated | Don't copy from llm-hopper template; write fresh per project | Rewrite template to match dogfood-emergent format |
| No `pong` / receipt confirmation for Strategy → Leader handoff | Convention: Leader writes ack line in HOPPER-FEEDBACK | Formalize ack file |
| `<task-id>-rework-N.md` filename not in PING.md | This guide §5 documents convention | Add to PING.md §Leader Review verdict actions |

**Why freeze**: per strategic decision 2026-05-14, the protocol stays at v5 for 6 months to (a) accumulate dogfood validation, (b) prevent feature creep toward octopus-style complexity, (c) keep IP/essay focus stable. v0.6 design happens 2026-08-15 earliest.

---

## 10. Glossary

- **`.hopper/`** — protocol package directory; travels with project
- **Anchor** — stable section ID written as `Anchor: \`file.md::section-name\``; used by other docs to cite
- **AGENTS.md (root)** — Codex CLI bootstrap pointer; not same as `.hopper/agents/AGENTS.md` (role binding)
- **CLAUDE.md (root)** — Claude Code bootstrap pointer
- **Dogfood** — using hopper to coordinate work on a real project (typically `myWriteAssistant`)
- **GEMINI.md (root)** — Gemini CLI bootstrap pointer
- **handoff** — A file in `.hopper/handoffs/` that transfers information between roles
- **HOPPER-FEEDBACK.md** — Project-level durable insight log; can be appended by any role
- **Implicit pong** — Step 3 lock (queue status flip); the closest thing to an ack signal in v5
- **manifest cursor** — `.hopper/MANIFEST.md` Current Phase section; single source of truth for "where are we"
- **PING.md** — Canonical protocol spec; frozen v5 through 2026-11-15
- **Pop** — Worker action of fetching next task (`ping`)
- **Push** — Leader action of adding task (edit `queue.md`)
- **Queue** — `.hopper/queue.md`; markdown table tracking task state
- **Round** — Dogfood-level grouping of related tasks; e.g. "Round 1" = initial provider abstraction, "Round 2" = cost-skew pair-mode validation
- **Sidecar** — Builder-pair polish review after substantive Builder done
- **Strategy** — Optional layer above Leader; observer/supervisor; convention not in PING v5
- **Worker** — Any non-Leader, non-Strategy role that pops tasks (Builder / Builder-UI / Executor / Critic / Researcher)

---

## Origin and status

This guide was written 2026-05-17 after a protocol completeness audit during myWriteAssistant Round 2 dogfood. The audit found 5 documented patterns (PING v5), 5 implicit/scattered patterns, and 7 fully-undocumented-but-in-use patterns (Strategy role, escalation files, sidecar, etc.). This guide documents all 17 patterns in one reference; PING.md remains the canonical spec for the 5 documented protocol-level patterns.

Future updates: any change to the documented-but-not-in-PING patterns lives here. Any change to PING-level protocol primitives requires PING.md v0.6 bump, scheduled no earlier than 2026-08-15.
