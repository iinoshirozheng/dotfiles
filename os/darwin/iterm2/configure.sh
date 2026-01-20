#!/usr/bin/env bash
set -euo pipefail

echo "[iTerm2] Configuring preferences..."
# Tell iTerm2 to use the custom preferences from the dotfiles directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${HOME}/.config/iterm2"
# Tell iTerm2 to load the preferences from the custom folder
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

echo "[iTerm2] Preferences configured to load from ${HOME}/.config/iterm2"
