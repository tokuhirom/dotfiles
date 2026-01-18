{ config, pkgs, ... }: {
  # Phase 1: Foundation - Basic setup
  # Cross-platform user environment configuration

  # Core CLI packages available on all systems
  home.packages = with pkgs; [
    # Essential CLI tools (Phase 1)
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

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # XDG Base Directory specification
  xdg.enable = true;
}
