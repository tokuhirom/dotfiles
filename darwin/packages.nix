{ pkgs, ... }:
{
  # CLI tools from nixpkgs
  # Migrated from Brewfile

  environment.systemPackages = with pkgs; [
    # === Development Tools ===
    # Build systems & compilers
    cmake
    automake
    ant
    bison
    re2c

    # Version control
    git
    git-lfs
    mercurial
    lefthook

    # GitHub tools
    gh
    act
    actionlint

    # === Container & Cloud Tools ===
    docker
    colima
    kind
    k9s
    lazydocker
    crane
    skopeo
    pack

    # Cloud CLIs
    awscli2

    # === Infrastructure as Code ===
    ansible
    opentofu  # Terraform alternative
    # packer  # Managed by mise
    atlas

    # === Databases & Data Tools ===
    postgresql_14
    duckdb
    # Database monitoring
    # innotop  # MySQL monitoring - not in nixpkgs
    # pg_top   # PostgreSQL monitoring - not in nixpkgs

    # === Programming Languages & Tools ===
    # Python
    python3Packages.ipython
    python3Packages.cython
    uv  # Fast Python package installer

    # Lua
    luarocks
    luajitPackages.luacheck

    # === CLI Utilities ===
    # File & text processing
    fd
    ripgrep
    silver-searcher  # ag
    bat
    fzf
    jq
    yq-go  # yq in nixpkgs
    pandoc
    lv
    nkf  # Network Kanji Filter

    # System monitoring
    bottom
    btop
    entr
    multitail

    # File managers & viewers
    ranger
    w3m
    bvi  # Binary viewer

    # Networking tools
    curl
    wget
    nmap
    ngrep
    whois
    inetutils  # telnet, ftp, etc.

    # === macOS Specific ===
    # mas  # Mac App Store CLI
    # terminal-notifier  # moved to homebrew

    # Window management & status bar
    # borders  # Window borders - not in nixpkgs yet
    # sketchybar  # Custom status bar - not in nixpkgs yet

    # === Task Runners & Build Tools ===
    go-task
    just
    # runn  # Not in nixpkgs
    # tbls  # Not in nixpkgs

    # === Certificates ===
    mkcert

    # === Security & Secrets ===
    sops
    trufflehog

    # === S3 & Cloud Storage ===
    s3cmd
    s5cmd
    # mc  # MinIO client - conflicts with midnight-commander in nixpkgs

    # === Documentation & Diagrams ===
    doxygen
    sphinx
    ditaa
    graphviz

    # === Text Editors ===
    vim
    neovim
    emacs

    # === Compression & Archives ===
    libarchive
    xorriso

    # === Libraries ===
    coreutils
    libedit
    libxml2
    nss
    pkgconf
    protobuf
    icu
    libjpeg
    imagemagick

    # === Misc Tools ===
    mise  # Runtime manager (asdf alternative)
    # pure-prompt  # ZSH prompt - use homebrew instead
    todo-txt-cli
    zellij
    tmux
    # zsh / bash はログインシェルなので homebrew で管理
    # fisher  # Fish shell plugin manager - not in nixpkgs

    # Swift
    swiftlint

    # Go
    # yaegi  # Go interpreter

    # === Packages not in nixpkgs (commented out) ===
    # crush  # AI coding assistant
    # sops-sakura-kms
    # usacloud
    # tftui  # Terraform TUI
    # func, quickstart, kn  # Knative tools
    # mkr  # Mackerel
    # dcv  # Docker Compose Viewer
    # taskeru  # Task management

  ];
}
