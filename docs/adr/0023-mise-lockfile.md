# ADR-0023: mise を lockfile で固定する

## ステータス

採用

## コンテキスト

supply chain risk の棚卸し (ADR-0016〜0022) で、mise の tools は全て
バージョン指定済みであり「妥当な水準」として許容していた (ADR-0021)。
しかしバージョン指定はタグベースであり、upstream がタグを動かしたり
リリースアセットを差し替えたりした場合には検知できない。

mise には lockfile 機能 (`mise.lock`) があり、各ツールのダウンロード URL と
sha256 checksum をプラットフォームごとに固定できる。`lockfile` 設定は
現行バージョン (2026.2.1) でデフォルト有効だが、lockfile 自体が
生成されていなかった。

## 決定

`mise.lock` を生成して git で管理する。

そのために `~/.config/mise` の symlink 構成を変更する:

- 旧: `~/.config/mise/` は実ディレクトリで、`config.toml` だけ symlink
- 新: `~/.config/mise` 自体を dotfiles への symlink にする (nvim と同じ方式)

mise は lockfile を temp ファイル + rename で書き込むため、ファイル単位の
symlink だと `mise lock` 実行時に symlink が実ファイルで上書きされてしまう。
ディレクトリごと symlink にすることで、`mise lock` の出力が直接リポジトリ内に
書き込まれる。

既存マシンは旧構成のままになるため、冪等な移行スクリプト
`setup/migrate-mise-symlink.sh` を用意した。dotfiles 管理外のファイルが
あれば止まって手動確認を促す。

## 理由

- checksum 固定により、バージョン指定だけでは防げないアセット差し替えを検知できる
- `mise lock` は全プラットフォーム (linux/macos/windows) 分のエントリを
  生成するので、1 台で実行すれば全マシンに行き渡る
- aqua / npm バックエンドのツールは version 固定のみだが、aqua は
  レジストリ側に checksum 検証があるため許容する

## 結果

- `mise.lock` (126 プラットフォームエントリ) を生成しコミットした
- バージョン更新時は `MISE_EXPERIMENTAL=1 mise lock` で lockfile も更新する。
  手順は `config/.config/mise/README.md` (= `cheat mise`) に記載
- 既存マシンでは `setup/migrate-mise-symlink.sh` を一度実行する必要がある
- ADR-0021 の mise の項は「バージョン指定のみ」から「checksum 固定」に強化された
