# ==============================================================================
#  ALIASES
# ==============================================================================

# eza (modern ls)
if command -v eza >/dev/null; then
  alias ls='eza --icons'
  alias ll='eza -l --octal-permissions --icons'
  alias la='eza -la --octal-permissions --icons'
  alias lt='eza -T --icons'
fi

# Editor
command -v nvim >/dev/null && alias vi=nvim vim=nvim

# Shell
alias update='source ~/.zshrc'

# System
alias brewup='brew update && brew upgrade && brew cleanup'

# Navigation
alias ..='cd ..' ...='cd ../..' ....='cd ../../..'
alias dot='cd ~/dotfiles' dl='cd ~/Downloads' dt='cd ~/Desktop'

# Git (補充 omz 沒有的)
alias ga='git add' gaa='git add --all'
alias gc='git commit -v' gcm='git commit -m'
alias gco='git checkout' gd='git diff'
alias gst='git status' gp='git push' gl='git pull'

# Ripgrep
if command -v rg >/dev/null; then
  _rg='rg --colors=line:fg:yellow --colors=path:fg:green --colors=path:style:bold --colors=match:fg:red --colors=match:style:bold'
  alias rgg="$_rg --pretty"
  alias rgf='rg --files | rg --color=always'
  alias rgi="$_rg -i"
  alias rgh="$_rg --hidden"
  alias rga="$_rg --hidden --no-ignore"
  alias rgc="$_rg -C 3"
fi
