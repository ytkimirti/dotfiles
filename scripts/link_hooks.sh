#!/bin/bash
# Point this repo's git hooks at the tracked hooks/ dir.
set -eu

cd ~/dotfiles
git config core.hooksPath hooks
chmod +x hooks/*
echo "👌 git hooks linked (core.hooksPath=hooks)"
