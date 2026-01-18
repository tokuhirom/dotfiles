# Legacy Scripts

このディレクトリには、Nix への移行により廃止された古いセットアップスクリプトが含まれています。

## 廃止されたスクリプト

### Phase 2 で置き換え
- `Brewfile` → `darwin/homebrew.nix` で宣言的に管理

### Phase 3 で置き換え
- `link.sh` → home-manager のファイル管理機能に置き換え

### Phase 4 で置き換え
- `setup/setup-git.sh` → `home/programs/git.nix`
- `setup/setup-mac-settings.sh` → `darwin/system-settings.nix`

### Phase 5 で置き換え
- `setup/setup-mise.sh` → mise は `home/common.nix` で管理、ビルド依存関係は `home/development.nix`
- `setup/setup-vimplug.sh` → Neovim は `home/programs/neovim.nix` で管理（lazy.nvim 使用）

## 現在のセットアップ方法

Nix を使用した新しいセットアップ方法については、[NIX_README.md](../NIX_README.md) を参照してください。

```bash
cd ~/dotfiles
./install-nix.sh
```

## 従来のセットアップ（非推奨）

これらのスクリプトは参照用に保持されていますが、新規インストールには使用しないでください。
