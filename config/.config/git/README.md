# git のグローバル hooks

`~/.gitconfig` の `core.hooksPath = ~/.config/git/hooks` から参照される、
全リポジトリ共通の hook 置き場 (ADR-0034)。

## 何をしているか

- **DCO**: すべてのコミットに `Signed-off-by: Name <mail>` を自動で付ける。
  `git commit` / `git ci` / gh / エディタ経由 / Claude Code など、経路を問わず付く。
  すでに `Signed-off-by` がある場合は重複させない。
- **ローカル hook のチェーン**: グローバル `core.hooksPath` を設定すると git は
  各リポジトリの `.git/hooks` を見なくなるため、`hook-dispatch` が
  `.git/hooks/<hook 名>` を見つけたら実行を引き継ぐ。

## 構成

```
hooks/
├── hook-dispatch          # 実体。呼ばれた hook 名で分岐する
├── prepare-commit-msg -> hook-dispatch   # DCO の付与はここ
├── pre-commit         -> hook-dispatch   # 以下はローカル hook 委譲のためだけの symlink
├── commit-msg         -> hook-dispatch
└── ...
```

## hook を追加したいとき

1. `hook-dispatch` に処理を足す（`$hook_name` で分岐）
2. その hook 名の symlink がなければ張る

```bash
cd config/.config/git/hooks
ln -s hook-dispatch pre-push
```

## Signed-off-by を付けたくないコミット

`--no-verify` は prepare-commit-msg には効かないので、trailer を消すなら

```bash
git commit --amend   # エディタで Signed-off-by 行を削除して保存
```

## 注意点

- husky / lefthook のようにリポジトリ側で `core.hooksPath` をローカル設定する
  ツールを入れると、そちらが優先されてこの hook は動かない（＝ DCO も付かない）。
- 名前とメールは `git var GIT_COMMITTER_IDENT` から取るので、リポジトリごとに
  `user.email` を変えていればその値が入る。
