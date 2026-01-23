{ ... }: {
  # Declarative Homebrew for GUI apps (casks) and Mac App Store apps
  # Nix-darwin manages Homebrew installation and keeps casks in sync

  homebrew = {
    enable = true;

    # Cleanup behavior
    onActivation = {
      cleanup = "zap";  # Uninstall packages not listed
      upgrade = true;    # Upgrade packages on activation
      autoUpdate = true; # Update Homebrew itself
    };

    # Homebrew taps
    taps = [
      "nikitabobko/tap"       # aerospace
      "felixkratz/formulae"   # borders, sketchybar
      "sacloud/usacloud"      # usacloud
      "k1low/tap"             # runn, tbls
      "charmbracelet/tap"     # crush
      "tokuhirom/tap"         # sops-sakura-kms, dcv, taskeru
      "sqldef/sqldef"         # psqldef
    ];

    # GUI Applications (Casks)
    casks = [
      # === Password & Security ===
      "1password"
      "1password-cli"

      # === Window Management ===
      "aerospace"  # i3-like tiling window manager
      "alt-tab"    # Windows-like alt-tab
      "raycast"    # Launcher & productivity
      "karabiner-elements"  # Keyboard customizer
      "hammerspoon"  # macOS automation with Lua

      # === Terminal Emulators ===
      "wezterm"    # GPU-accelerated (primary)
      # "alacritty"  # aerospace との相性が悪いため使用停止
      # "ghostty"    # aerospace との相性が悪いため使用停止
      # "kitty"      # 未使用

      # === AI & Coding Assistants ===
      "claude-code"  # Terminal-based AI assistant
      "tokuhirom/tap/notebeam"  # シンプルなメモアプリ
      "tokuhirom/tap/sakpilot"  # SAKURA Cloud AI assistant

      # === Web Browsers ===
      "google-chrome"
      "firefox"
      "vivaldi"

      # === Communication ===
      "slack"
      "discord"

      # === Development Tools ===
      "visual-studio-code"
      "jetbrains-toolbox"

      # === Text Editors ===
      "coteditor"  # Plain-text editor

      # === Productivity & Note-taking ===
      "obsidian"   # Knowledge base
      # "notion"     # 未使用
      "logseq"     # Knowledge management

      # === Utilities ===
      "cleanshot"           # Screen capture
      "caffeine"            # Prevent sleep
      "meetingbar"          # Next meeting in menu bar
      "itsycal"             # Menu bar calendar with calendar filtering
      "jordanbaird-ice"     # Menu bar manager
      "cyberduck"           # FTP/cloud browser
      # "deskpad"             # 仮想モニターを作成し画面共有時に特定ウィンドウのみ共有可能にするツール
      "ddpm"                # Monitor manager
      "wireshark-app"       # Network analyzer
      "uhk-agent"           # Ultimate Hacking Keyboard config

      # === Cloud & Virtualization ===
      "multipass"  # Ubuntu VMs

      # === Database Tools ===
      # "another-redis-desktop-manager"

      # === Japanese Input (IME) ===
      "atok"       # ATOK input method
      "aqua-voice" # Speech-to-text

      # === GitHub Tools ===
      "jasper-app" # GitHub issue reader

      # === Fonts ===
      "font-cica"
      "font-fira-code-nerd-font"
      "font-hack-nerd-font"
      "font-hackgen-nerd"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "font-noto-sans-cjk-jp"
      "font-noto-sans-mono"
      "font-noto-serif-cjk-jp"
    ];

    # Mac App Store Applications
    masApps = {
      "Get Plain Text" = 508368068;
      "iMovie" = 408981434;
      "Keynote" = 409183694;
      "LINE" = 539883307;
      "MindNode Classic" = 1289197285;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "Pixelmator Pro" = 1289583905;
      "Xcode" = 497799835;
    };

    # Homebrew formulae that MUST be installed via Homebrew
    # (Not available in nixpkgs or have issues)
    brews = [
      # Shell (ログインシェルは nix ではなく homebrew で管理)
      "zsh"
      "bash"

      "borders"      # macOS window borders - not in nixpkgs
      "sketchybar"   # Custom statusbar - not in nixpkgs
      "pure"         # ZSH prompt
      "terminal-notifier"  # macOS notifications
      "sops-sakura-kms"  # SAKURA Cloud KMS plugin
      "crush"        # AI coding assistant
      # "runn"         # Scenario runner
      # "tbls"         # Database documentation
      "usacloud"     # SAKURA Cloud CLI
      "dcv"          # Docker Compose Viewer
      "opencode"     # AI coding agent
      "sqldef/sqldef/psqldef"  # PostgreSQL schema management
    ];
  };
}
