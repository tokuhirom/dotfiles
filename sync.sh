#!/bin/bash
set -ex

cd $HOME/dotfiles
git add .
git commit -a -m 'sync'

git push origin master
git pull origin master
