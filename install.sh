#!/bin/bash

line()
{
	echo "---------- $1 -------------"
}
cmd=""

# Takes package name as first argument, you can specify a command name to
# look for if you want with the second argument
install()
{
	cmd_name=${2:-$1}
	if ! command -v $cmd_name &> /dev/null
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
         else
            echo "✅ $cmd_name already installed"
         fi
}

if [[ $OSTYPE == 'darwin'* ]]; then
	bash $HOME/dotfiles/scripts/configure_macos.sh
	bash $HOME/dotfiles/scripts/install_brew.sh
	cmd="brew"
elif [[ $OSTYPE == 'linux-gnu'* ]]; then
	echo "Owww, you are on linux"
	cmd="apt"
fi

read -p "🔎 Install packages with $cmd? [Y/n]" -n 1 -r
if [[ ! $REPLY =~ ^[Nn]$  ]]
then
   install fish
   install ripgrep rg
   install nvim
else
   echo "Skipped..."
fi

if command -v tmux &> /dev/null && [[ ! -d "$HOME/.tmux/plugins/tpm" ]]
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

fish $HOME/dotfiles/scripts/install_nvchad.fish

echo "✅ All packages are installed!"

echo "🚛 Linking config files"

# Disabled nvim for now, because using nvchad!!
configs=( .zshrc .vimrc .macos .gitconfig .gitignore .ideavimrc .tmux.conf fish iterm kitty lazygit )
for i in "${configs[@]}"
do
	fish $HOME/dotfiles/scripts/link_config.fish $i
done

# fish $HOME/dotfiles/scripts/configure_apps.fish

echo "✅ All OK!"
