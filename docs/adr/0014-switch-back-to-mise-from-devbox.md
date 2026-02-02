# ADR-0014: devbox から mise に戻す

## ステータス
採用（ADR-0004, ADR-0010 を廃止）

## コンテキスト
ADR-0004 で devbox をプロジェクトツール管理に採用し、ADR-0010 で mise を廃止して devbox に統一した。しかし運用していく中で以下の問題が明らかになった。

### devbox の問題点
- **Nix が必須**: devbox は内部で Nix を使っており、Nix のインストールが前提
- **Nix の知識が必要**: トラブル時に Nix の知識がないと対処が困難
- **チーム導入のハードル**: Nix に慣れていないメンバーには導入が厳しい
- **速度**: Nix ストアからのフェッチ・ビルドが遅い

### mise の利点
- **インストールが簡単**: `curl https://mise.run | sh` だけで導入可能
- **Nix 不要**: GitHub Releases からバイナリを直接ダウンロード
- **github: バックエンド**: 任意の GitHub リリースからツールをインストール可能（プラグイン不要）
- **速度**: バイナリを直接取得するため高速
- **チーム導入が容易**: 前提条件が少なく、どの環境でも動作する

## 決定
devbox を廃止し、ランタイム・ツール管理を mise に戻す。

## 結果
- `home/darwin.nix`, `home/linux.nix` から devbox を削除し mise を有効化
- `config/.zshrc` に `mise activate` を追加
- `config/.config/mise/config.toml` のシンボリックリンクを復活
- `setup/setup-mise.sh` で Nix なし環境でも mise をインストール可能
- devbox の設定ファイル（`cheat/devbox.md` 等）は念のため残す
