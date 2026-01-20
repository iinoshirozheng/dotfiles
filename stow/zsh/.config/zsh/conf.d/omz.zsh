# ==============================================================================
#  OH MY ZSH
# ==============================================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zoxide
  fzf
  sudo
  docker
  docker-compose
)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF + fd
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
