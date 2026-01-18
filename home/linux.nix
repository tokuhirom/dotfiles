{ config, pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  # Linux-specific home-manager configuration

  home.packages = with pkgs; [
    # Linux-specific tools
    xclip  # Clipboard support for terminal
  ];

  # Linux-specific dotfiles
  home.file = {
    # X11
    ".xinitrc".source = ../config/.xinitrc;

    # Window management
    ".config/i3/config".source = ../config/.config/i3/config;
    ".config/polybar/config".source = ../config/.config/polybar/config;
    ".config/polybar/launch.sh".source = ../config/.config/polybar/launch.sh;

    # Terminal (Linux-specific config)
    ".config/wezterm/wezterm.lua".source = ../config/.config/wezterm/wezterm.lua;

    # Input method
    ".config/fcitx5".source = ../config/.config/fcitx5;
    ".config/akaza/config.yml".source = ../config/.config/akaza/config.yml;

    # MIME type associations
    ".config/mimeapps.list".source = ../config/.config/mimeapps.list;
  };
}
