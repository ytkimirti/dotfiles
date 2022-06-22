#!/bin/bash

if [[ ! -d "/goinfre/$USER" ]]
then
	echo "No /goinfre found. Exiting"
	exit 1
fi

if [[ -z "$1" ]]
then
	echo "Usage: ./linkto_goinfre.sh <path_from_home>"
	echo "Example"
	echo "./linkto_goinfre.sh Library/Caches"
	echo "./linkto_goinfre.sh Library/Unity"
	exit 1
fi

# linkfolder Library/Caches
mkdir -p /goinfre/$USER/$1

if [[ ! -L "/$HOME/$1" ]]
then
	ln -s /goinfre/$USER/$1/ $HOME/$1
	echo "Created link ~/$1 -> /goinfre/$USER/$1"
else
	echo "Link ~/$1 already exists... Skipping"
	exit 0
fi

if [ ! -L "/$HOME/$1" ] && [ -d "/$HOME/$1" ]
then
	echo "The directory ~/$1 is moving to ~/$1_backup"
	mv "/$HOME/$1" "/$HOME/$1_backup"
fi

