#!/bin/bash

set -ex

pacman -Qqe > arch/pkglist.txt

BASEDIR=$(dirname "$0")
sudo pacman -S --needed - < $BASEDIR/arch/pkglist.txt

