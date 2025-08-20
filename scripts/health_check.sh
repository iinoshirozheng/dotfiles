#!/bin/bash

# Health check script
set -euo pipefail

echo "Checking system health..."

# Example checks
echo "Disk usage:"
df -h

echo "Memory usage:"
free -h
