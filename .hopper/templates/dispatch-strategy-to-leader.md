# Dispatch Template: Strategy → Leader

Anchor: `.hopper/templates/dispatch-strategy-to-leader.md::root`

> **Principle**: Dispatcher Empathy + Uniform Quality, Scaled Content. See `.hopper/USAGE-GUIDE.md` §3.3.
> **When to use**: Strategy hands off a multi-task phase (P0/P1/P2 closeout, Round transition, strategic pivot) to Leader with authority transfer + escalation contract.
> **Output filename convention**: `.hopper/handoffs/strategy-<YYYY-MM-DD>-<purpose-slug>.md`
> **Expected size**: 200-700 lines for multi-task phases; can be shorter for single-task strategic asks.

---

## How to use this template

1. Copy this entire body (everything below the `---` after this section) into a new file at the path above.
2. Replace every `<placeholder>` with concrete content.
3. Remove any section that genuinely doesn't apply (do not leave empty sections).
4. Run the §10 self-check. Answer YES to all 5 before sending.
5. Tell user the file is written; Leader pops it on next session.

---

# Strategy → Leader handoff: <purpose> (<YYYY-MM-DD>)

Anchor: `.hopper/handoffs/strategy-<YYYY-MM-DD>-<purpose-slug>.md::root`

**From**: Strategy Advisor (<model name>)
**To**: <Leader nickname, e.g. leader-primary>
**Re**: <one-line summary>
**Anchor refs**:
- `.hopper/PING.md`
- `.hopper/MANIFEST.md`
- `.hopper/AGENTS.md`
- <any prior handoff Leader must consume>
- <any spec / plan file>

---

## 1. Background changes (FYI, don't review)

<2-4 paragraphs: external catalysts, competitive intel, prior-round digest, anything Leader needs to know but doesn't need to act on>

**Impact on this dispatch**: <one paragraph tying background to scope>

---

## 2. Authority transfer

### Leader fully authorized to decide:
- <list of operational decisions>
- <task-level retry / pair-selection / sequencing>
- <budget allocation within phase>
- <Critic dispatch>

### Strategy retains decision on (you must ping):
- <hopper repo commits, if applicable>
- <scope expansion beyond this phase>
- <protocol modification proposals>
- <cross-Round transitions>

---

## 3. Task list

For EACH P0/P1/P2 task:

### <task-id> — <one-line purpose>
- **Status**: <queued / needs creation in queue.md>
- **Source**: <file path of spec / prior output>
- **Builder/role candidates**: <model + nickname options>
- **Scope (HARD)**: <what's in / what's out — be explicit>
- **Deliverable**: <output file path + required fields>
- **Verification (Leader self-verify before mark done)**:
  1. <machine-checkable criterion 1>
  2. <machine-checkable criterion 2>
- **Budget**: <≤$X; escalate at 50% over>

---

## 4. Escalation triggers

Sustained Round-level triggers (from `.hopper/handoffs/round-N-plan.md`):
1. <existing trigger 1>
2. <existing trigger 2>

New triggers for this phase:
N+1. <new trigger> — <why now>
N+2. <new trigger> — <why now>

### Ping format (enforced; Strategy rejects ambiguous pings)

Write to `.hopper/handoffs/leader-ping-strategy-<YYYY-MM-DDTHHMM>.md`:

```markdown
**Trigger**: <which #>
**Context**: <2-4 sentences>
**What I tried / decided so far**: <if any>
**What I need from Strategy**: <specific Q, YES/NO preferred>
**Suggested options (if any)**:
- A) ...
- B) ...
**Cost impact**: <$X spent, $Y projected>
**Time impact**: <blocks which tasks for how long>
```

---

## 5. Reporting cadence (non-escalation)

- **After each P0/P1 task done**: 1-line entry in `.hopper/HOPPER-FEEDBACK.md` (task id + cost + 1-2 sentence finding)
- **Phase done**: `.hopper/handoffs/leader-status-<YYYY-MM-DD>-<phase>-done.md` digest (200-400 words)
- **Round done**: triggers escalation #N (Round complete digest)

---

## 6. Negative space (do NOT do)

- ❌ <prohibited action 1>
- ❌ <prohibited action 2>
- ❌ <scope-creep temptation explicitly named>
- ❌ <"do not commit to hopper repo">
- ❌ <"do not touch frozen files like PING.md / queue.md schema">

---

## 7. Suggested phase cursor (optional; push to MANIFEST after ack)

```
**Status**: <new status text>
**Current cursor**: <one-line cursor>
**Next action**: <numbered list>
```

---

## 8. Acknowledge requirement

When you pop this handoff, add to top of `.hopper/HOPPER-FEEDBACK.md`:

```
- <YYYY-MM-DD> Strategy → Leader <purpose> ack'd; will queue <task-ids>; <reporting plan>.
```

Execute after ack. Strategy out.

---

## 9. (Optional) Cost / time projections

<rough $$$ and weeks; for transparency, not enforcement>

---

## 10. Dispatcher self-check (Strategy runs before sending)

Answer YES to all 5. If any NO, fix before sending:

1. **If I were Leader with zero context, could I start each P0/P1 task without further questions?** (Q: Each task has source / deliverable / verification / budget?)
2. **Can Leader know when each task is done without pinging me?** (Q: Acceptance criteria are machine-checkable?)
3. **Can Leader distinguish "in-scope deviation" from "must-escalate blocker"?** (Q: Negative space + escalation triggers are explicit?)
4. **Does Leader know the output shape, file location, and closure mechanism?** (Q: Reporting cadence + handoff filename conventions are stated?)
5. **Does Leader know the current cursor so they don't push tasks out of scope?** (Q: Phase cursor proposal is included?)

---

## 11. (Optional) Reference to prior dispatches

If this handoff supersedes / extends / refines a prior one, cite it:
- Supersedes: <prior file>
- Refines: <prior file>
- Extends: <prior file>
