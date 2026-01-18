# ==============================================================================
#  ZSH RC - Entry Point
# ==============================================================================

# 設定 Zsh Config 目錄
export ZDOTDIR="$HOME/.config/zsh"

# 啟用 nullglob，避免在沒有匹配檔案時報錯
setopt nullglob

# 自動載入 conf.d/ 下的所有 .zsh 設定檔
# 這些檔案已經被 stow 連結到 $HOME/.config/zsh/conf.d/
if [ -d "$ZDOTDIR/conf.d" ]; then
  for f in "$ZDOTDIR/conf.d"/*.zsh; do
    source "$f"
  done
fi

# 關閉 nullglob
unsetopt nullglob
