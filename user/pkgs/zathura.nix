{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = {
      lightcolor = "#D7D7D7";
      darkcolor = "#000000";
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
    options = {
    };
    extraConfig = ''
      set recolor "true"
      set recolor-lightcolor "${currentTheme.lightcolor}"
      set recolor-darkcolor "${currentTheme.darkcolor}"
    '';
  };
}