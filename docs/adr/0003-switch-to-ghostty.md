# ADR-0003: WezTerm から Ghostty への移行

## ステータス
採用

## コンテキスト
これまで WezTerm を使用していたが、aerospace との相性問題があった。Hammerspoon への移行（ADR-0001）により、タイリング WM の制約がなくなったため、ターミナルエミュレータの選択肢が広がった。

## 決定
Ghostty に移行する。

## 理由
- Hammerspoon 移行により aerospace との相性問題が解消
- WezTerm に特別な不満はないが、Ghostty を試してみたい
- Ghostty は軽量で高速

## 結果
- `darwin/homebrew.nix` で ghostty を有効化
- `config/.hammerspoon/init.lua` で T キーの起動アプリを Ghostty に変更
- WezTerm は一旦残す（フォールバック用）
