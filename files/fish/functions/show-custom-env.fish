function show-custom-env
	set custom_envs "LIBRARY_PATH" "C_INCLUDE_PATH"

	for env in $custom_envs
		set -S $env
	end
end
