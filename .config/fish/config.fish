alias l=ls
alias s=ls


if status --is-interactive
    # jenv
    jenv init - | source

    # plenv
    ~/.plenv/bin/plenv init - | source
end

# ctrl+r は使えない。
# キーワードいれてから ctrl+p 


