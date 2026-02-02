{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Linux-specific home-manager configuration

  # apt にないモダンなツールは Nix で管理
  # 基本的なパッケージは setup/setup-popos-desktop.sh で apt 管理
  home.packages = with pkgs; [
    # CLI ツール
    bottom       # システムモニタ (btop の Rust 代替)
    yq-go        # YAML プロセッサ
    zellij       # ターミナルマルチプレクサ (tmux 代替)
    # just, go-task, mkcert はプロジェクトごとに mise で管理

    # 開発ツール
    mise
    devbox
    nix-direnv   # direnv の Nix 統合
    duckdb       # 組み込み分析 DB

    # インフラ・クラウド
    docker-client
    awscli2
    # kind
    # k9s

    # セキュリティ
    sops         # シークレット管理
  ];

  # Linux 固有の環境変数は config/.config/environment.d/ibus.conf で管理
}
