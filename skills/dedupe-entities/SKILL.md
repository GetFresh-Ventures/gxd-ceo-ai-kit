---
name: dedupe-entities
description: Mathematically resolve duplicate entities in CSV datasets using machine-learning record linkage.
category: infrastructure
trigger_phrase: "run entity resolution"
---

# `dedupe-entities`

**Context:** The Proactive Intelligence Layer (PIL) suffers from Entity Fragmentation when CRM and backend datasets spell names slightly differently (e.g., "Golden Rule" vs "Golden Rule PHC"). This skill provides an interactive active-learning terminal utility to train a deduplication model and output a cleaned dataset.

## Execution Rules

1. Ensure the user has the Python dependencies installed:
   ```bash
   pip install dedupe
   ```
2. Request the target CSV the user wishes to deduplicate, and ask which exact fields should act as the matching bounds (e.g., `"Company Name"` and `"Contact"`).
3. If dependencies and user input are provided, instruct the user to run the specific command below. **You MUST ask the user to manually run this in their terminal because it is a highly interactive prompt that requires manual key presses (y/n/u/f). You cannot answer active-learning prompts on the user's behalf!**

   Provide exactly this string to the user:
   ```bash
   python tools/gfv-dedupe.py --input [FILE.csv] --output [deduplicated_FILE.csv] --fields "Column1" "Column2"
   ```
4. Wait for the user to complete the terminal active-learning flow.
5. Once the resulting output CSV is produced, you may read it back into context to analyze the merged `GFV_Cluster_ID` blocks if the user requests it.
