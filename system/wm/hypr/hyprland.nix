{ config, pkgs, userSettings, ... }:
{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      extraConfig = ''
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/keybindings.conf
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/themes/${userSettings.theme}.conf
      '';
    };
  };
}
