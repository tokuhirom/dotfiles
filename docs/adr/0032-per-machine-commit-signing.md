# ADR-0032: コミット署名のマシン固有設定を ~/.gitconfig.local へ切り出す

## ステータス
採用

## コンテキスト
コミット署名を 1Password の SSH 署名に寄せたい。しかし署名に関わる設定の一部は
マシンごとに異なる。

- **op-ssh-sign のパス**が OS 依存
  - macOS: `/Applications/1Password.app/Contents/MacOS/op-ssh-sign`
  - Linux: `/opt/1Password/op-ssh-sign`
- **署名公開鍵**がマシン/アカウント依存

一方 `config/.gitconfig` は全マシンで共有される symlink。ここにマシン固有の
署名設定を書くと、別マシンで誤った鍵・パスを参照してしまう。

さらに `commit.gpgsign = true` を共有設定に置くと、署名未設定のマシンでも署名が
強制され commit が失敗する。実際、署名設定が中途半端な状態で rebase が
`cannot run gpg` で停止する事故が起きた。

Git の `includeIf` は `gitdir:` / `onbranch:` 等の条件しか持たず、OS 判定はできない。

## 決定
署名に関わるマシン固有の設定を、共有 dotfile から **`~/.gitconfig.local`** に切り出す。

- 共有 `config/.gitconfig` は末尾で `[include] path = ~/.gitconfig.local` するのみ。
  署名関連（`user.signingkey` / `gpg.format` / `gpg.ssh.program` /
  `commit.gpgsign` / `tag.gpgsign` / `allowedSignersFile`）は一切持たない。
- `~/.gitconfig.local` は dotfiles に入れない（symlink しない）。`$HOME` 直下に
  各マシンで配置する。include は対象ファイルが無ければ黙って無視される。
- `commit.gpgsign = true` も `~/.gitconfig.local` 側にのみ置く。設定済みのマシンだけ
  署名し、未設定のマシンでは commit が壊れない。
- テンプレート `config/.gitconfig.local.example` と、OS を判定して
  op-ssh-sign のパスを埋めた雛形を生成する `setup/setup-git-sign.sh` を用意する。
  署名鍵（公開鍵）は手動で書き換える運用とする。
- `setup-git-sign.sh` は bootstrap からは自動実行しない。雛形は placeholder の
  signingkey + `commit.gpgsign=true` を含むため、未編集のまま有効化すると commit が
  失敗する。署名を使うマシンで明示的に実行し、鍵を埋める手動ステップとする。

## 理由
- マシン固有設定を共有 config から物理的に分離でき、誤参照が起きない。
- include は対象ファイルが無ければ無視されるため、未設定マシンで署名が強制されず
  commit が壊れない（事故の再発防止）。
- OS 依存の op-ssh-sign パスを setup スクリプトで吸収できる。
- 1Password 管理の鍵に寄せられ、秘密鍵をディスクに置かずに済む。

## 結果
- 署名を使うマシンでの初期設定:
  1. `setup/setup-git-sign.sh` を実行 → `~/.gitconfig.local` 生成（op-ssh-sign パスは自動）
  2. `~/.gitconfig.local` の `signingkey` を自分の 1Password 公開鍵に書き換える
     （`ssh-add -L` で確認可）
- 署名を使わないマシンでは何もしなくてよい（commit は署名なしで通る）。
- 共有 `config/.gitconfig` から `signingkey` / `gpg` / `commit.gpgsign` /
  `tag.gpgsign` が消え、機械非依存になった。
