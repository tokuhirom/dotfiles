#!/bin/bash
sudo apt-get -y install build-essential
sudo apt-get -y install cpanminus
curl -sL https://deb.nodesource.com/setup_11.x | sudo bash -
sudo apt-get -y install nodejs
sudo apt-get -y install python3 iputils-ping
sudo apt autoremove

