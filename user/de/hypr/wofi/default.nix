{ config, pkgs, userSettings, ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      width = "400px";
      height = "450px";
      allow_markup = true;
      allow_images = true;
      stylesheet = builtins.toPath "${config.home.homeDirectory}dots/user/de/hypr/wofi/themes/${userSettings.theme}.css";
      term = userSettings.terminal;
      prompt = "where we droppin...";
    };
  };
}
