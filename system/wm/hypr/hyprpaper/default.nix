{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = "${config.home.homeDirectory}dots/wallpapers/yin.png";
    yang = "${config.home.homeDirectory}dots/wallpapers/yang.png";
  };

  wallpaperPath = themes.${userSettings.theme};
  monitorWallpapers = builtins.map (monitor: "${monitor},${wallpaperPath}") userSettings.hypr.monitors;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        wallpaperPath
      ];
      wallpaper = monitorWallpapers;
    };
  };
}
