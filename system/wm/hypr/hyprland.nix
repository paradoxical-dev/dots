{ config, pkgs, userSettings, ... }:
let
  cursorConfigs = {
    yin = {
      cursorTheme = "Barbita-Modern-Classic";
    };
  };

  currentCursorConfig = cursorConfigs.${userSettings.theme} or {
    cursorTheme = "Barbita-Modern-Classic";
  };
in
{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      extraConfig = ''
        source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/apps.conf
        source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/env.conf
        env = XCURSOR_SIZE,24
        env = XCURSOR_THEME,${currentCursorConfig.cursorTheme}
        env = HYPRCURSOR_SIZE,24
        env = HYPRCURSOR_THEME,${currentCursorConfig.cursorTheme}
        source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/inputs.conf
        source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/keybindings.conf
        source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/themes/${userSettings.theme}.conf
        source = ${config.home.homeDirectory}dots/system/wm/hypr/conf/settings/windowrule.conf
      '';
    };
  };
}
