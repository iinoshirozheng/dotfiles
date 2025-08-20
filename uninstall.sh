#!/bin/bash

# Uninstall script for cleaning up

echo "[Uninstall] Removing stow-managed files..."
cd stow && stow -D zsh starship git tmux wezterm eza nvim

echo "[Uninstall] Cleaning up Homebrew (macOS only)..."
if [[ $(uname -s) == "Darwin" ]]; then
  brew cleanup
fi

echo "[Uninstall] Done."
