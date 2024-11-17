if status --is-interactive
    # Commands to run in interactive sessions can go here


    alias l=ls
    alias s=ls
    alias ll="ls -l"

    # PATH
    fish_add_path -m $HOME/bin/
    fish_add_path -m ~/dotfiles/bin/

    # homebrew
    if test -f /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end

    # jenv
    jenv init - | source

    # plenv
    ~/.plenv/bin/plenv init - | source
end

# ctrl+r は使えない。
# キーワードいれてから ctrl+p 



# Added by `rbenv init` on Sun Nov 17 13:47:08 JST 2024
status --is-interactive; and rbenv init - --no-rehash fish | source
