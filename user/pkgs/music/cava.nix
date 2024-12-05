{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    cava
  ];
  programs.cava = {
    enable = true;
    settings = {
      input.method = "fifo";
      color = {
        background = "'#DEDEDE'";
        foreground = "'#000000'";
      };
    };
  };
}
