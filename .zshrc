autoload -Uz compinit promptinit
compinit
promptinit

setopt prompt_subst
. ~/dotfiles/zsh/git-prompt.sh

prompt fire

export RPROMPT=$'$(__git_ps1 "%s")'

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
alias ll="ls -l"

# -------------------------------------------------------------------------
# Perl5
# -------------------------------------------------------------------------

export PERL_BADLANG=0
export PERL_CPANM_OPT="--no-man-pages --no-prompt --no-interactive"
export PERL_AUTOINSTALL="--defaultdeps"

# -------------------------------------------------------------------------
# Java
# -------------------------------------------------------------------------

if [[ -e /usr/libexec/java_home ]]; then
    function use_java14() {
        export JAVA_VERSION=14
        export JAVA_HOME=`/usr/libexec/java_home -v $JAVA_VERSION`
        export PATH=$JAVA_HOME/bin:$PATH
    }

    function use_java11() {
        export JAVA_VERSION=11
        export JAVA_HOME=`/usr/libexec/java_home -v $JAVA_VERSION`
        export PATH=$JAVA_HOME/bin:$PATH
    }

    function use_java8() {
        export JAVA_VERSION=1.8
        export JAVA_HOME=`/usr/libexec/java_home -v $JAVA_VERSION`
        export PATH=$JAVA_HOME/bin:$PATH
    }

    use_java11
fi

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

export HOMEBREW_GITHUB_API_TOKEN=aa088a98f596b0a7679303672d503977343eaba5

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

# -------------------------------------------------------------------------
# LINE
# -------------------------------------------------------------------------

FARM_INFO_URL=http://dav.navercorp.jp/data/facility/pmc.farm.active.info

function ss-farm-list() {
    curl -s $FARM_INFO_URL
}

function ss-farm-servers() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: ss-farm-list FARM"
        return
    fi

    FARM=$1
    ss-farm-list | egrep "^$FARM\t" | awk '{print $2}'
}

function ssline() {
    if [[ $# -eq 1 ]]; then
        local host=$1
    else
        local host=$(cat =(awk '{print $1 " " $1}' < ~/.itsc-servers) =(ss-farm-list | egrep 'cms|dmp|taxi|jrr|biz|connector|ansible|sticker|poi|bot-dispatcher|notify|switcher|adp|redirect|lad|lass|lasm|kakyoin') | fzf | awk '{print $2}')
    fi

    ss-login $host
}

# function agenda() {
#     ical2howm.py tokuhirom | peco --null | invoke-emacsclient-for-howm.pl --json
# }

# security add-generic-password -s kerberos -a JP11283 -w 'PASSWORD HERE'

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/JP11283/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/JP11283/Downloads/google-cloud-sdk/path.zsh.inc'
fi

if [ -d /usr/local/Cellar/perl/5.26.1/bin/ ]; then
    export PATH="/usr/local/Cellar/perl/5.26.1/bin/:$PATH"
fi
# added by Miniconda3 4.3.21 installer
# export PATH="$HOME/miniconda3/bin:$HOME/.plenv/bin/:$PATH"

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
if which plenv &> /dev/null; then eval "$(plenv init -)"; fi
export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"
export PATH="$HOME/dotfiles/local/bin/:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH="$HOME/.plenv/bin:$HOME/.plenv/shims:$PATH"
# PATH for rust tools
export PATH="$HOME/.cargo/bin:$PATH"
export CHEAT_EDITOR=vim

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/tokuhirom/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"



# Better `cat`
# brew install bat.
export BAT_STYLE="plain"

export PAGER=lv

[[ -d /usr/local/pulse ]] && export PATH="$PATH:/usr/local/pulse"
[[ -d $HOME/dotfiles/bin/ ]] && export PATH="$PATH:$HOME/dotfiles/bin/"

if [ -d /mnt/c/ ]; then
    export DISPLAY=172.17.112.1:0
fi


if [ -d ~/.wine ]; then
    function line_wine() {
        wine ~/.wine/drive_c/users/tokuhirom/Local\ Settings/Application\ Data/LINE/bin/current/LINE.exe
    }
fi

if [ -e /usr/bin/xsel ]; then
    alias pbcopy='xsel --clipboard --input'
fi

# add alias for xfce4's open
# https://ubuntuforums.org/showthread.php?t=1340719
if [ -e /usr/bin/exo-open ]; then
    alias open=exo-open
fi

function weather() {
    curl https://wttr.in/suginami
}
function nocaps() {
    setxkbmap -option ctrl:nocaps
}

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
