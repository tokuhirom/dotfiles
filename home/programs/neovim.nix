{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;

    # vim のエイリアスを設定
    viAlias = true;
    vimAlias = false;  # vim は別途インストール

    # デフォルトエディタとして設定
    defaultEditor = false;  # EDITOR は vim に設定済み
  };

  # Neovim の設定ファイル（lazy.nvim セットアップ）
  # 既存の設定をそのまま使用
  home.file.".config/nvim".source = ../../config/.config/nvim;
}
