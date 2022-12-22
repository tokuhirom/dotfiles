#!/bin/bash

# -------------------------------------------------------------------------
# fonts
# -------------------------------------------------------------------------
sudo apt install -y locales-all
sudo apt install -y fonts-ipafont fonts-noto
sudo apt install -y fonts-noto-cjk fonts-noto-cjk-extra
sudo apt install -y language-pack-ja

# -------------------------------------------------------------------------
# shohex san said, fcitx is better than ibus.
# -------------------------------------------------------------------------
sudo apt install fcitx fcitx-mozc --install-recommends

# -------------------------------------------------------------------------
# java related tools
# -------------------------------------------------------------------------
sudo apt install -y visualvm

# -------------------------------------------------------------------------
# xfce4
# -------------------------------------------------------------------------
sudo apt install xfce4
sudo apt install lightdm
sudo apt install -y xfce4-goodies

# -------------------------------------------------------------------------
# purge too heavy DM
# -------------------------------------------------------------------------
sudo apt purge gdm3

