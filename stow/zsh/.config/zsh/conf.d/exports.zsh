# ==============================================================================
#  ENVIRONMENT VARIABLES & PATHS
# ==============================================================================

# Homebrew
[[ -z "$HOMEBREW_PREFIX" && -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# PATH additions (只添加存在的目錄)
path_dirs=(
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/dotfiles/bin"
  "$HOME/miniconda3/bin"
  "$HOME/fvm/default/bin"
  "$HOME/.pub-cache/bin"
  "$HOME/development/cproject/bin"
)
for dir in $path_dirs; do
  [[ -d "$dir" ]] && export PATH="$dir:$PATH"
done

# VCPKG
[[ -d "$HOME/development/cproject/vcpkg" ]] && {
  export VCPKG_ROOT="$HOME/development/cproject/vcpkg"
  export PATH="$VCPKG_ROOT:$PATH"
}

# Editor & Pager
export EDITOR='nvim' VISUAL='nvim'
command -v bat >/dev/null && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Terminal
export CLICOLOR=1 TERM=xterm-256color
