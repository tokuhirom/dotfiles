#!/bin/bash

curl -sL https://deb.nodesource.com/setup_11.x | sudo bash -
sudo apt-get update
sudo apt-get upgrade

sudo apt-get -y install nodejs w3m
sudo apt-get -y install build-essential
sudo apt-get -y install cpanminus
sudo apt-get -y install python3 iputils-ping tmux vim-nox

# BEGIN TRIAL
sudo apt-get -y install adb
# END TRIAL

# sudo apt-get -y install linuxbrew-wrapper
# note. i can't install android-studio on pixelbook using linuxbrew.
sudo apt autoremove

~/dotfiles/setup-vimplug.sh
