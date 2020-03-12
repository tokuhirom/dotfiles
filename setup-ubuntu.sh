#!/bin/bash

curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -

sudo apt-get update
sudo apt-get upgrade

sudo apt-get -y install nodejs w3m
sudo apt-get -y install build-essential
sudo apt-get -y install cpanminus perl-doc
sudo apt-get -y install openjdk-11-jdk-headless
sudo apt-get -y install python3 iputils-ping tmux vim-nox silversearcher-ag

# cargo for building bat...
# Ubuntu 19.x has bat deb package...but latest LINE doesn't have it.
sudo apt-get -y install cargo llvm libclang-dev
cargo install bat

# VPN
sudo apt-get install -y libgnome-keyring0 libproxy1-plugin-webkit libwebkitgtk-1.0.0

# sudo apt-get -y install linuxbrew-wrapper
# note. i can't install android-studio on pixelbook using linuxbrew.
sudo apt autoremove

~/dotfiles/setup-vimplug.sh