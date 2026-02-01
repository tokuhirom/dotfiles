{ pkgs, ... }: {
  # Cross-platform user environment configuration

  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./development.nix
  ];

  # パッケージは OS 別に管理:
  # macOS: home/darwin.nix + darwin/packages.nix
  # Linux: home/linux.nix (Nix) + setup/setup-popos-desktop.sh (apt)

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    PAGER = "less";
  };

  # XDG Base Directory specification
  xdg.enable = true;

}
