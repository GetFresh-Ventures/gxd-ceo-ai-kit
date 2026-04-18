#!/usr/bin/env python3
"""
BlueBubbles API Bridge for GetFresh GTM Enablement Kit
Provides a connector to read and send iMessages via a local BlueBubbles server.
Ported from ElizaOS plugin-bluebubbles architectural constraints.
"""

import os
import sys
import json
import urllib.request
import argparse
from typing import List, Dict

# Defaults
DEFAULT_BB_URL = "http://localhost:1234"

def get_config():
    """Load BlueBubbles configuration."""
    bb_url = os.environ.get("BLUEBUBBLES_API_URL", DEFAULT_BB_URL)
    api_password = os.environ.get("BLUEBUBBLES_API_PASSWORD")
    return bb_url, api_password

def get_recent_messages(limit: int = 20) -> List[Dict]:
    """Retrieve recent messages through BlueBubbles."""
    bb_url, api_password = get_config()
    
    if not api_password:
        return [{"error": "BLUEBUBBLES_API_PASSWORD environment variable not set."}]
        
    url = f"{bb_url}/api/v1/message?password={api_password}&limit={limit}&with=chats"
    
    try:
        from urllib.request import urlopen
        with urlopen(url, timeout=5.0) as response:
            data = json.loads(response.read().decode())
            return data.get("data", [])
    except Exception as e:
        return [{"error": f"Failed to connect to BlueBubbles: {str(e)}"}]

def send_message(chat_id: str, text: str) -> Dict:
    """Send an iMessage through BlueBubbles."""
    bb_url, api_password = get_config()
    
    if not api_password:
        return {"error": "BLUEBUBBLES_API_PASSWORD environment variable not set."}
        
    url = f"{bb_url}/api/v1/message/text?password={api_password}"
    payload = {
        "chatGuid": chat_id,
        "text": text,
        "method": "apple-script"
    }
    
    headers = {"Content-Type": "application/json"}
    
    try:
        from urllib.request import Request, urlopen
        req = Request(url, data=json.dumps(payload).encode('utf-8'), headers=headers)
        with urlopen(req, timeout=5.0) as response:
            return json.loads(response.read().decode())
    except Exception as e:
        return {"error": f"Failed to send message: {str(e)}"}

def main():
    parser = argparse.ArgumentParser(description="BlueBubbles Bridge")
    subparsers = parser.add_subparsers(dest="command")
    
    # Read command
    read_parser = subparsers.add_parser("read", help="Read recent messages")
    read_parser.add_argument("--limit", type=int, default=10, help="Number of messages to fetch")
    
    # Write command
    write_parser = subparsers.add_parser("send", help="Send a message")
    write_parser.add_argument("--chat", required=True, help="Chat GUID")
    write_parser.add_argument("--text", required=True, help="Message text")
    
    args = parser.parse_args()
    
    if args.command == "read":
        messages = get_recent_messages(args.limit)
        print(json.dumps(messages, indent=2))
    elif args.command == "send":
        result = send_message(args.chat, args.text)
        print(json.dumps(result, indent=2))
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
