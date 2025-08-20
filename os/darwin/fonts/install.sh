#!/bin/bash

# Install Nerd Fonts
set -euo pipefail

echo "Installing Nerd Fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
