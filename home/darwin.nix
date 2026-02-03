{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
  # macOS-specific home-manager configuration
  # ADR-0015: Homebrew を優先。Brewfile にないものだけここで管理

  home.packages = with pkgs; [
    # Brewfile にないパッケージ
    gnumake
    python3
    ruby
    luajit
    direnv
    nix-direnv
    devbox
    tree
    htop
    watch
    parallel
    unzip
    gzip
    bzip2
    xz
    openssl
    zlib
    readline
    ncurses
  ];

}
