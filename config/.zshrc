autoload -Uz compinit promptinit
compinit
promptinit

setopt prompt_subst
. ~/dotfiles/config/zsh/git-prompt.sh

prompt fire

# export RPROMPT=$'$(__git_ps1 "%s")'

bindkey -e

# -------------------------------------------------------------------------
# history
# 履歴マニア - http://0xcc.net/unimag/3/
# -------------------------------------------------------------------------
HISTFILE=$HOME/.zsh-history           # 履歴をファイルに保存する
HISTSIZE=100000                       # メモリ内の履歴の数
SAVEHIST=100000                       # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
function history-all { history -E 1 } # 全履歴の一覧を出力する
# inter process history sharing
setopt share_history

# -------------------------------------------------------------------------
# Home, End, Del key
# https://stackoverflow.com/questions/8638012/fix-key-settings-home-end-insert-delete-in-zshrc-when-running-zsh-in-terminat
# ------------------------------------------------------------------------- 
bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line


# -------------------------------------------------------------------------
# User configuration
# -------------------------------------------------------------------------

# completion settings.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# -------------------------------------------------------------------------
# Locale
# -------------------------------------------------------------------------
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# -------------------------------------------------------------------------
# vim
# -------------------------------------------------------------------------
export EDITOR=vim
alias vi=vim

# -------------------------------------------------------------------------
# Alias
# -------------------------------------------------------------------------
alias ls="ls -lF --color"
alias s=ls
alias l=ls
alias sl=ls
alias ll="ls -l"

# -------------------------------------------------------------------------
# Perl5
# -------------------------------------------------------------------------

export PERL_BADLANG=0
export PERL_CPANM_OPT="--no-man-pages --no-prompt --no-interactive"
export PERL_AUTOINSTALL="--defaultdeps"

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
if [ -d '/Users/' ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    export PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi


# ndenv
if [ -e $HOME/.ndenv ]; then
    export PATH="$HOME/.ndenv/bin:$PATH"
    eval "$(ndenv init -)"
fi

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
[[ -d /usr/lib/golang/bin/ ]] && export PATH=/usr/lib/golang/bin/:$PATH

if [ -d $HOME/.rbenv ]; then
    PATH=$HOME/.rbenv/shims:$PATH
fi


if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
if which plenv &> /dev/null; then eval "$(plenv init -)"; fi
export PATH="$HOME/dotfiles/local/bin/:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH="$HOME/.plenv/bin:$HOME/.plenv/shims:$PATH"
# PATH for rust tools
export PATH="$HOME/.cargo/bin:$PATH"
export CHEAT_EDITOR=vim


export PAGER=less
# export PAGER=bat

[[ -d /usr/local/pulse ]] && export PATH="$PATH:/usr/local/pulse"
[[ -d $HOME/.local/bin/ ]] && export PATH="$PATH:$HOME/.local/bin/"
[[ -d $HOME/bin/ ]] && export PATH="$PATH:$HOME/bin/"
[[ -d $HOME/dotfiles/bin/ ]] && export PATH="$PATH:$HOME/dotfiles/bin/"

if [ -d /mnt/c/ ]; then
    export DISPLAY=172.17.112.1:0
fi


if [ -e /usr/bin/xsel ]; then
    alias pbcopy='xsel --clipboard --input'
fi

if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
        source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# support ANSI color in less
export LESS=-R

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
# homebrew
# ------------------------------------------------------------------------- 

# set path to homebrew
if [[ -d /opt/homebrew/bin ]]; then
    export PATH=/opt/homebrew/bin:$PATH
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
fi

# -------------------------------------------------------------------------
# misc
#
# -------------------------------------------------------------------------

mkdir -p ~/.vim/tmp

# use brew's ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# https://michimani.net/post/develop-zsh-prompt-remove-last-line/
setopt prompt_cr
setopt prompt_sp

# eval "$(nodenv init -)"

# -------------------------------------------------------------------------
# Java
# -------------------------------------------------------------------------

if [ -e /home/ ]; then
    alias pbcopy='xsel --clipboard --input'
fi


# eval "$(jenv init -)"

#  jenv add ~/Library/Java/JavaVirtualMachines/temurin-11.0.16.1/Contents/Home
#  jenv global temurin-11.0.16.1
