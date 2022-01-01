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
	yes '=' | head -n $COLUMNS | tr -d '\n'
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}"  )" &> /dev/null && pwd  )
COLUMNS=`tput cols`

cd $SCRIPT_DIR

printrow

for item in $dotfiles ; do
	#git --no-pager diff files/$item ~/$item
	git --no-pager diff files/$item ~/$item
done

printrow

echo -e "\n"
confirm "This will overrite repo [y/N]"  || exit 0

for item in $dotfiles ; do
	mkdir -p files/`dirname $item` && cp -f ~/$item files/$item
done

git add . && git commit -m "Autocommit"

echo -e '\n'

confirm "Push changes? [y/N]"  || exit 0

git push
