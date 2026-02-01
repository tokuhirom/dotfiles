{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
  # macOS-specific home-manager configuration

  home.packages = with pkgs; [
    # macOS-specific tools
  ];

}
