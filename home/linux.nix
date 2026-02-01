{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Linux-specific home-manager configuration

  home.packages = with pkgs; [
    # Linux 固有のパッケージは setup/setup-popos-desktop.sh で apt 管理
  ];

  # Linux 固有の環境変数は config/.config/environment.d/ibus.conf で管理
}
