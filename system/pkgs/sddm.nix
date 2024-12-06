{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = {
      wallpaper = "/home/${userSettings.username}/wallpapers/yin.png";
    };
    yang = {
      wallpaper = "/home/${userSettings.username}/wallpapers/yang.png";
    };
  };
  currentTheme = themes.${userSettings.theme};
in
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      sugarCandyNix = {
        enable = true;
        settings = {
          Background = currentTheme.wallpaper;
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
        };
      };
    };
    defaultSession = "hyprland";
    sessionPackages = with pkgs; [ hyprland ];
  };
}
