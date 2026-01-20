# ==============================================================================
#  ZSH RC - Entry Point
# ==============================================================================

# 載入 conf.d/ 下的所有設定檔
for f in "$HOME/.config/zsh/conf.d"/*.zsh(N); do
  source "$f"
done

# Starship 最後初始化
command -v starship >/dev/null && eval "$(starship init zsh)"
