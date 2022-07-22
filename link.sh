#!/bin/bash

set -e

# Mac.
if [ -d /Users/ ]; then
    [[ ! -e $HOME/dotfiles ]] && ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/dotfiles" $HOME/dotfiles
    # [[ ! -e $HOME/howm ]] && ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/howm" $HOME/howm

    for service in me.geso.journalsync me.geso.dotfilessync
    do
        if [ ! -e $HOME/Library/LaunchAgents/$service.plist ]; then
            echo "setup $service"
            ln -s $HOME/dotfiles/launchd/$service.plist $HOME/Library/LaunchAgents/$service.plist
            launchctl load ~/Library/LaunchAgents/$service.plist
        fi
    done
fi

function link {
    local fname=$1
    local src="$HOME/dotfiles/$fname"
    local dst="$HOME/$fname"
    if [ ! -e $dst ]; then
        mkdir -p $(dirname $dst)
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
link ChangeLog
link .fullmoon.ini
link .npmrc
link .xprofile
link .xinitrc
link .profile
link .stumpwmrc
link .xbindkeysrc
link .Xmodmap
link .pam_environment
link .yabairc
link .skhdrc
link .Rprofile

link .config/mimeapps.list
link .config/polybar/config
link .config/polybar/launch.sh
link .config/i3/config
link .config/terminator/config
link .config/awesome/rc.lua
link .config/fcitx/config
link .config/weston.ini
link .config/cagebreak/config

mkdir -p ~/.vim/tmp/


[[ ! -e $HOME/Documents/Alfred ]] && ln -s $HOME/dotfiles/Alfred $HOME/Documents/Alfred
