#!/bin/bash

# ~/.config/mise をディレクトリごと symlink に移行するスクリプト (ADR-0023)
#
# 旧構成: ~/.config/mise/ (実ディレクトリ) の中に config.toml だけ symlink
# 新構成: ~/.config/mise 自体が dotfiles への symlink (mise.lock も管理対象になる)
#
# 何度実行しても安全 (冪等)。

set -e

DIR="$HOME/.config/mise"
SRC="$HOME/dotfiles/config/.config/mise"

if [ -L "$DIR" ]; then
    echo "OK: $DIR は既に symlink です ($(readlink "$DIR"))"
    exit 0
fi

if [ ! -d "$DIR" ]; then
    ln -s "$SRC" "$DIR"
    echo "Linked $SRC -> $DIR"
    exit 0
fi

# 旧構成の config.toml symlink は削除してよい
if [ -L "$DIR/config.toml" ]; then
    rm "$DIR/config.toml"
fi

# dotfiles 管理外のファイルが残っていたら手動確認に倒す
remaining=$(ls -A "$DIR")
if [ -n "$remaining" ]; then
    echo "ERROR: $DIR に dotfiles 管理外のファイルが残っています:" >&2
    echo "$remaining" >&2
    echo "内容を確認して、必要なら $SRC に移してから再実行してください。" >&2
    exit 1
fi

rmdir "$DIR"
ln -s "$SRC" "$DIR"
echo "Migrated: $SRC -> $DIR"
