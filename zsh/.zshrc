# Zsh config file

local user_color='green'
local master_session='master'
local fish_wd() {
	pwd | sed -e "s|^$HOME|~|;s|\([^/.]\)[^/]*/|\1/|g"
}


local wd='%{$fg[$user_color]%}$(fish_wd)%{$reset_color%}'

# Attach to the main session, or create it if it doesn't exist
ta() {
	if [[ $1 == "remote" ]]; then
		tmux new-session -t $master_session
	else
		tmux attach -t $master_session
		if [[ $? -ne 0 ]]; then
			tmux new -ds $master_session
			tmux split-pane -ht $master_session
			tmux resize-pane -x 20
			tmux split-pane -vt $master_session
			tmux resize-pane -y 35
			tmux select-pane -t $master_session:0.0
			tmux attach -t $master_session
		fi
	fi
}


source ~/.zshenv

autoload -U colors && colors
setopt promptsubst

PROMPT="%n@%m ${wd}> "

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
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

alias ls="ls --color=auto"
alias vi="vim"
alias gdb="gdb -q"
alias tree="tree -C"
alias hc="herbstclient"
#alias cd="cd -P"	# When cd-ing into a symlink, cd into the directory the link is pointing to

bindkey -v
bindkey -r '[A'
bindkey -r '[B'
bindkey -r '/'
bindkey '' history-beginning-search-backward
bindkey '' history-beginning-search-backward

# Multiplex every remote terminal
if [[ $- == *i* && -z $TMUX && $TERM != "linux" && -n "$SSH_CONNECTION" ]]; then
	ta "remote"
fi

# TTY adheres to colorscheme now
if [[ "$TERM" == "linux" ]]; then
	while read -r line
	do
		colorNum=$(rax2 $(echo $line | sed -e 's/.*\.color\([0-9]*\).*/\1/g') | cut -d"x" -f2)
		if [[ $colorNum -ne 0 ]]; then
			colorCode=$(echo $line | sed -e 's/.*#\([0-9a-f].*\).*/\1/g')
		fi
		echo -en "\e]P${colorNum}${colorCode}"
	done < <(grep "color[0-9]" ~/.Xdefaults)
fi


if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
	exec startx
fi
