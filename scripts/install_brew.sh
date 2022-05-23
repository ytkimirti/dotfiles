echo "🔎 Checking if brew is installed..."

if ! command -v brew &> /dev/null
then
	echo "🧐 brew could not be found"
	read -p "Install brew?" -n 1 -r
	echo    # (optional) move to a new line
	if [[ ! $REPLY =~ ^[Yy]$  ]]
	then
		exit 1
	fi
	if [[ $USER == "ykimirti" ]]
	then
		# For ecole42
		echo "Installing brew to /goinfre/$USER"
		cd /goinfre/$USER && mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
	else
		# For other macs
		echo "Installing brew to /usr/local"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
else
	echo "✅ Brew is already installed"
fi

if ! command -v brew &> /dev/null
then
	echo "😬 Something went wrong with the brew install, install it manually"
	exit
fi
