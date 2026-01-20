# Linux-specific Zsh configuration

# ==============================
# Linux Aliases
# ==============================

# ls with colors (GNU ls)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Clipboard (requires xclip or xsel)
if command -v xclip &>/dev/null; then
  alias copy='xclip -selection clipboard'
  alias paste='xclip -selection clipboard -o'
elif command -v xsel &>/dev/null; then
  alias copy='xsel --clipboard --input'
  alias paste='xsel --clipboard --output'
elif command -v wl-copy &>/dev/null; then
  # Wayland
  alias copy='wl-copy'
  alias paste='wl-paste'
fi

# Open files/URLs with default application
alias open='xdg-open'

# Network
alias ports='sudo ss -tulnp'
alias localip="hostname -I | awk '{print \$1}'"
alias publicip="curl -s https://api.ipify.org && echo"

# ==============================
# Systemd shortcuts
# ==============================
if command -v systemctl &>/dev/null; then
  alias sc='sudo systemctl'
  alias scu='systemctl --user'
  alias scs='sudo systemctl status'
  alias scr='sudo systemctl restart'
  alias sce='sudo systemctl enable'
  alias scd='sudo systemctl disable'
  alias scstart='sudo systemctl start'
  alias scstop='sudo systemctl stop'
  alias jctl='journalctl -xe'
  alias jctlf='journalctl -f'
fi

# ==============================
# Package Manager shortcuts
# ==============================

# APT (Debian/Ubuntu)
if command -v apt &>/dev/null; then
  alias aptu='sudo apt update && sudo apt upgrade -y'
  alias apti='sudo apt install'
  alias aptr='sudo apt remove'
  alias apts='apt search'
  alias aptc='sudo apt autoremove -y && sudo apt autoclean'
fi

# DNF (Fedora/RHEL)
if command -v dnf &>/dev/null; then
  alias dnfu='sudo dnf upgrade -y'
  alias dnfi='sudo dnf install'
  alias dnfr='sudo dnf remove'
  alias dnfs='dnf search'
  alias dnfc='sudo dnf autoremove -y && sudo dnf clean all'
fi

# Pacman (Arch)
if command -v pacman &>/dev/null; then
  alias pacu='sudo pacman -Syu'
  alias paci='sudo pacman -S'
  alias pacr='sudo pacman -Rns'
  alias pacs='pacman -Ss'
  alias pacc='sudo pacman -Sc'
fi

# ==============================
# Linux Environment
# ==============================
export BROWSER="xdg-open"

# Linuxbrew support
if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"
fi

# ==============================
# Linux-specific functions
# ==============================

# Extract various archive formats
extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.tar.xz)  tar xJf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *.deb)     ar x "$1" ;;
      *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
