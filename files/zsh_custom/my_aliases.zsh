alias coode='code ~/tmp'
alias todo='code ~/.todo'

#fix this thing m8
#Add conda to path
alias condaset='export PATH="/Users/ytkimirti/opt/anaconda3/bin:$PATH"'
#alias condaset='source $ZSH/condaset.zsh'
#Remove conda from path
alias condarm='export PATH=`echo $PATH | tr ":" "\n" | grep -v "anaconda" | tr "\n" ":"`'

alias namaz='python3 ~/Projects/Python/namazvakti.py'
alias path="echo \"${PATH//:/\n}\""
alias t='tldr'
alias n='norminette -R CheckForbiddenSourceHeader'
alias nd='norminette -R CheckForbiddenSourceHeader -R CheckDefine'
alias g='gcc -Wall -Wextra -Werror'
alias a='./a.out'
alias p='pnpm'
alias px='pnpx'

#Git stuff
alias send='git add . && git commit -m "autocommit" && git push'
alias gitreset='git reset --hard'
alias gitclean='git clean -f -d'
alias gitrc='git clean -f -d && git reset --hard'
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gl='git log --graph --oneline --decorate'
alias gp='git push'

# Prevent sleeping
alias coffee='caffeinate -disu'
alias covfefe='caffeinate -disu'

# Util
alias cc='pwd | pbcopy'
alias localip='ifconfig | grep 192.168.'
alias publicip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com'
alias load='bash ~/dotfiles/load.sh'
alias unload='bash ~/dotfiles/unload.sh'
alias rmouts='rm */a.out'
alias cdwhich='cd "$(dirname "$(which pip3)")"'

# Easteregg
#alias cow="fortune | cowsay -f "$(cowsay -l | sed '1d' | tr ' ' '\n' | sort -R | head -1)" | lolcat -a -s 50 && caffeinate -disu"
alias thereisnospoon='~/dotfiles/cmatrix -s'

alias editcodenvim="code ~/.config/nvim/init.vim"
alias editsnippets='cd ~/.vim/plugged/SimpleSnippets-snippets/snippets'
alias editnvim="nvim ~/.config/nvim/init.vim"
alias editalias='vim $ZSH_CUSTOM/my_aliases.zsh'
alias editvim='vim ~/.vimrc'
alias editzsh='vim ~/.zshrc'
alias edittmux='vim ~/.tmux.conf'

# Tmux
alias ta="tmux attach-session -t main || tmux new -s main"
