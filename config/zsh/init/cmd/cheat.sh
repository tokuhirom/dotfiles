# cheat pager setting
if command -v bat &>/dev/null; then
    export CHEAT_PAGER=bat
fi

# cheat command completion
_cheat() {
    local cheat_dir="$HOME/dotfiles/cheat"
    local -a cheat_files

    # Get list of cheat sheets (without .md extension)
    cheat_files=(${cheat_dir}/*.md(:t:r))

    _arguments \
        '-e[edit cheat sheet]' \
        '-l[list cheat sheets]' \
        '--edit[edit cheat sheet]' \
        '--list[list cheat sheets]' \
        '1:cheat sheet:($cheat_files)'
}

compdef _cheat cheat
