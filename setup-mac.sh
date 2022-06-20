#!/bin/bash
bash link.sh

if [[ ! -e $HOME/.sdkman/bin/sdkman-init.sh ]]; then
    unset SDKMAN_DIR
    curl -s "https://get.sdkman.io" | bash
fi


./setup-mac-settings.sh

if [[ ! -e /usr/local/bin/brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle


