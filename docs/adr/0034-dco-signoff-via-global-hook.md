# ADR-0034: DCO の Signed-off-by をグローバル hook で自動付与する

## ステータス
採用

## コンテキスト

DCO (Developer Certificate of Origin) を要求する OSS リポジトリが増えており、
コミットに `Signed-off-by:` trailer が必要になる。付け忘れると CI で弾かれ、
rebase してやり直すことになる。

これまで `~/.gitconfig` の `[alias]` に次の 2 つを置いていた。

```
ci = commit -s
commit = commit -s
```

しかし **git のエイリアスは組み込みコマンドを上書きできない** ため、
`commit = commit -s` は完全な no-op だった。`git commit` を直接叩くと sign-off は
付かず、実際に効いていたのは `git ci` を使ったときだけ。
さらに gh やエディタ、Claude Code のようなツールは `git commit` を直接呼ぶので、
エイリアスでは経路をカバーしきれない。

git には `commit.signoff` に相当する設定は存在しない
(`format.signOff` は `git format-patch` 専用)。よって設定だけでは実現できない。

## 決定

`prepare-commit-msg` hook をグローバル hooks ディレクトリに置き、
コミット経路によらず `Signed-off-by` を自動付与する。

- `config/.config/git/hooks/hook-dispatch` を実体とし、各 hook 名から symlink する
- `~/.gitconfig` に `core.hooksPath = ~/.config/git/hooks` を設定
- trailer の付与は `git interpret-trailers --if-exists doNothing` で行い、重複を避ける
- 署名者は `git var GIT_COMMITTER_IDENT` から取る（リポジトリごとの `user.email`
  の上書きや環境変数もそのまま反映される）
- 効いていなかった `commit = commit -s` エイリアスは削除する（`ci` は残す）

## 理由

- **経路を問わず効く**: `git commit`・`gh`・エディタ・エージェントのいずれからでも付く。
  エイリアス方式の最大の穴がこれで塞がる。
- **hooksPath が .git/hooks を潰す問題への対処**: グローバル `core.hooksPath` を設定すると
  git は各リポジトリの `.git/hooks` を一切見なくなる。これは静かに壊れる類の副作用なので、
  `hook-dispatch` が `.git/hooks/<hook 名>` を見つけたら `exec` で委譲する構成にした。
  委譲のためだけに主要な hook 名すべての symlink を張ってある。
- **DCO 不要のリポジトリでも実害がない**: 余分な trailer が 1 行増えるだけで、
  そのために hook を出し入れするコストのほうが高い。

## 結果

- 全コミットに `Signed-off-by` が入るようになる。DCO の CI チェックで落ちなくなる。
- リポジトリ固有の `.git/hooks` は引き続き動く（`hook-dispatch` が呼ぶ）。
- husky / lefthook のようにリポジトリ側で `core.hooksPath` をローカル設定するツールを
  使うと、そちらが優先されてこの hook は動かない = DCO も付かない。そういうリポジトリでは
  `git commit -s` を明示するか、リポジトリ側の hook に sign-off を足す必要がある。
- sign-off を付けたくないコミットでは `git commit --amend` で trailer を消す
  （`--no-verify` は `prepare-commit-msg` には効かない）。
