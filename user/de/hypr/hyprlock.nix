{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = "${config.home.homeDirectory}dots/wallpapers/yin.png";
    yang = "${config.home.homeDirectory}dots/wallpapers/yang.png";
    burst = "${config.home.homeDirectory}dots/wallpapers/fractal.png";
    shards = "${config.home.homeDirectory}dots/wallpapers/shard.png";
  };

  wallpaperPath = themes.${userSettings.theme};
in
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
          path = wallpaperPath;
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [ 
        {
          size = "200, 50";
        }
      ];
    };
  };
}
