alias coode='code ~/tmp'
alias leet='code ~/.leetcode'
#My experimental conda thing

#fix this thing m8
#Add conda to path
alias condaset='export PATH="/Users/ytkimirti/opt/anaconda3/bin:$PATH"'
#alias condaset='source $ZSH/condaset.zsh'
#Remove conda from path
alias condarm='export PATH=`echo $PATH | tr ":" "\n" | grep -v "anaconda" | tr "\n" ":"`'

alias t='tldr'
alias editalias='vim ~/.oh-my-zsh/custom/my_aliases.zsh'
alias editvim='vim ~/.vimrc'
alias editzsh='vim ~/.zshrc'
alias n='norminette -R CheckForbiddenSourceHeader'
alias nd='norminette -R CheckForbiddenSourceHeader -R CheckDefine'
alias g='gcc -Wall -Wextra -Werror'
alias a='./a.out'

#Git stuff
alias gitreset='git reset --hard'
alias gitclean='git clean -f -d'
alias gitrc='git clean -f -d && git reset --hard'
alias gs='git status'
alias gc='git commit'
alias gl='git log --graph --oneline --decorate'
alias gp='git push'

#Prevent sleeping
alias coffee='caffeinate -disu'
alias covfefe='caffeinate -disu'

alias editsnippets='cd ~/.vim/plugged/SimpleSnippets-snippets/snippets'
alias send='git add . && git commit -m "autocommit" && git push'
alias load='bash ~/dotfiles/load.sh'
alias unload='bash ~/dotfiles/unload.sh'
#alias l='ls -l */*'
alias l='ls -l */* | cut -c 57-'
alias rmouts='rm */a.out'
alias thereisnospoon='~/dotfiles/cmatrix -s'

alias cc='pwd | pbcopy'
