{ config, pkgs, ... }: {
  # 開発用ビルド依存関係
  # mise で言語をビルドする際に必要なライブラリとツール

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

    # === 基本ライブラリ ===
    ncurses
    libyaml
    zlib
    openssl
    readline
    libxml2
    sqlite
    curl

    # === 画像処理ライブラリ ===
    gd
    libpng
    libjpeg
    freetype
    libwebp
    libxpm
    oniguruma  # libonig

    # === データベース ===
    postgresql

    # === その他の開発ライブラリ ===
    libzip
    bzip2
    libxslt
    icu

    # === 言語ツール ===
    # Perl
    perl
    perlPackages.CPAN

    # Ruby
    bundler

    # Rust
    cargo
  ];
}
