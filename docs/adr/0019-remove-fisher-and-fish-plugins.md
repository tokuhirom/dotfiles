# ADR-0019: fisher と fish プラグインを撤去する

## ステータス

採用

## コンテキスト

supply chain risk の棚卸し (ADR-0016〜0018 の続き) で、fish のプラグイン管理に
以下の問題があった:

- `fish_plugins` の 5 プラグイン中 4 つが未 pin (HEAD 追従)、
  tide のみ `@v6` だがタグは可動なので commit 固定ではない
- `setup/setup-fisher.sh` が fisher 本体を `curl | source` で main HEAD から
  取得・実行していた

当初は全プラグインの commit pin を検討したが、そもそも fish は最近使っておらず
(現在の常用シェルは zsh)、プラグインを維持する動機がなかった。

各プラグインの役割と依存状況:

| プラグイン | 役割 | config.fish からの参照 |
|-----------|------|----------------------|
| ilancosman/tide | プロンプト | なし |
| franciscolourenco/done | 長時間コマンドの完了通知 | なし |
| jethrokuan/z | ディレクトリ履歴ジャンプ | **あり** (`fzf_z` 関数, Ctrl-Q) |
| 0rax/fish-bd | 親ディレクトリ移動 | なし |
| kpbaks/autols.fish | cd 時に自動 ls | なし |

## 決定

fisher によるプラグイン機構を撤去する。

- `config/.config/fish/fish_plugins` を削除
- `setup/setup-fisher.sh` を削除
- `link.sh` から `link .config/fish/fish_plugins` を削除

`config.fish` 本体は設定ファイル保持ルールに従い残す。

## 理由

- 使っていないシェルのために、未 pin のサードパーティコードを 5 + 1 (fisher 本体)
  リポジトリ分も取得する経路を維持するのは、リスクだけあって利益がない
- pin して維持するコスト (定期的な更新レビュー) を払う価値が現状ない
- fish を再開する場合は、その時点で必要なプラグインだけを commit pin した形で
  導入し直せばよい (ADR-0016 の方針に従う)

## 結果

- fish を再開した場合、`config.fish` の `fzf_z` 関数 (Ctrl-Q) は `z` プラグインに
  依存しているため動かない。再開時は `jethrokuan/z` を commit pin で入れ直すこと
- 既存マシンの `~/.config/fish/fish_plugins` symlink は dangling になるので削除する
- インストール済みプラグインの実体 (`~/.config/fish/functions/` など) は
  fish を使っていないので実害はなく、気になる場合は手動で削除する
