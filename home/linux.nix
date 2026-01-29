{ config, pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Linux-specific home-manager configuration

  home.packages = with pkgs; [
    # === クリップボード ===
    xclip  # X11 クリップボードサポート
    wl-clipboard  # Wayland クリップボードサポート

    # === ウィンドウ管理 ===
    i3  # タイル型ウィンドウマネージャー
    i3status  # i3 ステータスバー
    i3lock  # スクリーンロック
    rofi  # アプリケーションランチャー
    polybar  # ステータスバー
    dunst  # 通知デーモン
    xss-lock  # スクリーンセーバーロック

    # === フォント ===
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    source-han-sans
    source-han-serif
    font-awesome  # アイコンフォント

    # === 日本語入力 (IME) ===
    ibus  # 入力メソッドフレームワーク
    ibus.dev  # ヘッダーファイル
    ibus-engines.mozc  # Google 日本語入力

    # === X11 ユーティリティ ===
    xorg.xev  # X イベント表示
    xorg.xdpyinfo  # ディスプレイ情報
    xorg.xrandr  # ディスプレイ設定
    xorg.xmodmap  # キーマップ設定
    arandr  # xrandr の GUI フロントエンド

    # === キーリマップ ===
    xremap  # 高度なキーリマッパー（X11/Wayland 対応）

    # === スクリーンショット ===
    scrot  # スクリーンショットツール
    maim  # スクリーンショットツール（高機能）
    flameshot  # GUI スクリーンショットツール（注釈機能付き）

    # === システムモニタ ===
    htop  # プロセスビューア
    btop  # リソースモニタ（モダン）
  ];

  # Linux-specific dotfiles
  home.file = {
    # X11
    ".xinitrc".source = ../config/.xinitrc;

    # Window management
    ".config/i3/config".source = ../config/.config/i3/config;
    ".config/polybar/config".source = ../config/.config/polybar/config;
    ".config/polybar/launch.sh".source = ../config/.config/polybar/launch.sh;

    # Terminal (Linux-specific config)
    ".config/wezterm/wezterm.lua".source = ../config/.config/wezterm/wezterm.lua;

    # Xremap
    ".config/xremap/config.yml".source = ../config/.config/xremap/config.yml;

    # MIME type associations
    ".config/mimeapps.list".source = ../config/.config/mimeapps.list;
  };

  # Linux 固有の環境変数
  home.sessionVariables = {
    # IBus IME 設定
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };
}
