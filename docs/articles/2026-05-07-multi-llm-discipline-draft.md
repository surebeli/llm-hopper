# Multi-LLM coordination as a discipline, not a framework

> **Status**: Draft v0 — first draft from dogfood evidence. Will polish before HN submission.
> **Date**: 2026-05-07
> **Word count**: ~2900

## What I learned shipping a 13-task multi-LLM dogfood in 2 days

Two days ago I started dogfooding a coordination protocol called `llm-hopper` on a real product (a writing assistant called myWriteAssistant). The numbers as of this morning:

- **13 tasks shipped** through the protocol's full lifecycle
- **7 LLM roles** (Researcher, Leader, Critic, Builder, Builder-UI, two Executors)
- **6 different LLMs / CLIs** (Claude Opus, Claude Code, GPT-5.5 Codex, Gemini 3.1 Pro, Kimi 2.6, DeepSeek-V4-Flash)
- **~$2.20 total cost** across all roles
- **4 protocol schema bumps** (v1 → v5), each tied to a real bug the protocol failed to anticipate
- **All 5 Critic-batch findings closed**, including 2 production-only bugs that mock tests + Critic batch + Leader review *all* missed and only live smoke against real upstream caught

This isn't a thought piece. The git history is public on `surebeli/llm-hopper` and `surebeli/myWriteAssistant`; every claim below is grounded in a commit hash you can read.

What I want to share is the counterintuitive lesson dogfood produced: **multi-LLM coordination isn't a framework problem. It's a discipline problem.** Most existing harnesses (OMC, OMO, OpenCode) try to solve it by writing more code. The interesting move is to write less code and impose more discipline — at least until you understand what discipline you actually need.

---

## The vendor-agnostic premise

Why coordinate multiple LLMs at all? In 2024-2026, the answer stopped being theoretical:

- Anthropic adjusted Pro/Max quota and tool policies at least three times
- OpenAI API regional availability fluctuated; some models got deprecated faster than docs caught up
- DeepSeek / Kimi / GLM remain geo-fenced for users outside China
- Gemini features got region-gated
- "I had a CLI that worked yesterday and broke today because of a vendor decision" became a normal sentence

If your entire AI workflow runs through one vendor's CLI, every policy change forces you to relearn. Vendor diversification isn't paranoia — it's the same hedging logic that made multi-cloud sane for infrastructure people in the 2010s.

But coordination across vendors has its own failure modes. Existing solutions split into:

1. **Plugin harnesses** (OMC for Claude Code, OMO for OpenCode): high feature surface, lock you into one host platform
2. **API gateways** (OpenRouter, LiteLLM): single-call routing, no agent coordination
3. **Code-first frameworks** (LangGraph, CrewAI, AutoGen): rich abstractions for developers building products, not for users coordinating their own work

I wanted something in the gap: **a protocol thin enough that any LLM CLI can participate, structured enough that the multi-step coordination is reproducible, and host-agnostic enough that it survives vendor policy changes.**

That's `llm-hopper`. The implementation is three markdown files.

---

## The protocol

I'll spare you the full text. The shape:

```
.hopper/
├── PING.md       # protocol — what does ping mean
├── queue.md      # state — task table with Status / Depends / Priority
└── handoffs/
    ├── <task-id>-output.md          # Worker → Leader feedback file
    └── <task-id>-leader-feedback.md # Leader → Worker (in-progress) channel
```

Plus per-CLI bootstrap files at the repo root (`CLAUDE.md` / `GEMINI.md` / `AGENTS.md`) that just say "if user types `ping`, follow `.hopper/PING.md`."

The user types `ping` in any LLM CLI session. The Worker (whatever role this session is playing) reads queue.md, picks the next eligible task by priority + lex order, edits queue.md to lock the task, executes it, runs sanity checks, marks done, writes a structured output.md, appends a cost log row, and atomic-commits everything in a single git commit prefixed `[<task-id>]`.

That's 10 steps. The user types one word.

When the protocol works, that's literally what happens. I'll come back to when it doesn't.

---

## Layered discovery: the strongest finding

If you take one thing from this essay, take this:

