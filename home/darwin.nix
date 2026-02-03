{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
  # macOS-specific home-manager configuration
  # ADR-0015: Homebrew を優先
  #
  # 現在、すべてのパッケージは Homebrew (Brewfile) で管理されています

  home.packages = with pkgs; [
    # Homebrew にないパッケージがあればここに追加
  ];

}
