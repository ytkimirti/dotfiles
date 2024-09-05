# When running a script etc. The shell is not interactive
if status is-interactive

end

if type -q nvim
	set -gx EDITOR nvim
else if type -q vim
	set -gx EDITOR vim
end

if [ -d /goinfre ]
	set -gx IS_ECOLE true

	set -gx ECOLE_MAIL "ykimirti@42istanbul.com.tr"
	set -gx ECOLE_USER "ykimirti"
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

set -gx HOMEBREW_NO_AUTO_UPDATE "1"
set -gx HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK "1"

set -q PATH; or set PATH ''; set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

# Set modes for these vars to path, (':' seperated)
set --path LIBRARY_PATH
set --path C_INCLUDE_PATH

if [ -d "$HOMEBREW_PREFIX" ]
	set -gxa LIBRARY_PATH "$HOMEBREW_PREFIX/lib"
	set -gxa C_INCLUDE_PATH "$HOMEBREW_PREFIX/include"
	set -gxp INFOPATH "$HOMEBREW_PREFIX/share/info"
end

if [ -d "$HOME/Library/Android/sdk" ]
	set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
end

if [ -d $HOME/mybin/bin ]
	set -gxp PATH "$HOME/mybin/bin"
end

set -gxp PATH "$HOME/miniconda3/bin"
set -gxp PATH "$HOME/.fzf/bin"
set -gxp PATH "$CARGO_HOME/bin"
set -gxp PATH "$HOME/go/bin"
set -gxp PATH "$HOME/.bun/bin"
set -gxp PATH "/opt/metasploit-framework/bin"

set -gxp PATH "$HOME/Library/Android/sdk/platform-tools"
set -gxp PATH "$HOME/Library/Android/sdk/tools"
set -gxp PATH "$HOME/Library/Android/sdk/emulator"

set -gxp PATH "$HOME/Library/Application Support/Code/User/globalStorage/ziglang.vscode-zig/zig_install"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if false and test -f "$HOME/miniconda3/bin/conda"
    eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# pyenv comes after conda so python by default is from pyenv
set -gx PYENV_SHELL fish
set -gx PYENV_ROOT $HOME/.pyenv

# You can manually set shims like this too but with it's own init script, it's safer
# set -gxp PATH $PYENV_ROOT/shims
if type -q pyenv
	pyenv init - | source
end

set -gx LC_ALL "en_US.UTF-8"

if type -q id; set -gx GROUP (id -gn $USER); end

set -gx DENO_INSTALL "$HOME/.deno"
set -gxp PATH "$DENO_INSTALL/bin:$PATH"

abbr -a -- gla 'git log --oneline --decorate --graph --all'
abbr -a -- gra 'git reset --hard HEAD && git clean -fd'
abbr -a -- chrome '/Applications/Google\\\ Chrome.app/Contents/MacOS/Google\\\ Chrome'
abbr -a -- dfiles 'cd $HOME/dotfiles'
abbr -a -- n 'cd ~/notes && lg'
abbr -a -- chrome-edge '/Applications/Google\\\ Chrome.app/Contents/MacOS/Google\\\ Chrome\'' \ --user-agent=\"Mozilla/5.0\ \(Macintosh\;\ Intel\ Mac\ OS\ X\ 10_15_7\)\ AppleWebKit/537.36\ \(KHTML,\ like\ Gecko\)\ Chrome/112.0.0.0\ Safari/537.36\ Edg/112.0.0.0\"
abbr -a -- covfefe 'caffeinate -disu'
abbr -a -- gl 'git log --oneline --decorate --graph'
abbr -a -- editfish 'cd $HOME/.config/fish && nvim config.fish'
abbr -a -- editnvim 'cd ~/.config/nvim && nvim'
abbr -a -- editvim 'vim ~/.vimrc'
abbr -a -- editkitty 'nvim ~/.config/kitty/kitty.conf'
abbr -a -- editgit 'nvim ~/.gitconfig'

abbr -a -- p pnpm
abbr -a -- px pnpx

abbr -a -- cleanvim 'rm -rf $HOME/.local/share/nvim'

abbr -a -- g git
abbr -a -- gca 'git add --all && git commit && git push'
abbr -a -- git-local-branch-clean git\ branch\ --merged\ \|\ egrep\ -v\ \"\(^\\\*\|master\|dev\)\"\ \|\ xargs\ git\ branch\ -d
abbr -a -- gs 'git status --short'

abbr -a -- vf 'nvim (fzf)'
abbr -a -- ll 'exa -alh'
abbr -a -- najs 'cowsay najs'
abbr -a -- nh norminette\ \|\ grep\ -E\ \'^Error:\ \|Error!\'\ \|\ head
abbr -a -- tree 'exa --tree'
abbr -a -- sim 'open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
abbr -a -- vv '. .venv/bin/activate.fish'
abbr -a -- vc "python -m venv .venv"
abbr -a -- gp "git push --no-verify"
abbr -a -- yt "cd ~/Movies/yt && yt-dlp"
abbr -a -- r "ranger"
abbr -a -- t "turbo"
abbr -a -- lgh "export HUSKY=0 && lg && set -e HUSKY"

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
