
confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

printrow() {
	yes '=' | head -n$(($COLUMNS)) | tr -d '\n'
}

confirm "This will overrite repo [y/N]"  || exit 0

#alias conf="confirm 'Are you sure m8?' && neofetch"

cp ~/.vimrc ~/dotfiles/.vimrc
cp ~/.zshrc ~/dotfiles/.zshrc
cp ~/.oh-my-zsh/custom/my_aliases.zsh ~/dotfiles/my_aliases.zsh

git add . && git commit -m "Autocommit"

printrow
printrow

git --no-pager diff origin/master master

printrow
printrow
#yes '=' | head -n$(($COLUMNS)) | tr -d '\n'

confirm "Push changes? [y/N]"  || exit 0


