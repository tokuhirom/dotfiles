# xremap - キーリマッパー

X11/Wayland 対応のキーリマッパー。Karabiner Elements のように、単独タップと組み合わせで動作を変えることができる。

## キーバインド

| キー | 単独タップ | 組み合わせ |
|------|-----------|-----------|
| 左 Alt | 無変換 | Alt キー |
| 右 Alt | 変換 | Alt キー |

## セットアップ

xremap は `/dev/input/event*` デバイスへのアクセスが必要です。

```bash
# ユーザーを input グループに追加
sudo usermod -aG input $USER

# 再ログインしてグループ変更を反映
# または一時的に:
newgrp input
```

## 起動方法

```bash
# X11 の場合
xremap ~/.config/xremap/config.yml

# systemd で自動起動（推奨）
systemctl --user enable xremap
systemctl --user start xremap
```

## systemd service 設定

`~/.config/systemd/user/xremap.service`:

```ini
[Unit]
Description=xremap key remapper
After=graphical-session.target

[Service]
ExecStart=/run/current-system/sw/bin/xremap %h/.config/xremap/config.yml
Restart=always

[Install]
WantedBy=graphical-session.target
```

## 設定ファイル

- `~/.config/xremap/config.yml` - メイン設定

## 参考

- [xremap GitHub](https://github.com/k0kubun/xremap)
