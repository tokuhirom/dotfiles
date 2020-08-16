#!/bin/bash

set -ex

BASEDIR=$(dirname "$0")
pacman -S --needed - < $BASEDIR/arch/pkglist.txt
yay -S --needed - < $BASEDIR/arch/yaylist.txt

