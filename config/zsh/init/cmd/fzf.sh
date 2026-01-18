# -------------------------------------------------------------------------
# history search
#
# https://zenn.dev/nokogiri/articles/ec99e40df54555
# -------------------------------------------------------------------------

if which fzf &> /dev/null; then

    # fzf history
    function fzf-select-history() {
        # BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
        # -e: exact match
        local selected
        selected=$(history -n -r 1 | tac | awk '!seen[$0]++' | tac | fzf --no-sort +m -e --query "$LBUFFER" --prompt="History > ")
        if [[ -n "$selected" ]]; then
            # Convert escaped \n back to actual newlines
            BUFFER=${selected//\\n/$'\n'}
        fi
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N fzf-select-history
    bindkey '^r' fzf-select-history

    # cdr自体の設定
    if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
        autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
        add-zsh-hook chpwd chpwd_recent_dirs
        zstyle ':completion:*' recent-dirs-insert both
        zstyle ':chpwd:*' recent-dirs-default true
        zstyle ':chpwd:*' recent-dirs-max 1000
    fi

    # fzf cdr
    function fzf-cdr() {
        local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
        if [ -n "$selected_dir" ]; then
            BUFFER="cd ${selected_dir}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N fzf-cdr
    setopt noflowcontrol
    bindkey '^q' fzf-cdr

    # https://www.rasukarusan.com/entry/2018/08/14/083000
    # git checkout branchをfzfで選択
    alias co='git checkout $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --stat --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'
    # git br -d branchをfzfで選択
    alias git-delete-brach='git br -d $(git branch | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git tree {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'
fi

