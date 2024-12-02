{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    wlroots
    xwayland
    grim
    slurp
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    wl-clipboard
    breeze-icons
  ];
}
