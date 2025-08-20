#!/bin/bash

# Linux post-install script
set -euo pipefail

echo "Running Linux post-install steps..."

# Example: Install additional tools
if command -v apt >/dev/null; then
  sudo apt update && sudo apt install -y htop
elif command -v dnf >/dev/null; then
  sudo dnf install -y htop
elif command -v pacman >/dev/null; then
  sudo pacman -S --noconfirm htop
fi
