if [ -d /Users ]; then
    export PATH=/opt/homebrew/bin:$PATH

    # use brew's coreutils
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

    # use brew's ruby
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

    # `code` command
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

