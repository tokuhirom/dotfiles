# profiling の方法
#
# 先頭行に
#   zmodload zsh/zprof
# を追加｡最後に
#   zprof
# を追加｡
zmodload zsh/zprof

# -------------------------------------------------------------------------
# Key binding
# -------------------------------------------------------------------------

# Emacs like keybinding
bindkey -e

# Home, End, Del key
# https://stackoverflow.com/questions/8638012/fix-key-settings-home-end-insert-delete-in-zshrc-when-running-zsh-in-terminat
bindkey "^[[3~" delete-char
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line

# -------------------------------------------------------------------------
# History
# 履歴マニア - http://0xcc.net/unimag/3/
# -------------------------------------------------------------------------

HISTFILE=$HOME/.zsh-history           # 履歴をファイルに保存する
HISTSIZE=100000                       # メモリ内の履歴の数
SAVEHIST=100000                       # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
setopt share_history                  # inter process history sharing

# -------------------------------------------------------------------------
# Completion
# -------------------------------------------------------------------------

# completion settings.
# 大文字小文字を無視し、部分一致でマッチングして補完する設定
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# -------------------------------------------------------------------------
# Locale
# -------------------------------------------------------------------------

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# -------------------------------------------------------------------------
# vim
# -------------------------------------------------------------------------

if which nvim &> /dev/null; then
    export EDITOR=nvim
    alias vi=nvim
    alias vim=nvim
else
    export EDITOR=vim
    alias vi=vim
fi

# -------------------------------------------------------------------------
# Alias - ls
# -------------------------------------------------------------------------

alias ls="ls -lF --color"
alias s=ls
alias l=ls
alias sl=ls
alias ll="ls -l"

# -------------------------------------------------------------------------
# today
# -------------------------------------------------------------------------

function today() {
    _path=`date +$HOME/tmp/%Y%m%d/`
    mkdir -p $_path
    cd $_path
}

# -------------------------------------------------------------------------
# OSX
# -------------------------------------------------------------------------

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

if command -v bat &> /dev/null
then
    export CHEAT_PAGER=bat
fi
export PAGER=less
# support ANSI color in less
export LESS=-R

# export PAGER=bat

[[ -d $HOME/dotfiles/bin/ ]] && export PATH="$PATH:$HOME/dotfiles/bin/"

# なんのスクリプトかまったく思い出せないので一旦コメントアウト
#   if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
#           source /usr/share/doc/pkgfile/command-not-found.zsh
#   fi


# -------------------------------------------------------------------------
# auto pushd
#
# -------------------------------------------------------------------------

DIRSTACKSIZE=100
setopt AUTO_PUSHD

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

# -------------------------------------------------------------------------
# misc
#
# -------------------------------------------------------------------------

# httpx://michimani.net/post/develop-zsh-prompt-remove-last-line/
setopt prompt_cr
setopt prompt_sp

# -------------------------------------------------------------------------
# history search
#
# https://zenn.dev/nokogiri/articles/ec99e40df54555
# -------------------------------------------------------------------------

if which fzf &> /dev/null; then

    # fzf history
    function fzf-select-history() {
        # BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
        BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
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

# -------------------------------------------------------------------------
# load other sources
# -------------------------------------------------------------------------

for file in ~/dotfiles/config/zsh/init/*/*.sh; do
    [ -r $file ] && source $file
done

if command -v starship >/dev/null 2>&1; then
        eval "$(starship init zsh)"
fi



zprof
