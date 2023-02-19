#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

export LC_MESSAGES=ja_JP.UTF-8

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

# IM=fcitx
IM=ibus

export DefaultImModule=$IM
export GTK_IM_MODULE=$IM
export QT_IM_MODULE=$IM
export XMODIFIERS="@im=$IM"


export BROWSER=/usr/bin/google-chrome-stable

# -d: daemonize
# -r: replace
# -x: xim
# ibus-daemon --verbose -rx &> ~/.ibus.log &
case "$IM" in
    "fcitx" ) fcitx5 &> ~/.fcitx5.log & ;;
    "ibus" ) ibus-daemon --verbose -rxrR &> ~/.ibus.log & ;;
esac

setxkbmap -option ctrl:nocaps

# set keyboard repeat rate.
# first number=initial delay
# second number=freq
xset r rate 200 30

# -------------------------------------------------------------------------
# synergy - share mouse/keyboard
# -------------------------------------------------------------------------

# change 解像度
# xrandr --output HDMI-0 --mode 1920x1080

# -------------------------------------------------------------------------
# xbindkeys - keyremapper
# -------------------------------------------------------------------------

# enable shortcut keys in ~/.xbindkeysrc
# xbindkeys


gnome-keyring-daemon &

caffeine &

# -------------------------------------------------------------------------
# xremap - key remapper like karabiner, autohotkey
# ------------------------------------------------------------------------- 
xremap --watch ~/dotfiles/config/xremap.yml &

# -------------------------------------------------------------------------
# Run window manager
# -------------------------------------------------------------------------

# stumpwm, `C-3` based screen like operation.
# exec stumpwm
# run polybar(DO NOT RUN IF YOU ARE USING *awesome*)
# ~/.config/polybar/launch.sh

exec i3

# win+enter -> run terminal
# win+C-r   -> restart awesome
# win+S-q   -> quit awesome
# win+s     -> show help
# exec awesome

