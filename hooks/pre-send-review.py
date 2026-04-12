#!/usr/bin/env python3
"""
GFV CEO Enablement Kit — Pre-Send Review Hook
Blocks any outbound email/message from being sent without explicit approval.

Install: Copy to ~/.claude/hooks/pre-send-review.py
Trigger: PreToolUse event (on email/messaging tools)

This hook checks for send/email/message tool calls and ensures
the user has explicitly approved the content.
"""

import os
import sys
import json


def main():
    """
    Check if the current tool call is an outbound communication.
    If so, ensure it's been approved.

    Note: This is a framework — customize for your specific
    email sending tools (Gmail API, SMTP scripts, etc.)
    """

    # Read tool call context from stdin (Claude Code hook protocol)
    try:
        input_data = json.loads(sys.stdin.read())
    except (json.JSONDecodeError, EOFError):
        return  # Not a structured hook call, skip

    tool_name = input_data.get("tool_name", "").lower()

    # List of tool names that represent outbound communication
    send_tools = [
        "send_email",
        "gmail_send",
        "gmail_create_draft",
        "smtp_send",
        "send_message",
        "send_slack",
    ]

    if any(send_tool in tool_name for send_tool in send_tools):
        # Block and require review
        result = {
            "decision": "block",
            "message": (
                "🛑 OUTBOUND COMMUNICATION DETECTED\n\n"
                "Before sending, please:\n"
                "1. Show the full message content for review\n"
                "2. Get explicit 'send it' approval\n"
                "3. Then retry the send\n\n"
                "This is a GFV CEO Enablement Kit safety rule — no autonomous sending."
            )
        }
        print(json.dumps(result))
        sys.exit(0)


if __name__ == "__main__":
    main()
