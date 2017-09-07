# ZSH profile

# Startx on first terminal
if [ -z "$DISPLAY" ] && [ ! -f /tmp/.X0-lock ]; then
	exec startx
fi

