{ config, pkgs, userSettings, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      sugarCandyNix = {
        enable = true;
        settings = {
          Background = ../../wallpapers/${userSettings.theme};
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
