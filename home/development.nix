{ config, pkgs, ... }: {
  # 開発用ビルド依存関係
  # mise で言語をビルドする際に必要なライブラリとツール

  # pkg-config が .dev パッケージを見つけられるように設定
  home.sessionVariables = {
    PKG_CONFIG_PATH = "$HOME/.nix-profile/lib/pkgconfig";
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
    oniguruma  # libonig

    # === データベース ===
    postgresql

    # === その他の開発ライブラリ ===
    libzip
    bzip2.dev
    libxslt.dev
    icu.dev

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
