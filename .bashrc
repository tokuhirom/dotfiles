# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export GOPATH=$HOME/go/
shopt -s globstar

source ~/.git-prompt.sh

alias kerb="ssh tokuhirom@igw1.linecorp.com"
# export PATH=$HOME/.linuxbrew/bin:$PATH

export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

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

