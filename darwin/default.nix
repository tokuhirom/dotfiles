{ pkgs, ... }: {
  # Import Phase 2 modules
  imports = [
    ./packages.nix    # CLI tools from nixpkgs
    ./homebrew.nix    # GUI apps via Homebrew
  ];

  # Enable the Nix daemon
  services.nix-daemon.enable = true;

  # Nix configuration
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "root" "tokuhirom" ];
  };

  # Set macOS system defaults
  system.stateVersion = 5;

  # Auto-optimize Nix store
  nix.optimise.automatic = true;

  # Garbage collection
  nix.gc = {
    automatic = true;
    interval.Day = 7;
    options = "--delete-older-than 30d";
  };
}
