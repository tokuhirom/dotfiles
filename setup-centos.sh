#!/bin/sh
sudo yum install -y epel-release
sudo yum install -y tmux screen
sudo yum install -y git vim python-pip zsh rubygem-bundler golang
sudo yum install -y openssl-devel ruby-devel
sudo yum install -y java-1.8.0-openjdk-devel java-1.8.0-headless
sudo yum groupinstall -y 'Development tools'

