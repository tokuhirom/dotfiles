#!/bin/bash
export PATH=/home/tokuhirom/.rakudobrew/bin/:$PATH


rakudobrew self-upgrade
rakudobrew build moar '--configure-opts=--moar-option=--debug'

rakudobrew global moar-nom

rakudobrew build-panda

panda --notests install Pod::To::Markdown
panda --notests install Hash::MultiValue
panda install Linenoise
panda install LibraryMake
panda install URI::Escape
panda install HTTP::Tinyish
panda --notests install App::Mi6
panda install Template::Mojo
panda install Pod::Perl6doc
panda install HTTP::Server::Tiny
panda install Crust
panda install Getopt::Tiny
panda install git://github.com/shoichikaji/Pod-Perl6doc.git

# ~/dotfiles/local/bin/perl6-precompile-all

rakudobrew rehash


