{ pkgs, config, ... }:
let
  # home-manager.users から最初のユーザー名を取得
  primaryUser = builtins.head (builtins.attrNames config.home-manager.users);
in {
  imports = [
    ./packages.nix         # CLI tools from nixpkgs
    ./homebrew.nix         # GUI apps via Homebrew
    ./system-settings.nix  # macOS system settings
  ];

  # Primary user for user-specific options (homebrew, system.defaults, etc.)
  system.primaryUser = primaryUser;

  # Disable nix-darwin's Nix management (using Determinate Nix)
  nix.enable = false;

  # Set macOS system defaults
  system.stateVersion = 5;
}
