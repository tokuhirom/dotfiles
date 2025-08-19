if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    if test -d /opt/homebrew
        fish_add_path --global --move --path "/opt/homebrew/bin" "/opt/homebrew/sbin"
    end

    function today
        set _path (date +"$HOME/tmp/%Y%m%d/")
        mkdir -p $_path
        cd $_path
    end

    # https://ka2n.hatenablog.com/entry/2017/01/09/fish_shell%E3%81%A7z%E3%81%AE%E7%B5%90%E6%9E%9C%E3%82%92peco%E3%81%A3%E3%81%A6%E7%88%86%E9%80%9F%E3%81%A7%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E7%A7%BB%E5%8B%95%E3%81%99%E3%82%8B
    function fzf_z
      # すでに入力済みの文字列があればそれを fzf のクエリとして入力済みにする
      set -l fzf_flags
      set -l query (commandline)
      if test -n $query
        set -l fzf_flags --query "$query"
      end

      # Check if TMUX environment variable is set
      if test -n "$TMUX"
          # Append --tmux=bottom to fzf_flags
          set fzf_flags $fzf_flags --tmux=bottom
      end

      z -l | perl -pe 's/^\S+\s+//; s/^$ENV{HOME}/~/' | fzf --style=minimal $fzf_flags | perl -pe 's/^~/$ENV{HOME}/' | read recent
      if [ $recent ]
          cd $recent
          commandline -r ''
          commandline -f repaint
      end
    end

    function fish_user_key_bindings
        bind \cq fzf_z # Bind to Ctrl-Q
    end 

    function prco
        gh pr list | fzf | awk '{print $1}' | xargs gh co
    end

    function prview
        gh pr list | fzf | awk '{print $1}' | xargs gh pr view --web
    end

    abbr -a s ls
    abbr -a l ls
    abbr -a sl ls
    abbr -a ll ls -l
    abbr -a popd prevd
    abbr -a k kubectl
    abbr -a t topydo

    # jif type -q nvim
    # abbr -a vim nvim
    # end

    if test -d ~/.plenv
        fish_add_path ~/.plenv/bin
        eval "$(plenv init -)"
    end

    fish_add_path ~/dotfiles/bin/

    if test -d /opt/homebrew/opt/mysql@8.4/bin/
        fish_add_path /opt/homebrew/opt/mysql@8.4/bin/
    end

    set jetbrains "$HOME/Library/Application Support/JetBrains/Toolbox/scripts/"
    if test -d "$jetbrains"
        fish_add_path "$jetbrains"
    end

      fish_add_path /opt/homebrew/opt/mariadb@10.11/bin
      fish_add_path /opt/homebrew/opt/postgresql@13/bin


    set EDITOR vim
end


# Setting PATH for Python 3.12
# The original version is saved in $HOME/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# Added by LM Studio CLI (lms)
set -gx PATH $PATH $HOME/.lmstudio/bin
# End of LM Studio CLI section


# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end



# TypeSpec
set TYPESPEC_PATH "$HOME/.tsp/bin"
if [ -d "$TYPESPEC_PATH" ]
  set PATH "$TYPESPEC_PATH" $PATH
end



# Added by LM Studio CLI (lms)
set -gx PATH $PATH $HOME/.lmstudio/bin
# End of LM Studio CLI section

mise activate fish | source


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/to-matsuno/.lmstudio/bin
# End of LM Studio CLI section

set -x TODO_FILE ~/todo.txt


