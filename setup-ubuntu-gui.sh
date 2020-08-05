#!/bin/bash

# sudo apt install -y firefox-esr
# fcitx-mozc

sudo apt install -y locales-all
sudo apt install -y fonts-ipafont fonts-noto
sudo apt install -y fonts-noto-cjk fonts-noto-cjk-extra
sudo apt install -y language-pack-ja

sudo apt install -y ibus-mozc

# for dayflower's LINE vpn script
# PulseSecure/NSA
sudo apt install -y openconnect python3-metaconfig
sudo apt install -y python2 python-keyring

# xfce4
sudo apt install xfce4
sudo apt install lightdm

sudo apt purge gdm3

# albert
# Alfred like command launcher.
# https://albertlauncher.github.io/docs/installing/
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O "/etc/apt/trusted.gpg.d/home:manuelschneid3r.asc"
sudo apt update
sudo apt install albert


# --------------------------------------------------------------
# wine for LINE app
# --------------------------------------------------------------
sudo apt install wine winbind winetricks
# install IME
winetricks allfonts

