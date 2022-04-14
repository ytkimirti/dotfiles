# ------------ zsh options --------------
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/dotfiles/files/zsh_custom"
export EDITOR="vim"
COMPLETION_WAITING_DOTS=true
DISABLE_AUTO_UPDATE="true"
#CASE_SENSITIVE="true"

ZSH_THEME="short"

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
	zsh-syntax-highlighting
	copydir
	copyfile
	encode64
	extract
	rand-quote
	themes
)

# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=yellow'

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## -------- Custom -----------------
export dotfiles=".ideavimrc .vimrc .zshrc .tmux.conf .oh-my-zsh/custom/my_aliases.zsh .gitconfig .gitignore_global"


## -------- Vi-mode options -------

ZVM_ESCAPE_KEYTIMEOUT=0.01
ZVM_KEYTIMEOUT=0.01
#  mmmmmmmaaaaaaaaaaaaaayybe
#my_init() {
	  #[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh
	  
#}
#zvm_after_init_commands+=(my_init)


if [[ "$USER" == "ykimirti" ]]
then
	PATH="/Users/ykimirti/mybin/homebrew/bin":$PATH
	PATH=$PATH:"/goinfre/ykimirti/homebrew/bin"
	PATH=$PATH:"/Users/ykimirti/Library/Python/3.9/bin"
	PATH=$PATH:"/Users/ykimirti/Library/Python/3.9/lib/python/site-packages"
else
	PATH=$PATH:"/usr/local/opt/llvm/bin/"
fi

# For adb
source ~/dotfiles/scripts/add_unity_to_path.sh > /dev/null
