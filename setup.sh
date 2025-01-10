#!/bin/bash

if [ -e /etc/arch-release ]; then
    ./setup/setup-arch.sh
fi

if [ -e /Users ]; then
    ./setup/setup-mac-settings.sh
    ./setup/setup-mac.sh
fi

./setup/setup-git.sh
./setup/setup-R.sh
./setup/setup-plenv.sh
./setup/setup-vimplug.sh
./setup/setup-tmux.sh

