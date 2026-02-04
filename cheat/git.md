# Git チートシート

## 歴史改変（rebase -i）

```bash
# 直近 N コミットを編集
git rebase -i HEAD~N

# 特定のコミットから編集（そのコミットは含まない）
git rebase -i <commit-hash>

# 最初のコミットから全て編集
git rebase -i --root
```

### rebase -i のコマンド

| コマンド | 短縮 | 説明 |
|----------|------|------|
| `pick` | `p` | コミットをそのまま使う |
| `reword` | `r` | コミットメッセージを変更 |
| `edit` | `e` | コミットを修正（停止する） |
| `squash` | `s` | 前のコミットに統合（メッセージ編集あり） |
| `fixup` | `f` | 前のコミットに統合（メッセージ破棄） |
| `drop` | `d` | コミットを削除 |

### よくある操作

```bash
# 直前のコミットメッセージを修正
git commit --amend

# 直前のコミットにファイルを追加（メッセージ変更なし）
git add <file>
git commit --amend --no-edit

# rebase 中止
git rebase --abort

# rebase 続行（edit 後など）
git rebase --continue

# conflict 解決後に続行
git add <conflicted-files>
git rebase --continue
```

## コミットの取り消し

```bash
# 直前のコミットを取り消し（変更は残る）
git reset --soft HEAD~1

# 直前のコミットを取り消し（変更もステージングも残る）
git reset HEAD~1

# 直前のコミットを完全に取り消し（変更も消える）
git reset --hard HEAD~1

# 特定のコミットまで戻す
git reset --hard <commit-hash>

# リモートにプッシュ済みのコミットを打ち消す（新しいコミットを作成）
git revert <commit-hash>
```

## ブランチ操作

```bash
# ブランチ作成して切り替え
git switch -c <branch-name>

# リモートブランチをチェックアウト
git switch <remote-branch>

# ブランチ削除
git branch -d <branch-name>      # マージ済みのみ
git branch -D <branch-name>      # 強制削除

# リモートで削除されたブランチをローカルからも削除
git fetch --prune
```

## cherry-pick

```bash
# 特定のコミットを現在のブランチに適用
git cherry-pick <commit-hash>

# 複数コミットを適用
git cherry-pick <hash1> <hash2> <hash3>

# 範囲指定（hash1 は含まない、hash2 は含む）
git cherry-pick <hash1>..<hash2>

# コミットせずに変更だけ適用
git cherry-pick -n <commit-hash>
```

## stash

```bash
# 変更を一時退避
git stash

# メッセージ付きで退避
git stash push -m "作業中の機能"

# 退避リスト表示
git stash list

# 最新の stash を復元（stash は残る）
git stash apply

# 最新の stash を復元して削除
git stash pop

# 特定の stash を復元
git stash apply stash@{1}

# stash の内容を確認
git stash show -p stash@{0}

# stash を削除
git stash drop stash@{0}
git stash clear  # 全削除
```

## reflog（救済措置）

```bash
# 操作履歴を表示
git reflog

# 誤って reset した場合の復旧
git reset --hard HEAD@{1}

# 削除したブランチの復旧
git branch <branch-name> HEAD@{N}
```

## diff

```bash
# ステージング前の変更
git diff

# ステージング済みの変更
git diff --staged

# コミット間の差分
git diff <hash1>..<hash2>

# ファイル名のみ表示
git diff --name-only

# 統計情報
git diff --stat
```

## log

```bash
# グラフ表示
git log --oneline --graph --all

# 特定ファイルの履歴
git log -p <file>

# コミットを検索
git log --grep="キーワード"

# 変更内容を検索
git log -S "検索文字列"
```

## 危険なコマンド（要注意）

```bash
# 強制プッシュ（他人の変更を上書きする可能性）
git push --force-with-lease  # 安全版（推奨）
git push --force             # 危険版

# 追跡されていないファイルを削除
git clean -n  # dry-run（確認）
git clean -f  # 実行
git clean -fd # ディレクトリも含む
```
