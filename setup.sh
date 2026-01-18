#!/bin/bash

if [ -e /etc/arch-release ]; then
    ./setup/setup-arch.sh
fi

if [ -e /etc/pop-os/lsb-release ]; then
    ./setup/setup-popos-desktop.sh
fi

if [ -e /Users ]; then
    ./setup/setup-mac-settings.sh
    ./setup/setup-mac.sh
fi

./setup/setup-git.sh
./setup/setup-plenv.sh
./setup/setup-vimplug.sh
./setup/setup-tmux.sh
./setup/setup-alacritty.sh
./setup/setup-go.sh
./setup/setup-mise.sh
./setup/setup-claude.sh

