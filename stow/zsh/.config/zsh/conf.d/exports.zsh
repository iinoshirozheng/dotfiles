# ==============================================================================
#  ENVIRONMENT VARIABLES & PATHS
# ==============================================================================

# --- Homebrew (最重要，必須先載入) ---
if [[ -z "$HOMEBREW_PREFIX" ]] && [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export BREW_PREFIX=$(brew --prefix)
fi

# --- Antigravity ---
if [ -d "$HOME/.antigravity/antigravity/bin" ]; then
  export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi

# --- Dotfiles Bin ---
# 為了讓 dotfile 指令可用
export PATH="$HOME/dotfiles/bin:$PATH"

# --- Miniconda (Python 環境) ---
if [ -d "$HOME/miniconda3/bin" ]; then
  export PATH="$HOME/miniconda3/bin:$PATH"
fi

# --- Flutter SDK (透過 FVM 管理) ---
if [ -d "$HOME/fvm/default/bin" ]; then
  export PATH="$HOME/fvm/default/bin:$PATH"
fi

# --- Dart / Firebase (Pub cache) ---
if [ -d "$HOME/.pub-cache/bin" ]; then
  export PATH="$HOME/.pub-cache/bin:$PATH"
fi

# --- cproject Environment ---
# 使用 $HOME 代替絕對路徑以提高可攜性
if [ -d "$HOME/development/cproject/bin" ]; then
  export PATH="$HOME/development/cproject/bin:$PATH"
fi

if [ -d "$HOME/development/cproject/vcpkg" ]; then
  export VCPKG_ROOT="$HOME/development/cproject/vcpkg"
  export PATH="$VCPKG_ROOT:$PATH"
fi

# --- Man Pager ---
# Use bat as manpager for syntax highlighting
if command -v bat >/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# --- Editor ---
export EDITOR='nvim'
export VISUAL='nvim'

# --- Terminal Colors ---
export CLICOLOR=1
export TERM=xterm-256color
