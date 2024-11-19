{ config, pkgs, ... }:
{
  programs.zathura = {
    enable = true;
    options = {
      # default-bg = "#e1e4dc";
      # default-fg = "#000000";
    };
    extraConfig = ''
      set recolor "true"
      set recolor-lightcolor "#e1e4dc"
      set recolor-darkcolor "#000000"
    '';
  };
}
