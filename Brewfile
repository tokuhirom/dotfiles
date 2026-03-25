# Homebrew パッケージ管理
# 適用: bin/brew-sync
# ADR-0015: macOS では Homebrew を優先

# === Taps ===
tap "tokuhirom/tap"         # dcv, notebeam, sakpilot


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
brew "gitleaks"

brew "mashiike/tap/actionspin"

# Version control
brew "git"
brew "git-lfs"
# brew "lefthook" # lefthook は mise で入れる

# ai
brew "pchuri/tap/confluence-cli"

# GitHub tools
brew "gh"
# brew "actionlint" # actionlint も mise で入れる

# === Infrastructure as Code ===
# brew "ansible"         # 使うときは uv run のほうがバージョン固定されて良い
# brew "opentofu"        # 使ってない

# === Databases & Data Tools ===
# brew "postgresql@14"   # docker run でいい

# === Programming Languages & Tools ===
# Python
brew "ipython"
# brew "cython"         # cython 別にいらない

# Lua
# brew "luarocks"       # 使ってない
# brew "luacheck"

# Rust (cargo 含む)
# brew "rust" # rust は cargo で入れないと、mise が RUSTUP_TOOLCHAIN を設定するため、わけわからんことになる。

# Swift
brew "swiftlint"

# === CLI Utilities ===
# File & text processing
brew "ripgrep"
brew "the_silver_searcher"
brew "bat"
brew "fzf"
brew "jq"
brew "yq"
brew "pandoc"
brew "nkf"
brew "bvi"

# System monitoring
brew "bottom"
brew "btop"
brew "multitail"

# File managers & viewers
brew "w3m"

# Networking tools
brew "curl"
brew "wget"
brew "nmap"
brew "ngrep"
brew "whois"
brew "inetutils"

# === Certificates ===
brew "mkcert"

# === S3 & Cloud Storage ===
# brew "s5cmd" # 使ってない:w

# === Documentation & Diagrams ===
brew "doxygen"
brew "sphinx-doc"

# === Text Editors ===
brew "vim"
brew "neovim"

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

# === Runtime Manager ===
brew "mise"

# === macOS Specific ===
brew "terminal-notifier"

# === SAKURA Cloud & Custom Tools ===
brew "dcv"

# AI
# brew "ollama"            # 今使ってない

# Mac 関連
brew "mas" # コマンドラインで mac app store アプリを操作

# === GUI Applications (Casks) ===

# Password & Security
cask "1password"
cask "1password-cli"

# Window Management
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
# cask "zed"

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
