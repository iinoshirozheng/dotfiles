# macOS-specific Zsh configuration

# ==============================
# Homebrew
# ==============================
if [[ -d "/opt/homebrew" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
elif [[ -d "/usr/local/Homebrew" ]]; then
  export HOMEBREW_PREFIX="/usr/local"
fi

if [[ -n "$HOMEBREW_PREFIX" ]]; then
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"
fi

# ==============================
# macOS Aliases
# ==============================

# ls with colors (BSD ls)
alias ls='ls -G'

# Clipboard
alias copy='pbcopy'
alias paste='pbpaste'

# DNS
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# Finder: show/hide hidden files
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

# Network
alias ports='sudo lsof -iTCP -sTCP:LISTEN -n -P'
alias localip="ipconfig getifaddr en0"
alias publicip="curl -s https://api.ipify.org && echo"

# Quick Look
alias ql='qlmanage -p'

# Open current directory in Finder
alias finder='open -a Finder .'

# Lock screen
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Empty trash & clear system logs
alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'

# Disable/Enable Spotlight
alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

# ==============================
# macOS Environment
# ==============================
export BROWSER="open"
export GPG_TTY=$(tty)

# Prefer GNU coreutils if installed
if [[ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# GNU sed
if [[ -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# GNU grep
if [[ -d "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
fi
