{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    sddm
    libgtop
    btop
    gnome-bluetooth
    hyprpicker
    hyprsunset
    hypridle
    hyprlock
    hyprpanel
    wofi
    libsForQt5.dolphin
    yazi
    firefox-wayland
  ];
}
