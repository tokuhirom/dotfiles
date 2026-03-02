# Homebrew パッケージ管理
# 適用: bin/brew-sync
# ADR-0015: macOS では Homebrew を優先

# === Taps ===
tap "nikitabobko/tap"       # aerospace
tap "felixkratz/formulae"   # borders, sketchybar
tap "sacloud/usacloud"      # usacloud
tap "k1low/tap"             # runn, tbls
tap "charmbracelet/tap"     # crush
tap "tokuhirom/tap"         # sops-sakura-kms, dcv, taskeru
tap "sqldef/sqldef"         # psqldef
tap "ariga/tap"             # atlas
tap "buildpacks/tap"        # pack

# === Shell ===
# ログインシェルは nix ではなく homebrew で管理
brew "zsh"
brew "bash"

# === Development Tools ===
# Build systems & compilers
brew "cmake"
brew "automake"
brew "ant"
brew "bison"
brew "re2c"
brew "rakudo"

# Version control
brew "git"
brew "git-lfs"
brew "mercurial"
# brew "lefthook" # lefthook は mise で入れる

# GitHub tools
brew "gh"
# brew "actionlint" # actionlint も mise で入れる

# === Container & Cloud Tools ===
# colima 使う場合でも docker/docker-compose は必要
#
# docker-compose は以下の設定必要｡brew-sync の中でついでにやってる｡
# https://github.com/abiosoft/colima/discussions/874#discussioncomment-7695803
brew "docker"
brew "docker-compose"
brew "colima"
brew "kind"
brew "lazydocker"
brew "crane"
brew "skopeo"
brew "buildpacks/tap/pack"

# Cloud CLIs
brew "awscli"

# === Infrastructure as Code ===
# brew "ansible"         # 使うときは uv run のほうがバージョン固定されて良い
# brew "opentofu"        # 使ってない
# brew "ariga/tap/atlas" # 使ってない｡必要になったら mise.toml で管理すればいい

# === Databases & Data Tools ===
# brew "postgresql@14"   # docker run でいい
brew "duckdb"

# === Programming Languages & Tools ===
# Python
brew "ipython"
# brew "cython"         # cython 別にいらない
brew "uv"

# Lua
# brew "luarocks"       # 使ってない
# brew "luacheck"

# Perl
brew "perl"

# Rust (cargo 含む)
brew "rust"

# Swift
brew "swiftlint"

# === CLI Utilities ===
# File & text processing
brew "fd"
brew "ripgrep"
brew "the_silver_searcher"
brew "bat"
brew "fzf"
brew "jq"
brew "yq"
brew "pandoc"
brew "nkf"
brew "lv"
brew "bvi"

# System monitoring
brew "bottom"
brew "btop"
brew "entr"
brew "multitail"

# File managers & viewers
brew "ranger"
brew "w3m"

# Networking tools
brew "curl"
brew "wget"
brew "nmap"
brew "ngrep"
brew "whois"
brew "inetutils"

# === Task Runners & Build Tools ===
brew "go-task"
brew "just"

# === Certificates ===
brew "mkcert"

# === Security & Secrets ===
brew "sops"
brew "sops-sakura-kms"

# === S3 & Cloud Storage ===
brew "s3cmd"
# brew "s5cmd" # 使ってない:w

# === Documentation & Diagrams ===
brew "doxygen"
brew "sphinx-doc"
brew "ditaa"
brew "graphviz"
brew "d2"               # diagrams

# === Text Editors ===
brew "vim"
brew "neovim"
brew "emacs"

# === Build Tools ===
brew "make"

# === Programming Languages ===
brew "python@3"
brew "ruby"

# === CLI Utilities ===
brew "tree"
brew "htop"
brew "parallel"
brew "xz"

# === Libraries ===
brew "coreutils"
brew "imagemagick"

# === Terminal Multiplexers ===
brew "zellij"
brew "tmux"

# === Runtime Manager ===
brew "mise"

# === macOS Specific ===
# brew "borders"            # ウィンドウの周りにボーダーつけるやつ｡
brew "terminal-notifier"

# === SAKURA Cloud & Custom Tools ===

brew "usacloud"
brew "crush"
brew "dcv"
brew "opencode"
# brew "sqldef/sqldef/psqldef" # 使ってない｡使う場合でも mise で入れた方がいい

# AI
# brew "ollama"            # 今使ってない

# Mac 関連
brew "mas" # コマンドラインで mac app store アプリを操作

# === GUI Applications (Casks) ===

# Password & Security
cask "1password"
cask "1password-cli"

# Window Management
# cask "aerospace"       # 今使ってない
cask "alt-tab"
cask "raycast"
cask "karabiner-elements"
cask "hammerspoon"

# Terminal Emulators
cask "alacritty"
cask "ghostty"
cask "wezterm"

# AI & Coding Assistants
# cask "claude-code" # native install のほうがよさそう
cask "tokuhirom/tap/notebeam"
cask "tokuhirom/tap/sakpilot"

# Web Browsers
cask "google-chrome"
cask "google-chrome@canary"
cask "firefox"
# cask "vivaldi" # 使ってない

# Communication
cask "slack"
cask "discord"

# Development Tools
cask "visual-studio-code"
cask "jetbrains-toolbox"

# Text Editors
cask "coteditor"

# Productivity & Note-taking
cask "obsidian"
cask "logseq"

# Utilities
cask "cleanshot"
cask "caffeine"
cask "meetingbar"
cask "jordanbaird-ice"
# cask "cyberduck"        # 使ってない
cask "ddpm"
# cask "wireshark-app"    # 使ってない
cask "uhk-agent"

# Cloud & Virtualization
cask "multipass"        # ubuntu 専用 VM 管理くん

# Japanese Input (IME)
# cask "atok" # mac-akaza にするため不要となった
cask "aqua-voice"

# GitHub Tools
cask "jasper-app"

# AI
cask "codex"
cask "codex-app"
# cask "kiro"

# Fonts
cask "font-cica"
cask "font-fira-code-nerd-font"
cask "font-hack-nerd-font"
cask "font-hackgen-nerd"
cask "font-jetbrains-mono"
cask "font-jetbrains-mono-nerd-font"
cask "font-noto-sans-cjk-jp"
cask "font-noto-sans-mono"
cask "font-noto-serif-cjk-jp"

# === Mac App Store ===
mas "Get Plain Text", id: 508368068
mas "LINE", id: 539883307
mas "MindNode Classic", id: 1289197285
mas "Pixelmator Pro", id: 1289583905
mas "Xcode", id: 497799835
