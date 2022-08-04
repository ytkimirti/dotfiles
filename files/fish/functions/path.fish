function path
	for path in $PATH; echo $path; end
	echo "==== USER PATHS ===="
	for path in $fish_user_paths; echo $path; end
end
