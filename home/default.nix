{ config, pkgs, lib, ... }: {
  imports = [
    ./common.nix
    ./darwin.nix
    ./linux.nix
  ];

  # Home Manager settings
  home.stateVersion = "24.11";

  # User information (username と homeDirectory は flake.nix で設定)

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
