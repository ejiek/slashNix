#!/usr/bin/env python3
import re
import os
import sys

# Make sure the QUTE_FIFO environment variable is set
fifo_path = os.getenv('QUTE_FIFO')
if not fifo_path:
    print("Error: QUTE_FIFO environment variable is not set.", file=sys.stderr)
    sys.exit(1)

def extract_pr_number(url):
    match = re.search(r'/pull/(\d+)', url) # TODO: check repo url
    return match.group(1) if match else None

current_url = os.getenv("QUTE_URL")
sys.stdout.write(f"{current_url}")
pr_number = extract_pr_number(current_url)
if pr_number:
    pr_tracker_url = f"https://nixpk.gs/pr-tracker.html?pr={pr_number}"
    with open(fifo_path, 'w') as fifo:
        fifo.write(f'open {pr_tracker_url}\n')
else:
    with open(fifo_path, 'w') as fifo:
        fifo.write(f":message-error 'PR number not found in URL'\n")

sys.exit(0)
