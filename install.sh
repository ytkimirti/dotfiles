#!/bin/bash

line()
{
	echo "---------- $1 -------------"
}
cmd=""

install()
{
	if ! command -v $1 &> /dev/null
	then
	echo "🧐 $1 could not be found"
	read -p "🤨 Install $1? " -n 1 -r
	if [[ ! $REPLY =~ ^[Yy]$  ]]
	then
		echo "❌ skipped installation of $1"
		return
	fi
		echo
		echo "\$ $cmd install $1"
		$cmd install $1
	fi
}

if [[ $OSTYPE == 'darwin'* ]]; then
	bash $HOME/dotfiles/scripts/install_brew.sh
	cmd="brew"
elif [[ $OSTYPE == 'linux-gnu'* ]]; then
	echo "Owww, you are on linux"
	cmd="apt"
fi

echo "🔎 Checking packages..."

install fish
install tmux
install exa
install bat
install ripgrep

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]
then
	# Tmux plugin manager
	line "Installing tmux plugin manager"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [[ ! -d "$HOME/.fzf" ]]
then
	#FZF install
	line "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
fi

echo "✅ All packages are installed!"

echo "🚛 Linking config files"

configs=( .zshrc .vimrc .gitconfig .gitignore_global .ideavimrc .tmux.conf fish )
for i in "${configs[@]}"
do
	fish $HOME/dotfiles/scripts/link_config.fish $i
done

echo "✅ All OK!"