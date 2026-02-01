#!/bin/bash

# ibus-skk のキーボードレイアウトを US に変更する
# デフォルトでは jp (日本語キーボード) が設定されているため、
# US キーボードを使っている場合はこのスクリプトで修正する。
# パッケージ更新時に戻るので、その都度再実行が必要。

sudo sed -i 's|<layout>jp</layout>|<layout>us</layout>|' /usr/share/ibus/component/skk.xml

echo "ibus-skk のキーボードレイアウトを us に変更しました。"
echo "反映するにはログアウトしてください。"
