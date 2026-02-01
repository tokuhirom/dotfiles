{ pkgs, ... }: {
  # Cross-platform user environment configuration

  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./development.nix
  ];

  # CLI packages available on all systems (macOS & Linux)
  home.packages = with pkgs; [
    # === Essential CLI Tools ===
    # git と git-lfs は programs/git.nix で管理
    # neovim は programs/neovim.nix で管理
    vim
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

    # Version control
    mercurial

    # === Programming Languages & Tools ===
    # Python
    python3
    python3Packages.ipython

    # Ruby
    ruby

    # Lua
    luajit
    luajitPackages.luarocks

    # === CLI Utilities ===
    # File & text processing
    coreutils  # GNU coreutils (tac, etc.)
    silver-searcher  # ag
    yq-go
    pandoc

    # System monitoring
    bottom
    btop
    entr

    # File managers
    # ranger

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
    awscli2

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
    direnv  # Directory-based environment switching
    nix-direnv  # Fast direnv integration for Nix
    devbox  # Nix-based portable dev environments
    mise  # Runtime/language manager
    # opencode  # nixpkgs 版はビルドがスタックするため homebrew で管理
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
    EDITOR = "vim";
    VISUAL = "vim";
    PAGER = "less";
  };

  # XDG Base Directory specification
  xdg.enable = true;

}
