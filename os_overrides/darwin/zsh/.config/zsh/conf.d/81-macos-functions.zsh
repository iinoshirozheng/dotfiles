# macOS-specific Zsh functions

# ------------------------------
# Finder utilities
# ------------------------------

# Open current directory in Finder, or specified path
o() {
  if [[ $# -eq 0 ]]; then
    open .
  else
    open "$@"
  fi
}

# cd to the path of the front Finder window
cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || return
}

# ------------------------------
# Notification
# ------------------------------

# Send macOS notification
notify() {
  local title="${1:-Notification}"
  local message="${2:-Task completed}"
  osascript -e "display notification \"$message\" with title \"$title\""
}

# Say text with TTS
say-it() {
  say "$@"
}

# ------------------------------
# System utilities
# ------------------------------

# Toggle dark mode
darkmode() {
  osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
}

# Get bundle identifier of an app
bundleid() {
  osascript -e "id of app \"$1\""
}

# Eject all mounted volumes
ejectall() {
  osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
}

# Show/hide desktop icons
toggledesktop() {
  local current
  current=$(defaults read com.apple.finder CreateDesktop)
  if [[ "$current" == "true" ]] || [[ "$current" == "1" ]]; then
    defaults write com.apple.finder CreateDesktop -bool false
  else
    defaults write com.apple.finder CreateDesktop -bool true
  fi
  killall Finder
}

# Restart Finder
restartfinder() {
  killall Finder
}

# Restart Dock
restartdock() {
  killall Dock
}

# ------------------------------
# Network utilities
# ------------------------------

# Get WiFi network name
wifi-name() {
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'
}

# Get WiFi password from Keychain
wifi-password() {
  local ssid="${1:-$(wifi-name)}"
  security find-generic-password -D "AirPort network password" -a "$ssid" -gw
}

# ------------------------------
# Cleanup utilities
# ------------------------------

# Remove .DS_Store files recursively
cleanup-ds() {
  find "${1:-.}" -type f -name '*.DS_Store' -ls -delete
}

# Clear DNS cache
cleardns() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  echo "DNS cache flushed"
}
