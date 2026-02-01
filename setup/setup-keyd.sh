#!/bin/bash

# keyd セットアップスクリプト
# keyd をソースからビルド・インストールし、設定を適用する

set -ex

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# 依存パッケージのインストール
if command -v apt-get &>/dev/null; then
    sudo apt-get install -y build-essential git
elif command -v pacman &>/dev/null; then
    sudo pacman -S --needed --noconfirm base-devel git
fi

# keyd のビルド・インストール
if ! command -v keyd &>/dev/null; then
    TMPDIR=$(mktemp -d)
    git clone https://github.com/rvaiya/keyd.git "$TMPDIR/keyd"
    cd "$TMPDIR/keyd"
    make
    sudo make install
    cd -
    rm -rf "$TMPDIR"
else
    echo "keyd は既にインストールされています"
fi

# 設定ファイルのコピー
sudo mkdir -p /etc/keyd
sudo cp "$DOTFILES_DIR/config/.config/keyd/default.conf" /etc/keyd/default.conf

# systemd サービスの有効化・起動
sudo systemctl enable keyd
sudo systemctl restart keyd

echo "keyd のセットアップが完了しました"
echo "sudo keyd -m でキー入力をモニタリングして動作確認できます"
