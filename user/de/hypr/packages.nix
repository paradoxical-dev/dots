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
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.qtimageformats
    libsForQt5.ffmpegthumbs
    firefox-wayland
  ];
}
