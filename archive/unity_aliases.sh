UNITY_PROJECTS_DIR="$HOME/Projects/Unity"

if [[ $USER == "ykimirti" ]]; then
	UNITY_PROJECTS_DIR="/goinfre/$HOME"
fi

uopen() {
	if [[ "$1" != "" ]]; then
		if [[ -d "$UNITY_PROJECTS_DIR/$1" ]]; then
			"$unity_path/Unity" -projectPath "$UNITY_PROJECTS_DIR/$1"
		else
			echo "No project named $1 is in $UNITY_PROJECT_DIR"
		fi
	else
		echo "No argument given..."
	fi
}

_uopen() {
	compadd $(ls -t $UNITY_PROJECTS_DIR)
}

uls() {
	ls $UNITY_PROJECTS_DIR
}

compdef _uopen uopen
