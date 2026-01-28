# シンプルなプロンプト（git ブランチ表示のみ）

# git ブランチ名を取得
function _git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " %F{yellow}($branch)%f"
}

# プロンプト設定
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f$(_git_branch) %# '

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
