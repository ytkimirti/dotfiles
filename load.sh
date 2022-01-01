
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

confirm "This will overrite repo [y/N]"  || exit 0

cp ~/.vimrc ~/dotfiles/.vimrc
cp ~/.zshrc ~/dotfiles/.zshrc
cp ~/.oh-my-zsh/custom/my_aliases.zsh ~/dotfiles/my_aliases.zsh

git add . && git commit -m "Autocommit"

yes '=' | head -n$(($COLUMNS)) | tr -d '\n'

git --no-pager diff origin/master master

yes '=' | head -n$(($COLUMNS)) | tr -d '\n'

confirm "Push changes? [y/N]"  || exit 0


