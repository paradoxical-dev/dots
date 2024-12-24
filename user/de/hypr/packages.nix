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
    yazi
    firefox-wayland
  ];
}
