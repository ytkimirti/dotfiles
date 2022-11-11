#!/bin/bash

if ! docker build -t ytkimirti/dotfiles .
then
	echo "Error while building" && exit 1
fi

echo "> Running the container"

if ! docker run --name dotfiles -dit ytkimirti/dotfiles
then
	echo "Error while running" && exit 1
fi

echo "> Attaching to the container"
docker attach dotfiles
# docker start -a dotfiles

echo "> Stopping processes"
docker stop dotfiles
docker rm dotfiles

docker ps -a
