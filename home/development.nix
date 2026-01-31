{ config, pkgs, ... }: {
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
  ];
}
