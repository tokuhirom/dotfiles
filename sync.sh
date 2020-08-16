#!/bin/bash
set -ex

cd $HOME/dotfiles

if [ -e /etc/arch-release ]; then
    yay -Qqe > arch/pkglist.txt
fi

git add .
git commit -a -m 'sync'

git push origin master
git pull origin master

