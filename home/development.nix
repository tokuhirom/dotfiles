{ config, pkgs, ... }: {
  # 開発用パッケージ
  # ADR-0015: macOS では Homebrew を優先
  #
  # ビルドツール (gcc, cmake, autoconf 等) は Xcode Command Line Tools
  # またはプロジェクトごとに devbox で管理する。

  home.packages = with pkgs; [
    # Homebrew で入手できないパッケージのみここに追加
  ];
}