**Single-LLM review is insufficient, even at the highest tier.** A Claude Opus session reviewing its own spec misses things a fresh GPT-5.5 session catches in 5 minutes. A GPT-5.5 Builder writing code finds errors that Researcher and two Critic sessions all glossed over. Live smoke against the real upstream provider catches what mock tests can't, no matter how thorough.

These aren't anecdotes — they're the spine of what 2 days of dogfood produced.

### Concrete examples

**Researcher missed SDK version drift.** I (Leader, Claude Opus) wrote a v0.2 spec that referenced `LanguageModelV1` from `@ai-sdk/provider`. The Researcher (Gemini 3.1 Pro Preview) read the entire codebase + spec and reported back a 3000-word audit. It didn't catch that the actual installed SDK was 5.x, which uses `LanguageModelV2`. Two Critic sessions (GPT-5.5 Codex) reviewed the spec next; they didn't catch it either. The Builder (GPT-5.5 Codex) caught it the moment they tried to import: their first commit message includes "spec said V1 incorrectly, builder corrected during execution." Each layer reads at a different focal length. Spec reviewers look at contracts; coders look at imports.

**Critic v0 caught structural holes; Critic v1 caught contract execution gaps.** The same model (GPT-5.5 Codex) in two separate fresh sessions reviewed the same spec at different revisions. v0 found 12 issues — almost all about missing contracts (capability flags with no executable behavior, no `requestId` field, no error sanitizer scope). I revised the spec, asked v1 to review again. v1 found 11 different issues — almost all about contract execution (the new sanitizer regex misses bare `sk-...` keys; the OpenAI provider is declared in `STABLE_PROVIDER_IDS` but no adapter task exists; client hooks still post the old body shape). The two reviews complemented; neither alone was sufficient. **The remaining-hole distribution shifts after each revision, and you need a fresh reviewer to see the new shape.**

**Critic batch caught what Leader review completely missed.** As Leader, I had reviewed each Builder task individually (`review T02`, `review T04`, etc.) with `accept (strong)` verdicts. Then I dispatched a Critic batch review of the T01-T04 batch. Critic returned `REWORK before landing`. Three findings I'd missed entirely:

1. Routes after T02 require `providerConfig` in body — but the existing client hooks (`use-chat.ts`, `use-proactive.ts`) still posted the old body shape. The UI was a 400-on-every-message bomb. I'd checked the backend grep allow-list but not the client wiring.
2. `STABLE_PROVIDER_IDS` includes "openai" but no OpenAI adapter exists or is queued. The 5-stable smoke gate would never pass. I wrote the spec saying 5 providers but only queued 4 adapter tasks.
3. The error sanitizer regex covers `Bearer ...` and `api_key=...` but not bare `sk-...` or natural-language forms like `"Incorrect API key provided: sk-secret-token"`. AC9 (key absent from error responses) had a real production leak path.

I had read these files. I'd reviewed each task. I'd given strong-accept verdicts. As the spec author, I had confirmation bias — I trusted what I'd written. A fresh reviewer with no spec-writing memory caught it in 10 minutes for $0.65.

**Live smoke caught what every static review missed.** This is the deepest finding. T02 implementation passed mock tests, AC1 grep, AC2 integration tests, AC16 capability dispatch tests. Critic batch reviewed it and found new issues but not adapter routing. Leader strong-accepted T02-rework after the fix. Then we did manual verification: configure Doubao, send "hello", see if Chat panel works. The test failed. Twice. Once because @ai-sdk/openai 5.x defaults to OpenAI's new `/responses` endpoint, which Doubao doesn't support — the Doubao adapter needed `provider.chat()` to force `/chat/completions` routing. Then once more because the route returned `result.toTextStreamResponse()` (plain text) but the client expected Vercel AI SDK's data stream protocol (`0:"text"\n` chunks). Two production-only bugs, neither catchable by mock tests no matter how thorough.

### What this means

A reasonable inference from these data points:

