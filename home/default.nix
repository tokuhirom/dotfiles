{ config, pkgs, lib, ... }: {
  imports = [
    ./common.nix
    ./darwin.nix
    ./linux.nix
  ];

  # Home Manager settings
  home.stateVersion = "24.11";

  # User information (can be overridden in flake.nix)
  home.username = lib.mkDefault "tokuhirom";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin
    then "/Users/tokuhirom"
    else "/home/tokuhirom"
  );

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
