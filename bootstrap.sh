#!/bin/bash

# Bootstrap script for initial setup

set -euo pipefail

detect_os() {
  case "$(uname -s)" in
    Darwin) echo "darwin" ;;
    Linux)  echo "linux" ;;
    *) echo "unsupported"; exit 1 ;;
  esac
}

main() {
  OS=$(detect_os)
  echo "[*] OS: $OS"

  # 安裝 GNU stow
  if ! command -v stow >/dev/null 2>&1; then
    if [ "$OS" = "darwin" ]; then
      command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brew install stow
    else
      if command -v apt >/dev/null; then sudo apt update && sudo apt install -y stow;
      elif command -v dnf >/dev/null; then sudo dnf install -y stow;
      elif command -v pacman >/dev/null; then sudo pacman -S --noconfirm stow;
      else echo "Please install stow manually"; exit 1; fi
    fi
  fi

  DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  "$DOTFILES_ROOT/install.sh" "$OS"
}

main "$@"
