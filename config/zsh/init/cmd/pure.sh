if [ -d /opt/homebrew ]; then
    fpath+=("/opt/homebrew/share/zsh/site-functions")

    autoload -U promptinit; promptinit
    prompt pure
else
    echo "pure not available"
fi


