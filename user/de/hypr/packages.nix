{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    sddm
    libgtop
    gnome-bluetooth
    hyprpanel
    wofi
    dolphin
    kdePackages.kdegraphics-thumbnailers
    kdePackages.qtimageformats
    firefox-wayland
  ];
}
