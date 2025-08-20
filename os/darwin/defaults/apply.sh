#!/bin/bash

set -euo pipefail
echo "[*] Applying macOS defaults..."

defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write com.apple.dock autohide -bool true
killall Dock || true

echo "[*] macOS defaults applied."
