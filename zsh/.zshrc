# Zsh config file

local user_color='green'
local master_session='shenanigans'
local fish_wd() {
	pwd | sed -e "s|^$HOME|~|;"'s|\([^/.]\)[^/]*/|\1/|g'
}
local wd='%{$fg[$user_color]%}$(fish_wd)%{$reset_color%}'

# Attach to the main session, or create it if it doesn't exist
ta() {
	tmux attach -t $master_session
	if [[ $? -ne 0 ]]; then
		tmux new -ds $master_session
		tmux split-pane -ht $master_session
		tmux resize-pane -x 78
		tmux split-pane -vt $master_session
		tmux resize-pane -y 19
		tmux attach -t $master_session
	fi
}


bindkey -v
bindkey '[A' up-line-or-search
bindkey '[B' down-line-or-search


alias ls="ls --color=auto"
alias vi="vim"
alias gdb="gdb -q"
#alias cd="cd -P"	# When cd-ing into a symlink, cd into the directory the link is pointing to
autoload -U colors && colors
setopt promptsubst


PROMPT="%n@%m ${wd}> "
RPROMPT="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"

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

# Keep every terminal multiplexed, attach to old sessions and create new ones as needed
if [[ $- == *i* && -z $TMUX ]]; then
	local master_status=$(tmux ls | grep $master_session | grep 'attached')
	if [[ $master_status == "" || -n "$SSH_CONNECTION" ]]; then
		ta
	else
		local targetsession=$(tmux ls | grep -v 'attached' | tail -1 | cut -d":" -f1)
		if [[ $targetsession == "" ]]; then
			tmux new-session -s $(date +%s%N | md5sum | cut -b 1-8)
		else
			tmux attach -t $targetsession
		fi
	fi
fi
