{ config, pkgs, ... }: {
  # Cross-platform user environment configuration
  # Phase 2: Expanded with common development tools

  # CLI packages available on all systems (macOS & Linux)
  home.packages = with pkgs; [
    # === Essential CLI Tools (Phase 1) ===
    git
    git-lfs
    neovim
    tmux
    fzf
    ripgrep
    bat
    jq
    fd
    gh

    # === Development Tools ===
    # Build systems
    cmake
    gnumake
    automake
    pkg-config

    # Version control
    mercurial

    # === Programming Languages & Tools ===
    # Python
    python3
    python3Packages.ipython

    # Lua
    luajit
    luajitPackages.luarocks

    # === CLI Utilities ===
    # File & text processing
    silver-searcher  # ag
    yq-go
    pandoc

    # System monitoring
    bottom
    btop
    entr

    # File managers
    ranger

    # Networking
    curl
    wget
    nmap
    whois

    # === Container & Cloud ===
    docker-client
    kind
    k9s

    # Cloud
    awscli

    # === Task Runners ===
    go-task
    just

    # === Security ===
    sops
    mkcert

    # === Data Tools ===
    duckdb

    # === Documentation ===
    graphviz
    ditaa

    # === Misc Tools ===
    mise  # Runtime/language manager
    zellij
    tree
    htop
    watch
    parallel

    # Compression
    unzip
    gzip
    bzip2
    xz

    # === Development Dependencies ===
    # Libraries commonly needed for building
    openssl
    zlib
    readline
    ncurses
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
  };

  # XDG Base Directory specification
  xdg.enable = true;
}
