
# Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


#FZF install
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git config --global url.ssh://git@github.com/.insteadOf https://github.com/

git config --global user.name "Yusuf"
git config --global user.email yusuftaha9@gmail.com
git config --global diff.tool vimdiff
git config --global difftool.prompt false
