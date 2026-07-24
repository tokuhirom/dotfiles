# ADR-0037: DCO の Signed-off-by を init.templateDir で配る

## ステータス
採用（ADR-0034 を置き換える）

## コンテキスト

ADR-0034 で、DCO の `Signed-off-by` を全コミットに付けるために
`core.hooksPath = ~/.config/git/hooks` をグローバル設定した。目的（コミット経路を
問わず sign-off が付く）は達成できていたが、`core.hooksPath` をグローバルに
設定することの副作用が想定より重かった。

`core.hooksPath` が設定されていると `git rev-parse --git-path hooks` が
その値を返すため、lefthook のように「リポジトリの hook 置き場」を git に
尋ねるツールがグローバル設定を掴んでしまう。lefthook v2 の `lefthook install` は
`core.hooksPath` が local/global どちらかに設定されているとエラーで停止し、
次の 2 つを案内する。

- `git config --unset-all --global core.hooksPath`
- `lefthook install --reset-hooks-path`

この dotfiles ではどちらも実害がある。

- `--reset-hooks-path` は `git config --global --unset-all core.hooksPath` を実行する。
  `~/.gitconfig` は `config/.gitconfig` への symlink なので、**dotfiles リポジトリの
  ファイルが書き換わり**、同時に全リポジトリで DCO が止まる。
- `--force` は警告のみで続行し、`~/.config/git/hooks` に hook を書き込む。ここも
  symlink なので **dotfiles の `config/.config/git/hooks/` が上書きされる**。

husky v9 は `core.hooksPath` を local に設定するため、そのリポジトリでは
警告もなく DCO だけが静かに消える（これは ADR-0034 でも想定済みだった）。

要するに、グローバル `core.hooksPath` は「他人の道具を壊す」だけでなく
「他人の道具に自分の dotfiles を壊させる」経路になっていた。

## 決定

`core.hooksPath` をやめ、`init.templateDir` で hook を配る方式に切り替える。

- `config/.config/git/template/hooks/prepare-commit-msg` に hook の実体を置く
- `~/.gitconfig` に `init.templateDir = ~/.config/git/template` を設定する
- `git init` / `git clone` のとき、template の中身が `.git/` へコピーされる
- 既存リポジトリへは `bin/git-template-apply` で配る（`git init` の再実行。
  既存のコミット・設定・ref は壊れず、template だけが再適用される）
- ローカル hook へ委譲する `hook-dispatch` は不要になったので撤去する。
  hook が `.git/hooks` に直接置かれる方式では、委譲先が自分自身になり無限再帰する

## 理由

- **他のツールと構造的に衝突しない**: `.git/hooks` の所有権をリポジトリ側に返すので、
  lefthook / husky が期待どおり動く。dotfiles が書き換えられる経路も消える。
- **`hook-dispatch` の委譲という複雑さが消える**: グローバル hooksPath が
  `.git/hooks` を潰すことへの対処だったので、前提ごとなくなる。
  hook 名ごとの symlink 群（委譲のためだけに 16 個張っていた）も不要になる。
- **DCO の取りこぼしは許容する**: template 方式では新規 clone/init のときにしか
  配られず、hook を更新しても既存リポジトリには伝播しない。ただし sign-off が
  付かなかった場合は CI で気づけるうえ、`git commit -s` や `git commit --amend -s` で
  後から直せる。dotfiles が壊れるリスクのほうが高い。

## 結果

- 新規に `git init` / `git clone` したリポジトリでは、これまでどおり経路を問わず
  `Signed-off-by` が付く。
- 既存リポジトリには自動では配られない。`bin/git-template-apply` を実行する
  （すでに `.git/hooks/prepare-commit-msg` があるリポジトリでは上書きされない）。
- `template/hooks/` の hook を修正しても、既に配られたリポジトリは古いままになる。
  配り直すには対象リポジトリの hook を消してから `git-template-apply` を実行する。
- lefthook / husky を使うリポジトリでは DCO が付かない。必要ならそのツール側の
  設定に sign-off を足すか `git commit -s` を使う。
- `init.templateDir` を設定したことで、git 標準テンプレート（`*.sample`,
  `description`, `info/exclude`）は新規リポジトリにコピーされなくなる。実害はない。
