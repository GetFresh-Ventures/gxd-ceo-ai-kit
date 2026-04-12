# EngineClaw Autonomous Task: The Night Shift

**Cron Schedule**: `0 2 * * *` (Run daily at 2:00 AM)  
**Context Bindings**: `~/gtm-brain`, `~/ceo-brain`  

## Objective
Proactively audit the CRM pipeline for stalled deals and draft rescue communications so the CEO can approve them immediately upon their morning login.

## Execution Instructions

### Phase 1: Pipeline Audit
1. Execute the `skills/pipeline-pulse` protocol to retrieve the latest state of the pipeline from the Proactive Intelligence Layer (PIL).
2. Cross-reference HubSpot data with `~/gtm-brain/pipeline.md` to identify deals stagnant for >5 days.
3. Query `gfv_memory.db` for meeting transcripts or last-contact details related to these stagnant entities.

### Phase 2: Draft Generation
1. Utilize `skills/email-composer` to draft a follow-up ("rescue") email for up to 3 of the most critical stalled deals.
2. Adhere strictly to the `~/ceo-brain/voice-model.md` for tone, formatting, and brevity.

### Phase 3: Stage Approvals
1. Create directory `~/gtm-brain/pending_approvals/` if it does not exist.
2. Save each draft email as a structured markdown file within the `pending_approvals` directory (e.g., `deal_rescue_acme_corp.md`).
3. Include the "Reason for drafting" and the "Context/Transcript snippet" at the top of the file so the CEO has full visibility before approving.
4. Terminate execution and sleep. Do NOT dispatch the emails autonomously.
