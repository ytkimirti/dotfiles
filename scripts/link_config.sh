#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: ./link_config.sh <relative_name>"
	echo "Example:"
	echo "./link_config.sh .gitconfig"
	echo "This does ln -s ~/.gitconfig ~/dotfiles/files/.gitconfig"
	exit 1
fi
file=$1

curr=~/dotfiles/files/$file

if [ -d "$curr" ]; then
	# echo "$curr is a directory"
	target=~/.config/$file
	if [ "$(readlink "$target")" = "$curr/" ]; then
		echo "👌 $file"
		exit 0
	fi
	# Rename if already exists
	if [ -d "$target/" ]; then
		echo "An old link already exists. Renaming to $target""_old"
		mv "$target" "$target""_old"
	fi
	# Link
	echo "ln -s $curr/ $target"
	if ln -s "$curr/" "$target"; then
		echo "Done!"
	else
		echo "Error!" && exit 1
	fi
elif [ -f "$curr" ]; then
	# echo "$curr is a file"
	target=~/$file
	if [ "$(readlink "$target")" = "$curr" ]; then
		echo "👌 $file"
		exit 0
	fi
	# Rename if already exists
	if [ -d "$target" ]; then
		echo "An old link already exists. Renaming to $target""_old"
		mv "$target" "$target""_old"
	fi
	# Link
	echo "ln -s $curr $target"
	if ln -s "$curr" "$target"; then
		echo "Done!"
	else
		echo "Error!" && exit 1
	fi
else
	echo "$curr does not exist!" && exit 1
fi
