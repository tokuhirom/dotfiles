{ pkgs, ... }: {
  # Core system packages (Phase 1: Foundation)
  environment.systemPackages = with pkgs; [
    # Essential CLI tools
    git
    neovim
    tmux
    fzf
    ripgrep
    bat
    jq
    fd
    gh
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
