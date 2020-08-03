#!/bin/bash
set -ex

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt update
sudo apt upgrade

sudo apt install -y nodejs

