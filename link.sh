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

# all platforms
link .bashrc
link .vimrc
link .tmux.conf
link .gitignore_global
link .zshrc
link .Rprofile
link .config/nvim
link .config/bat/config
link .screenrc

# mac only
if [ -d /Users ]; then
    link .yabairc
    link .skhdrc
fi

# linux only
if [ -d /home ]; then
    link .xinitrc

    link .config/mimeapps.list
    link .config/i3/config
    link .config/fcitx5
    link .config/polybar/config
    link .config/polybar/launch.sh
    link .config/wezterm/wezterm.lua
    link .config/akaza/config.yml
fi

mkdir -p ~/.vim/tmp/

