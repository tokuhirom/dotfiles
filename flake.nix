{
  description = "tokuhirom's dotfiles - Multi-platform system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # macOS system management
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # User environment management (cross-platform)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }:
    let
      # Helper to create Linux home-manager configuration
      mkLinuxHome = { username, hostname, system ? "x86_64-linux" }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home
            {
              home.username = username;
              home.homeDirectory = "/home/${username}";
            }
          ];
        };

      # Helper to create macOS nix-darwin configuration
      mkDarwinHost = { username, hostname, system ? "aarch64-darwin" }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = { pkgs, lib, ... }: {
                imports = [ ./home ];
                home.username = username;
                home.homeDirectory = lib.mkForce "/Users/${username}";
              };
            }
          ];
        };

      # Import machine-specific configurations from ~/.config/nix/machines.nix
      # This keeps your hostnames and usernames private (outside the git repo)
      # SUDO_USER is set when running with sudo, use it to find the real user's home
      sudoUser = builtins.getEnv "SUDO_USER";
      homeEnv = builtins.getEnv "HOME";
      homeDir = if sudoUser != ""
        then "/Users/${sudoUser}"  # macOS path when running with sudo
        else homeEnv;
      machinesPath = homeDir + "/.config/nix/machines.nix";

      machineConfigs = if builtins.pathExists machinesPath
        then import machinesPath { inherit mkLinuxHome mkDarwinHost; }
        else {
          # Default empty configs if machines.nix doesn't exist
          # Copy machines.nix.example to ~/.config/nix/machines.nix
          darwinConfigurations = {};
          homeConfigurations = {};
        };
    in
    {
      # Machine-specific configurations (from machines.nix, gitignored)
      darwinConfigurations = machineConfigs.darwinConfigurations or {};
      homeConfigurations = machineConfigs.homeConfigurations or {};
    };
}
