{ config, pkgs, lib, ... }: {
  # 開発用パッケージ
  #
  # ビルドツール (gcc, cmake, autoconf 等) は Xcode Command Line Tools
  # またはプロジェクトごとに devbox で管理する。
  # nix で入れるとシステムのツールチェインと競合するため。

  home.packages = with pkgs; [
    # === 言語ツール ===
    perl
    perlPackages.CPAN
    cargo
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # === GUI 開発ライブラリ (Wails/WebView) - Linux のみ ===
    gtk3.dev
    glib.dev
    pango.dev
    gdk-pixbuf.dev
    cairo.dev
    harfbuzz.dev
    atk.dev
    at-spi2-atk.dev
    at-spi2-core.dev
    libsoup_3.dev
    webkitgtk_4_1.dev
  ];
}
