# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# audio bell
set bell-style visible

export GOPATH=$HOME/go/
shopt -s globstar


# -----------------------------------------------
# LINE
# -----------------------------------------------

alias kerb="ssh tokuhirom@igw1.linecorp.com"

# -----------------------------------------------
# Prompt
# -----------------------------------------------

source ~/dotfiles/zsh/git-prompt.sh
export PS1='\u@\h $(__git_ps1 " (\e[95m%s\e[0m)") \$ '
# export PS1='[\e[33m\u\e[0m@\e[32m\h\e[0m \e[34m\W\e[0m$(__git_ps1 " (\e[95m%s\e[0m)")\e[0m]\$ '

# -----------------------------------------------
# Basic
# -----------------------------------------------

export EDITOR=vim

alias ls="ls -F --color"
alias s=ls
alias l=ls

# -----------------------------------------------
#
# android development
# https://ryanharter.com/blog/dev-on-pixelbook/
#
# -----------------------------------------------
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# for pixelbook
function connect_adb() {
    adb connect 100.115.92.2:5555
}

# -----------------------------------------------
# WSL2
# -----------------------------------------------

if [ -d /mnt/c/ ]; then
    export DISPLAY=172.17.112.1:0
fi

# -----------------------------------------------
# git-bash
# -----------------------------------------------

if [ -e /git-bash.exe ]; then
    export PATH="$HOME/scoop/shims/:$PATH"
    export JAVA_TOOL_OPTIONS=-Duser.language=en
    alias pbcopy=clip
    alias top=ntop
fi

[[ -d $HOME/dotfiles/bin/ ]] && export PATH=$PATH:$HOME/dotfiles/bin/
[[ -d /c/Strawberry/perl/bin/ ]] && export PATH=/c/Strawberry/perl/bin/:$PATH
[[ -d '/c/Program Files/AdoptOpenJDK/jdk-11.0.6.10-hotspot' ]] && export JAVA_HOME=/c/Program\ Files/AdoptOpenJDK/jdk-11.0.6.10-hotspot
