function hmm
	if not type -q php
		echo "php not found"
		exit 1
	end
	if not test -d ~/mybin/hmm
		echo "hmm not installed"
		if not confirm "install hmm?"
			exit 1
		end
		mkdir -p ~/mybin/hmm
		git clone --depth 1 https://github.com/nadrad/h-m-m ~/mybin/hmm
	end
	php ~/mybin/hmm/h-m-m
end