- **Each LLM and each role sees a different cone.** Researcher reads contracts; Coder reads imports; Critic looks for structural gaps; Live smoke catches wire-level mismatches.
- **Adversarial framing matters.** The Critic prompt explicitly asks "find what's wrong"; the Leader review prompt asks "is this acceptable?" Different framings produce different sensitivity.
- **Fresh sessions matter.** Critic v0 and v1 were the same model in different sessions; they found different issues partly because v1 didn't carry v0's mental model of "what's already been checked."
- **Mock tests have hard limits.** They verify what you encoded; they can't verify what you didn't think to encode. Live integration is non-negotiable for adapter-touching code.

This is the discipline argument: coordinating 4-7 LLMs across roles isn't redundant. The protocol routes work to layers that catch different bug classes, and the cumulative coverage exceeds what any single layer can produce. Single-LLM coordination, even with multiple sessions of the same model, can't replicate the layering benefit.

---

## Cost reality: the 200x differential is real

I'd assumed multi-LLM routing would save 30-50% on token costs. The dogfood numbers are more dramatic.

Per-task cost across the 13 done tasks (token in/out, approximate USD):

| Task | Role | LLM | Tokens (k in / k out) | Cost |
|------|------|-----|----------------------|------|
| T01 | Builder | GPT-5.5 Codex | 22 / 3.5 | ~$0.20 |
| T02 | Builder | GPT-5.5 Codex | 30 / 4.8 | ~$0.30 |
| T02-rework (3-round) | Builder | GPT-5.5 Codex | 105 / 13 | ~$0.85 |
| T03 | Builder | GPT-5.5 Codex | 26 / 4.2 | ~$0.25 |
| T-EXE-1 (JSDoc, 8 files) | Executor | Kimi 2.6 | 18 / 3.5 | **~$0.03** |
| T-EXE-2 (README section) | Executor | DeepSeek-V4-Flash | 15 / 2 | **~$0.001** |
| critic-v1 (spec review) | Critic | GPT-5.5 Codex | 30 / 4.5 | ~$0.25 |
| T15 (batch critic review) | Critic | GPT-5.5 Codex | 90 / 6.5 | ~$0.65 |

The per-task cost differential between the cheapest tier (DeepSeek V4 Flash) and the most expensive tier (GPT-5.5 Codex on a complex task) is **roughly 200x**. The quality differential on the kinds of work I gave each tier — JSDoc comments for Kimi, single-file README expansion for DeepSeek-Flash — was negligible to invisible. Both produced clean, technically accurate output that followed the protocol exactly.

The implication: most existing multi-LLM tools that route based on "task complexity" are leaving real money on the table. Routing on actual cost-per-quality differential would change ~$0.05 to ~$0.001 for a non-trivial fraction of work.

What did the rough $2.20 buy? Roughly: a refactor from a single-vendor (Doubao) Next.js + Tauri writing assistant into a vendor-agnostic provider abstraction with three registered adapters (Doubao, Claude, OpenAI), full client wiring, error sanitization, integration tests for the protocol, and a documented coordination protocol that itself iterated through four schema bumps based on discovered gaps.

I'm not sure what an ARC-Solo solo developer would estimate this work at if they were paid by the hour. But $2.20 of LLM tokens is a price point that changes the calculus of whether to even start.

---

## Protocol evolution: 4 schema bumps in 2 days

Each bump was triggered by a real bug the protocol failed to anticipate.

**v1 → v2 (Atomic commit step added).** A Builder finished T01, marked it done, but didn't commit. Working tree piled up, future tasks would have rebased into a knot. The protocol had no rule that "done in queue + commit on disk must atomically agree." v2 added Step 9 (Atomic commit) and the rule that commit failure means the task isn't done.

**v2 → v3 (Output artifact + Leader Review Protocol).** I noticed I was manually copying Builder's CLI report into the Leader session every time I wanted to review work. The protocol had a Worker→Leader feedback loop, but the channel was the user's clipboard. v3 made `<task-id>-output.md` mandatory and added the `review <task-id>` form so Leader reads from disk instead of asking the user to paste.

