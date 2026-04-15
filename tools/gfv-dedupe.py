#!/usr/bin/env python3
"""
GFV Entity Sweeper (gfv-dedupe)
Automated fuzzy deduplication and entity resolution CLI.

Installation:
  pip install dedupe

Usage:
  python tools/gfv-dedupe.py --input raw_data.csv --output merged_data.csv --fields "Company Name" "Contact"
"""
import os
import csv
import re
import argparse
import json

try:
    import dedupe
except ImportError:
    print("❌ Critical Dependency Missing. Please run: pip install dedupe")
    exit(1)

def preProcess(column):
    try :
        column = column.decode('utf8')
    except AttributeError:
        pass
    column = re.sub('  +', ' ', column)
    column = re.sub('\n', ' ', column)
    column = column.strip().strip('"').strip("'").lower()
    if not column:
        column = None
    return column

def readData(filename, fields):
    data_d = {}
    with open(filename, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row_id, row in enumerate(reader):
            clean_row = {}
            for col in fields:
                clean_row[col] = preProcess(row[col])
            data_d[row_id] = clean_row
    return data_d

def main():
    parser = argparse.ArgumentParser(description="GFV Entity Resolution using Dedupe")
    parser.add_argument('--input', required=True, help="Input CSV file")
    parser.add_argument('--output', required=True, help="Output deduplicated CSV file")
    parser.add_argument('--fields', required=True, nargs='+', help="Columns to base deduplication on")
    parser.add_argument('--settings', default='dedupe_learned_settings', help="File to store learned settings")
    parser.add_argument('--training', default='dedupe_training.json', help="File to store training data")
    args = parser.parse_args()

    print(f"Loading data from {args.input}...")
    data = readData(args.input, args.fields)
    
    model_fields = [{'field': f, 'type': 'String'} for f in args.fields]
    
    if os.path.exists(args.settings):
        print(f"Reading learned settings from {args.settings}...")
        with open(args.settings, 'rb') as f:
            deduper = dedupe.StaticDedupe(f)
    else:
        print("Training a new deduplication model...")
        deduper = dedupe.Dedupe(model_fields)
        if os.path.exists(args.training):
            print(f"Reading training data from {args.training}...")
            with open(args.training, 'rb') as f:
                deduper.prepare_training(data, f)
        else:
            deduper.prepare_training(data)

        print("\n=======================================================")
        print("Starting Active Learning. Please answer the following prompts:")
        print("y: yes, same entity | n: no, different | u: unsure | f: finished")
        print("=======================================================\n")
        dedupe.console_label(deduper)
        deduper.train()

        with open(args.training, 'w') as tf:
            deduper.write_training(tf)
        with open(args.settings, 'wb') as sf:
            deduper.write_settings(sf)
            
    print("\nClustering records (this may take a moment)...")
    clustered_dupes = deduper.partition(data, 0.5)
    
    print(f"Found {len(clustered_dupes)} duplicate clusters. Writing output to {args.output}...")
    
    with open(args.input, 'r', encoding='utf-8') as f_in, open(args.output, 'w', encoding='utf-8') as f_out:
        reader = csv.DictReader(f_in)
        writer = csv.writer(f_out)
        writer.writerow(reader.fieldnames + ['GFV_Cluster_ID', 'Confidence_Score'])
        
        cluster_lookup = {}
        for cluster_id, (records, scores) in enumerate(clustered_dupes):
            for record_id, score in zip(records, scores):
                cluster_lookup[record_id] = (cluster_id, score)
                
        f_in.seek(0)
        next(reader)
        for row_id, row in enumerate(reader):
            c_info = cluster_lookup.get(row_id, ("Unique", 1.0))
            writer.writerow(list(row.values()) + [c_info[0], c_info[1]])
            
    print(f"✅ Done! Entities have been permanently swept into designated clusters in {args.output}.")

if __name__ == '__main__':
    main()
