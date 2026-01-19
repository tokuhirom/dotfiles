# pure prompt - homebrew or manual install
if [ -d /opt/homebrew/share/zsh/site-functions ]; then
    # homebrew
    fpath+=("/opt/homebrew/share/zsh/site-functions")
else
    # manual install
    if [ ! -d "$HOME/.zsh/pure" ]; then
        mkdir -p "$HOME/.zsh"
        git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    fi
    fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
prompt pure

# usacloud profile in RPROMPT
function _usacloud_prompt() {
    local usacloud_current_file="$HOME/.usacloud/current"
    if [[ -f "$usacloud_current_file" ]]; then
        local profile=$(cat "$usacloud_current_file" 2>/dev/null | tr -d '[:space:]')
        if [[ -n "$profile" ]]; then
            RPROMPT="%F{cyan}usacloud:${profile}%f"
        else
            RPROMPT=""
        fi
    else
        RPROMPT=""
    fi
}
precmd_functions+=(_usacloud_prompt)
