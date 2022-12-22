#!/bin/bash

set -e

function link {
    local fname=$1
    local src="$HOME/dotfiles/config/$fname"
    local dst="$HOME/$fname"
    if [ ! -e $dst ]; then
        mkdir -p $(dirname $dst)
        echo "Linking $src $dst"
        if [ -e /git-bash.exe ]; then
            # windows' git-bash doesn't support symlink
            ln "$src" "$dst"
        else
            ln -s "$src" "$dst"
        fi
    else
        echo "Exists $dst"
    fi
}

link .bashrc
link .vimrc
link .tmux.conf
link .gitignore_global
link .zshrc

link .config/i3/config
link .config/fcitx5

mkdir -p ~/.vim/tmp/

