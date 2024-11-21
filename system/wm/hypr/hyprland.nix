{ config, pkgs, ... }:
# let
#   hyprlandConfPath = "${config.home.homeDirectory}dots/system/wm/hypr/hyprland.conf";
# in 
{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      extraConfig = ''
      source = ${config.home.homeDirectory}dots/system/wm/hypr/hyprland.conf
      '';
    };
  };
}
