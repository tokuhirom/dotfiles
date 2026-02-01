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
# root 権限で動作するため、特定のコミットに固定する
KEYD_VERSION="v2.6.0"
KEYD_COMMIT="7c0aecb8bfd34dc8642bf4eefd2e59c89e61cec3"

if ! command -v keyd &>/dev/null; then
    TMPDIR=$(mktemp -d)
    git clone https://github.com/rvaiya/keyd.git "$TMPDIR/keyd"
    cd "$TMPDIR/keyd"
    git checkout "$KEYD_COMMIT"
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
