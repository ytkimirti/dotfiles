#!/usr/bin/bash

if [[ ! -d "/goinfre" ]]; then
	return
fi
if [[ -L "$HOME/Library/$1" ]]; then
	echo "Link $1 already exists at $HOME/Library/$1. Skipping..."
else
	if [[ ! -d "$HOME/Library/$1" ]]; then
		echo "There is no folder named $1 inside $HOME/Library"
		return
	fi
	mkdir -p /goinfre/Library/$1
	echo "Created directory /goinfre/$USER/Library/$1"
	rm -rf $HOME/Library/$1 /goinfre/$USER/Library/$1
	echo "Deleted folder $HOME/Library/$1"
	ln -s /goinfre/$USER/Library/$1/ $HOME/Library/$1
	echo "Created link"
	ls -la $HOME/Library/$2
fi
