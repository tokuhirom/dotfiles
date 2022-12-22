#!/bin/bash
set -eux

if [ ! -d ~/.plenv ]; then
    git clone https://github.com/tokuhirom/plenv.git ~/.plenv
fi

if [ ! -d ~/.plenv/plugins/perl-build/ ]; then
    git clone https://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
fi


