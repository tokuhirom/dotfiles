# profiling の方法
#
# 先頭行に
#   zmodload zsh/zprof
# を追加｡最後に
#   zprof
# を追加｡

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
# load other sources
# -------------------------------------------------------------------------

for file in ~/dotfiles/config/zsh/init/os/*.sh; do
    [ -r $file ] && source $file
done

source ~/dotfiles/config/zsh/init/lang/go.sh
source ~/dotfiles/config/zsh/init/lang/java-jenv.sh
source ~/dotfiles/config/zsh/init/lang/perl.sh
source ~/dotfiles/config/zsh/init/lang/python-rye.sh
source ~/dotfiles/config/zsh/init/lang/ruby-rbenv.sh
source ~/dotfiles/config/zsh/init/lang/rust.sh

source ~/dotfiles/config/zsh/init/cmd/fzf.sh
source ~/dotfiles/config/zsh/init/cmd/pure.sh
