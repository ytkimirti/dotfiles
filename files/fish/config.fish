set -gx CLEAN_PATH "$PATH"
# When running a script etc. The shell is not interactive
if status is-interactive
    set -g fish_keyboard_protocol none
end

if type -q nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
end

if [ -d /goinfre ]
    set -gx IS_ECOLE true

    set -gx ECOLE_MAIL "ykimirti@42istanbul.com.tr"
    set -gx ECOLE_USER ykimirti
end

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden'

# Homebrew stuff
if [ "$IS_ECOLE" = true ]
    set -gx RUSTUP_HOME "/goinfre/$USER/.rustup"
    set -gx CARGO_HOME "/goinfre/$USER/.cargo"

    set -gx HOMEBREW_PREFIX "$HOME/mybin/homebrew"
    set -gx HOMEBREW_CELLAR "$HOME/mybin/homebrew/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOME/mybin/homebrew"
else
    set -gx RUSTUP_HOME "$HOME/.rustup"
    set -gx CARGO_HOME "$HOME/.cargo"

    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
end

set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK 1

set -q PATH; or set PATH ''
set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH
set -q MANPATH; or set MANPATH ''
set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH

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

if [ -d $HOME/.local/bin ]
    set -gxp PATH "$HOME/.local/bin"
end

set -gxp PATH "$HOME/miniconda3/bin"
set -gxp PATH "$HOME/.fzf/bin"
set -gxp PATH "$CARGO_HOME/bin"
set -gxp PATH "$HOME/go/bin"
set -gxp PATH "$HOME/.bun/bin"
set -gxp PATH /opt/metasploit-framework/bin

set -gxp PATH "$HOME/Library/Android/sdk/platform-tools"
set -gxp PATH "$HOME/Library/Android/sdk/tools"
set -gxp PATH "$HOME/Library/Android/sdk/emulator"

set -gxp PATH "$HOME/Library/Application Support/Code/User/globalStorage/ziglang.vscode-zig/zig_install"



set -gx LC_ALL "en_US.UTF-8"

if type -q id
    set -gx GROUP (id -gn $USER)
end

abbr -a -- gla 'git log --oneline --decorate --graph --all'
abbr -a -- dfiles 'cd $HOME/dotfiles'
abbr -a -- n 'cd ~/notes && lg'
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
abbr -a -- r ranger
abbr -a -- t turbo
abbr -a -- lgh "export HUSKY=0 && lg && set -e HUSKY"
abbr -a -- stremio-clean 'rm -rf "/Users/kimirti/Library/Application Support/stremio-server/streamio-cache"'
abbr -a -- qs 'pnpx @upstash/qstash-cli dev'

abbr -a -- c claude

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

if type -q fnm
    fnm env --use-on-cd --log-level=quiet --shell fish | source
end

# Added by Windsurf
fish_add_path /Users/kimirti/.codeium/windsurf/bin

# Added by Antigravity
fish_add_path /Users/kimirti/.antigravity/antigravity/bin
