{ config, pkgs, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      sugarCandyNix = {
        enable = true;
        settings = {
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          FormPosition = "left";
          PartialBlur = true;
        };
      };
    };
    defaultSession = "hyprland";
    sessionPackages = with pkgs; [ hyprland ];
  };
}
