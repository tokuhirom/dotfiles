#!/bin/bash
yay -Rs $(yay -Qqe |grep fcitx5)
yay -S  --needed --noconfirm ibus ibus-qt ibus-anthy ibus-mozc

