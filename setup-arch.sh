#!/bin/bash

set -ex

BASEDIR=$(dirname "$0")
sudo pacman -S --needed - < $BASEDIR/arch/pkglist.txt

