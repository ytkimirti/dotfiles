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

			adb_path="$editor_path/$version_name/$platform_tools_path"

			echo "Attempt adding $adb_path"
			if [[ ":$PATH:" == *"$adb_path"* ]]; then
				echo "Path already exists in the environment. Aborting"
			else
				echo "Adding to PATH"

				PATH=$PATH:$adb_path
				export PATH
			fi

			#/Applications/Unity/Hub/Editor/2020.3.28f1/Unity.app/Contents/MacOS
			unity_path="$editor_path/$version_name/Unity.app/Contents/MacOS"

			echo "Attempt adding unity path:\n$unity_path"
			if [[ ":$PATH:" == *"$unity_path"* ]]; then
				echo "Path already exists in the environment. Aborting"
			else
				echo "Adding to PATH"

				PATH=$PATH:$unity_path
				export PATH
			fi
		else
			echo "No editor versions found in $editor_path"
		fi
	fi
fi
