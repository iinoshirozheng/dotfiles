#!/bin/bash

# Shared installation script

echo "[Install] Installing fonts..."
if [[ $(uname -s) == "Darwin" ]]; then
  bash ./os/darwin/fonts/install.sh
else
  echo "[Install] Skipping fonts installation for non-macOS systems."
fi

echo "[Install] Installing common tools..."
if [[ $(uname -s) == "Darwin" ]]; then
  brew bundle --file=./Brewfile
elif [[ -f ./os/linux/apt.txt ]]; then
  xargs -a ./os/linux/apt.txt sudo apt install -y
fi

./bin/dotfile link
