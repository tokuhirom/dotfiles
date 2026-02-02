#!/bin/bash
set -eu

# mise のインストール
if ! command -v mise &>/dev/null && [ ! -e ~/.local/bin/mise ]; then
    curl https://mise.run | sh
fi

MISE="${HOME}/.local/bin/mise"
if command -v mise &>/dev/null; then
    MISE="mise"
fi

eval "$($MISE activate bash)"
mise install
