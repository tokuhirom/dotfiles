{ config, pkgs, ... }: {
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
    direnv  # Directory-based environment switching
    nix-direnv  # Fast direnv integration for Nix
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

  # Dotfiles management
  home.file = {
    # Shell configurations
    ".bashrc".source = ../config/.bashrc;
    # .zshrc は programs/zsh.nix で管理

    # Editor configurations
    ".vimrc".source = ../config/.vimrc;
    ".ideavimrc".source = ../config/.ideavimrc;
    ".emacs.d".source = ../config/.emacs.d;

    # Terminal multiplexer
    ".tmux.conf".source = ../config/.tmux.conf;
    ".screenrc".source = ../config/.screenrc;

    # Git
    ".gitignore_global".source = ../config/.gitignore_global;

    # R
    ".Rprofile".source = ../config/.Rprofile;

    # XDG config directories
    # .config/nvim は programs/neovim.nix で管理
    ".config/bat/config".source = ../config/.config/bat/config;
    ".config/ghostty".source = ../config/.config/ghostty;
    ".config/starship.toml".source = ../config/.config/starship.toml;
    ".config/alacritty".source = ../config/.config/alacritty;
    ".config/fish/config.fish".source = ../config/.config/fish/config.fish;
    ".config/fish/fish_plugins".source = ../config/.config/fish/fish_plugins;
    ".config/mise/config.toml".source = ../config/.config/mise/config.toml;
    ".config/zellij/config.kdl".source = ../config/.config/zellij/config.kdl;
    ".config/ranger".source = ../config/.config/ranger;
    ".config/topydo".source = ../config/.config/topydo;
    ".config/aerospace/aerospace.toml".source = ../config/.config/aerospace/aerospace.toml;
    ".config/sketchybar".source = ../config/.config/sketchybar;

    # Bin scripts
    ".local/bin/aerospace-focus-handler" = { source = ../bin/aerospace-focus-handler; executable = true; };
    ".local/bin/app-toggle" = { source = ../bin/app-toggle; executable = true; };
    ".local/bin/cheat" = { source = ../bin/cheat; executable = true; };
    ".local/bin/docker-clean-all" = { source = ../bin/docker-clean-all; executable = true; };
    ".local/bin/docker-minil-release" = { source = ../bin/docker-minil-release; executable = true; };
    ".local/bin/epoch" = { source = ../bin/epoch; executable = true; };
    ".local/bin/git-branch-cleanup" = { source = ../bin/git-branch-cleanup; executable = true; };
    ".local/bin/git-branch-name-suggestion" = { source = ../bin/git-branch-name-suggestion; executable = true; };
    ".local/bin/httpdumpd" = { source = ../bin/httpdumpd; executable = true; };
    ".local/bin/minil-setup" = { source = ../bin/minil-setup; executable = true; };
    ".local/bin/mit" = { source = ../bin/mit; executable = true; };
    ".local/bin/random" = { source = ../bin/random; executable = true; };
    ".local/bin/slog" = { source = ../bin/slog; executable = true; };
    ".local/bin/yabai-focus.pl" = { source = ../bin/yabai-focus.pl; executable = true; };
    ".local/bin/yay-install" = { source = ../bin/yay-install; executable = true; };
    ".local/bin/yay-list-files" = { source = ../bin/yay-list-files; executable = true; };
    ".local/bin/yay-list-packages" = { source = ../bin/yay-list-packages; executable = true; };
    ".local/bin/yay-search" = { source = ../bin/yay-search; executable = true; };
    ".local/bin/yay-uninstall" = { source = ../bin/yay-uninstall; executable = true; };
    ".local/bin/yay-which" = { source = ../bin/yay-which; executable = true; };
  };

  # Add .local/bin to PATH
  home.sessionPath = [ "$HOME/.local/bin" ];

  # Create vim tmp directory
  home.activation.createVimTmp = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $HOME/.vim/tmp/
  '';
}
