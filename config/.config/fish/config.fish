if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

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
end
