#!/bin/bash
curl -sL https://deb.nodesource.com/setup_11.x | sudo bash -
sudo apt-get -y install nodejs
sudo apt-get -y install build-essential
sudo apt-get -y install cpanminus
sudo apt-get -y install python3 iputils-ping linuxbrew-wrapper tmux
# note. i can't install android-studio on pixelbook using linuxbrew.
sudo apt autoremove

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
