{ config, pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
  # macOS-specific home-manager configuration

  home.packages = with pkgs; [
    # macOS-specific tools will be added in Phase 2
  ];

  # === Phase 3: macOS-specific dotfiles ===
  home.file = {
    # Window management
    ".yabairc".source = ../config/.yabairc;
    ".skhdrc".source = ../config/.skhdrc;
  };
}
