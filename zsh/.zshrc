# Zsh config file

local user_color='blue'
local master_session='master'
local fish_wd() 
{
	pwd | sed -e "s|^$HOME|~|;s|\([^/.]\)[^/]*/|\1/|g"
}

local season()
{
	local month="$(date +%m)"
	local day="$(date +%d)"
	local season="unk"
	case "$month" in
		1|2)
			season=4 ;;
		3)
			if [[ $day -lt 21 ]]; then
				season=4
			else
				season=1
			fi
			;;
		4|5)
			season=1 ;;
		6)
			if [[ $day -lt 21 ]]; then
				season=1
			else
				season=2
			fi
			;;
		7|8)
			season=2 ;;
		9)
			if [[ $day -lt 23 ]]; then
				season=2
			else
				season=3
			fi
			;;
		10|11)
			season=3 ;;
		12)
			if [[ $day -lt 22 ]]; then
				season=3
			else
				season=4
			fi
			;;
	esac
	case "$season" in
		1)
			echo -n '%{$fg[green]%}春%{$reset_color%}' ;;
		2)
			echo -n '%{$fg[blue]%}夏%{$reset_color%}' ;;
		3)
			echo -n '%{$fg[yellow]%}秋%{$reset_color%}' ;;
		4)
			echo -n '%{$fg[cyan]%}冬%{$reset_color%}' ;;
	esac
}

local wd='%{$fg_bold[$user_color]%}$(fish_wd)%{$reset_color%}'

# Attach to the main session, or create it if it doesn't exist
ta() {
	if [[ $1 == "remote" ]]; then
		tmux new-session -t $master_session
	else
		tmux attach -t $master_session
		if [[ $? -ne 0 ]]; then
			tmux new -ds $master_session
			tmux select-pane -t $master_session:0.0
			tmux attach -t $master_session
		fi
	fi
}

tm() {
	if ! tmux attach -t "mpsyt"; then
		tmux new -ds "mpsyt"  mpsyt
		tmux attach -t "mpsyt" -c "mpsyt"
	fi
}

source ~/.zshenv

autoload -U colors && colors
setopt promptsubst

PROMPT="$(season) ${wd}> "

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
zstyle :compinstall filename "$HOME/.zshrc"

autoload -U compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

alias ls="ls --color=auto"
alias vi="nvim"
alias vim="nvim"
alias gdb="gdb -q"
alias tree="tree -C"
#alias cd="cd -P"	# When cd-ing into a symlink, cd into the directory the link is pointing to


bindkey -v
bindkey -r '[A'
bindkey -r '[B'
bindkey -r '/'
bindkey '' history-beginning-search-backward
bindkey '' history-beginning-search-backward

eval `dircolors ~/.dircolors`

# Multiplex every remote terminal
if [[ $- == *i* && -z $TMUX && $TERM != "linux" && -n "$SSH_CONNECTION" ]]; then
	ta "remote"
fi

# TTY adheres to colorscheme now
if [[ "$TERM" == "linux" ]]; then
	colorNum=0
	while read -r line
	do
		if [[ $colorNum -ne 0 ]]; then
			colorCode=$(echo $line | sed -e 's/.*#\([0-9a-f].*\).*/\1/g')
			echo $colorCode
			if [[ $colorCode != "" ]]; then
				echo -en "\e]P${colorNum}${colorCode}"
				: $(( colorNum += 1 ))
			fi
		fi
	done < <(grep -A20 'colorname\[' /etc/portage/savedconfig/x11-terms/st-0.7)
fi


if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
 	exec startx
fi
