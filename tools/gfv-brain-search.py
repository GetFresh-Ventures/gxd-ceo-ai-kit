#!/usr/bin/env python3
"""
GFV Native Local Brain (FTS Search)

Replaces external PIL/Vector dependencies with a blazingly fast, 
100% local SQLite FTS5 search engine across the `ceo-brain`.
Allows the Kit to query historical learnings without remote latency.
"""

import os
import sys
import sqlite3
import argparse
from pathlib import Path

# Paths
CEO_BRAIN_DIR = Path(os.environ.get("GFV_CEO_BRAIN", Path.home() / "ceo-brain"))
BRAIN_DB = Path.home() / ".claude" / "gfv-native-brain.db"

def init_db():
    """Initializes the FTS5 virtual tables."""
    BRAIN_DB.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(BRAIN_DB)
    cursor = conn.cursor()
    
    # Create an FTS5 virtual table for lightning fast text search
    cursor.execute('''
        CREATE VIRTUAL TABLE IF NOT EXISTS documents USING fts5(
            filepath,
            content,
            tokenize="porter"
        )
    ''')
    conn.commit()
    return conn

def ingest_directory():
    """Recursively parses all markdown files in ceo-brain and indexes them."""
    if not CEO_BRAIN_DIR.exists():
        print(f"Directory not found: {CEO_BRAIN_DIR}")
        return

    conn = init_db()
    cursor = conn.cursor()
    
    # Wipe the index for fresh ingestion (ideal for cron or session-stop hooks)
    cursor.execute("DELETE FROM documents")
    
    ingested_count = 0
    for path in CEO_BRAIN_DIR.rglob("*.md"):
        if ".git" in str(path):
            continue
        try:
            content = path.read_text(encoding="utf-8")
            cursor.execute(
                "INSERT INTO documents (filepath, content) VALUES (?, ?)",
                (str(path), content)
            )
            ingested_count += 1
        except Exception:
            pass # Skip binary or unreadable files
            
    conn.commit()
    conn.close()
    
    print(f"🧠 Indexed {ingested_count} files into native Local Brain.")

def search_brain(query: str, limit: int = 5):
    """Executes a BM25 ranked FTS query against the Brain."""
    if not BRAIN_DB.exists():
        print("Brain database not initialized. Run `gfv-brain-search.py ingest` first.")
        return
        
    conn = init_db()
    cursor = conn.cursor()
    
    # SQLite FTS5 uses MATCH
    try:
        cursor.execute('''
            SELECT filepath, snippet(documents, 1, '[[', ']]', '...', 20) 
            FROM documents 
            WHERE documents MATCH ? 
            ORDER BY rank 
            LIMIT ?
        ''', (query, limit))
        
        results = cursor.fetchall()
        
        if not results:
            print(f"No results found for: '{query}'")
            return
            
        print(f"🔍 Top {len(results)} results for '{query}':\n")
        for filepath, snippet in results:
            print(f"📄 {filepath}")
            print(f"   {snippet}\n")
            
    except sqlite3.OperationalError as e:
        print(f"Search error (did you use proper syntax?): {e}")
        
    finally:
        conn.close()

def main():
    parser = argparse.ArgumentParser(description="GFV Native Local Brain (FTS)")
    parser.add_argument("action", choices=["ingest", "search"], help="Action to perform")
    parser.add_argument("--query", help="The FTS search query (e.g. 'aprio AND strategy')")
    parser.add_argument("--limit", type=int, default=5, help="Max results to return")
    
    args = parser.parse_args()
    
    if args.action == "ingest":
        ingest_directory()
    elif args.action == "search":
        if not args.query:
            print("❌ Must provide --query with search action")
            sys.exit(1)
        search_brain(args.query, args.limit)

if __name__ == "__main__":
    main()
