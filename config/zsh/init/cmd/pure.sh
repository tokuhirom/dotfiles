if [ -d /opt/homebrew ]; then
    fpath+=("/opt/homebrew/share/zsh/site-functions")
else
    if [ ! -d "$HOME/.zsh/pure" ]; then
        mkdir -p "$HOME/.zsh"
        git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    fi
    fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
prompt pure
