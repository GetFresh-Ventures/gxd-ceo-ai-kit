#!/usr/bin/env python3
"""
GFV Execution Telemetry Module
Tracks CEO interactions, session durations, and error rates using a local SQLite schema.
"""

import os
import sys
import sqlite3
import argparse
from pathlib import Path
from datetime import datetime

TELEMETRY_DB = Path.home() / ".claude" / "gfv-telemetry.db"

def init_db():
    TELEMETRY_DB.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(TELEMETRY_DB)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS sessions (
            session_id TEXT PRIMARY KEY,
            start_time TEXT,
            end_time TEXT,
            level TEXT,
            status TEXT
        )
    ''')
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            session_id TEXT,
            timestamp TEXT,
            event_type TEXT,
            details TEXT,
            status TEXT
        )
    ''')
    conn.commit()
    conn.close()

def log_session(session_id, action, level="unknown", status="running"):
    init_db()
    conn = sqlite3.connect(TELEMETRY_DB)
    cursor = conn.cursor()
    
    timestamp = datetime.utcnow().isoformat()
    
    if action == "start":
        cursor.execute(
            "INSERT OR REPLACE INTO sessions (session_id, start_time, level, status) VALUES (?, ?, ?, ?)",
            (session_id, timestamp, level, status)
        )
    elif action == "stop":
        cursor.execute(
            "UPDATE sessions SET end_time = ?, status = ? WHERE session_id = ?",
            (timestamp, status, session_id)
        )
        
    conn.commit()
    conn.close()

def log_event(session_id, event_type, details="", status="success"):
    init_db()
    conn = sqlite3.connect(TELEMETRY_DB)
    cursor = conn.cursor()
    
    timestamp = datetime.utcnow().isoformat()
    cursor.execute(
        "INSERT INTO events (session_id, timestamp, event_type, details, status) VALUES (?, ?, ?, ?, ?)",
        (session_id, timestamp, event_type, details, status)
    )
    
    conn.commit()
    conn.close()

def dump_stats():
    if not TELEMETRY_DB.exists():
        print("No telemetry data found.")
        return
        
    conn = sqlite3.connect(TELEMETRY_DB)
    cursor = conn.cursor()
    
    cursor.execute("SELECT COUNT(*) FROM sessions")
    total_sessions = cursor.fetchone()[0]
    
    cursor.execute("SELECT COUNT(*) FROM events")
    total_events = cursor.fetchone()[0]
    
    print(f"📊 Total Sessions: {total_sessions}")
    print(f"📈 Total Events: {total_events}")
    
    conn.close()

def main():
    parser = argparse.ArgumentParser(description="GFV Telemetry Tracker")
    parser.add_argument("action", choices=["start", "stop", "event", "stats"], help="Action to perform")
    parser.add_argument("--session", default="unknown", help="Session ID")
    parser.add_argument("--level", default="unknown", help="Executive level")
    parser.add_argument("--type", default="hook", help="Event type")
    parser.add_argument("--details", default="", help="Event details")
    parser.add_argument("--status", default="success", help="Event status")
    
    args = parser.parse_args()
    
    if args.action == "start":
        log_session(args.session, "start", args.level, args.status)
    elif args.action == "stop":
        log_session(args.session, "stop", status=args.status)
    elif args.action == "event":
        log_event(args.session, args.type, args.details, args.status)
    elif args.action == "stats":
        dump_stats()

if __name__ == "__main__":
    main()
