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
	
else if [ "$USER" = "ytkimirti" ]
	set -x EDITOR nvim
end

set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

set -gx PATH "$HOME/.fzf/bin" $PATH;
set -gx PATH "$HOME/.cargo/bin" $PATH;
# if type -q starship
# 	starship init fish | source
# end
