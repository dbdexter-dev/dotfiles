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
