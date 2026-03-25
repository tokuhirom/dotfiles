# シンプルなプロンプト（git ブランチ表示のみ）

# git ブランチ名を取得
function _prompt_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " %F{yellow}($branch)%f"
}

# ホスト名のハッシュからディレクトリ表示の色を決定
function _prompt_dir_color() {
    local colors=(blue green cyan magenta red yellow white)
    local hash=$(echo -n "$HOST" | cksum | awk '{print $1}')
    echo "${colors[$((hash % ${#colors[@]} + 1))]}"
}
_PROMPT_DIR_COLOR=$(_prompt_dir_color)

# プロンプト設定
setopt PROMPT_SUBST
PROMPT='%F{${_PROMPT_DIR_COLOR}}%~%f$(_prompt_git_branch)
%# '

