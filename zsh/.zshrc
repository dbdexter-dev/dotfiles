# Set colors for ls and autocompletion
eval $(dircolors -b ~/.dircolors)

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' format '%d'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/dbdexter/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

PROMPT='%F{green:}%n%f@%m:%F{blue:}%/%f> '
RPROMPT='%B%(?..[%?])%b'
prompt_opts=(cr percent)

alias ls="ls --color=auto"
alias vi="vim"
alias grep="grep --color=auto"
alias lcd='cd "$(readlink -f .)"'

export THEOS_DEVICE_IP=192.168.1.3
export THEOS_DEVICE_PORT=31337

#source ~/.zsh/git_prompt.zsh

bindkey "^R" history-incremental-search-backward
bindkey "[H" beginning-of-line
bindkey "[F" end-of-line
bindkey "[5~" beginning-of-history
bindkey "[6~" end-of-history
bindkey "[3~" delete-char

# Disable Ctrl+S, Ctrl+Q
stty -ixon

# Alert on command completion
precmd() {
	print -n '\a'
}

fortune | cowsay -f small.cow
