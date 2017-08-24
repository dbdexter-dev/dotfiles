# Zsh config file

local user_color='green'
fish_wd() {
	pwd | sed -e "s|^$HOME|~|;"'s|\([^/.]\)[^/]*/|\1/|g'
}
local wd='%{$fg[$user_color]%}$(fish_wd)%{$reset_color%}'

bindkey -v

alias ls="ls --color=auto"
alias vi="vim"
alias gdb="gdb -q"
#alias cd="cd -P"	# When cd-ing into a symlink, cd into the directory the link is pointing to
autoload -U colors && colors
setopt promptsubst


PROMPT="%n@%m ${wd}> "
RPROMPT="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
command_not_found_handler() {
	# Weeb shit right here
	echo -e "バカ！「$1」わ何ですか？" >&2
	return 127
}

autoload -Uz compinit
compinit
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' format '%d'
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*:cd:*' file-patterns '*(/):directories'
zstyle ':completion:*:ls:*' file-patterns '*(/):directories'
zstyle :compinstall filename '/home/dbdexter/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
