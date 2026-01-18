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

# 4.設定 Dynamic Profiles (自動載入設定檔)
DYNAMIC_PROFILE_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
mkdir -p "$DYNAMIC_PROFILE_DIR"
if [ -f "$ITERM_PREFS_DIR/Profiles.json" ]; then
    echo "[iTerm2] Linking Dynamic Profile..."
    ln -sf "$ITERM_PREFS_DIR/Profiles.json" "$DYNAMIC_PROFILE_DIR/dotfiles_profiles.json"
fi

echo "[iTerm2] Done. Please restart iTerm2 to apply changes."
