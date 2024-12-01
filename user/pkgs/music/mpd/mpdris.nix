{ config, pkgs, userSettings, ... }:
{
  home.packages = with pkgs; [
    mpdris2
    mpd-mpris
  ];
  services.mpdris2 = {
    enable = true;
    notifications = false;
    mpd.musicDirectory = "/home/${userSettings.username}/Music";
  };
  services.mpd-mpris = {
    enable = true;
    mpd.useLocal = true;
  };
}
