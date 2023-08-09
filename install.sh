#!/bin/bash

# set -e

line()
{
	echo "---------- $1 -------------"
}

echo "🚛 Linking config files"

configs=( .condarc .zshrc .vimrc .macos .gitconfig .ideavimrc .tmux.conf fish iterm kitty lazygit nvim )
for i in "${configs[@]}"
do
	bash ~/dotfiles/scripts/link_config.sh "$i"
done

cmd=""

# Takes package name as first argument.
# You can specify a command name to
# look for if you want with the second argument
install()
{
	if ! command -v "$cmd" &> /dev/null; then
		echo "No package manager named $cmd found!"
		exit 1
	fi
	cmd_name=${2:-$1}
	if ! command -v "$cmd_name" &> /dev/null
	then
		# echo "🧐 $1 could not be found"
		# read -p "🤨 Install $1? " -n 1 -r
		# if [[ ! $REPLY =~ ^[Yy]$  ]]
		# then
		# 	echo "❌ skipped installation of $1"
		# 	return
		# fi
		echo "\$ $cmd install $1"
		if ! $cmd install -y "$1"; then
			echo "❌ $cmd_name installation failed"
			exit 1
		fi
		echo "✅ $cmd_name installed"
	else
		echo "👌 $cmd_name"
	fi
}

echo "🚛 Installing packages"

if [[ $OSTYPE == 'darwin'* ]]; then
	cmd="brew"
elif [[ $OSTYPE == 'linux-gnu'* ]]; then
	cmd="apt"
	apt update
else
	echo "Unknown os" && exit 1
fi

install neovim nvim
install tmux

if [[ $OSTYPE == 'darwin'* ]]; then
	bash ~/dotfiles/scripts/configure_macos.sh
	if ! command -v brew &> /dev/null
	then
		echo "Installing brew..."
		bash ~/dotfiles/scripts/install_brew.sh
	fi
	cmd="brew"
	if ! command -v "rg" &> /dev/null
	then
		install ripgrep rg
	fi
	if ! command -v "lazygit" &> /dev/null
	then
		install lazygit
	fi
elif [[ $OSTYPE == 'linux-gnu'* ]]; then
	echo "Owww, you are on linux"
	cmd="apt"
	bash ~/dotfiles/scripts/install_ripgrep.sh
	bash ~/dotfiles/scripts/install_lazygit.sh
fi

# if command -v tmux &> /dev/null && [[ ! -d "$HOME/.tmux/plugins/tpm" ]]
# then
# 	# Tmux plugin manager
# 	echo "Installing tmux plugin manager"
# 	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# fi
# echo "👌 tmux plugin manager"

if [[ ! -d ~/.asdf ]]
then
	echo "Installing asdf"
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
fi

echo "👌 asdf"

if [[ ! -d ~/.fzf ]]
then
	#FZF install
	echo "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --bin
fi
echo "👌 fzf"
