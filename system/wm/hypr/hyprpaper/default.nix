{ config, pkgs, lib, userSettings, ... }:
let
  themes = {
    yin = "${config.home.homeDirectory}dots/wallpapers/yin.png";
    yang = "${config.home.homeDirectory}dots/wallpapers/yang.png";
    burst = "${config.home.homeDirectory}dots/wallpapers/fractal.png";
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
  # Service override fix
  systemd.user.services.hyprpaper = {
    Service = {
      # provide a delay and for some reason it works
      # 0.5 seconds is the lowest I could get to work
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 0.6";
    };
  };
}
