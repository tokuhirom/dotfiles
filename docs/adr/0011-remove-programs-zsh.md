# ADR-0011: programs.zsh を廃止し素の .zshrc で管理

## ステータス
採用

## コンテキスト
home-manager の `programs.zsh` で zsh の設定を管理していた。
しかし、既存の `config/.zshrc` と設定が重複しており（履歴設定、補完設定など）、
`programs.zsh` の `initContent` から `.zshrc` を source する二重構造になっていた。

## 決定
`programs.zsh` を廃止し、`config/.zshrc` で直接管理する。
zsh プラグイン（autosuggestions, syntax-highlighting）は apt/homebrew でインストールする。

### 変更内容
- `home/programs/zsh.nix` を削除
- `home/common.nix` から import と `home.sessionVariables` を削除
- `config/.zshrc` に direnv hook、zsh プラグインの source を追加
- `setup/setup-popos-desktop.sh` に zsh-autosuggestions, zsh-syntax-highlighting を追加

## 理由
- `.zshrc` と `programs.zsh` の二重管理を解消
- 設定変更が即座に反映される（`apply-nix.sh` 不要）
- zsh プラグインは apt/homebrew で十分管理できる
- シェルの設定はシェルの設定ファイルで管理するのが自然

## 結果
- zsh の設定はすべて `config/.zshrc` で完結する
- プラグインのインストールは `setup/setup-popos-desktop.sh`（Linux）または homebrew（macOS）
