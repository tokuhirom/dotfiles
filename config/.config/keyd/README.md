# keyd - キーリマッパー

カーネルレベルで動作するキーリマッパー。root 権限で動作し、X11/Wayland/コンソールすべてで使える。

## キーバインド

| キー | 単独タップ | ホールド/組み合わせ |
|------|-----------|-------------------|
| Caps Lock | - | Ctrl |
| 左 Alt | 無変換 | Alt キー |
| 右 Alt | 変換 | Alt キー |

## セットアップ

```bash
./setup/setup-keyd.sh
```

## 設定の変更

1. `config/.config/keyd/default.conf` を編集
2. 設定を反映:

```bash
sudo cp ~/.config/keyd/default.conf /etc/keyd/default.conf
sudo systemctl restart keyd
```

## 動作確認

```bash
# キー入力のモニタリング
sudo keyd -m
```

## 設定ファイル

- `/etc/keyd/default.conf` - keyd が読む設定（システム）
- `~/.config/keyd/default.conf` - dotfiles 管理用（シンボリックリンク）

## 参考

- [keyd GitHub](https://github.com/rvaiya/keyd)
