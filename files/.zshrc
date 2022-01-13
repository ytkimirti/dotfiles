export ZSH="$HOME/.oh-my-zsh"
export EDITOR="vim"

ZSH_THEME="daveverwer"
# 'daveverwer' with the heart thing
# kim at ~/tmp type jaischeema
# fino - multiline thing
# My thing gallois
# theunraveler real gud
# arrow hmm noice
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
plugins=(
	z
	colored-man-pages
	colorize
	copydir
	copyfile
	encode64
	extract
	vi-mode
	rand-quote
	themes
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Custom scripts
export dotfiles=".vimrc .zshrc .tmux.conf .oh-my-zsh/custom/my_aliases.zsh .gitconfig .gitignore_global"


## NOTE
#
# ccat			syntaxed cat
#
#
#
#
#
#
