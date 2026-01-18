# ==============================================================================
#  ENVIRONMENT VARIABLES & PATHS
# ==============================================================================

# --- Antigravity ---
if [ -d "$HOME/.antigravity/antigravity/bin" ]; then
  export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi

# --- Dotfiles Bin ---
# 為了讓 dotfile 指令可用
export PATH="$HOME/dotfiles/bin:$PATH"

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
