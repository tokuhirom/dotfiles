# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export GOPATH=$HOME/go/
shopt -s globstar
