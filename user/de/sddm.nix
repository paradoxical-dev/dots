{ config, pkgs, ... }:
{
  services.displayManager = {
    sddm.enable = true;
    defaultSession = "hyprland";
    sessionPackages = with pkgs; [ hyprland ];
  };
}
