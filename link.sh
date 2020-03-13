#!/bin/bash

set -e

# Mac.
if [ -d /Users/ ]; then
    [ ! -e $HOME/dotfiles ] && ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/dotfiles" $HOME/dotfiles
    [ ! -e $HOME/howm ] && ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/howm" $HOME/howm
fi

function link {
    local fname=$1
    local src="$HOME/dotfiles/$fname"
    local dst="$HOME/$fname"
    if [ ! -e $dst ]; then
        echo "Linking $src $dst"
        if [ -e /git-bash.exe ]; then
            # git-bash doesn't support symlink
            ln "$src" "$dst"
        else
            ln -s "$src" "$dst"
        fi
    else
        echo "Exists $dst"
    fi
}

link .screenrc
link .bashrc
link .pause
link .itsc-servers
link .emacs
link .zshrc
link .tmux.conf
link .vimrc
link .gitignore_global
link .zprofile
link .inputrc

mkdir -p ~/.vim/tmp/

