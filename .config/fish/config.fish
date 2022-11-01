alias l=ls
alias s=ls

# jenv
status --is-interactive; and jenv init - | source

# ctrl+r は使えない。
# キーワードいれてから ctrl+p 

# plenv
status --is-interactive; and source (~/.plenv/bin/plenv init - | psub)

