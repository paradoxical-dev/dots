{ config, pkgs, userSettings, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "${config.home.homeDirectory}dots/wallpapers/${userSettings.theme}";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
    };
  };
}
