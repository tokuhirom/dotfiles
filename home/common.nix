{ pkgs, ... }: {
  # Cross-platform user environment configuration

  imports = [
    ./programs/git.nix
    ./programs/neovim.nix
    ./development.nix
  ];

  # パッケージは OS 別に管理:
  # macOS: home/darwin.nix + darwin/packages.nix
  # Linux: home/linux.nix (Nix) + setup/setup-popos-desktop.sh (apt)

  # 環境変数は .zshrc で管理

  # XDG Base Directory specification
  xdg.enable = true;

}
