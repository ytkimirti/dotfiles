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

set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden'

# Homebrew stuff
set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/opt/homebrew"

set -gxp PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
set -gxp MANPATH "$HOMEBREW_PREFIX/share/man"
set -gxp INFOPATH "$HOMEBREW_PREFIX/share/info"

# Set modes for these vars to path, (':' seperated)
set --path LIBRARY_PATH
set --path C_INCLUDE_PATH

set -gxa LIBRARY_PATH "$HOMEBREW_PREFIX/lib"
set -gxa C_INCLUDE_PATH "$HOMEBREW_PREFIX/include"
set -gxp INFOPATH "$HOMEBREW_PREFIX/share/info"

set -gxp PATH "$HOME/.fzf/bin"
set -gxp PATH "$HOME/.cargo/bin"

# pyenv
set -gx PYENV_SHELL fish
set -gx PYENV_ROOT $HOME/.pyenv

# You can manually set shims like this too but with it's own init script, it's safer
# set -gxp PATH $PYENV_ROOT/shims
pyenv init - | source

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
