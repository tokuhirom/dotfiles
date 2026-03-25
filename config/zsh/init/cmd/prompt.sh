# シンプルなプロンプト（git ブランチ表示のみ）

# git ブランチ名を取得
function _prompt_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " %F{yellow}($branch)%f"
}

# ホスト名のハッシュから色(256色)を決定
function _prompt_host_color() {
    local colors=(1 2 3 4 5 6 9 10 11 12 13 14 25 33 37 61 67 71 97 105 131 136 166 172 208)
    local hash=$(printf '%d' "0x$(echo -n "$HOST" | md5sum | cut -c1-8)")
    echo "${colors[$((hash % ${#colors[@]} + 1))]}"
}
_PROMPT_HOST_COLOR=$(_prompt_host_color)

# プロンプト設定
setopt PROMPT_SUBST
PROMPT='%F{${_PROMPT_HOST_COLOR}}%m%f:%~$(_prompt_git_branch)
%# '

