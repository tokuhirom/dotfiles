# dotfiles プロジェクト用 Claude 指示

## ショートカットキーの設定

ショートカットキーを設定する際は、aerospace のキーバインドと競合しないように注意すること。

aerospace で使用中のキー:
- `Alt + h/j/k/l` - フォーカス移動
- `Alt + Shift + h/j/k/l` - ウィンドウ移動
- `Alt + r/c/d/z/g/a/e` - aerotag タグ切り替え
- `Ctrl + Alt + *` - aerotag タグトグル
- `Alt + Shift + *` - aerotag ウィンドウ移動

設定前に `config/.config/aerospace/aerospace.toml` を確認すること。

## config/.config 下の設定ファイル

`config/.config/` 以下に設定を追加・変更した場合:

1. そのディレクトリに `README.md` を作成してショートカットキーや使い方を記載する
2. `cheat/` ディレクトリにシンボリックリンクを作成して `cheat <name>` でアクセスできるようにする

```bash
# 例: zellij の場合
ln -s ../config/.config/zellij/README.md cheat/zellij.md
```

現在 cheat でアクセスできる設定:
- `cheat aerospace` - aerospace + aerotag
- `cheat zellij` / `cheat zj` - zellij
- `cheat wezterm` - wezterm

## bin/ コマンド

便利なコマンドは `bin/` に追加する:
- `aerotag-list` - aerotag のウィンドウ・タグ状態を一覧表示
- `macos-hotkeys` - macOS のショートカットキー一覧

## macOS 設定

macOS のシステム設定変更は `setup/setup-mac-settings.sh` にコマンドとして追加する。
