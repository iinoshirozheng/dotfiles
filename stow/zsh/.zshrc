# ==============================================================================
#  ZSH RC - 執行於互動式 Shell (Interactive Shell)
#  負責設定 Alias、外掛、個人化功能
# ==============================================================================

# ==============================================================================
#  OH MY ZSH & THEME CONFIGURATION
# ==============================================================================
# Oh My Zsh 安裝路徑
export ZSH="$HOME/.oh-my-zsh"

# ZSH 主題設定
ZSH_THEME=""

# Oh My Zsh 套件設定 (建議從最基本的開始)
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

# ==============================================================================
#  LOAD OH MY ZSH
# ==============================================================================
# 載入 Oh My Zsh。它會處理後續的外掛載入。
source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
#  ALIASES (命令別名)
# ==============================================================================
# -- eza (現代化的 ls) --
# unalias ls # Oh-My-Zsh 可能會設定 ls，取消它以確保我們的設定優先
alias ls='eza --icons'
alias l='eza -bghH --icons'
alias ll='eza -l --octal-permissions --icons --git'
alias la='eza -la --octal-permissions --icons --git'
alias lt='eza -T --icons'

# -- 自訂指令 --
alias update='source ~/.zshrc'
alias vi=nvim
alias vim=nvim

# ==============================================================================
#  FINAL INITIALIZATION
# ==============================================================================

# 載入 fzf 的按鍵綁定與自動補全
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 載入 starship
eval "$(starship init zsh)"


# --- cproject Environment ---
export PATH="/Users/ray/development/cproject/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"
export VCPKG_ROOT="/Users/ray/development/cproject/vcpkg"
export PATH="$VCPKG_ROOT:$PATH"

# Added by Antigravity
export PATH="/Users/ray/.antigravity/antigravity/bin:$PATH"

# Added by Antigravity
export PATH="/Users/ray/.antigravity/antigravity/bin:$PATH"
