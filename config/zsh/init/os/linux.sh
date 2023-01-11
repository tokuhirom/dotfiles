if [ -e /home/ ]; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste="xclip -selection c -o"
    alias open="xdg-open"
fi
