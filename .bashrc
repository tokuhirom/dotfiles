# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export GOPATH=$HOME/go/
shopt -s globstar

alias kerb="ssh tokuhirom@igw1.linecorp.com"
export PATH=$HOME/.linuxbrew/bin:$PATH
