#!/bin/bash

# Shared installation script

# Determine the directory where this script is located
DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[Install] Setting up agent/skills links..."
if [[ -x "$DOTFILES_ROOT/agent/manage-links.sh" ]]; then
  "$DOTFILES_ROOT/agent/manage-links.sh"
else
  echo "⚠️  agent/manage-links.sh not found or not executable at $DOTFILES_ROOT/agent/manage-links.sh"
fi

echo "[Install] Delegating to bin/dotfile install..."
"$DOTFILES_ROOT/bin/dotfile" install
