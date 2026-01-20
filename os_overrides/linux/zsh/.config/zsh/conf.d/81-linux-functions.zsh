# Linux-specific Zsh functions

# ------------------------------
# Desktop utilities
# ------------------------------

# Open file manager at current directory or specified path
o() {
  if [[ $# -eq 0 ]]; then
    xdg-open . &>/dev/null &
  else
    xdg-open "$@" &>/dev/null &
  fi
}

# ------------------------------
# Notification
# ------------------------------

# Send desktop notification (requires notify-send)
notify() {
  local title="${1:-Notification}"
  local message="${2:-Task completed}"
  if command -v notify-send &>/dev/null; then
    notify-send "$title" "$message"
  else
    echo "notify-send not found. Install libnotify-bin"
  fi
}

# ------------------------------
# System utilities
# ------------------------------

# System information
sysinfo() {
  echo "=== System Information ==="
  echo "Hostname: $(hostname)"
  echo "Kernel: $(uname -r)"
  echo "Uptime: $(uptime -p)"
  echo ""
  echo "=== Memory ==="
  free -h
  echo ""
  echo "=== Disk Usage ==="
  df -h / /home 2>/dev/null
}

# Distribution info
distro() {
  if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    echo "$PRETTY_NAME"
  elif command -v lsb_release &>/dev/null; then
    lsb_release -d | cut -f2
  else
    echo "Unknown distribution"
  fi
}

# ------------------------------
# Service management
# ------------------------------

# Restart a systemd service
restart-service() {
  if [[ -z "$1" ]]; then
    echo "Usage: restart-service <service-name>"
    return 1
  fi
  sudo systemctl restart "$1"
  sudo systemctl status "$1"
}

# Show service logs
service-logs() {
  if [[ -z "$1" ]]; then
    echo "Usage: service-logs <service-name>"
    return 1
  fi
  journalctl -u "$1" -f
}

# ------------------------------
# Network utilities
# ------------------------------

# Get WiFi network name
wifi-name() {
  if command -v nmcli &>/dev/null; then
    nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2
  elif command -v iwgetid &>/dev/null; then
    iwgetid -r
  else
    echo "Neither nmcli nor iwgetid found"
  fi
}

# List all network connections
netinfo() {
  echo "=== Network Interfaces ==="
  ip -br addr
  echo ""
  echo "=== Active Connections ==="
  ss -tulnp 2>/dev/null | head -20
}

# ------------------------------
# Cleanup utilities
# ------------------------------

# Clean package manager cache
pkg-clean() {
  if command -v apt &>/dev/null; then
    sudo apt autoremove -y && sudo apt autoclean
  elif command -v dnf &>/dev/null; then
    sudo dnf autoremove -y && sudo dnf clean all
  elif command -v pacman &>/dev/null; then
    sudo pacman -Sc --noconfirm
  fi
  echo "Package cache cleaned"
}

# Clean journal logs
journal-clean() {
  sudo journalctl --vacuum-time=7d
  echo "Journal logs older than 7 days removed"
}

# Clean thumbnail cache
thumbnail-clean() {
  rm -rf ~/.cache/thumbnails/*
  echo "Thumbnail cache cleared"
}

# Full system cleanup
full-clean() {
  pkg-clean
  journal-clean
  thumbnail-clean
  echo "Full cleanup completed"
}

# ------------------------------
# Process utilities
# ------------------------------

# Find process by name
psg() {
  ps aux | grep -v grep | grep -i "$1"
}

# Kill process by name
killbyname() {
  if [[ -z "$1" ]]; then
    echo "Usage: killbyname <process-name>"
    return 1
  fi
  pkill -f "$1"
}
