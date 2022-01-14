# ------------ zsh options --------------
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/dotfiles/files/zsh_custom"
export EDITOR="vim"
COMPLETION_WAITING_DOTS=true
DISABLE_AUTO_UPDATE="true"
#CASE_SENSITIVE="true"

ZSH_THEME="daveverwer"

# ------- two line themes ----------
# 'guezwho'
#
# ------- one line themes ----------
# 'short'      directory > xxxxxx
# 'daveverwer' kim:directory $ xxxxxx
# kim at ~/tmp type jaischeema
#
# My thing gallois
# arrow hmm noice

plugins=(
	z
	colored-man-pages
	colorize
	copydir
	copyfile
	encode64
	extract
	rand-quote
	themes
)
# zsh-vi-mode maybe???

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## -------- Custom -----------------
export dotfiles=".vimrc .zshrc .tmux.conf .oh-my-zsh/custom/my_aliases.zsh .gitconfig .gitignore_global"

ZVM_ESCAPE_KEYTIMEOUT=0.01
ZVM_KEYTIMEOUT=0.01

## -------- Vi-mode options -------

#  mmmmmmmaaaaaaaaaaaaaayybe
#my_init() {
	  #[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh
	  
#}
#zvm_after_init_commands+=(my_init)


## NOTE
#
# ccat			syntaxed cat
#
#
#
#
#
#