**v3 → v4 (Refresh shared state + scope-qualify acceptance).** Two bugs surfaced. First: I (Leader) edited `queue.md` to add new tasks; the Edit tool worked from a stale snapshot, and an unrelated row got reverted. Builder Codex then refused to pop a task because its dependency appeared unmet — protocol working as designed, even though Leader had created the inconsistency. Second: a Builder created `tests/unit/claude-adapter.test.ts` mid-task without committing yet; a sibling Executor session running `tsc --noEmit` for its own acceptance saw the orphaned test file and broke. v4 added Step 0.5 (refresh shared state before each ping) and changed Step 6 to scope-qualify acceptance to task-touched files.

**v4 → v5 (Eliminate prose dispatch).** The user pointed out that I was writing long natural-language instructions to Builder ("manual verify failed: Doubao 403, fix is..." / "do T-SANITIZER-FIX next, not T-OPENAI"). The protocol design said `ping` should be a single word; somehow it had grown into multi-paragraph dispatches. Diagnosis showed 5 prose dispatches in a single task cycle (T02-rework), and 3 of those were fixable by protocol additions: Step 0.5 should re-read PING.md (so schema bumps don't require manual nudge), `ping --task=<id>` form (so task priority overrides don't need prose), and a Leader Feedback Channel as a structured file (so manual-verify diagnosis becomes auditable artifact instead of chat history).

The lesson here isn't "the protocol got better." Every protocol gets better with iteration. The interesting lesson is **how many gaps a protocol designer literally cannot anticipate**. v1 looked complete on paper. Two days of dogfood revealed 4 layers of unconsidered cases. If I'd shipped llm-hopper as a finished design, I'd have shipped 4 protocol bugs simultaneously.

---

## What this is and isn't

`llm-hopper` is a discipline + 3 markdown files. The total code in the protocol layer is about 800 lines of markdown. It's vendor-agnostic by design. It's been validated against Claude Code, Codex CLI, Gemini CLI, Kimi (web), and DeepSeek (web). It's MIT licensed.

It is not:
- Another multi-agent harness — those exist (OMC, OMO, myclaude, OpenCode plugins) and many are technically superior for users who've committed to one host platform
- A daemon or runtime — there's no process to install, no port to bind. You write three markdown files, your LLMs follow them
- An orchestrator that makes decisions for you — Leader is a role you (or a session you assign) plays; the protocol structures the *handoff*, not the *thinking*

Its argument is small: if you already have multiple LLM subscriptions and you're already coordinating them by hand, here's a way to make the coordination structured, file-system-backed, and reproducible. The first time you run it, the friction is real. By the third or fourth task, the friction is gone, and what's left is the actual coordination work — which is intrinsic to multi-LLM, not protocol overhead.

---

## What's next

Three follow-up essays planned, in order of conviction:

1. *Where every multi-LLM harness in 2026 hides your money* — about cost observability. OMC says "30-50% cheaper" but provides no user-visible breakdown. OMO doesn't surface cost at all. The dogfood produced 13 rows of real cost data; the upstream tools have nothing comparable.
2. *Live smoke against real upstream is non-negotiable for adapter code* — about the production-only bugs caught by manual verify in T02-rework. Mock tests pass things they shouldn't.
3. *Why your AI workflow is one policy change away from breaking* — vendor-agnostic from the policy-risk angle. Less technical, more strategic.

The protocol itself is at v5. v0.3 release of llm-hopper goes out when I have the energy to write the README in English.

If any of this resonates, the dogfood case study is at `github.com/surebeli/myWriteAssistant`, branch `feat/hopper-dogfood`. The full HOPPER-FEEDBACK.md log of 5 applied protocol patches, 9 proposed improvements, and 12 essay-quality observations is in `.hopper/HOPPER-FEEDBACK.md` of that branch. The `llm-hopper` protocol itself is at `github.com/surebeli/llm-hopper`.

The whole setup cost me $2.20 in API tokens to get to this essay. Every commit is timestamped, signed, and public. If you find a flaw in the discipline argument, the evidence to challenge it is in the same repo.

---

*Author: surebeli (litianyi). May 2026.*

*This essay was written using llm-hopper itself: outline drafted by Leader (Claude Opus 4.7), competing perspectives proposed by Critic (GPT-5.5 fresh session), final pass by Drafter (also Claude). Cost: another ~$0.40 across the writing roles. Yes, that's also in the COST-LOG.md.*
