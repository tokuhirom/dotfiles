#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap $HOME/.Xmodmap
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export BROWSER=/usr/bin/google-chrome-stable


fcitx &

joplin-desktop &

setxkbmap -option ctrl:nocaps

# set keyboard repeat rate.
# first number=initial delay
# second number=freq
xset r rate 200 30

# -------------------------------------------------------------------------
# synergy - share mouse/keyboard
# -------------------------------------------------------------------------

synergy &

# change 解像度
xrandr --output HDMI-0 --mode 1920x1080

# -------------------------------------------------------------------------
# xbindkeys - keyremapper
# -------------------------------------------------------------------------

# enable shortcut keys in ~/.xbindkeysrc
# xbindkeys

# -------------------------------------------------------------------------
# xkeysnail - key remapper like karabiner, autohotkey
# ------------------------------------------------------------------------- 

gnome-keyring-daemon &

# run keyboard shortcuts
xhost +SI:localuser:xkeysnail
# /etc/xkeysnail.py is link of ~/dotfiles/xkeysnail/config.py
sudo -u xkeysnail DISPLAY=:0 /usr/bin/xkeysnail /etc/xkeysnail.py &
# sudo xkeysnail --quiet ~/dotfiles/xkeysnail/config.py &

# run polybar(DO NOT RUN IF YOU ARE USING *awesome*)
~/.config/polybar/launch.sh

# -------------------------------------------------------------------------
# Run window manager
# -------------------------------------------------------------------------

# stumpwm, `C-3` based screen like operation.
exec stumpwm
# exec i3

# win+enter -> run terminal
# win+C-r   -> restart awesome
# win+S-q   -> quit awesome
# win+s     -> show help
# exec awesome

