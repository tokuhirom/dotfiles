#!/bin/bash

set -ex

# install: pacman -S pkgname
# search:  pacman -Ss keyword

# yay
# yay is the wrapper for AUR and pacman.
if [[ -e /usr/bin/yay ]]; then
    echo "yay exists"
else
    git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si
fi


# update list
sudo pacman -Syu

# manage mirror site
yes | sudo pacman -S reflector
sudo reflector --country 'Japan' --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# update list
yay -Syyu

# core
sudo pacman -S --needed --noconfirm openssh vim git tmux sudo git-lfs gcc base-devel go the_silver_searcher zsh w3m curl wget

# nvidia driver(if needed)
sudo pacman -S --needed --noconfirm nvidia

# network
# network-manager-applet=nm-applet
sudo pacman -S --needed --noconfirm networkmanager network-manager-applet
sudo systemctl enable NetworkManager


# X
yay -S --needed --noconfirm wezterm firefox i3lock xdg-utils xsel
yay -S --needed --noconfirm google-chrome
yay -S --needed --noconfirm obsidian
# xremap
yay -S --needed --noconfirm xremap-x11-bin
echo uinput | sudo tee /etc/modules-load.d/uinput.conf
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-input.rules
# startx
yay -S --needed --noconfirm xorg-xinit
# screenshot
yay -S --needed --noconfirm maim

# visual studio code
yay -S --needed --noconfirm code

# stumpwm
# yay -S --needed --noconfirm rofi stumpwm i3lock jumpapp

# awesome
# sudo pacman -S --needed --noconfirm awesome

# i3
yay -S --needed --noconfirm rofi i3-wm polybar xss-lock dunst i3lock

# Japanese
yay -S --needed --noconfirm adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts otf-ipafont noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-unifont siji-ng
yay -S --needed --noconfirm ttf-mona ttf-monapo ttf-ipa-mona ttf-vlgothic ttf-mplus ttf-koruri ttf-sazanami ttf-hanazono ttf-ms-fonts ttf-twemoji
# shohex san said, fcitx is better than ibus.
yay -S --needed --noconfirm fcitx5-mozc-ut fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-im

# IDEA
yay -S --needed --noconfirm intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre
yay -S --needed --noconfirm jetbrains-fleet

# Ultimate hacking keyboard
yay -S --needed --noconfirm uhk-agent-appimage

# perl
yay -S --needed --noconfirm perl-lwp-protocol-https

# ruby
yay -S --needed --noconfirm ruby

# r
yay -S --needed --noconfirm r

# development
sudo pacman -S --needed --noconfirm valgrind

# Enable multilib
yay -S --needed --noconfirm steam

# Chatting
yay -S --needed --noconfirm slack-electron

# sway
yay -S --needed --noconfirm sway

# twitter
yay -S --needed --noconfirm moderndeck


