#!/usr/local/bin/fish

set ndir "$HOME/.config/nvim"
set repo "https://github.com/NvChad/NvChad"

if not type -q nvim
   echo " No nvim found on path, returning..."
   exit 1
end

function err
   echo (set_color red)$argv[1](set_color normal)
   exit 1
end

echo "🔎 Checking if nvchad is installed..."

function install_chad
   if test -d $ndir
      echo Moving $(set_color yellow)$ndir$(set_color normal) to $(set_color yellow){$ndir}_old$(set_color normal)
      mv $ndir {$ndir}_old
   end

   echo Cloning to $(set_color yellow)$ndir$(set_color normal)

   if git clone --depth 1 $repo $ndir
      echo "$(set_color green)Done!$(set_color normal)"
   else
      err "Error while cloning"
   end
end

if test -d "$ndir"; and test -d "$ndir/.git"

   echo "A git repo exists inside $(set_color yellow)~/.config/nvim$(set_color normal)"

   set url (cd $ndir; git remote get-url (git remote))
   if test $url = "$repo"
      echo Repo urls match (set_color yellow)$url(set_color normal)
      echo "$(set_color green)NvChad already installed$(set_color normal)"
   end
else
   install_chad
end

# Link nvchadrc file here

set lfile $ndir/lua/custom
set ldir $HOME/dotfiles/files/nvchad/custom/

if test -d $lfile; and not test -L $lfile
   echo "custom dir is a directory?!?!? Moving it to ~/tmp/"
   mkdir -p ~/tmp
   mv $lfile ~/tmp/
end

if test -L $lfile
   if test (readlink $lfile) = $ldir
      echo "✅ $(set_color green)Symlink already installed$(set_color normal)"
      exit 0
   else
      echo A symlink exists but to the wrong path of (readlink $lfile)
      echo Removing
      rm -rf $lfile
   end
end

echo "Creating $lfile -> $ldir"
ln -s $ldir $lfile


echo (set_color green)"ALL DONE *chef's kiss*"(set_color normal)
