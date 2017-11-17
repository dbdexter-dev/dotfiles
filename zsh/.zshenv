# ZSH environment config

export THEOS=~/theos
export PATH="$HOME/.local":"$HOME/.local/bin":$THEOS/bin:$PATH
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="st"
export SUDO_EDITOR="nvim"
export RANGER_LOAD_DEFAULT_RC="FALSE"

# Options for Wayland (might switch from xorg at some point)
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=dvorak-intl
export XKB_DEFAULT_MODEL=pc105
