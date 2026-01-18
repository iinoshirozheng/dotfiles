# ==============================================================================
#  ALIASES (命令別名)
# ==============================================================================

# -- eza (現代化的 ls) --
if command -v eza >/dev/null; then
  alias ls='eza --icons'
  alias l='eza -bghH --icons'
  alias ll='eza -l --octal-permissions --icons --git'
  alias la='eza -la --octal-permissions --icons --git'
  alias lt='eza -T --icons'
fi

# -- 編輯器 --
if command -v nvim >/dev/null; then
  alias vi=nvim
  alias vim=nvim
fi

# -- 自訂指令 --
alias update='source ~/.zshrc'

# -- System Maintenance --
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewinfo='brew leaves | xargs brew desc --eval-all'

# -- Navigation --
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias dot='cd ~/dotfiles'
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias p='cd ~/development'

# -- Git Shortcuts (if you don't use the plugin) --
# g is often aliased to git by plugins, but just in case:
if ! type g >/dev/null; then
  alias g='git'
fi

alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gst='git status'
alias gp='git push'
alias gl='git pull'

