# ==============================================================================
#  OH MY ZSH CONFIGURATION
# ==============================================================================

# Oh My Zsh 安裝路徑
export ZSH="$HOME/.oh-my-zsh"

# ZSH 主題設定 (我們主要使用 Starship，所以這裡留白或設為空)
ZSH_THEME=""

# Oh My Zsh 套件設定
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zoxide
  fzf
  sudo
  git-open
  docker
  docker-compose
)

# 載入 Oh My Zsh
# 注意：這應該在所有設定之後，但在 Starship 之前
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# 載入 fzf 的按鍵綁定與自動補全
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- FZF & FD Integration ---
# 使用 fd 取代預設的 find，尊重 .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- Zoxide ---
# 初始化 zoxide
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# 載入 starship (Prompt)
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi
