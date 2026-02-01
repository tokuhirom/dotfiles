# ADR-0008: Linux パッケージ管理を home-manager から apt に移行

## ステータス
採用

## コンテキスト
`home/linux.nix` で Linux 固有のパッケージ（i3, フォント, ibus, X11 ユーティリティ等）を home-manager の `home.packages` で管理していた。
しかし、これらはシステムワイドにインストールすれば十分なものばかりで、Nix で管理する必要性が薄い。

## 決定
Linux 固有のパッケージ管理を `setup/setup-popos-desktop.sh` の `apt install` に移行する。
`home/linux.nix` の環境変数設定（IBus）は残す。

### 移行したパッケージ
- クリップボード: xclip, wl-clipboard
- ウィンドウ管理: i3, i3status, i3lock, rofi, polybar, dunst, xss-lock
- フォント: noto-fonts, noto-fonts-cjk, font-awesome 等
- 日本語入力: ibus, ibus-mozc
- X11 ユーティリティ: xev, xdpyinfo, xrandr, xmodmap, arandr
- スクリーンショット: flameshot（scrot, maim は廃止）

### 対象外
- xremap は apt にないため別途導入
- htop, btop は `home/common.nix` で管理済み

## 理由
- これらのパッケージはシステムワイドにインストールすれば十分
- apt で管理したほうがシンプルで、Nix の評価コストを減らせる
- Pop!_OS のセットアップスクリプトに集約することで見通しがよくなる

## 結果
- Linux 固有パッケージは `setup/setup-popos-desktop.sh` で管理する
- `home/linux.nix` は環境変数設定のみ残る
