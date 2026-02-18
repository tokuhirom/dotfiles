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

# kitty keyboard protocol (CSI u) 対応
# ghostty などのモダンターミナルで Ctrl+M が効くように
bindkey '^[[109;5u' accept-line

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
# Zsh プラグイン (apt or homebrew でインストール)
# -------------------------------------------------------------------------

# zsh-autosuggestions
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -------------------------------------------------------------------------
# direnv
# -------------------------------------------------------------------------

# if command -v direnv &> /dev/null; then
#     eval "$(direnv hook zsh)"
# fi


# -------------------------------------------------------------------------
# Locale
# -------------------------------------------------------------------------

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# -------------------------------------------------------------------------
# vim
# -------------------------------------------------------------------------

if which nvim &> /dev/null; then
 #  export EDITOR=nvim
 #  alias vi=nvim
 #  alias vim=nvim
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
[[ -d $HOME/.local/bin/ ]] && export PATH="$HOME/.local/bin:$PATH"

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
source ~/dotfiles/config/zsh/init/lang/perl.sh
source ~/dotfiles/config/zsh/init/lang/rust.sh

source ~/dotfiles/config/zsh/init/cmd/fzf.sh
source ~/dotfiles/config/zsh/init/cmd/prompt.sh
source ~/dotfiles/config/zsh/init/cmd/zellij.sh
source ~/dotfiles/config/zsh/init/cmd/cheat.sh
source ~/dotfiles/config/zsh/init/cmd/tmux.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# JetBrains Toolbox scripts (goland, idea, etc.)
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

export PATH="$HOME/.tiup/bin:$PATH"

export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section


# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section


if [ -d /usr/local/go ]; then
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$PATH:/usr/local/go/bin
fi


export TODO_FILE="$HOME/todo.txt"

alias difit="npx difit"

if [ -e "$HOME/.config/colima/default/docker.sock" ]; then
    export DOCKER_HOST=unix://$HOME/.config/colima/default/docker.sock
fi


# -------------------------------------------------------------------------
# mise
# -------------------------------------------------------------------------

if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

