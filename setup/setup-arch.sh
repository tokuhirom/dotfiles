#!/bin/bash

set -ex

# install: pacman -S pkgname
# search:  pacman -Ss keyword

# update list
sudo pacman -Syu

# core
sudo pacman -S --needed --noconfirm openssh vim git tmux sudo git-lfs gcc base-devel go the_silver_searcher zsh w3m curl wget

# nvidia driver(if needed)
sudo pacman -S --needed --noconfirm nvidia

# manage mirror site
sudo pacman -S reflector
sudo reflector --country 'Japan' --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# network
# network-manager-applet=nm-applet
sudo pacman -S --needed --noconfirm networkmanager network-manager-applet
sudo systemctl enable NetworkManager

# yay
# yay is the wrapper for AUR and pacman.
if [[ -e /usr/bin/yay ]]; then
    echo "yay exists"
else
    git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si
fi


# X
sudo pacman -S --needed --noconfirm wezterm firefox i3lock xdg-utils xsel
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
sudo pacman -S --needed --noconfirm rofi i3-wm polybar xss-lock dunst i3lock

# Japanese
sudo pacman -S --needed --noconfirm adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts otf-ipafont noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-unifont siji-ng
yay -S --needed --noconfirm ttf-mona ttf-monapo ttf-ipa-mona ttf-vlgothic ttf-mplus ttf-koruri ttf-sazanami ttf-hanazono ttf-ms-fonts
# shohex san said, fcitx is better than ibus.
sudo pacman -S --needed --noconfirm fcitx5-mozc fcitx5-configtool fitx5-gtk fcitx5-qt fcitx5-im

# IDEA
yay -S --noconfirm intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre
yay -S --noconfirm jetbrains-fleet

# Ultimate hacking keyboard
yay -S --noconfirm uhk-agent-appimage

./setup-vimplug.sh

# perl
yay -S --noconfirm perl-lwp-protocol-https

# ruby
yay -S --noconfirm ruby

# r
yay -S --noconfirm r

# development
sudo pacman -S --needed --noconfirm valgrind

# Enable multilib
yay -S --noconfirm steam

# Chatting
yay -S --noconfirm slack-electron

# sway
yay -S --noconfirm sway

# twitter
yay -S --noconfirm cawbird


