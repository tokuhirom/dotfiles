# ADR-0027: マシンセットアップを mise bootstrap に移行する

## ステータス
採用

## コンテキスト

これまでマシンのセットアップは複数の仕組みに分かれていた:

- `link.sh` — `config/` 配下を `~/` へ素の symlink (OS 分岐つき, ADR-0007)
- `Brewfile` + `setup/setup-mac.sh` — macOS のパッケージ
- `setup/setup-popos-desktop.sh` / `setup-arch.sh` — Linux の apt / pacman パッケージ
- `setup/setup-mac-settings.sh` — macOS defaults
- `setup/setup-{mise,go,claude,plenv,alacritty}.sh` — ツール / 個別バイナリ導入
- `config/.config/mise/{config.toml,mise.lock}` — ツール定義 (mise + lockfile, ADR-0023)

ツール管理は既に mise に寄せてあった (ADR-0014, ADR-0023)。新しくリリースされた
`mise bootstrap` (experimental) は、dotfiles の symlink・パッケージ・OS defaults・
login shell・tools・カスタムタスクを 1 コマンドで宣言的に流せる。dotfiles の symlink を
担う `link.sh` を `[dotfiles]` セクションで置き換えれば、セットアップの入口を
`mise bootstrap` に一本化でき、`mise dotfiles status` / `--dry-run` で適用状態の確認も
できるようになる。

ただし bootstrap は experimental で、`[bootstrap.packages]` の cask/mas/tap や
macOS defaults の PlistBuddy 操作はサポートが未確認。よって全面移行ではなく段階的に進める。

## 決定

**Phase 1**: dotfiles の symlink を `mise` の `[dotfiles]` に移行し、残りの導入処理は
`mise bootstrap` から呼ぶ `bootstrap` タスクで束ねる。既存の `setup/*.sh` と `Brewfile` は
中身を変えずそのまま呼び出す。

- リポジトリ直下に `mise.toml` を新設し、`[settings]`・共通 `[dotfiles]`・`[tasks.bootstrap]`
  を定義する。`dotfiles.root = "~/dotfiles/config"` とし、source 省略で
  `~/dotfiles/config/` 配下をミラーする (現在のディレクトリ構造と完全一致)。
- OS 固有の dotfiles は `mise.macos.toml` / `mise.linux.toml` に分離する。これらは
  `mise bootstrap -E macos` / `-E linux` のときだけマージされる (link.sh の uname 分岐に相当)。
- `setup.sh` を OS を検出して `mise bootstrap -E <os>` を呼ぶ薄いラッパに置き換える。
  ツール定義は従来どおり `config/.config/mise/config.toml` (グローバル) が担当する。
- `link.sh` と、`setup.sh` のラッパ化で不要になった `setup/setup-mise.sh` を削除する。

将来フェーズ (本 ADR の対象外): `[bootstrap.packages]` への brew/apt/pacman 集約、
`[bootstrap.macos.defaults]` への defaults 移行、login shell の `[bootstrap.user]` 化。

## 理由

- ツールは既に mise 管理なので、dotfiles と OS セットアップも mise に寄せると入口が 1 つになる。
- `[dotfiles]` は宣言的で、`mise dotfiles status` / `apply --dry-run` により適用状態を
  確認・プレビューできる。`link.sh` は「無ければ張る」だけで状態確認の手段が無かった。
- mac / Linux のクロスプラットフォーム性は OS 別設定ファイル (`mise.{macos,linux}.toml`) を
  `-E` でマージする仕組みでそのまま維持できる。
- experimental な機能 (cask/mas/defaults) には踏み込まず、検証済みの `[dotfiles]` だけを
  採用することでリスクを抑える (段階的移行)。

### 検証

`mise dotfiles status` で、`link.sh` が張った既存 symlink 全 33 エントリ
(共通 26 + Linux 7) がすべて `applied` になり、`link.sh` と完全に等価であることを確認した。
`-E` 無しでは OS 固有エントリが除外され、`-E macos` では mac 固有の source が
存在する (Mac で適用可能) ことも確認した。`mise bootstrap -E linux --dry-run` で
dotfiles・tools・bootstrap タスクが正しく流れることも確認済み。

## 結果

- セットアップの入口が `./setup.sh` (= `mise bootstrap -E <os>`) に一本化される。
- dotfiles 管理が宣言的になり、`mise dotfiles status` で差分を確認できる。
- `mise.toml` / `mise.macos.toml` / `mise.linux.toml` が新設され、`link.sh` と
  `setup/setup-mise.sh` が削除される。
- `[dotfiles]` / `bootstrap` は experimental のため `experimental = true` が必要。
  初回はリポジトリを `mise trust` する必要がある (`setup.sh` が自動で実行する)。
- 真っさらなマシンでは、`~/.config/mise` の symlink が dotfiles ステップで作られる関係上、
  ツールが解決されない場合がある。その際は `./setup.sh` をもう一度実行するか
  `mise install` を実行する。
- Brewfile・apt/pacman・macOS defaults は当面 `bootstrap` タスク経由で従来どおり実行される。
  これらの宣言的移行は将来フェーズで検討する。

## 関連

- ADR-0007: dotfiles を素の symlink に移行 (link.sh の導入。本 ADR で [dotfiles] に置換)
- ADR-0014: devbox から mise に戻す
- ADR-0023: mise を mise.lock で固定 (ツール定義は引き続きこちらが担当)
