{ config, pkgs, userSettings, ... }:
{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      extraConfig = ''
      source = ~/dots/system/wm/hypr/conf/settings/keybindings.conf
      source = ~/dots/system/wm/hypr/conf/settings/inputs.conf
      source = ~/dots/system/wm/hypr/conf/settings/env.conf
      source = ~/dots/system/wm/hypr/conf/settings/windowrule.conf
      source = ~/dots/system/wm/hypr/conf/settings/apps.conf
      source = ~/dots/system/wm/hypr/conf/themes/${userSettings.theme}.conf
      '';
    };
  };
}
