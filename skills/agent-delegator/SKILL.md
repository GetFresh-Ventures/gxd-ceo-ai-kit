---
name: agent-delegator
description: Exposes ThreadPool sub-agent delegation to prevent context window contamination when performing parallel or highly iterative lookup tasks.
---

# Agent Delegator 

This skill brings Hermes' `subagent_delegate.py` thread-isolation capabilities into the CEO Kit. 

## When to Use

You are tasked with reading or analyzing an enormous corpus of text (e.g., 20 different web pages, 10 previous memory transcripts, or thousands of rows).
Processing this inside your single running execution window will pollute your context, slow down your core thought loops, and risk exceeding token limits.

Instead, route sub-tasks to detached thread pools.

## How to Execute

You do not run `subagent_delegate.py` from CLI directly; instead, utilize it within Python automation scripts when isolating intelligence extraction.

```python
import sys
import os

# Import the Hermes Subagent delegate ported into GFV-Brain
sys.path.append("/Users/dirajgoel/Documents/Code/gfv-brain/scripts")
from subagent_delegate import delegate_task, list_subagents

# Farm off an expensive operation asynchronously
task_id = delegate_task(
    "Open 15 competitor pages, summarize their pricing, and return a structured JSON block.", 
    context={"scope": "pricing"}
)

# You can fetch the result later rather than blocking the main CEO agent
```

*Note: The native `subagent_delegate.py` calls an isolated `claude -c` process barrier.*


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
