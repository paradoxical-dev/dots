{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.sddm
    libgtop
    btop
    gnome-bluetooth
    hyprpicker
    hyprsunset
    hypridle
    hyprlock
    hyprpanel
    wofi
    yazi
    ranger
    firefox-wayland
    google-chrome
  ];
}
