#!/bin/bash
set -euo pipefail

# iTerm2 Configuration Loader
# 告訴 iTerm2 從我們指定的目錄讀取設定

ITERM_PREFS_DIR="$HOME/dotfiles/stow/iterm2"

echo "[iTerm2] Configuring preferences location..."

# 1. 告訴 iTerm2 從自訂資料夾讀取設定
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# 2. 設定自訂資料夾路徑
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$ITERM_PREFS_DIR"

# 3. 嘗試匯入色彩設定 (若 iTerm2 未開啟)
COLOR_PRESET="$ITERM_PREFS_DIR/Catppuccin_Macchiato.itermcolors"
if [ -f "$COLOR_PRESET" ]; then
    echo "[iTerm2] Color preset found. You can import it in iTerm2 Preferences > Profiles > Colors > Color Presets > Import..."
    open "$COLOR_PRESET" || true
fi

# 4. Dynamic Profiles 現在由 stow 管理
# 檔案位於: stow/iterm2/Library/Application Support/iTerm2/DynamicProfiles/dotfiles_profiles.json
# 執行 `dotfile link` 即可建立 symlink

echo "[iTerm2] Done. Please run 'dotfile link' and restart iTerm2 to apply changes."
