{ config, pkgs, userSettings, ... }:
{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      extraConfig = ''
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/apps.conf
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/env.conf
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/inputs.conf
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/keybindings.conf
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/themes/${userSettings.theme}.conf
      source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/windowrule.conf
      '';
    };
  };
}
