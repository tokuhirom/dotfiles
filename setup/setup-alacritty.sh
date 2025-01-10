#!/bin/bash
mkdir -p ~/.local/share/alacritty/themes

if [ -d ~/.local/share/alacritty/themes/.git ]; then
  cd ~/.local/share/alacritty/themes && git pull
else
  git clone https://github.com/alacritty/alacritty-theme ~/.local/share/alacritty/themes
fi


