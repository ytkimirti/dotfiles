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
