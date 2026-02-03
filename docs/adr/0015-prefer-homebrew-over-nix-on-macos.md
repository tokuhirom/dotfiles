# ADR-0015: macOS では Homebrew を Nix より優先する

## ステータス
採用

## コンテキスト
これまで CLI ツールは主に Nix (nix-darwin) で管理し、GUI アプリは Homebrew (casks) で管理していた。

しかし、Nix を使い続けてきた結果、以下の課題が明らかになった：
- Nix のメリットを実感できなかった
- 将来的に Nix をやめたいという思いがある
- まずは Homebrew 中心の構成に移行したい

## 決定
macOS 環境では Homebrew を優先して使用する。

- CLI ツールも Homebrew (brews) で管理する
- Homebrew で入手できないパッケージのみ Nix に残す
- GUI アプリは引き続き Homebrew (casks) で管理

## 理由
- Homebrew はmacOS のデファクトスタンダードであり、情報が豊富
- トラブル時の対処が容易
- 段階的に Nix への依存を減らし、最終的には Nix を廃止する可能性を見据えている

## 結果
- Homebrew パッケージは `Brewfile` で管理
- `bin/brew-sync` で宣言的に同期（インストール + 不要パッケージ削除）
- nix-darwin の homebrew モジュールは無効化
- nix-darwin はシステム設定と dotfiles リンクの管理に使用
