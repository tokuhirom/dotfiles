#!/bin/sh
sudo yum update
sudo yum install -y epel-release
sudo yum install -y tmux screen
sudo yum install -y git vim python-pip zsh rubygem-bundler
sudo yum install -y openssl-devel ruby-devel
sudo yum install -y java-11-openjdk
sudo yum groupinstall -y 'Development tools'

