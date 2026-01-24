{ config, pkgs, ... }: {
  # 開発用ビルド依存関係
  # mise で言語をビルドする際に必要なライブラリとツール

  # pkg-config が .dev パッケージを見つけられるように設定
  # ビルドツールがヘッダーファイルとライブラリを見つけられるように設定
  home.sessionVariables = {
    PKG_CONFIG_PATH = "$HOME/.nix-profile/lib/pkgconfig";
    C_INCLUDE_PATH = "$HOME/.nix-profile/include";
    CPLUS_INCLUDE_PATH = "$HOME/.nix-profile/include";
    LIBRARY_PATH = "$HOME/.nix-profile/lib";

    # ASDF PHP plugin: PostgreSQL サポートを無効化 (NixOS には pg_config がないため)
    ASDF_PHP_CONFIGURE_OPTIONS = "--without-pdo-pgsql";
  };

  home.packages = with pkgs; [
    # === ビルドツール ===
    gcc
    gnumake
    cmake
    autoconf
    automake
    libtool
    pkg-config
    bison
    re2c

    # === 基本ライブラリ (.dev output for headers and pkg-config) ===
    ncurses.dev
    libyaml.dev
    zlib
    zlib.dev
    openssl.dev
    readline.dev
    libxml2.dev
    sqlite.dev
    curl.dev

    # === 画像処理ライブラリ ===
    gd.dev
    libpng.dev
    libjpeg.dev
    freetype.dev
    libwebp  # No dev output
    libxpm
    oniguruma.dev  # libonig

    # === データベース ===
    postgresql  # pg_config などのバイナリ
    postgresql.dev  # ヘッダーファイル

    # === その他の開発ライブラリ ===
    libzip
    bzip2.dev
    libxslt.dev
    icu.dev

    # === GUI 開発ライブラリ (Wails/WebView) ===
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

    # === 言語ツール ===
    # Perl
    perl
    perlPackages.CPAN

    # Rust
    cargo
  ];
}
