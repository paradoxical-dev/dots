{ config, pkgs, userSettings, ... }:
let
  getWallpaper = theme: let
    jpgPath = "${config.home.homeDirectory}/dots/wallpapers/${theme}.jpg";
    pngPath = "${config.home.homeDirectory}/dots/wallpapers/${theme}.png";
  in
    if builtins.pathExists jpgPath then
      jpgPath
    else if builtins.pathExists pngPath then
      pngPath
    else
      throw "Wallpaper not found for theme: ${theme}";

  themeWallPaper = getWallpaper userSettings.theme;
  monitorWallPapers = builtins.map (monitor: "${monitor},${themeWallPaper}") userSettings.hypr.monitors;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        themeWallPaper
      ];
      wallpaper = monitorWallPapers;
    };
  };
}
