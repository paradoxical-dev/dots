{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    sddm
    waybar
    wofi
    dolphin
    firefox-wayland
  ];
}
