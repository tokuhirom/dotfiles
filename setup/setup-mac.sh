#!/bin/bash
if [[ ! -e /usr/local/bin/brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle

brew tap homebrew/autoupdate
brew autoupdate start --upgrade --clean

