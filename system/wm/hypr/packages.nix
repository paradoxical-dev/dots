{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    wlroots
    xwayland
    grim
    slurp
    xorg.xhost
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    wl-clipboard
    kdePackages.breeze-icons
  ];
}
