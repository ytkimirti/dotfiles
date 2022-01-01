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

for item in $dotfiles ; do
	mkdir -p files/`dirname $item` && cp -f ~/$item files/$item
done

git add . && git commit -m "Autocommit"

yes '=' | head -n$(($COLUMNS)) | tr -d '\n'

git --no-pager diff origin/master master

yes '=' | head -n$(($COLUMNS)) | tr -d '\n'

confirm "Push changes? [y/N]"  || exit 0

git push
