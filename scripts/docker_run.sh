#!/bin/bash

NAME=${1:-personal_linux}

OTHER_ARGS="${@:2}"

if [[ "$OTHER_ARGS" == *"--pwd"* ]]; then
  RUN_ARGS="-v $PWD:/pwd"
fi

if docker ps | grep "$NAME" >/dev/null
then
	echo "> Container is already running. Attaching to it"
	docker attach "$NAME"
	exit
fi
if docker ps -a | grep "$NAME" >/dev/null
then
	echo "> Container is stopped. Starting..."
	docker start "$NAME"
	echo "> Attaching..."
	docker attach "$NAME"
	exit
fi

echo "> No container found. Building fresh image"
if ! docker build -t ytkimirti/dotfiles "$HOME"/dotfiles/
then
	echo "Error while building" && exit 1
fi

echo "> Running the container"
if ! docker run $RUN_ARGS --name "$NAME" --cap-add=SYS_PTRACE -dit ytkimirti/dotfiles 
then
	echo "Error while running" && exit 1
fi

echo "> Attaching to the container"
docker attach "$NAME"

docker ps -a
