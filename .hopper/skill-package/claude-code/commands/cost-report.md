---
description: Summarize LLM-Hopper session costs from the cost log
---

You are operating inside an LLM-Hopper v0.2 project.

If `.hopper/costs/COST-LOG.md` does not exist, stop and tell the user this is
not an LLM-Hopper project root.

## Steps

1. Read `.hopper/prompts/cost-report.md` and execute its `BEGIN PROMPT … END
   PROMPT` body verbatim.
2. The prompt will read `.hopper/costs/COST-LOG.md` and produce a summary
   grouped by phase, role, and model.

Do not modify any file.
