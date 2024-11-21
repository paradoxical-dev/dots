{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    sddm
    libgtop
    gnome-bluetooth
    hyprpanel
    wofi
    dolphin
    firefox-wayland
  ];
}
