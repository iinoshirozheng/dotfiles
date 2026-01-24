#!/bin/bash

# Shared installation script

echo "[Install] Setting up agent/skills links..."
if [[ -x ./agent/manage-links.sh ]]; then
  ./agent/manage-links.sh
else
  echo "⚠️  agent/manage-links.sh not found or not executable"
fi

echo "[Install] Delegating to bin/dotfile install..."
./bin/dotfile install
