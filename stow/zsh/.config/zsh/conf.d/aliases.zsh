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
