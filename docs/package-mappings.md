# Package Name Mappings: Homebrew → Nix

This document lists package name differences between Homebrew and Nix for easier migration.

## ✅ Identical Names

Most packages have the same name in both Homebrew and Nix:
- git, neovim, tmux, fzf, bat, jq, fd, gh
- cmake, ansible, curl, wget, bash, zsh
- docker, kind, k9s, awscli
- graphviz, pandoc, doxygen
- mise, zellij, ranger, nmap

## 🔄 Name Differences

### Homebrew → Nix

| Homebrew | Nix | Notes |
|----------|-----|-------|
| `the_silver_searcher` | `silver-searcher` | The 'ag' search tool |
| `postgresql@13` | `postgresql_13` | Version-specific PostgreSQL |
| `ipython` | `python3Packages.ipython` | Python package |
| `luarocks` | `luajitPackages.luarocks` | LuaJIT package |
| `mc` | ❌ Not available | Conflicts with midnight-commander |
| `yq` | `yq-go` | YAML processor (Go version) |
| `icu4c@76` | `icu` | Unicode/globalization library |
| `jpeg` | `libjpeg` | JPEG library |

## ❌ Not Available in Nix

These packages are not in nixpkgs and must stay in Homebrew:

### macOS-Specific Tools
- `borders` - Window border system
- `sketchybar` - Custom status bar
- `crush` - AI coding assistant
- `mkr` - Mackerel monitoring CLI
- `usacloud` - SAKURA Cloud CLI
- `sops-sakura-kms` - SAKURA Cloud KMS plugin

### Knative Tools
- `func` - Knative functions
- `kn` - Knative CLI
- `quickstart` - Knative quickstart

### Other Tools
- `tftui` - Terraform TUI
- `runn` - Scenario runner
- `tbls` - Database documentation tool
- `dcv` - Docker Compose Viewer
- `taskeru` - Task management tool
- `todo-txt` - Todo.txt CLI (may be available as `todo-txt-cli`)
- `innotop` - MySQL monitoring
- `pg_top` - PostgreSQL monitoring

These packages remain in `darwin/homebrew.nix` under the `brews` section.

## 📦 Package Categories

### CLI Tools in home/common.nix (Cross-platform)
~60 packages available on both macOS and Linux via Nix

### CLI Tools in darwin/packages.nix (macOS-specific)
~100+ packages for macOS system-wide installation

### GUI Apps in darwin/homebrew.nix (macOS-only)
- 47 casks (GUI applications)
- 13 Homebrew-only formulae
- 10 Mac App Store apps

## 🔍 Finding Package Names

To search for a package in Nix:
```bash
# Search nixpkgs
nix search nixpkgs <package-name>

# Example
nix search nixpkgs silver-searcher
nix search nixpkgs ipython
```

## 🚀 Migration Strategy

1. **Phase 2** ✅ Current
   - Migrate common CLI tools to `home/common.nix`
   - Migrate macOS tools to `darwin/packages.nix`
   - Keep GUI apps and unavailable tools in `darwin/homebrew.nix`

2. **Phase 3-7** (Future)
   - Gradually migrate more tools as they become available
   - Document new mappings discovered during use
   - Keep this file updated

## 📝 Notes

- Nix package names use hyphens (`-`) instead of underscores (`_`)
- Version-specific packages use underscores: `@13` → `_13`
- Language-specific packages are nested: `packageName` → `langPackages.packageName`
- macOS-specific tools often stay in Homebrew for better integration
