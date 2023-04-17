function asdfi
	set command $argv[1]
	if ! test $command
		echo "Usage: asdfi <plugin_name>"
		return
	end

	echo "\$ asdf plugin add $command"
	set -l output (asdf plugin add $command 2>&1)
	if ! [ $output = "Plugin named yarn already added" ]
		return
	end

	echo "\$ asdf install $command latest"
	asdf install $command latest || return
	echo "\$ asdf global $command latest"
	asdf global $command latest || return
	echo "== Done! =="
end
