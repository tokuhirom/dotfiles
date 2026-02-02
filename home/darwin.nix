{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
  # macOS-specific home-manager configuration

  home.packages = with pkgs; [
    # common.nix から移行
    vim
    tmux
    fzf
    ripgrep
    bat
    jq
    fd
    gh
    cmake
    gnumake
    automake
    mercurial
    python3
    python3Packages.ipython
    ruby
    luajit
    luajitPackages.luarocks
    coreutils
    silver-searcher
    yq-go
    pandoc
    bottom
    btop
    entr
    curl
    wget
    nmap
    whois
    docker-client
    # kind
    # k9s
    awscli2
    go-task
    just
    sops
    mkcert
    duckdb
    graphviz
    ditaa
    direnv
    nix-direnv
    devbox
    mise
    zellij
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
