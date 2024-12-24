{ config, pkgs, userSettings, ... }:
let
  currentTheme = import ./themes/${userSettings.theme}.nix;
in
{
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      term = userSettings.terminal;
      prompt = "where we droppin...";
    };
    style = currentTheme.config;
  };
}
