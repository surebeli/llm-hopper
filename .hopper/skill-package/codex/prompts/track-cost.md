# /track-cost — Record this session's tokens and cost into LLM-Hopper cost log

You are operating inside an LLM-Hopper v0.2 project.

If `.hopper/costs/COST-LOG.md` does not exist, stop and tell the user this is
not an LLM-Hopper project root.

## Steps

1. Read `.hopper/prompts/track-cost.md` and execute its `BEGIN PROMPT … END
   PROMPT` body verbatim.
2. The prompt will ask the user for tokens, phase, and optional note, then
   append a row to `.hopper/costs/COST-LOG.md` and update the running total.
3. End by printing the last 5 rows and the new total.

Only modify `.hopper/costs/COST-LOG.md`.
