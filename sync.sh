#!/bin/bash
set -ex

BASEDIR=$(dirname "$0")

if [ -e /etc/arch-release ]; then
    pacman -Qqe > $BASEDIR/arch/pkglist.txt
fi

cd $HOME/dotfiles
git add .
git commit -a -m 'sync'

git push origin master
git pull origin master

