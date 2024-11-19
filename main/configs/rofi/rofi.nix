{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    location = "center";
    xoffset = 0;
    yoffset = 0;
    font = "Victor Mono 14";
    extraConfig = {
      modi = "drun,window,run,filebrowser,ssh,keys";
      show-modi = "drun,window";

      sidebar-mode = false;
      lines = 10;
      columns = 1;
      fixed-num-lines = true;

      padding = 5;
      opacity = 85;
      width = 50;

      show-icons = true;

      ssh-client = "ssh";
      drun-show-actions = true;
    };
  };
}
