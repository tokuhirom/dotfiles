# Nix Configuration

This dotfiles repository is being migrated to use Nix for declarative system and user environment management.

## Quick Start

### 1. Configure Your Machines (First Time Only)

```bash
# Copy the template to ~/.config/nix/ (outside the repo)
# This keeps your hostnames/usernames private
mkdir -p ~/.config/nix
cp ~/dotfiles/machines.nix.example ~/.config/nix/machines.nix

# Edit with your machine info
vim ~/.config/nix/machines.nix
```

Example `~/.config/nix/machines.nix`:
```nix
{ mkLinuxHome, mkDarwinHost }:
{
  homeConfigurations = {
    "yourname@laptop" = mkLinuxHome {
      username = "yourname";
      hostname = "laptop";
    };
  };
}
```

**Why `~/.config/nix/`?**
- Outside the git repo, so it's never accidentally committed
- Standard location for Nix user configuration
- Won't appear in your public dotfiles repo

### 2. Install Nix and Apply Configuration

**Easiest way - Automated installation:**
```bash
cd ~/dotfiles
./install-nix.sh
```

This script will:
1. Install Nix using the Determinate Systems installer
2. Configure your environment
3. Apply the dotfiles configuration automatically

## Manual Installation

### 1. Install Nix (Determinate Installer - Recommended)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

The Determinate installer:
- Enables flakes by default
- Has better uninstall support
- More reliable than the official installer

### 2. Apply Configuration

**On Linux:**
```bash
cd ~/dotfiles

# First time setup - this will create flake.lock
# Use the username@hostname you configured in ~/.config/nix/machines.nix
# --impure allows reading your private machines.nix
# --print-build-logs shows download/build progress
nix run home-manager/master --impure --print-build-logs -- switch --flake .#username@hostname

# After first run, you can use the installed home-manager
home-manager switch --impure --flake .#username@hostname
```

**On macOS:**
```bash
cd ~/dotfiles

# Configure your Mac in ~/.config/nix/machines.nix first
# (see step 1 above)

# First time setup
# --impure allows reading your private machines.nix
nix run nix-darwin --impure --print-build-logs -- switch --flake .#your-mac-hostname

# After first run
darwin-rebuild switch --impure --flake .#your-mac-hostname
```

## Current Migration Status

### Phase 1: Foundation ✅ COMPLETE

- ✅ Flake structure created
- ✅ Basic nix-darwin configuration (macOS)
- ✅ Basic home-manager configuration (Linux + macOS)
- ✅ Core CLI tools (9 packages)

### Phase 2: Package Management ✅ COMPLETE

- ✅ Migrated ~100+ CLI tools to `darwin/packages.nix` (macOS)
- ✅ Migrated ~60 CLI tools to `home/common.nix` (cross-platform)
- ✅ Declarative Homebrew for 47 casks + 13 formulae + 10 Mac App Store apps
- ✅ Package name mappings documented

### Phase 3: Dotfiles Management ✅ COMPLETE

**Completed:**
- ✅ Replaced `link.sh` with home-manager file management
- ✅ Cross-platform dotfiles in `home/common.nix` (22 files)
- ✅ macOS-specific dotfiles in `home/darwin.nix` (2 files)
- ✅ Linux-specific dotfiles in `home/linux.nix` (8 files)
- ✅ All 22 bin/ scripts linked to `~/.local/bin` with executable permissions
- ✅ `~/.vim/tmp/` directory created automatically
- ✅ `~/.local/bin` added to PATH

**What works now:**
- All dotfiles managed declaratively
- Bin scripts executable and in PATH (cheat, app-toggle, git-*, etc.)
- Platform-specific configs automatically applied
- No more manual symlinking needed

**What doesn't work yet:**
- System settings (still using setup-mac-settings.sh)
- Git configuration (still using setup-git.sh)
- Shell configuration (zsh/bash setup)

### Upcoming Phases

- **Phase 4**: System Configuration Scripts (1 week)
- **Phase 5**: Advanced Features (2 weeks)
- **Phase 6**: Linux Support Expansion (1 week)
- **Phase 7**: Cleanup & Documentation (1 week)

## Directory Structure

```
dotfiles/
├── flake.nix           # Nix flake entry point
├── flake.lock          # Auto-generated lockfile (git committed)
├── darwin/             # macOS system configuration
│   └── default.nix
└── home/               # User environment (cross-platform)
    ├── default.nix     # Main home-manager config
    ├── common.nix      # Cross-platform settings
    ├── darwin.nix      # macOS-specific user configs
    ├── linux.nix       # Linux-specific user configs
    └── programs/       # Program-specific configs (Phase 4+)
```

## Verification

After applying the configuration:

```bash
# Check which packages are managed by Nix
which git neovim tmux ripgrep bat jq fd gh fzf

# They should point to /nix/store/...

# Check package versions
git --version
nvim --version
```

## Rollback

If something goes wrong:

**Linux:**
```bash
# List generations
home-manager generations

# Rollback to previous generation
home-manager switch --flake . --rollback
```

**macOS:**
```bash
# List generations
darwin-rebuild --list-generations

# Rollback
darwin-rebuild --rollback
```

## Useful Commands

```bash
# Update flake inputs (nixpkgs, home-manager, etc.)
nix flake update

# Check what would change (dry-run)
home-manager switch --flake . --dry-run  # Linux
darwin-rebuild check --flake .           # macOS

# Show download/build progress (add to any nix command)
nix run <package> --print-build-logs
home-manager switch --flake . --show-trace  # Shows detailed error traces

# Clean old generations
nix-collect-garbage --delete-older-than 30d

# Search for packages
nix search nixpkgs <package-name>

# See what's being downloaded in real-time
nix build --print-build-logs --verbose <package>
```

## Tips & Best Practices

### Show Download Progress

By default, Nix can be silent during downloads. Always use these flags:

```bash
# For nix run commands
nix run <package> --print-build-logs

# For home-manager/darwin-rebuild
home-manager switch --flake . --show-trace
darwin-rebuild switch --flake . --show-trace
```

The `install-nix.sh` script includes these flags automatically!

## Notes

- **Flakes are enabled by default** with Determinate installer
- **Progress visibility**: Use `--print-build-logs` to see downloads
- **Existing shell scripts continue to work** during migration
- **Homebrew is not removed** - Nix packages appear first in PATH
- **link.sh still works** - will be replaced in Phase 3
- **All setup/*.sh scripts still needed** - will be replaced in later phases
