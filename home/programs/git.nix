{ config, pkgs, ... }: {
  programs.git = {
    enable = true;

    # Git LFS サポート
    lfs.enable = true;

    # Git 設定（新しい settings 構文を使用）
    settings = {
      # ユーザー情報
      user = {
        name = "Tokuhiro Matsuno";
        email = "tokuhirom@gmail.com";
      };

      # エイリアス
      alias = {
        # コミット済みブランチの削除
        br-cleanup = "!git branch --merged | egrep -v \"main|master|develop\" | grep -v \\* | xargs -I % git branch -d %";
        prowl = "!gh prowl";
        ci = "commit";
        co = "checkout";
        st = "status --short --branch";
        br = "branch";
        tree = "log --graph --pretty=oneline --abbrev-commit";
        fetch-pulls = "fetch origin +refs/pull/*:refs/remotes/pull/*";
      };

      # 色設定
      color.ui = true;

      # Core 設定
      core = {
        editor = "vim";
        excludesfile = "~/.gitignore_global";
        fsmonitor = true;
        untrackedcache = true;
      };

      # 初期ブランチ名
      init.defaultBranch = "main";

      # サブモジュール設定
      submodule.recurse = true;

      # カラム表示
      column.ui = "auto";

      # ブランチソート
      branch = {
        sort = "-committerdate";
        autosetuprebase = "always";
      };

      # タグソート
      tag.sort = "version:refname";

      # Merge 設定
      merge = {
        ff = false;
        conflictstyle = "zdiff3";
      };

      # Diff 設定
      diff = {
        noprefix = true;
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      # Push 設定
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      # Fetch 設定
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      # Help 設定
      help.autocorrect = "prompt";

      # Commit 設定
      commit.verbose = true;

      # Rerere 設定（マージコンフリクトの記憶と再利用）
      rerere = {
        enabled = true;
        autoupdate = true;
      };

      # Rebase 設定
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      # Pull 設定
      pull.rebase = true;
    };
  };
}
