alias l=ls
alias s=ls


if status --is-interactive
    # PATH
    fish_add_path ~/dotfiles/bin/

    # jenv
    jenv init - | source

    # plenv
    ~/.plenv/bin/plenv init - | source
end

# ctrl+r は使えない。
# キーワードいれてから ctrl+p 


