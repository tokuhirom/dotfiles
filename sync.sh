#!/bin/bash
for dir in $HOME/dotfiles $HOME/diary
do
    cd $dir
    git add .
    git commit -a -m 'sync'
    git push origin master
    git pull origin master
done
