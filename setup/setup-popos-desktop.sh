#!/bin/bash

# === 基本 CLI ツール ===
sudo apt install -y vim tmux fzf ripgrep bat jq fd-find gh
sudo apt install -y neovim zsh git-lfs silversearcher-ag
sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting

# === 開発ツール ===
sudo apt install -y cmake make automake mercurial
sudo apt install -y python3 ipython3 ruby luajit luarocks

# === CLI ユーティリティ ===
sudo apt install -y pandoc graphviz ditaa direnv
sudo apt install -y btop entr htop tree watch parallel
sudo apt install -y curl wget nmap whois
sudo apt install -y unzip gzip bzip2 xz-utils

# === ビルド用ライブラリ ===
sudo apt install -y libssl-dev zlib1g-dev libreadline-dev libncurses-dev

# === その他 ===
sudo apt install -y docker.io bvi w3m nodejs valgrind

# desktop
sudo apt install -y xsel gnome-tweaks slack

# クリップボード
sudo apt install -y xclip wl-clipboard

# ウィンドウ管理
sudo apt install -y i3 i3status i3lock rofi polybar dunst xss-lock

# フォント
sudo apt install -y fonts-noto fonts-noto-cjk fonts-noto-color-emoji fonts-font-awesome

# 日本語入力 (IME)
sudo apt install -y ibus ibus-mozc

# X11 ユーティリティ
sudo apt install -y x11-utils x11-xserver-utils arandr

# キーリマップ（xremap は cargo install or release バイナリで別途導入）

# スクリーンショット
sudo apt install -y flameshot

# akaza deps
sudo apt install -y libgdk-pixbuf-2.0-dev libgtk-4-dev libibus-1.0-dev libmarisa-dev

# cosmic-term don't supports ibus
sudo apt purge cosmic-term
