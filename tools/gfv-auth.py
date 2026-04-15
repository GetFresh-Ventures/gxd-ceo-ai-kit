#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess

def fetch_secret(secret_key, op_reference=None):
    """Fetch secret from ENV or 1Password via CLI"""
    # 1. Check local environment variables
    if secret_key in os.environ:
        return os.environ[secret_key]
        
    # 2. Check 1Password if reference is provided
    if op_reference:
        try:
            result = subprocess.run(
                ["op", "read", op_reference],
                capture_output=True,
                text=True,
                check=True
            )
            return result.stdout.strip()
        except FileNotFoundError:
            # 1Password CLI not installed
            pass
        except subprocess.CalledProcessError:
            # Auth expired or invalid reference
            pass
            
    return None

def main():
    parser = argparse.ArgumentParser(description="GFV Secrets API Gateway")
    parser.add_argument("key", help="The secret key name (e.g., LINEAR_API_KEY)")
    parser.add_argument("--op", help="The 1Password op:// reference URL fallback")
    parser.add_argument("--silent", action="store_true", help="Print only the secret if found, else nothing")
    
    args = parser.parse_args()
    
    secret = fetch_secret(args.key, args.op)
    
    if secret:
        print(secret)
        sys.exit(0)
    else:
        if not args.silent:
            print(f"❌ AUTH ERROR: Secret '{args.key}' could not be resolved.", file=sys.stderr)
            if args.op:
                print(f"   Ensure you are logged into 1Password CLI: eval $(op signin)", file=sys.stderr)
            print(f"   Or export {args.key}=<your_token> in your environment.", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
