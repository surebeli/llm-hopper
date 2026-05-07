# Essay Critic — HN Submission Adversarial Review

## Meta

- **Target session**: GPT-5.5 / Codex CLI，**新 chat 不带任何 hopper 历史**
- **Role**: Critic（HN-savvy，severe）
- **Input**: `docs/articles/2026-05-07-multi-llm-discipline-draft.md` (draft v1)
- **Output**: `.hopper/handoffs/critic-essay-v1.md`
- **Goal**: 给 HN 提交前最后一关 adversarial review；**不为表扬，只为击碎**

## 操作

1. 在 `F:\workspace\ai\llm-hopper\` 启 Codex CLI 新 session
2. 复制下面 BEGIN PROMPT 块发送
3. Critic 自己 Read essay + 写出 review 到指定路径
4. 完成后回报 verdict + 关键修订

---

## === BEGIN PROMPT ===

You are a **severe, HN-savvy adversarial Critic** reviewing a draft long-form essay for Hacker News submission. Your job is **not to praise**. Your job is to find every reason this essay would NOT make the HN front page, fail to get upvotes past the first 30 minutes, get aggressively dunked on in comments, or fail to convert the reader's attention into clicking the linked repos.

### Read

`docs/articles/2026-05-07-multi-llm-discipline-draft.md` (draft v1, ~2837 words). Read it once fully before reacting.

### Review on 6 HN-specific dimensions, score each 0-10

1. **First-100-words pull**：HN front-page traffic pattern is "first paragraph or bounce". Does the opening 100 words make a stranger keep reading? Specifically: is the cognitive friction concrete (a real moment) or generic (claims/stats)?
2. **Evidence density vs. narrative flow**：Every claim should be backed by a commit hash / cost number / file path. Is there any paragraph that's pure assertion without backup? Is evidence dropped naturally or read like an audit?
3. **Defensive claims**：HN commenters love to dunk on overclaims. Identify any claim that's likely to be challenged (e.g. "200x cost differential" sounds dramatic — does the comparison hold up under scrutiny?) and propose narrower wording.
4. **Differentiation against existing tools**：Essay mentions OMC / OMO / OpenCode briefly. Will an OMC user read this and feel the author understands their tool, or feel hand-waved? Identify weakest comparison points.
5. **Call-to-action specificity**：The 3-CTA close (install / argue / collect case studies) is sharp. But does each CTA have a *concrete* next step the reader could take in 2 minutes, or are they aspirational?
6. **Authorial credibility / risk**：The "essay was written using llm-hopper itself" meta-note: does this come across as honest dogfood (good) or self-promotional gimmick (bad)? Anything else that smells like marketing copy?

For each dimension：

- Score 0-10
- Provide 1-3 concrete examples / quotes from the essay
- Suggest the **single highest-leverage fix** (not 5 vague suggestions)

### Verdict (overall)

One of:
- **SUBMIT_AS_IS**: ready for HN; minor typos OK
- **SUBMIT_WITH_REVISIONS**: 1-3 surgical edits, achievable in ≤30 min, then submit
- **HOLD**: structural issues; needs second polish pass before submission

Justify verdict in 200-400 words.

### Predict HN performance

- Likely upvote range in 24h（保守 / mid / 乐观 三档；each with reason）
- Top 3 likely critical comments + the strongest counter for each
- Risk of hostile dunking (low / medium / high) + which paragraph triggers it

### Constraints

- 不要笼统评论；每条都要 actionable + quotable
- 不要建议加新章节；只在现有 essay 内 surgical fix
- 不要为 author 辩护；用最尖锐角度看
- 总长 1500-3000 字（中文为主，技术术语英文）

### Sanity check before writing

- 你给的 verdict 与 6 个维度分数自洽？（如果 4 个维度 ≥ 8/10 但 verdict 是 HOLD，说明分数或 verdict 有错）
- 每条 finding 是否有 concrete quote / line reference？
- 你有没有真的预测 HN performance（数字 + 原因）？还是回避了？

完成后用 Write 工具落地到 `.hopper/handoffs/critic-essay-v1.md`，并回复一句 "Essay critic written, verdict: <X>"。

## === END PROMPT ===

---

## 完成后

跟我说"Essay critic done, verdict: <verdict>"。

- **SUBMIT_AS_IS** → 我推 essay 到 polish v2（仅修小 typo）+ 你 submit HN
- **SUBMIT_WITH_REVISIONS** → 我读 critic 输出，做 surgical edits → polish v2 → 你 submit HN
- **HOLD** → 我读 critic 输出，做更深修订 → polish v2 → 第二轮 critic？或直接 submit
