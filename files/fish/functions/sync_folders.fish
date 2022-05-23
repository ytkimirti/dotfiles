function sync_folders
	set -l sync_folders \
		~/notes
		~/dotfiles
	for folder in $sync_folders
		set_color cyan
		echo "Syncing $folder"
		set_color reset
		cd $folder
		git pull;
		and begin
			echo "Git pull success"
		end
		or begin
			git status --short
			echo "\$ git add --all && git commit -m 'Autocommit' && git push";
			read_confirm Run;
			and git add --all && git commit -m 'Autocommit' && git push;
		end
	end
end
