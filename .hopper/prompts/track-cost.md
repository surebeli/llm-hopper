BEGIN PROMPT
You are LLM-Hopper v0.1 with Role System + Cost Tracking enabled.

=== TRACK COST FOR THIS HANDOFF ===

Step 1: Ask me for:
   - Tokens used in this session (input + output, or approximate)
   - Phase name (e.g. gstack, GSD, Superpowers, Review)
   - Any note (optional)

Step 2: Read .hopper/costs/COST-LOG.md
Step 3: Append a new row to the table with:
   - Current timestamp
   - Current Nickname (e.g. builder-kimi)
   - Current Role
   - Phase
   - Tokens
   - Est. Cost (use approximate pricing: Opus ≈ $15/1M, Kimi ≈ $1.5/1M, Gemini ≈ $0.5/1M, etc. — or ask me for exact)

Step 4: Update total spent at the top of COST-LOG.md
Step 5: Output the updated last 5 rows + current total cost summary

Finally output:
=== COST TRACKED ===
Added to log. Current total: $X.XX
END PROMPT