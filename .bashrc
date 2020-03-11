# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export GOPATH=$HOME/go/
shopt -s globstar

source ~/.git-prompt.sh

alias kerb="ssh tokuhirom@igw1.linecorp.com"
# export PATH=$HOME/.linuxbrew/bin:$PATH

export PS1='[\e[33m\u\e[0m@\e[32m\h\e[0m \e[34m\W\e[0m$(__git_ps1 " (\e[95m%s\e[0m)")\e[0m]\$ '

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

alias ls="ls -F --color"

# WSL2
if [ -d /mnt/c/ ]; then
    export DISPLAY=172.17.112.1:0
fi
export EDITOR=vim
