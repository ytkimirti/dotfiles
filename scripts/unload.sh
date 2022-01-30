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

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}"   )" &> /dev/null && pwd   )
COLUMNS=`tput cols`

cd $SCRIPT_DIR

printrow() {
	yes '=' | head -n $COLUMNS | tr -d '\n'
}

printrow

for item in $dotfiles ; do
	git --no-pager diff ~/$item files/$item
	#mkdir -p ~/`dirname $item` && cp -f files/$item ~/$item
done

printrow

confirm "Overrite the local config? [y/N]" || exit 0

for item in $dotfiles ; do
	#git --no-pager diff ~/$item files/$item
	mkdir -p ~/`dirname $item` && cp -f files/$item ~/$item
done
