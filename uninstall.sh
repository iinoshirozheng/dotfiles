#!/bin/bash

# Uninstall script for cleaning up


DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[Uninstall] Unlinking configurations from bin/dotfile..."
"$DOTFILES_ROOT/bin/dotfile" unlink

echo "[Uninstall] Cleaning up Homebrew (macOS only)..."
if [[ $(uname -s) == "Darwin" ]]; then
  brew cleanup
fi

echo "[Uninstall] Done."
