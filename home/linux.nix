{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Linux-specific home-manager configuration

  home.packages = with pkgs; [
    # apt にないパッケージは Nix で管理
    bottom
    yq-go
    docker-client
    kind
    k9s
    awscli2
    go-task
    just
    sops
    mkcert
    duckdb
    nix-direnv
    devbox
    mise
    zellij
  ];

  # Linux 固有の環境変数は config/.config/environment.d/ibus.conf で管理
}
