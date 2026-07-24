# git の hook テンプレート

`~/.gitconfig` の `init.templateDir = ~/.config/git/template` から参照される、
新しいリポジトリに配られる hook の置き場 (ADR-0037)。

## 何をしているか

- **DCO**: すべてのコミットに `Signed-off-by: Name <mail>` を自動で付ける。
  `git commit` / `git ci` / gh / エディタ経由 / Claude Code など、経路を問わず付く。
  すでに `Signed-off-by` がある場合は重複させない。
- **配り方**: `git init` / `git clone` のときに `template/` の中身が
  そのリポジトリの `.git/` へ**コピー**される。`core.hooksPath` は使わない。

## 構成

```
template/
└── hooks/
    └── prepare-commit-msg   # DCO の付与
```

## 既存リポジトリへ配る

`init.templateDir` は `git init` / `git clone` のときしか効かない。
すでに手元にあるリポジトリには `bin/git-template-apply` で配る
（内部で `git init` を再実行する。既存のコミットや設定は壊れない）。

```bash
git-template-apply                  # カレントのリポジトリ
git-template-apply ~/foo ~/bar      # 指定したリポジトリ
ghq list -p | xargs git-template-apply
```

すでに `.git/hooks/prepare-commit-msg` があるリポジトリでは上書きされない。
hook を更新したときに配り直したい場合は、その hook を消してから実行する。

## hook を追加したいとき

`template/hooks/` にその名前で実行可能なファイルを置くだけ。
既存リポジトリには上記のとおり `git-template-apply` で配る。

## Signed-off-by を付けたくないコミット

`--no-verify` は prepare-commit-msg には効かないので、trailer を消すなら

```bash
git commit --amend   # エディタで Signed-off-by 行を削除して保存
```

## 注意点

- **コピーなので更新は伝播しない**。`template/hooks/` を直しても、
  すでに hook が入っているリポジトリは古いままになる。
- lefthook / husky を入れたリポジトリでは、そのツールが `.git/hooks` を
  上書きするか `core.hooksPath` をローカル設定するため DCO は付かなくなる。
  必要ならそのリポジトリの hook 側に sign-off を足すか `git commit -s` を使う。
- `init.templateDir` を設定すると git 標準のテンプレート
  (`*.sample` や `description`) はコピーされなくなる。実害はない。
- 名前とメールは `git var GIT_COMMITTER_IDENT` から取るので、リポジトリごとに
  `user.email` を変えていればその値が入る。
