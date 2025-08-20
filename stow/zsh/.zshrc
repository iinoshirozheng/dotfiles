export ZDOTDIR="$HOME/.config/zsh"
[ -d "$ZDOTDIR/conf.d" ] && for f in $ZDOTDIR/conf.d/*.zsh; do source "$f"; done
