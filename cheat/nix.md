# Nix チートシート

## パッケージ検索

```bash
# パッケージを検索
nix search nixpkgs <パッケージ名>

# 例: ruby を検索
nix search nixpkgs ruby

# バージョンを確認
nix eval nixpkgs#ruby.version

# 複数バージョンがあるパッケージ
nix search nixpkgs 'nodejs_[0-9]+'
nix search nixpkgs 'jdk[0-9]+'
nix search nixpkgs 'python3[0-9]+'
```

## パッケージ情報

```bash
# パッケージのメタ情報
nix eval nixpkgs#ruby.meta.description
nix eval nixpkgs#ruby.meta.homepage

# derivation パス
nix eval nixpkgs#ruby.drvPath

# キャッシュにあるか確認
nix path-info --store https://cache.nixos.org nixpkgs#ruby
```

## 一時的に使う

```bash
# パッケージを一時的にインストールして実行
nix run nixpkgs#cowsay -- "Hello"

# シェルに入る（インストールせず）
nix shell nixpkgs#ruby nixpkgs#nodejs

# 開発シェル（flake.nix がある場合）
nix develop
```

## システム管理 (nix-darwin)

```bash
# 設定を適用
./apply-nix.sh

# ビルドのみ（適用しない）
darwin-rebuild build --impure --flake ".#$(hostname)"

# ガベージコレクション
nix-collect-garbage -d

# 古い世代を削除（30日以上前）
sudo nix-collect-garbage --delete-older-than 30d
```

## Flake 操作

```bash
# flake の更新
nix flake update

# 特定の input だけ更新
nix flake lock --update-input nixpkgs

# flake の出力を確認
nix flake show

# flake のチェック
nix flake check
```

## トラブルシューティング

```bash
# 依存関係を確認
nix why-depends --impure .#darwinConfigurations.$(hostname).system nixpkgs#nodejs

# ビルドログを確認
nix log /nix/store/xxxxx.drv

# キャッシュを無視してビルド
nix build --rebuild nixpkgs#ruby
```

## よく使うパッケージ名

| 用途 | パッケージ名 |
|------|-------------|
| Node.js LTS | `nodejs_22` |
| Python | `python3`, `python311`, `python312` |
| Ruby | `ruby`, `ruby_3_2`, `ruby_3_3` |
| Java | `jdk`, `jdk21`, `jdk17`, `jdk25` |
| Go | `go` |
| Rust | `rustc`, `cargo` |
| PHP | `php`, `php82`, `php83` |

## legacyPackages について

`nix search` の出力で `legacyPackages.aarch64-darwin.ruby` のように表示されるが、非推奨ではない。

| 出力形式 | 説明 |
|----------|------|
| `packages` | Flakes の正式な形式。全パッケージを事前評価する |
| `legacyPackages` | 巨大なパッケージセット用。遅延評価で効率的 |

nixpkgs は数万パッケージあるため `packages` だと評価に時間がかかりすぎる。
"legacy" は「flakes 以前の nixpkgs 構造を維持する」という意味で、廃止予定ではない。

## 参考リンク

- [NixOS パッケージ検索](https://search.nixos.org/packages)
- [nix-darwin マニュアル](https://daiderd.com/nix-darwin/manual/)
- [Home Manager オプション](https://nix-community.github.io/home-manager/options.html)
