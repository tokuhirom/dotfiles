#!/bin/bash
if [ ! -e ~/.local/bin/mise ]; then
    curl https://mise.run | sh
fi

# install build-deps
if [ -d /etc/ubuntu-advantage ]; then
    sudo apt install -y mlocate ncurses-dev libyaml-dev zlib1g-dev \
        autoconf \
        automake \
        libtool \
        build-essential \
        pkg-config \
        bison \
        re2c libxml2-dev libssl-dev libsqlite3-dev libcurl4-openssl-dev \
        libgd-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libwebp-dev \
        libxpm-dev libonig-dev libpq-dev libreadline-dev \
        build-essential libreadline-dev libpq-dev libxml2-dev \
        libssl-dev libcurl4-openssl-dev libjpeg-dev libpng-dev libfreetype6-dev \
        libzip-dev libonig-dev libsqlite3-dev pkg-config autoconf bison re2c \
        libgd-dev libbz2-dev libxslt1-dev libicu-dev
fi

eval "$(~/.local/bin/mise activate bash)"
mise install

