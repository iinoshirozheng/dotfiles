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

# -- Ripgrep Shortcuts --
# 增強顏色: 行號黃色、路徑綠色粗體、匹配紅色粗體
if command -v rg >/dev/null; then
  _rg_color='--colors=line:fg:yellow --colors=path:fg:green --colors=path:style:bold --colors=match:fg:red --colors=match:style:bold'

  # 基本搜尋 (支援 pipeline: echo "pattern" | rgg)
  rgg() { 
    if [[ -p /dev/stdin ]]; then
      command rg ${=_rg_color} --pretty "$@"
    else
      command rg ${=_rg_color} --pretty "$@"
    fi
  }
  
  alias rgf='rg --files | rg --color=always' # 搜尋檔名
  alias rgi="rg ${=_rg_color} -i"             # 不區分大小寫
  alias rgh="rg ${=_rg_color} --hidden"       # 包含隱藏檔案
  alias rga="rg ${=_rg_color} --hidden --no-ignore"  # 搜尋所有檔案
  alias rgt="rg ${=_rg_color} -t"             # 搜尋指定類型 (e.g. rgt py "pattern")
  alias rgtls='rg --type-list | rg --color=always'   # 列出所有類型
  alias rgc="rg ${=_rg_color} -C 3"           # 顯示上下文 3 行
  alias rge="rg ${=_rg_color} -g"             # 搜尋指定副檔名 (e.g. rge "*.tsx" "pattern")
fi

