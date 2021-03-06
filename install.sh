#!/bin/bash
# Script to migrate muh config easily

packages="git zsh vim tmux stow wget"
stufftostow="zsh vim tmux"
dotrepo="dbdexter-dev/dotfiles"
pathogen="https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
vim_plugins=(	'taohex/lightline-buffer'	\
				'itchyny/lightline.vim'		\
				'w0rp/ale'	\
				'ajh17/VimCompletesMe'		\
				'tpope/vim-repeat'			\
				'tpope/vim-surround'		\
				'tpope/vim-fugitive'		\
				)
pkgmans=('pacman' 'emerge' 'apt-get' 'yum')
manager=''

green='\e[32m'
normal='\e[0m'

# Detect package manager
echo -e "$green==> Detecting package manager$normal"
for pkgman in ${pkgmans[@]}; do
	which $pkgman > /dev/null
	if [[ $? -eq 0 ]]; then
		manager=$pkgman
		break
	fi
done

if [[ $manager == '' ]]; then
	echo "Package manager not found >.<"
	exit
fi
echo -e "$green==> Will use ${manager}$normal"

set -e

case $manager in
	'pacman') sudo pacman -Sy --needed $packages;;
	'emerge') sudo emerge --sync; sudo emerge --ask $packages;;
	'apt-get') sudo apt-get update; sudo apt-get install $packages;;
	'yum') sudo yum update; sudo yum install $packages;;
	*) echo -e 'This message should not appeear'; exit;;
esac

chsh -s $(which zsh)

echo -e "${green}==> Installing vim plugins...$normal"
cd $HOME
mkdir -p .vim/autoload .vim/bundle .vim-tmp
cd .vim
wget $pathogen -O autoload/pathogen.vim
cd bundle
for plugin in ${vim_plugins[@]}; do
	git clone --depth=1 "https://github.com/$plugin"
done
vim +Helptags +qall

echo -e "${green}==> Fetching dotfiles...$normal"
cd $HOME
git clone "https://github.com/$dotrepo" .dotfiles
cd .dotfiles

echo -e "${green}==> Stowing...$normal"
for dir in $stufftostow; do
	stow $dir
done

echo -e "${green}==> Removing unnecessary config...$normal"
for dir in $(ls -d */ | egrep -v $(echo $stufftostow | sed -e 's/ /|/g')); do
	rm $dir
done

echo -e "${green}Migration complete, good luck captain!$normal"
sleep 1

cd $HOME
zsh
