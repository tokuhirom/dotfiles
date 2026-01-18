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
              home-manager.users.${username} = import ./home;
            }
          ];
        };
    in
    {
      # macOS configurations
      darwinConfigurations = {
        # Example: Change YOUR-MAC-HOSTNAME to your actual hostname
        # Get it with: scutil --get LocalHostName
        "YOUR-MAC-HOSTNAME" = mkDarwinHost {
          username = "tokuhirom";
          hostname = "YOUR-MAC-HOSTNAME";
          system = "aarch64-darwin";  # or "x86_64-darwin" for Intel
        };
      };

      # Linux home-manager configurations
      homeConfigurations = {
        # Personal machines
        "tokuhirom@pop-os" = mkLinuxHome {
          username = "tokuhirom";
          hostname = "pop-os";
        };

        "tokuhirom@arch" = mkLinuxHome {
          username = "tokuhirom";
          hostname = "arch";
        };

        # Work machines - add your work username here
        # Example:
        # "workuser@work-laptop" = mkLinuxHome {
        #   username = "workuser";
        #   hostname = "work-laptop";
        # };
      };
    };
}
