#!/bin/bash

# https://tecadmin.net/install-oracle-java-11-on-debian-9-stretch/


sudo apt install -y dirmngr
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EA8CACC073C3DB2A
echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/linuxuprising-java.list

sudo apt update
sudo apt install -y oracle-java11-installer
sudo apt install -y oracle-java11-set-default


