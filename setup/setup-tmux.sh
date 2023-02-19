#!/bin/bash
if [ -e ~/.tmux/plugins/tpm ]; then
    echo "~/.tmux/plugins/tpm already exists"
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
