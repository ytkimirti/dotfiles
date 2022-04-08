# You have to source this script, not just run it

if [[ $OSTYPE == 'darwin'* ]]; then
	echo "OS is MACOS"
	editor_path="/Applications/Unity/Hub/Editor"

	if [ -d "$editor_path" ]; then
		echo "Unity hub is installed"
		echo "Searching for unity versions"
		if [[ "$(ls -S $editor_path)" != "" ]]; then
			version_name=$(ls -S $editor_path | head -n1 | cut -d " " -f1)
			echo "Selected version is $version_name"
			platform_tools_path="/PlaybackEngines/AndroidPlayer/SDK/platform-tools"

			new_path="$editor_path/$version_name/$platform_tools_path"

			echo "Attempt adding $new_path"
			if [[ ":$PATH:" == *"$new_path"* ]]; then
				echo "Path already exists in the environment. Aborting"
			else
				echo "Adding to PATH"

				PATH=$PATH:$new_path
				export PATH
			fi
		else
			echo "No editor versions found in $editor_path"
		fi
	fi
fi
