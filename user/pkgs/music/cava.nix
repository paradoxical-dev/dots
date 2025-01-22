{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = {
      background = "#DEDEDE";
      foreground = "#000000";
    };
    yang = {
      background = "#222222";
      foreground = "#fefefe";
    };
    burst = {
      background = "#17171f";
      foreground = "#BB9AF7";
    };
    shards = {
      background = "#101017";
      foreground = "#caafbe";
    };
  };

  currentTheme = themes.${userSettings.theme};
in
{
  home.packages = with pkgs; [
    cava
  ];
  programs.cava = {
    enable = true;
    settings = {
      input.method = "fifo";
      color = {
        background = "'${currentTheme.background}'";
        foreground = "'${currentTheme.foreground}'";
      };
    };
  };
}
