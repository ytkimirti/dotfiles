# When running a script etc. The shell is not interactive
if status is-interactive

end

if type -q nvim
	set -gx EDITOR nvim
else if type -q vim
	set -gx EDITOR nvim
end

if [ -d /goinfre ]
	set -gx IS_ECOLE true
end

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden'

# Homebrew stuff
if [ "$IS_ECOLE" = "true" ]
	set -gx RUSTUP_HOME "/goinfre/$USER/.rustup"
	set -gx CARGO_HOME "/goinfre/$USER/.cargo"

	set -gx HOMEBREW_PREFIX "$HOME/mybin/homebrew"
	set -gx HOMEBREW_CELLAR "$HOME/mybin/homebrew/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOME/mybin/homebrew"
else
	set -gx RUSTUP_HOME "$HOME/.rustup"
	set -gx CARGO_HOME "$HOME/.cargo"

	set -gx HOMEBREW_PREFIX "/opt/homebrew"
	set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
	set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
end

set -q PATH; or set PATH ''; set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

# Set modes for these vars to path, (':' seperated)
set --path LIBRARY_PATH
set --path C_INCLUDE_PATH

set -gxa LIBRARY_PATH "$HOMEBREW_PREFIX/lib"
set -gxa C_INCLUDE_PATH "$HOMEBREW_PREFIX/include"
set -gxp INFOPATH "$HOMEBREW_PREFIX/share/info"

if [ -d $HOME/mybin ]
	set -gxp PATH "$HOME/mybin/bin"
end

set -gxp PATH "$HOME/flutter/bin"
set -gxp PATH "$HOME/.fzf/bin"
set -gxp PATH "$CARGO_HOME/bin"
set -gxp PATH "$HOME/go/bin"
set -gxp PATH "/opt/metasploit-framework/bin"

set -gxp PATH "/usr/local/bin"

# pyenv
set -gx PYENV_SHELL fish
set -gx PYENV_ROOT $HOME/.pyenv

set -gx LC_ALL "en_US.UTF-8"

if type -q id; set -gx GROUP (id -gn $USER); end
set -gx ECOLE_MAIL "ykimirti@42istanbul.com.tr"
set -gx ECOLE_USER "ykimirti"

# You can manually set shims like this too but with it's own init script, it's safer
# set -gxp PATH $PYENV_ROOT/shims
if type -q fnm
	pyenv init - | source
end

if type -q fnm
	eval (fnm env)
end

# Does make difference?
# if type -q fnm
# 	fnm env --use-on-cd | source
# end

if type -q thefuck
	thefuck --alias | source
end

# if type -q starship
# 	starship init fish | source
# end
