{ pkgs, ... }: {
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
    actionspin

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
    awscli

    # === Infrastructure as Code ===
    ansible
    opentofu  # Terraform alternative
    packer
    atlas

    # === Databases & Data Tools ===
    postgresql_13
    duckdb
    # Database monitoring
    # innotop  # MySQL monitoring - not in nixpkgs
    # pg_top   # PostgreSQL monitoring - not in nixpkgs

    # === Programming Languages & Tools ===
    # Python
    ipython
    cython
    uv  # Fast Python package installer

    # Lua
    luarocks
    luacheck

    # Java
    jenv

    # === CLI Utilities ===
    # File & text processing
    fd
    ripgrep
    the-silver-searcher  # ag
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
    telnet

    # === macOS Specific ===
    mas  # Mac App Store CLI
    terminal-notifier

    # Window management & status bar
    # borders  # Window borders - not in nixpkgs yet
    # sketchybar  # Custom status bar - not in nixpkgs yet

    # === Task Runners & Build Tools ===
    go-task
    just
    # runn  # Not in nixpkgs
    # tbls  # Not in nixpkgs

    # === Container & Image Tools ===
    prometheus
    node_exporter
    fluent-bit
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
    neovim
    emacs

    # === Compression & Archives ===
    libarchive
    squashfs
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
    cpanminus  # Perl CPAN
    pure  # ZSH prompt
    todo-txt
    zellij
    tmux
    zsh
    bash
    fisher  # Fish shell plugin manager

    # Swift
    swiftlint

    # Go
    yaegi  # Go interpreter

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
