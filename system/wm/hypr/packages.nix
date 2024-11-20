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
    wl-clipboard
    breeze-icons
  ];
}
