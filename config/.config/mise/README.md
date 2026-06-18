# mise

## 構成

`~/.config/mise` はディレクトリごと dotfiles への symlink (ADR-0023)。
`config.toml` に加えて `mise.lock` も git で管理する。

- `config.toml` - ツールとバージョンの定義
- `mise.lock` - 各ツールのダウンロード URL と sha256 checksum を全プラットフォーム分固定

なお、マシンセットアップ (dotfiles の symlink・OS パッケージ) はリポジトリ直下の
`mise.toml` / `mise.{macos,linux}.toml` が担当する。詳細は後述の「bootstrap」と ADR-0027 を参照。

## bootstrap (マシンセットアップ)

ADR-0027 で、dotfiles の symlink と OS セットアップを `mise bootstrap` に一本化した。

```bash
cd ~/dotfiles

# OS を検出して bootstrap (dotfiles symlink + tools + OS パッケージ)
./setup.sh

# dotfiles だけ適用 / 状態確認 / プレビュー
mise dotfiles apply  -E macos   # または -E linux
mise dotfiles status -E linux
mise bootstrap       -E linux --dry-run
```

- 共通 dotfiles は `mise.toml`、OS 固有は `mise.macos.toml` / `mise.linux.toml` の `[dotfiles]`。
  `dotfiles.root = "~/dotfiles/config"` で、source 省略時に `config/` 配下をミラーする。
- OS 固有ファイルは `-E macos` / `-E linux` のときだけマージされる (`MISE_AUTO_ENV=1` でも自動選択可)。
- `[dotfiles]` / `bootstrap` は experimental のため `mise.toml` で `experimental = true` を有効化済み。
- 初回はリポジトリの `mise trust` が必要 (`setup.sh` が自動実行)。

mise の `lockfile` 設定はデフォルトで有効なので、インストール時に
`mise.lock` の checksum と照合される。バージョンを上げただけで lock を
更新し忘れた場合は、インストール時に lockfile とずれてエラーになるか
lock が更新されるので気づける。

## 既存マシンからの移行

旧構成 (`~/.config/mise/` 実ディレクトリ + `config.toml` のみ symlink) の
マシンでは、最初に一度だけ移行スクリプトを実行する:

```bash
~/dotfiles/setup/migrate-mise-symlink.sh
```

dotfiles 管理外のファイルが `~/.config/mise/` にある場合はエラーで止まるので、
内容を確認して手動で移してから再実行する。

## バージョン更新の手順

1. `config.toml` のバージョンを書き換える
2. lockfile を更新する (`mise lock` は experimental フラグが必要):

   ```bash
   MISE_EXPERIMENTAL=1 mise lock
   ```

3. `mise.lock` の diff を確認してコミットする
4. `mise install` で新バージョンをインストールする

## 補足 (マルチプラットフォーム)

`mise.lock` はツールごとに platform (OS/arch) 別の URL と checksum を持つ形式
なので、**1 つの lockfile を Mac と Linux で共有できる**。各マシンは自分の
platform のエントリだけを参照する。`mise lock` はどのマシンで実行しても
全 platform 分 (linux-x64/arm64, macos-x64/arm64, windows-x64) を更新する。

checksum の有無はバックエンドによって異なる:

- **URL + sha256 固定**: core の node/go/bun/perl と github バックエンド、
  terraform/packer/watchexec/zellij/ghq など (14 ツール)
- **version 固定のみ**: java/python/rust (core バックエンドの実装上 lock 非対応)、
  aqua / npm バックエンド (codex, fd, duckdb など。aqua はレジストリ側で
  checksum 検証が行われる)
