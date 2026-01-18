{ config, pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Linux-specific home-manager configuration
  # Phase 1: Foundation - Basic Linux setup

  home.packages = with pkgs; [
    # Linux-specific tools (Phase 1: Core tools only)
    xclip  # Clipboard support for terminal
  ];

  # Linux-specific dotfiles will be linked in Phase 3
  home.file = {
    # Placeholder
  };
}
