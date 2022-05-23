if status is-interactive
    # Commands to run in interactive sessions can go here
	if type -q thefuck
		thefuck --alias | source
	end

    set -x FZF_DEFAULT_COMMAND 'rg --files --hidden'

	if test -d $HOME/dotfiles/files/zsh_custom/my_aliases.zsh
		source $HOME/dotfiles/files/zsh_custom/my_aliases.zsh
	end
end

if [ "$USER" = "ykimirti" ]
	
end
