#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

sudo apt -y install w3m curl
sudo apt -y install nodejs tree
sudo apt -y install build-essential
sudo apt -y install openjdk-11-jdk-headless
sudo apt -y install python3 iputils-ping tmux vim-nox silversearcher-ag
sudo apt -y install zsh
sudo apt -y install peco bat

sudo apt autoremove

~/dotfiles/setup-vimplug.sh
