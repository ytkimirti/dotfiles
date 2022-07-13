alias c set_color

set -l file $argv[1]
if [ -d $HOME/dotfiles/files/$file ] # For directories

    set -l lfile $HOME/.config/$file
    # if is a link, rename
    if [ -L "$lfile" ] && [ -d "$lfile" ]
        # echo "🤔 $lfile is a symlink to a directory"
        if  [ (readlink $lfile) = "$HOME/dotfiles/files/$file/" ]
            echo 💨 (c yellow)$file(c reset) folder set up, skipping...
            return
        else
            echo 🧹 $HOME/.config/$file already exists, renaming it to {$file}_backup
            mv $HOME/.config/$file $HOME/.config/{$file}_backup
        end
    else if [ -d $HOME/.config/$file ] # if directory already exists
        echo 🧹 $HOME/.config/$file already exists, renaming it to {$file}_backup
        mv $HOME/.config/$file $HOME/.config/{$file}_backup
    end
    ln -s ~/dotfiles/files/$file/ ~/.config/$file
    echo "~/.config/$file  ->  ~/dotfiles/files/$file/"

else if [ -f $HOME/dotfiles/files/$file ] # For files
    set -l lfile $HOME/$file
    # if is a link, rename
    if [ -L "$lfile" ] && [ -f "$lfile" ]
        # echo 🤔 $lfile is a symlink to a (c green)file(c reset)
        if  [ (readlink $lfile) = "$HOME/dotfiles/files/$file" ]
            echo 💨 (c green)$file(c reset) set up, skipping...
            return
        else
            echo 🧹 $HOME/$file already exists, renaming it to {$file}_backup
            mv $HOME/$file $HOME/{$file}_backup
        end
    else if [ -f $HOME/$file ] # if file already exists
        echo 🧹 $HOME/$file already exists, renaming it to {$file}_backup
        mv $HOME/$file $HOME/{$file}_backup
    end
    ln -s ~/dotfiles/files/$file ~/$file
    echo "✅ ~/.config/$file  ->  ~/dotfiles/files/$file"
else
    c red
    echo "File $file not if ~/dotfiles/files"
    c reset
end
