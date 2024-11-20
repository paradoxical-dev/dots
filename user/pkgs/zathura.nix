{ config, pkgs, ... }:
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
      set recolor-lightcolor "#D7D7D7"
      set recolor-darkcolor "#000000"
    '';
  };
}
