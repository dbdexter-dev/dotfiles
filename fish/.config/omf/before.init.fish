fish_vi_key_bindings

set -x THEOS "/opt/theos"
set -x PATH "$HOME/.local" $PATH $THEOS/bin
set -x EDITOR "vim"
set -x BROWSER "firefox"
set -x TERMINAL "termite"
set -x theme_color_name "zenburn"
set -x XKB_DEFAULT_LAYOUT "dvorak"
set -x LS_COLORS (ls_colors_generator)

alias ls='ls-i --color=auto --group-directories-first'
alias vi='vim'
alias gdb='gdb -q'

if status --is-login
	set -g theme_powerline_fonts no
	if test -z "$DISPLAY"
		and test -n "$XDG_VTNR"
		and [ "$XDG_VTNR" -eq 1 ]
		exec startx
	end
end

if status --is-interactive
	function bell_on_completion --on-event fish_prompt
		echo -ne '\a'
	end
	set -g theme_nerd_fonts yes
	set -g theme_display_vagrant yes
	set -g theme_display_vi no
	set -g theme_display_date no
	set -g theme_display_user yes
end


# vim: ft=conf
