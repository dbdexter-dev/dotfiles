# ZSH profile

export THEOS=/opt/theos
export PATH="$HOME/.local":$THEOS/bin:$PATH
export EDITOR=vim
export BROWSER="firefox"
export TERMINAL="urxvtc"

# Options for Wayland (might switch from xorg at some point)
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=dvorak-intl
export XKB_DEFAULT_MODEL=pc105

# Startx on first terminal
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

