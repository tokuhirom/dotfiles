#!/bin/bash

# dotfiles の symlink を作成するスクリプト

set -e

DOTFILES_DIR="$HOME/dotfiles"

function link {
    local fname=$1
    local src="$DOTFILES_DIR/config/$fname"
    local dst="$HOME/$fname"
    if [ ! -e "$dst" ]; then
        mkdir -p "$(dirname "$dst")"
        echo "Linking $src -> $dst"
        ln -s "$src" "$dst"
    else
        echo "Exists $dst"
    fi
}

# === 全プラットフォーム共通 ===

# シェル設定
link .bashrc
link .zshrc

# エディタ設定
link .vimrc
link .ideavimrc
link .emacs.d

# ターミナルマルチプレクサ
link .tmux.conf
link .screenrc

# Git
link .gitconfig
link .gitignore_global

# R
link .Rprofile

# XDG config
link .config/nvim
link .config/bat/config
link .config/ghostty
link .config/starship.toml
link .config/alacritty
link .config/fish/config.fish
link .config/fish/fish_plugins
link .config/mise/config.toml
link .config/zellij/config.kdl
link .config/ranger
link .config/topydo
link .config/aerospace/aerospace.toml
link .config/sketchybar

link .claude/skills/tagpr/SKILL.md
link .claude/skills/deprecate-cpan-module/SKILL.md

# Hammerspoon
link .hammerspoon/init.lua

# === macOS 固有 ===
if [ "$(uname)" = "Darwin" ]; then
    link .yabairc
    link .skhdrc
fi

# === Linux 固有 ===
if [ "$(uname)" = "Linux" ]; then
    link .xinitrc
    link .config/i3/config
    link .config/polybar/config
    link .config/polybar/launch.sh
    link .config/wezterm/wezterm.lua
    link .config/xremap/config.yml
    link .config/environment.d/ibus.conf
fi

# Vim 用一時ディレクトリ
mkdir -p ~/.vim/tmp/
