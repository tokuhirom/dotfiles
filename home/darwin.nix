{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
  # macOS-specific home-manager configuration
  # ADR-0015: Homebrew を優先。Nix 専用パッケージのみここで管理

  home.packages = with pkgs; [
    # Nix 専用パッケージ
    nix-direnv
    devbox
  ];

}
