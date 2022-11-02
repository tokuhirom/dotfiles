if status --is-interactive
    # Commands to run in interactive sessions can go here


    alias l=ls
    alias s=ls
    alias ll="ls -l"

    # PATH
    fish_add_path -m $HOME/bin/
    fish_add_path -m ~/dotfiles/bin/

    # homebrew
    eval (/opt/homebrew/bin/brew shellenv)

    # jenv
    jenv init - | source

    # plenv
    ~/.plenv/bin/plenv init - | source
end

# ctrl+r は使えない。
# キーワードいれてから ctrl+p 


