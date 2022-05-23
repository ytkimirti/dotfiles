return
# TODO: Turn these into abbreviations
alias t='tldr'
alias n='norminette'
alias nd='norminette -R CheckForbiddenSourceHeader -R CheckDefine'
alias a='./a.out'
alias p='pnpm'
alias px='pnpx'

#Git stuff
alias gitreset='git reset --hard'
alias gitclean='git clean -f -d'
alias gitrc='git clean -f -d && git reset --hard'
alias gs='git status --short'
alias ga='git add --all'
alias gc='git commit'
alias gl='git log --graph --oneline --decorate'
alias gla='git log --graph --oneline --decorate --all'

# Prevent sleeping
alias covfefe='caffeinate -disu'

# Util
alias cc='pwd | pbcopy'
alias localip='ifconfig | grep 192.168.'
alias publicip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com'
alias load='bash ~/dotfiles/load.sh'
alias unload='bash ~/dotfiles/unload.sh'
alias rmouts='rm */a.out'

# Easteregg
alias cow="fortune | cowsay -f "$(cowsay -l | sed '1d' | tr ' ' '\n' | sort -R | head -1)" | lolcat -a -s 50 && caffeinate -disu"
alias thereisnospoon='~/dotfiles/cmatrix -s'

alias editcodenvim="code ~/.config/nvim/init.vim"
alias editsnippets='cd ~/.vim/plugged/SimpleSnippets-snippets/snippets'
alias editnvim="nvim ~/.config/nvim/init.vim"
alias editalias='vim ~/dotfiles/files/.oh-my-zsh/custom/my_aliases.zsh'
alias editvim='vim ~/.vimrc'
alias editzsh='vim ~/.zshrc'
alias edittmux='vim ~/.tmux.conf'

# Tmux
alias ta="tmux attach-session -t main || tmux new -s main"
