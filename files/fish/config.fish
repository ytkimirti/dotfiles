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

set -gx HOMEBREW_NO_AUTO_UPDATE

set -q PATH; or set PATH ''; set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

# Set modes for these vars to path, (':' seperated)
set --path LIBRARY_PATH
set --path C_INCLUDE_PATH

set -gxa LIBRARY_PATH "$HOMEBREW_PREFIX/lib"
set -gxa C_INCLUDE_PATH "$HOMEBREW_PREFIX/include"
set -gxp INFOPATH "$HOMEBREW_PREFIX/share/info"

if [ -d "$HOME/Library/Android/sdk" ]
	set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
end

if [ -d $HOME/mybin ]
	set -gxp PATH "$HOME/mybin/bin"
end

set -gxp PATH "$HOME/mybin/bin"
set -gxp PATH "$HOME/flutter/bin"
set -gxp PATH "$HOME/.fzf/bin"
set -gxp PATH "$CARGO_HOME/bin"
set -gxp PATH "$HOME/go/bin"
set -gxp PATH "/opt/metasploit-framework/bin"

set -gxp PATH "/usr/local/bin"
set -gxp PATH "/opt/homebrew/opt/curl/bin"
set -gxp PATH "$HOME/Library/Android/sdk/platform-tools"
set -gxp PATH "$HOME/Library/Android/sdk/tools"
set -gxp PATH "$HOME/Library/Android/sdk/emulator"

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

if [ -f ~/.asdf/asdf.fish ]
	source ~/.asdf/asdf.fish
end


# if type -q starship
# 	starship init fish | source
# end

abbr -a -- gla 'git log --oneline --decorate --graph --all' # imported from a universal variable, see `help abbr`
abbr -a -- gra 'git reset --hard HEAD && git clean -fd' # imported from a universal variable, see `help abbr`
abbr -a -- editkitty 'nvim ~/.config/kitty/kitty.conf' # imported from a universal variable, see `help abbr`
abbr -a -- gcaa git\ add\ --all\ \&\&\ git\ commit\ -m\ \'Autocommit\'\ \&\&\ git\ pull\ \&\&\ git\ push # imported from a universal variable, see `help abbr`
abbr -a -- chrome /Applications/Google\\\ Chrome.app/Contents/MacOS/Google\\\ Chrome # imported from a universal variable, see `help abbr`
abbr -a -- dfiles 'cd $HOME/dotfiles' # imported from a universal variable, see `help abbr`
abbr -a -- n 'cd ~/notes && lg' # imported from a universal variable, see `help abbr`
abbr -a -- chrome-edge /Applications/Google\\\ Chrome.app/Contents/MacOS/Google\\\ Chrome\ \ --user-agent=\"Mozilla/5.0\ \(Macintosh\;\ Intel\ Mac\ OS\ X\ 10_15_7\)\ AppleWebKit/537.36\ \(KHTML,\ like\ Gecko\)\ Chrome/112.0.0.0\ Safari/537.36\ Edg/112.0.0.0\" # imported from a universal variable, see `help abbr`
abbr -a -- covfefe 'caffeinate -disu' # imported from a universal variable, see `help abbr`
abbr -a -- editfiles 'cd $HOME/dotfiles' # imported from a universal variable, see `help abbr`
abbr -a -- gl 'git log --oneline --decorate --graph' # imported from a universal variable, see `help abbr`
abbr -a -- edittmux 'vim ~/.tmux.conf' # imported from a universal variable, see `help abbr`
abbr -a -- addpath 'set -U -a fish_user_path' # imported from a universal variable, see `help abbr`
abbr -a -- editfish 'cd $HOME/.config/fish && nvim config.fish' # imported from a universal variable, see `help abbr`
abbr -a -- editnvim 'cd ~/.config/nvim && nvim' # imported from a universal variable, see `help abbr`
abbr -a -- p pnpm # imported from a universal variable, see `help abbr`
abbr -a -- editnvchad 'cd ~/.config/nvim/lua/custom && nvim ~/.config/nvim/lua/custom/chadrc.lua && cd -' # imported from a universal variable, see `help abbr`
abbr -a -- cdpacker 'cd $HOME/.local/share/nvim/site/pack/packer/start' # imported from a universal variable, see `help abbr`
abbr -a -- editnvimp 'nvim ~/.config/nvim/lua/user/plugins.lua' # imported from a universal variable, see `help abbr`
abbr -a -- drun 'bash $HOME/dotfiles/scripts/docker_run.sh' # imported from a universal variable, see `help abbr`
abbr -a -- editmacos 'vim ~/.macos' # imported from a universal variable, see `help abbr`
abbr -a -- ta 'tmux new-session -A -s main' # imported from a universal variable, see `help abbr`
abbr -a -- editvim 'vim ~/.vimrc' # imported from a universal variable, see `help abbr`
abbr -a -- g git # imported from a universal variable, see `help abbr`
abbr -a -- mk 'make -j8' # imported from a universal variable, see `help abbr`
abbr -a -- gca 'git add --all && git commit && git push' # imported from a universal variable, see `help abbr`
abbr -a -- gf 'cd /goinfre/ykimirti' # imported from a universal variable, see `help abbr`
abbr -a -- git-local-branch-clean git\ branch\ --merged\ \|\ egrep\ -v\ \"\(^\\\*\|master\|dev\)\"\ \|\ xargs\ git\ branch\ -d # imported from a universal variable, see `help abbr`
abbr -a -- gs 'git status --short' # imported from a universal variable, see `help abbr`
abbr -a -- fen 'funced -e nvim' # imported from a universal variable, see `help abbr`
abbr -a -- vimfzf 'vim (fzf)' # imported from a universal variable, see `help abbr`
abbr -a -- ll 'exa -alh' # imported from a universal variable, see `help abbr`
abbr -a -- najs 'cowsay najs' # imported from a universal variable, see `help abbr`
abbr -a -- nh norminette\ \|\ grep\ -E\ \'^Error:\ \|Error!\'\ \|\ head # imported from a universal variable, see `help abbr`
abbr -a -- tree 'exa --tree' # imported from a universal variable, see `help abbr`
abbr -a -- sim 'open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app' # imported from a universal variable, see `help abbr`
abbr -a -- editgit 'nvim ~/.gitconfig' # imported from a universal variable, see `help abbr`
abbr -a -- vv '. .venv/bin/activate.fish'
