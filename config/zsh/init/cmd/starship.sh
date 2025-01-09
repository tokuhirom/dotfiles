# better prompt
# https://blog.64p.org/entry/2025/01/08/051041
if which starship &> /dev/null; then
    eval "$(starship init zsh)"
else
    echo "[WARN] starship not available"
fi

