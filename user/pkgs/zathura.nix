{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = {
      lightcolor = "#D7D7D7";
      darkcolor = "#000000";
    };
    yang = {
      lightcolor = "#222222";
      darkcolor = "#e7e7e7";
    };
    burst = {
      lightcolor = "#17171f";
      darkcolor = "#d8d6eb";
    };
  };

  currentTheme = themes.${userSettings.theme};
in
{
  home.packages = with pkgs; [
    zathura
  ];

  programs.zathura = {
    enable = true;
    options = { };
    extraConfig = ''
      set recolor "true"
      set recolor-lightcolor "${currentTheme.lightcolor}"
      set recolor-darkcolor "${currentTheme.darkcolor}"
    '';
  };
}
