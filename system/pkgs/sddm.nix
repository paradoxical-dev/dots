{ config, pkgs, lib, userSettings, ... }:
let
  themes = {
    yin = {
      wallpaper = "yin.png";
      accent = "#222222";
      main = "#222222";
      button_text = "#FFFFFF";
    };
    yang = {
      wallpaper = "yang.png";
      main = "#FFFFFF";
      accent = "#FFFFFF";
      button_text = "#222222";
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
          Background = lib.cleanSource ../../wallpapers/${currentTheme.wallpaper};
          MainColor = currentTheme.main;
          AccentColor = currentTheme.accent;
          OverrideLoginButtonTextColor = currentTheme.button_text;
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          FormPosition = "left";
          HaveFormBackground = false;
          PartialBlur = true;
        };
      };
    };
    defaultSession = "hyprland";
    sessionPackages = with pkgs; [ hyprland ];
  };
}
