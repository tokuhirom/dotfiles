{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    # vim のエイリアスを設定
    viAlias = true;
    vimAlias = false;  # vim は別途インストール

    # デフォルトエディタとして設定
    defaultEditor = false;  # EDITOR は vim に設定済み
  };

}
