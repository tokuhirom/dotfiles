# シンプルなプロンプト（git ブランチ表示のみ）

# git ブランチ名を取得
function _git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " %F{yellow}($branch)%f"
}

# プロンプト設定
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f$(_git_branch)
%# '

