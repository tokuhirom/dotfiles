# ADR-0012: xremap から keyd に移行

## ステータス
採用

## コンテキスト
Linux 環境でのキーリマッピングに xremap を使用していた。
xremap はユーザー空間で動作し、`/dev/input/event*` へのアクセス権限（input グループ）が必要で、
X11/Wayland セッション開始後にしか動作しない。

## 決定
xremap の代わりに keyd を使用する。

### 変更内容
- `config/.config/keyd/default.conf` を新規作成
- `setup/setup-keyd.sh` を新規作成
- xremap の設定ファイル（`config/.config/xremap/`）はそのまま残す

### キーマップ
- Caps Lock → Ctrl（新規追加）
- 左 Alt: ホールド → Alt、単押し → 無変換（xremap と同等）
- 右 Alt: ホールド → Alt、単押し → 変換（xremap と同等）

## 理由
- keyd はカーネルレベル（root 権限の systemd サービス）で動作するため、X11/Wayland/TTY すべてで使える
- input グループへのユーザー追加が不要
- C 実装で軽量・高速
- 設定ファイルがシンプル

## 結果
- キーリマッピングが TTY（コンソール）でも有効になる
- systemd のシステムサービスとして管理される（ユーザーサービスではない）
- 設定変更時は `/etc/keyd/default.conf` にコピーして `sudo systemctl restart keyd` が必要
