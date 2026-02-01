{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Linux-specific home-manager configuration

  home.packages = with pkgs; [
    # Linux 固有のパッケージは setup/setup-popos-desktop.sh で apt 管理
  ];

  # Linux 固有の環境変数
  home.sessionVariables = {
    # IBus IME 設定
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };
}
