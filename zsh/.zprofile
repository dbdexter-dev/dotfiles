# ZSH profile

export THEOS=/opt/theos
export PATH="$HOME/.local":$THEOS/bin:$PATH
export EDITOR=vim
export BROWSER="vivaldi-stable"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
