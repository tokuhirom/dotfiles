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

  outputs = { self, nixpkgs, nix-darwin, home-manager }: {
    # macOS configuration
    darwinConfigurations."YOUR-MAC-HOSTNAME" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";  # Change to x86_64-darwin for Intel Macs
      modules = [
        ./darwin
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tokuhirom = import ./home;
        }
      ];
    };

    # Linux home-manager configurations
    homeConfigurations."tokuhirom@pop-os" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home
        {
          home.username = "tokuhirom";
          home.homeDirectory = "/home/tokuhirom";
        }
      ];
    };

    homeConfigurations."tokuhirom@arch" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home
        {
          home.username = "tokuhirom";
          home.homeDirectory = "/home/tokuhirom";
        }
      ];
    };
  };
}
